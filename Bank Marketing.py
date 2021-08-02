#!/usr/bin/env python
# coding: utf-8

# # Bank Marketing

# In[142]:


#loading libraries
import pandas as pd 
import numpy as np                     
import seaborn as sns                   
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick
import warnings
warnings.filterwarnings("ignore")


# In[5]:


#Load dataset
bank = pd.read_csv("/Users/shanpriyahome/Personal/Family Folders/Priya/Python/Dataset/Project/bank/bank-full.csv", delimiter=';')
bank.head()


# In[6]:


bank.info()


# Observation: There are 17 coloumns with no null values

# In[7]:


bank.describe()


# In[8]:


bank.columns


# In[9]:


bank.corr()


# In[10]:


print("Shape of the dataset")
bank.shape


# In[11]:


print("[INFO] dataset summary")
print(bank.describe())


# In[12]:


print(bank.dtypes)


# In[13]:


print(bank.isnull().sum())


# # Categorical Variables

# In[14]:


cat_Var = pd.Categorical(bank)
print(cat_Var)


# In[15]:


print('\n')
print('________________________________________________________________________________')
print('Jobs:\n', bank['job'].unique())
print('________________________________________________________________________________')
print('Marital:\n', bank['marital'].unique())
print('________________________________________________________________________________')
print('Education:\n', bank['education'].unique())
print('________________________________________________________________________________')
print('\n')


# In[16]:


print('Default:\n', bank['default'].unique())
print('\n')
print('Housing:\n', bank['housing'].unique())
print('\n')
print('Loan:\n', bank['loan'].unique())


# In[17]:


Y = (bank['y'] == 'yes')*1


# # Job Deatils

# In[18]:


labels=bank['job'].value_counts().index
values=bank['job'].value_counts().values

plt.figure(figsize = (15, 8))
ax = sns.barplot(x=labels, y=values)
for i, p in enumerate(ax.patches):
    height = p.get_height()
    ax.text(p.get_x()+p.get_width()/2., height + 0.1, values[i],ha="center")
    ax.tick_params(axis='x', labelsize=16)
    ax.tick_params(axis='y', labelsize=16)
    fmt = '%.0f'
    #plt.xticks(rotation='vertical')
    plt.xlabel('Jobs', fontsize=20)
plt.ylabel('Job Count', fontsize=20)
plt.title('JOBS OF THE CUSTOMERS', fontsize=20, y=1.03, weight='bold')


# # Marital Status

# In[19]:


labels=bank['marital'].value_counts().index
values=bank['marital'].value_counts().values

plt.figure(figsize = (15, 8))
ax = sns.barplot(x=labels, y=values)
for i, p in enumerate(ax.patches):
    height = p.get_height()
    ax.text(p.get_x()+p.get_width()/2., height + 0.1, values[i],ha="center")
    ax.tick_params(axis='x', labelsize=16)
    ax.tick_params(axis='y', labelsize=16)
    #plt.xticks(rotation='vertical')
    plt.xlabel('Marital Status', fontsize=20)
plt.ylabel('No of people', fontsize=20)
plt.title('MARITAL STATUS OF THE CUSTOMERS', fontsize=20, y=1.03, weight='bold')


# In[20]:


labels=bank['education'].value_counts().index
values=bank['education'].value_counts().values

plt.figure(figsize = (15, 8))
ax = sns.barplot(x=labels, y=values)
for i, p in enumerate(ax.patches):
    height = p.get_height()
    ax.text(p.get_x()+p.get_width()/2., height + 0.1, values[i],ha="center")
    #plt.xticks(rotation='vertical')
    ax.tick_params(axis='x', labelsize=16)
    ax.tick_params(axis='y', labelsize=16)
    plt.xlabel('education', fontsize=20)
plt.ylabel('No of people', fontsize=20)
plt.title('EDUCATION OF THE CUSTOMERS', fontsize=20, y=1.03, weight='bold')


# # Customer Contact Details:

# In[94]:


print('Customer Contact Values:\n', bank['contact'].unique())


# In[112]:


contact_labels = bank['contact'].value_counts().index
contact_values=bank['contact'].value_counts().values
contact_len= len(bank['contact'])
percentage_contact = []


# In[113]:


for i in contact_values:
    print(i)
    i = (i/contact_len)*100
    percentage_contact.append(i)
    print(percentage_contact)


# In[114]:


type(percentage_contact)


# In[115]:


plt.title('CONTACT DETAILS OF THE CUSTOMERS', fontsize=20, y=1.03, weight='bold')
sizes = percentage_contact
#sizes = [215, 130, 215]
colors = ['gold', 'yellowgreen', 'lightcoral']
textprops = {"fontsize":10}
wedgeprops = {"linewidth": 1, 'width':1, "edgecolor":"k"}
explode = (0.1, 0, 0)  # explode 1st slice

#plt.pie(sizes, explode=explode, labels=contact_labels, colors=colors,autopct='%1.2f%%', shadow=True, startangle=140, textprops=textprops,wedgeprops = wedgeprops )
plt.pie(sizes, explode=explode, labels=contact_labels, colors=colors,autopct='%1.2f%%', shadow=True, startangle=140, textprops=textprops,wedgeprops = wedgeprops )
plt.axis('equal')
plt.show()


# In[168]:


plt.figure(figsize = (15, 8))
ax = sns.barplot(x=contact_labels, y=contact_values)
for i, p in enumerate(ax.patches):
    print(percentage_contact[i])
    height = p.get_height()
    print(height)
    ax.text(p.get_x()+p.get_width()/2., height + 0.1, percentage_contact[i], ha="center")
    ax.tick_params(axis='x', labelsize=16)
    ax.tick_params(axis='y', labelsize=16)
    plt.xlabel('contact', fontsize=20)
plt.ylabel('No of people', fontsize=20)
plt.title('CONTACT OF THE CUSTOMERS', fontsize=20, y=1.03, weight='bold')


# In[111]:


plt.figure(figsize = (15, 8))
ax = sns.barplot(x=contact_labels, y=contact_values)
for p in ax.patches:
    width = p.get_width()
    print(width)
    height = p.get_height()
    print(height)
    x, y = p.get_xy() 
    print(x,y)
    ax.annotate(f'{height:.0%}', (x + width/2, y + height*1.02), ha='center')
    ax.tick_params(axis='x', labelsize=16)
    ax.tick_params(axis='y', labelsize=16)
    plt.xlabel('contact', fontsize=20)
plt.ylabel('No of people', fontsize=20)
plt.title('CONTACT OF THE CUSTOMERS', fontsize=20, y=1.03, weight='bold')


# # Numerical Variable

# In[20]:


print(bank.select_dtypes(include=np.number).columns.tolist())


# In[21]:


#sns.set(rc={"figure.figsize": (10, 10)}); np.random.seed(0)
sns.set(rc={"figure.figsize": (25, 25)})
ax = sns.distplot(bank['age'],color="#DF0101",hist_kws = {'edgecolor':'blue'})
plt.xlabel('AGE', fontsize=20)
plt.ylabel('NO OF PEOPPLE', fontsize=20)
plt.title('AGE OF THE CUSTOMERS', fontsize=20, y=1.03, weight='bold')
plt.show()


# In[22]:


print('**************************************************')
print('\t Age Description \n')
print(bank['age'].describe())
print('**************************************************')


# In[37]:


plt.subplots(figsize = (25, 20))
sns.countplot(bank['age'])
plt.xlabel('AGE', fontsize=20)
plt.ylabel('NO OF PEOPPLE', fontsize=20)
plt.title('AGE OF THE CUSTOMERS', fontsize=20, y=1.03, weight='bold')
plt.show()


# In[ ]:





# In[ ]:




