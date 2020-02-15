#! /usr/bin/env python
import numpy as np
import pandas as pd
from tqdm import tqdm

indexnames = ['L3_1_DVA_FIN','L3_4_RDV','L3_6_FVA_INT','L3_2_DVA_INT',
              'L3_5_FVA_FIN','L3_7_DDC','L3_3_DVA_INTrex','L3_5_MVA','L3_8_FDC']
years = np.arange(1995,2012).astype('str')

rowstd =np.loadtxt('1995/1995_L3_1_DVA_FIN_row.csv',dtype='str',delimiter=',')[1:]
colstd = np.loadtxt('1995/1995_L3_1_DVA_FIN_col.csv',dtype='str',delimiter=',')[1:]

wrong_file =['1996_L3_4_RDV','1996_L3_5_FVA_FIN','1999_L3_1_DVA_FIN','1999_L3_6_FVA_INT','1999_L3_5_FVA_FIN',
             '1999_L3_8_FDC','2000_L3_1_DVA_FIN','2000_L3_4_RDV','2000_L3_2_DVA_INT','2000_L3_5_FVA_FIN',
             '2000_L3_3_DVA_INTrex']
country = np.array(['AUS', 'AUT', 'BEL', 'BGR', 'BRA', 'CAN', 'CHN', 'CYP', 'CZE',
                    'DEU', 'DNK', 'ESP','EST', 'FIN', 'FRA', 'GBR', 'GRC', 'HUN', 'IDN',
                    'IND', 'IRL', 'ITA', 'JPN', 'KOR', 'LTU', 'LUX', 'LVA', 'MEX',
                    'MLT', 'NLD', 'POL', 'PRT', 'ROM', 'RUS', 'SVK', 'SVN', 'SWE',
                    'TUR', 'TWN', 'USA', 'RoW'])
def extractfromcsv(year,indexname):
    '''
        this is for extract CHN from years before 2001
        the data contains other countrys to CHN and CHN to other countrys
        '''
    dat = np.loadtxt(year+'/'+year+'_'+indexname+'.csv',dtype='str',delimiter=',')[1:,1:].astype('float')
    datt = dat[1435*6:1435*7,:]
    tochnarr = np.ndarray([35,35*41])
    for i in range(41):
        tochnarr[:,35*i:35*(i+1)] = datt[35*i:35*(i+1),35*i:35*(i+1)]
    chntoarr=np.ndarray([35,35*41])
    for i in range(41):
        chntoarr[:,35*i:35*(i+1)] =dat[1435*i:1435*(i+1),:][35*6:35*(6+1),35*6:35*(6+1)]
    dataframe1 = pd.DataFrame(tochnarr,index=np.arange(1,36),columns=np.repeat(country,35).reshape(-1,35).ravel())
    dataframe2 = pd.DataFrame(chntoarr,index=np.arange(1,36),columns=np.repeat(country,35).reshape(-1,35).ravel())
    dataframe1.to_csv('out/'+year+'/'+year+'_'+indexname+'tochn.csv')
    dataframe2.to_csv('out/'+year+'/'+year+'_'+indexname+'chnto.csv')

wrong_file =['1996_L3_4_RDV','1996_L3_5_FVA_FIN','1999_L3_1_DVA_FIN','1999_L3_6_FVA_INT','1999_L3_5_FVA_FIN',
             '1999_L3_8_FDC','2000_L3_1_DVA_FIN','2000_L3_4_RDV','2000_L3_2_DVA_INT','2000_L3_5_FVA_FIN',
             '2000_L3_3_DVA_INTrex']

for i in tqdm(range(6)):
    for j in tqdm(range(9)):
        if years[i]+'_'+indexnames[j] in wrong_file:
            print "wrong file! skip"
        else:
            extractfromcsv(years[i],indexnames[j])
