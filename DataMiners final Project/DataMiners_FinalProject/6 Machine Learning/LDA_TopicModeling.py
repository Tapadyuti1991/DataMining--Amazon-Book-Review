
# coding: utf-8

# In[82]:

#importing packages
from nltk.tokenize import RegexpTokenizer
from nltk.tokenize import word_tokenize
from stop_words import get_stop_words
from nltk.stem.porter import PorterStemmer
from gensim import corpora, models
import gensim
import csv
import numpy as np


# In[45]:

#Defining tokenizer using Regex
tokenizer = RegexpTokenizer(r'\w+')

# create English stop words list
en_stop = get_stop_words('en')

# Create p_stemmer of class PorterStemmer
p_stemmer = PorterStemmer()


# In[78]:

texts = []


# In[122]:

#importing file 
with open('C:/Users/Gautam/Downloads/Book1.csv', 'r') as f:
    reader = csv.reader(f)
    doca = list(reader)


# In[137]:

#List to append all the lists
flattened_list = []


# In[138]:

for x in doca:
    for y in x:
        flattened_list.append(y)


# In[145]:

raw_lower=[]


# In[146]:

# loop through document list
for i in np.arange(0,len(flattened_list)):
    
    print(i)
    raw_lower = flattened_list[i].lower()
    # clean and tokenize document string
    tokens = tokenizer.tokenize(raw_lower)

    # remove stop words from tokens
    stopped_tokens = [i for i in tokens if not i in en_stop]
    
    # stem tokens
    stemmed_tokens = [p_stemmer.stem(i) for i in stopped_tokens]
    
    # add tokens to list
    texts.append(stemmed_tokens)


# In[147]:

print(texts)


# In[168]:

#Converting document to dictionary
dictionary = corpora.Dictionary(texts)


# In[ ]:

# # convert tokenized documents into a document-term using doc2bow that will produce documents.
corpus = [dictionary.doc2bow(text) for text in texts]

#generate LDA model
lda = gensim.models.ldamodel.LdaModel(corpus, num_topics=5, ,num_words=10, id2word = dictionary, passes=20)


# In[167]:

#Trying with different topic value..
print(lda.print_topics(num_topics=10, num_words=10))


# In[150]:

print(dictionary)


# In[169]:

#Topic Wise words with probability..
for i in  lda.show_topics():
    print(i[0], i[1])

