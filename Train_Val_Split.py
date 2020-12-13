#!/usr/bin/env python
# coding: utf-8

# In[1]:


from sklearn.model_selection import train_test_split


# In[2]:


import os
os.chdir('/Users/rushilnandandubey/Documents/Fall2020/CS-695(NLP)/Final/dumpp')


# In[3]:


os.listdir()


# In[4]:


file1 = open('sourcestring.txt', 'r') 
Lines = file1.readlines() 


# In[5]:


src=[]
for each in Lines:
    #remove spaces and tabspaces at end of lines
    each=each.strip()
    src.append(each)


# In[6]:


src


# In[7]:


l_dict={}
for each in os.listdir('target'):
    print(each)
    file1 = open('target/'+each, 'r') 
    Lines = file1.readlines()
    target=[]
    for eachline in Lines:
        #remove spaces and tabspaces at end of lines
        eachline=eachline.strip()
        target.append(eachline)
    l_dict[each]=target
    


# In[9]:


for key,value in l_dict.items():
    lang=key.split('_')
    lang=lang[1]
    print(lang)
    X,x,Y,y= train_test_split(src,value,train_size=0.65,test_size=0.35,random_state=42)
    #train for source
    
    with open('src/corpus.train.cmb.bpe.src.shuf', 'w') as file:
        for listitem in X:
            
            file.write('%s\n' % listitem)
                
    xtest,xval,ytest,yval=train_test_split(x,y,test_size=0.5,random_state=42)
    
    #test for source
    
    with open('src/src.test', 'w') as file:
        for listitem in xtest:
            
            file.write('%s\n' % listitem)
            
    #validation source      
    with open('src/corpus.dev.cmb.bpe.src', 'w') as file:
        for listitem in xval:
            
            file.write('%s\n' % listitem)
    
    #src x test = xtest, ytest
    #tgt y test = xval, yval
    
    #train for target
    with open('tgt/'+lang+'.corpus.train.cmb.bpe.tgt.shuf','w') as file:
        for listitem in Y:
            
            file.write('%s\n' % listitem)

                
    with open('tgt/'+lang+'.corpus.dev.cmb.bpe.tgt','w') as file:
        for listitem in yval:
            
            file.write('%s\n' % listitem)
            

                
    with open('tgt/'+lang+'.test','w') as file:
        for listitem in ytest:
            
            file.write('%s\n' % listitem)
    
    
    
    


# In[ ]:





# In[ ]:




