It is a brief pipeline to extract data from datasets in [here](http://139.129.209.66:8000/d/daedafb854/)


In this work, I use R, Bash and Python to extract different countries different indicators in different years. The data have some property: big, not unified(.RData or .csv), some have mistakes. It is very sparse so it waste many storage. And the conversion of Rdata to csv leads some mistakes, so it needs very careful examination and check work. At first I want to store all of them in HDF5 for better IO, but i'm not familiar with codes, so I store them in csv. 


#### wget to extract data
```
getdata.sh
```

#### check row and col names for further extraction
##### before 2001
use awk to read row and columns in csv, then compare them with std names
```
#first
extractnames.sh
#second
refer to codes in analyze_dim_name.ipynb: check 1995-2000's row and column name
#run and check
```
**There are some wrong files, need to examine them later**

##### after 2001
Use R to extract row and columns and compare

```
#first run Rscript to get row and columns
run extractrowandcol.R
#second
refer to codes in analyze_dim_name.ipynb: after 2001, use R to produce csv, read and decide.
#run and check
```

**All the files have exactly the same structure**

## extract data concerning CHINA
### analysis
**The data dimension is: ** 1435*1435*41
If use RData to extract some matrix to analyze its row and column names,  the  automatically saved names have mistakes. So we use the previous plot to inspire us and find the true data structure:

![Markdown](http://i1.bvimg.com/640680/0ba5f17f200bc207.png)

The first big block is **to** the first country(AUS)

So the column names in first big block are:   X>AUS

When row and columns names match there are values, so there are only values in diagonal. 

**(That’s the main reason the R data file is big: the minimum number is :41*41*35*35, but RData have 1435*1435*41, 41 fold redundancy)**

### How to find a country
#### after 2001
The data we use is RData, use Rscript to extract data
##### to CHINA
Locate the country，**CHN is 7th**

**The seventh block are all countries to CHINA**
**dat[,,7]**  the matrix dimension is 1435*1435
```
datt<-dat[,,7]
datt[1+35*(i-1):35*i,1+35*(i-1):35*i]
```
Use for loop, **use a array:35*（35*41）** to store
save to **tochn.csv**
Rows:c1-c35
Columns: every 35 columns are a same country
```
Run extract2001.R
#output in out directory
```
##### CHINA to
**each 1435*1435 block’s seventh mini block is China to another country**
**dat[211:245,211:245,i]** 
```
Run extract2001.R
```
Use for loop, **use a array:35*（35*41）**to store
**save to chnto.csv**

Rows:c1-c35

Columns: every 35 columns are a same country

#### before 2001
There are some exceptions we do not deal with at first

The data we use only has csv, so use python to extract
##### to CHINA
The principle is similar to after 2001

But the data is just the transpose: (1435*41)*1435

**The seventh block are all countries to CHINA**

**Run extract1995.py**
```
datt = dat[1435*6:1435*7,:]   #1435*1435datt[35*i:35*(i+1),35*i:35*(i+1)]  #loop
```
Use for loop, **use a array:35*（35*41）**to store
**save to chnto.csv**

##### CHINA to

**each 1435*1435 block’ seventh mini block is China to another country**
```
dattt =dat[1435*i:1435*(i+1),:]  #the ith country 1435*1435
dattt[35*6:35*(6+1),35*6:35*(6+1)]  
```
Save to **chnto.csv**


## To do
### Exception dealing
- [ ] before 2001 there are some files not in standard form, needs more examine to extract. Maybe case by case
### analyze data
#### plot the change,
for example, heat map, line chart, animation …

![Markdown](http://i1.bvimg.com/640680/0ce616088c435eae.gif)

#### do simple statistics
#### model the change


