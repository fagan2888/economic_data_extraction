#! /usr/bin/env python
import numpy as np
import pandas as pd
import h5py
import os
from tqdm import tqdm

countrys = np.array(['AUS', 'AUT', 'BEL', 'BGR', 'BRA', 'CAN', 'CHN', 'CYP', 'CZE',
                     'DEU', 'DNK', 'ESP','EST', 'FIN', 'FRA', 'GBR', 'GRC', 'HUN', 'IDN',
                     'IND', 'IRL', 'ITA', 'JPN', 'KOR', 'LTU', 'LUX', 'LVA', 'MEX',
                     'MLT', 'NLD', 'POL', 'PRT', 'ROM', 'RUS', 'SVK', 'SVN', 'SWE',
                     'TUR', 'TWN', 'USA', 'RoW'])
indexnames = ['L3_1_DVA_FIN','L3_4_RDV','L3_6_FVA_INT','L3_2_DVA_INT',
              'L3_5_FVA_FIN','L3_7_DDC','L3_3_DVA_INTrex','L3_5_MVA','L3_8_FDC']
years = np.arange(1995,2012).astype('str')

def get_data(indexname,year,country,option):
    '''
        index
        year
        country you want like USA
        option :tochn or chnto
        2*17*9*41
        '''
    if option == 'tochn':
        if os.path.exists('out/'+year+'/'+year+'_'+indexname+'_tochn.csv'):
            data = pd.read_csv('out/'+year+'/'+year+'_'+indexname+'_tochn.csv')
            ind =np.where(country==countrys)[0][0]
            dat = np.array(data.iloc[:,35*ind+1:35*(ind+1)+1])
            return True,dat, 'year: '+year+', indicator: '+indexname  +', country: '+country+' '+option,opt+'/'+year+'/'+country+'/'+index
        else:
            #print 'no such file: '+ 'out/'+year+'/'+year+'_'+indexname+'_tochn.csv'
            return False,'no such file: '+ 'out/'+year+'/'+year+'_'+indexname+'_chnto.csv'
    elif option =='chnto':
        if os.path.exists('out/'+year+'/'+year+'_'+indexname+'_chnto.csv'):
            data = pd.read_csv('out/'+year+'/'+year+'_'+indexname+'_chnto.csv')
            ind =np.where(country==countrys)[0][0]
            dat = np.array(data.iloc[:,35*ind+1:35*(ind+1)+1])
            return True,dat, 'year: '+year+', indicator: '+indexname  +', country: '+country+' '+option,opt+'/'+year+'/'+country+'/'+index
        else:
            #print 'no such file: '+ 'out/'+year+'/'+year+'_'+indexname+'_chnto.csv'
            return False,'no such file: '+ 'out/'+year+'/'+year+'_'+indexname+'_chnto.csv'

with h5py.File('wholedata') as f:
    for opt in tqdm(['tochn','chnto']):
        for year in tqdm(years):
            for country in tqdm(countrys):
                for index in indexnames:
                    if get_data(index,year,country,'tochn')[0]:
                        f.create_dataset(get_data(index,year,country,'tochn')[3],data=get_data(index,year,country,'tochn')[1])
                    else:
                        get_data(index,year,country,'tochn')[1]
