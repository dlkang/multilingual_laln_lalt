#!/bin/bash
#!

# set up GPU
export CUDA_VISIBLE_DEVICES=0

# path to the raw opus-100 dataset
data_path=../tico_data/
# set the code base directory
zero_path=./
# set the submodels directory, for vocabulary and bpe models
submodel_path=../submodels/
# set the well-trained nmt models
nmtmodel_path=../Ours-L24-RoBT/

conda init --all

# get language information
source ${zero_path}/scripts/data/tico_common.sh

function test {
src=$1
ref=$2
out=$3
y=$4
  
source activate ${zero_path}/p2_conda
conda list
# To evaluate Baseline Transformers, change the settings as follows:
# 1. model_name="transformer",scope_name="transformer",\
# 2. delete to_lang_vocab_file="${submodel_path}/vocab.zero.to_lang",\
python2 ${zero_path}/run.py --mode test --parameters=\
model_name="transformer_multilingual",scope_name="transformer_fuse",\
eval_batch_size=32,\
gpus=[0],\
src_vocab_file="${submodel_path}/vocab.zero.src",\
tgt_vocab_file="${submodel_path}/vocab.zero.tgt",\
to_lang_vocab_file="${submodel_path}/vocab.zero.to_lang",\
src_test_file="$src",\
tgt_test_file="$ref",\
output_dir="${nmtmodel_path}",\
test_output="$out.trans.txt"

source activate ${zero_path}/p3_conda
python3 ${zero_path}/scripts/spm_decode.py \
  --model ${submodel_path}/sentencepiece.model \
  --input_format=id \
  --input $out.trans.txt > $out.trans.post.txt
  
# In our experiments, we train our sentencepiece model with the option "--character_coverage 0.9995 --input_sentence_size=10000000". This leads to '??' noisy outputs.
sed -i 's/ ⁇ //g' $out.trans.post.txt
source activate ${zero_path}/p3_conda
python3 -m sacrebleu $ref < $out.trans.post.txt > $out.trans.post.txt.sacrebleu
  
}

function handle_source {
  txt=$1
  lang=$2
  out=$3

source activate ${zero_path}/p3_conda
  python3 ${zero_path}/scripts/spm_encode.py \
    --model ${submodel_path}/sentencepiece.model \
    --output_format=id \
    --inputs ${txt} \
    --outputs ${out}
  
  sed -i "s/^/<2${lang}> /g" ${out}

  # In our experiments, we limit the source words to 100 to avoid memory issue
  # This will slightly affect the decoding performance (We find without length constraint, we could get better BLEU)
  # cut -d' ' -f 1-100  <  ${out} >tmp; mv tmp ${out}

}

# zero-short translation
test_set_name="zero-shot"
zsdata_path=${data_path}/${test_set_name}/
echo Zero shot langs: ${zero_shot_langs}
for x in ${zero_shot_langs}; do
  for y in ${zero_shot_langs}; do
    if [[ $x == $y ]]; then
      continue
    fi

    xy_path=${zsdata_path}/${x}-${y}/
    if [[ ! -d ${xy_path} ]]; then
      xy_path=${zsdata_path}/${y}-${x}/tico.${y}-${x}-test
    else
      xy_path=${xy_path}/tico.${x}-${y}-test
    fi

    src=${xy_path}.${x}
    bpesrc=${test_set_name}.${x}2${y}.bpe.${x}
    ref=${xy_path}.${y}
    out=${test_set_name}.${x}2${y}.zero

    if [[ ! -f $src ]]; then
      continue
    fi

    handle_source $src $y $bpesrc

    test $bpesrc $ref $out $y

  done
done

