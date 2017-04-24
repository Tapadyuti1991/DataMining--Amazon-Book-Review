
# coding: utf-8

# In[24]:

import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt
get_ipython().magic(u'matplotlib inline')
import unicodedata
import sys
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.cluster import KMeans
from sklearn import metrics


# In[3]:

from io import StringIO
import requests
import json
import pandas as pd

# @hidden_cell
# This function accesses a file in your Object Storage. The definition contains your credentials.
# You might want to remove those credentials before you share your notebook.
def get_object_storage_file_with_credentials_49013d1f7eed469aa9292258fdeec309(container, filename):
    """This functions returns a StringIO object containing
    the file content from Bluemix Object Storage."""

    url1 = ''.join(['https://identity.open.softlayer.com', '/v3/auth/tokens'])
    data = {'auth': {'identity': {'methods': ['password'],
            'password': {'user': {'name': 'member_0535f2960f72ec9596c9cb8cba5514e3bab87845','domain': {'id': '389b11290ea74fb3af0c4e70414ec211'},
            'password': 'EM^n-q4&z&z[V7kZ'}}}}}
    headers1 = {'Content-Type': 'application/json'}
    resp1 = requests.post(url=url1, data=json.dumps(data), headers=headers1)
    resp1_body = resp1.json()
    for e1 in resp1_body['token']['catalog']:
        if(e1['type']=='object-store'):
            for e2 in e1['endpoints']:
                        if(e2['interface']=='public'and e2['region']=='dallas'):
                            url2 = ''.join([e2['url'],'/', container, '/', filename])
    s_subject_token = resp1.headers['x-subject-token']
    headers2 = {'X-Auth-Token': s_subject_token, 'accept': 'application/json'}
    resp2 = requests.get(url=url2, headers=headers2)
    return StringIO(resp2.text)

data = pd.read_csv(get_object_storage_file_with_credentials_49013d1f7eed469aa9292258fdeec309('KmeansAmazon', 'LatestData.csv'))
data.head()


# In[5]:

#Extracting only useful columns
df1 = data.iloc[:, [3,4,5,9]]
df1.head()


# In[6]:

#change data type of non-Text features from string to integer
df1.iloc[:, 1:2] = df1.iloc[:, 1:2].apply(pd.to_numeric)
pd.to_numeric(df1['Ratings'], errors='coerce')


# In[7]:

#include reviews that have more than 15 helpfulness data point only
df1 = df1[(df1.HelpfulDenomerator > 15)]


# In[8]:

df1['Ratings'].shape


# In[27]:

df1.isnull().sum()


# In[28]:

#converting the book reviews to lower case 
df1.loc[:, 'Review_Text'] = df1['Review_Text'].str.lower()
df1["Review_Text"].head(10)


# In[29]:

#removint the punctuation

dictionary = dict.fromkeys(i for i in range(sys.maxunicode)
                      if unicodedata.category(chr(i)).startswith('P'))
def remove_punctuation(text):
    return text.translate(dictionary)

df1['Review_Text']=df1['Review_Text'].apply( lambda x: remove_punctuation(x))
df1["Review_Text"].head(4)


# In[40]:

df1['Ratings'].shape


# In[9]:

#transform Helpfulness into a binary variable with 0.50 ratio
df1.loc[:, 'Helpfulness'] = np.where(df1.loc[:, 'HelpfulNumerator'] / df1.loc[:, 'HelpfulDenomerator'] > 0.50, 1, 0)
df1.head(3)


# In[10]:

df1.groupby('Helpfulness').count()


# In[11]:

df1.corr()


# In[12]:

#make a copy
df2 = df1.copy(deep = True)


# In[13]:

df2.head()


# In[14]:

#tokenize text with Tfidf
from sklearn.feature_extraction.text import TfidfVectorizer

vectorizer = TfidfVectorizer(min_df = 0.1, max_df=0.9,
                             ngram_range=(1, 4), 
                             stop_words='english')
vectorizer.fit(df2['Review_Text'])


# In[15]:

trainingdata = vectorizer.transform(df2['Review_Text'])
vocabulary = vectorizer.get_feature_names()


# In[ ]:

#find best logistic regression parameters
from sklearn import grid_search, cross_validation
from sklearn.linear_model import LogisticRegression
feature_set = trainingdata
gs = grid_search.GridSearchCV(
    estimator=LogisticRegression(),
    param_grid={'C': [10**-i for i in range(-5, 5)], 'class_weight': [None, 'balanced']},
    cv=cross_validation.StratifiedKFold(df1.Helpfulness,n_folds=10),
    scoring='roc_auc'
)


gs.fit(trainingdata, df2.Helpfulness)
gs.grid_scores_


# In[20]:

#plot ROC/AUC curve
from sklearn.metrics import roc_auc_score, roc_curve
actuals = gs.predict(feature_set) 
probas = gs.predict_proba(feature_set)
plt.plot(roc_curve(df2[['Helpfulness']], probas[:,1])[0], roc_curve(df2[['Helpfulness']], probas[:,1])[1])


# In[21]:

# ROC/AUC score
#Accuracy of bag of Words Model is 75 Percent
y_score = probas
test2 = np.array(list(df2.Helpfulness))
y_true = test2
roc_auc_score(y_true, y_score[:,1].T)


# In[25]:

#Used tfidf to Analyze text..
model = KMeans(n_clusters=5, init='k-means++', max_iter=50, n_init=1,random_state=3)

vectorizer = TfidfVectorizer(min_df = 0.05, max_df=0.95,
                             ngram_range=(1, 2), 
                             stop_words='english')
vectorizer.fit(df1['Review_Text'])


# In[26]:

training = vectorizer.transform(df1['Review_Text'])
vocabulary = vectorizer.get_feature_names()
sse_err = []


# In[35]:

res = model.fit(training)
vocabulary = np.array(vocabulary)
cluster_centers = np.array(res.cluster_centers_)
sorted_vals = [res.cluster_centers_[i].argsort() for i in range(0,np.shape(res.cluster_centers_)[0])]
topwords=set()
for i in range(len(res.cluster_centers_)):
    topwords = topwords.union(set(vocabulary[sorted_vals[i][-15:]]))
topwords=list(topwords)


# In[36]:

#Displaying the top 15 words per clusters
words


# In[38]:

train_set=training[:,[np.argwhere(vocabulary==i)[0][0] for i in words]]


# In[39]:

#Cluster wise count
df1['cluster'] = model.labels_
df1.groupby('cluster').count()


# In[50]:

# what does each cluster look like
df1.groupby('cluster').mean()


# In[51]:

#final 
df1.corr()


# In[42]:

#add Score column to top words
import scipy as scipy

topscore = np.array(list(df1.Ratings))
topscore = topscore.reshape(46907, 1)
features = scipy.sparse.hstack((train_set,scipy.sparse.csr_matrix(topscore)))
features = scipy.sparse.csr_matrix(features)


# In[44]:

#Logistic Regression and get GridSearchCV 
from sklearn import grid_search, cross_validation
from sklearn.linear_model import LogisticRegression
feature_set = features
gs = grid_search.GridSearchCV(
    estimator=LogisticRegression(),
    param_grid={'C': [10**-i for i in range(-5, 5)], 'class_weight': [None, 'balanced']},
    cv=cross_validation.StratifiedKFold(df1.Helpfulness,n_folds=10),
    scoring='roc_auc'
)
gs.fit(features, df1.Helpfulness)
gs.grid_scores_


# In[72]:

print(gs.best_estimator_)


# In[45]:

predictor = gs.predict(feature_set)


# In[46]:

#Calculating the coefficients P-value 
print(gs.best_estimator_.coef_)
print(gs.best_estimator_.intercept_)


# In[47]:

#roc curve
from sklearn.metrics import roc_auc_score, roc_curve
actuals = gs.predict(feature_set) 
probas = gs.predict_proba(feature_set)
plt.plot(roc_curve(df1[['Helpfulness']], probas[:,1])[0], roc_curve(df1[['Helpfulness']], probas[:,1])[1])


# In[50]:


#roc auc score
y_score = probas
test2 = np.array(list(df1.Helpfulness))
test2 = test2.reshape(46907,1)
y_true = test2

roc_auc_score(y_true, y_score[:,1].T)


# In[53]:

from sklearn.metrics import confusion_matrix
def plot_confusion_matrix(cm, title='Confusion matrix', cmap=plt.cm.Blues):
    plt.imshow(cm, interpolation='nearest', cmap=cmap)
    plt.title(title)
    plt.colorbar()
    plt.tight_layout()
    plt.ylabel('Actual Helpfulness')
    plt.xlabel('Predicted Helpfulness')

# Compute confusion matrix
cm = confusion_matrix(y_true, predictor)
np.set_printoptions(precision=2)
print(cm)
plt.figure()
# plot_confusion_matrix(cm)
cm_normalized = cm.astype('float') / cm.sum(axis=1)[:, np.newaxis]
plot_confusion_matrix(cm_normalized, title='Confusion matrix')
plt.figure()

plt.show()


# In[57]:

#Displayin the top parameters
words.extend(['topscore'])
sorted(zip(topwords,gs.best_estimator_.coef_[0]),key=lambda x:x[1])

