#!/bin/bash

bash ./scripts/data/download_opus100.sh . ../opus-100

wget http://data.statmt.org/bzhang/acl2020_multilingual/submodels.tar.gz -P ..
tar zvxf ../submodels.tar.gz -C ..

wget http://data.statmt.org/bzhang/acl2020_multilingual/Ours-L24-RoBT.tar.gz -P ..
tar zvxf Ours-L24-RoBT.tar.gz -C ..
