#!/bin/bash
{
for year in '2001' '2002' '2003' '2004' '2005', '2006' '2007' '2008' '2009' '2010' '2011' ; do
mkdir ${year}
cd ${year}
for name in '1_DVA_FIN.RData' '2_DVA_INT.RData' '3_DVA_INTrex.RData' '4_RDV.RData' '5_FVA_FIN.RData' '5_MVA.RData' '6_FVA_INT.RData' '7_DDC.RData' '8_FDC.RData'; do
wget -c 'http://139.129.209.66:8000/d/daedafb854/files/?p=/WIOD/WIOD_index2_Trade/'${year}'/L3_'${name}'&dl=1' -O ${year}_L3_${name}
done
cd ../
done
}

'1995' '1996' '1997' '1998' '1999' '2000' 
{
for year in '1999' '2000'  ; do
mkdir ${year}
cd ${year}
for name in '1_DVA_FIN.csv' '2_DVA_INT.csv' '3_DVA_INTrex.csv' '4_RDV.csv' '5_FVA_FIN.csv' '5_MVA.csv' '6_FVA_INT.csv' '7_DDC.csv' '8_FDC.csv'; do
wget -c 'http://139.129.209.66:8000/d/daedafb854/files/?p=/WIOD/WIOD_index2_Trade/'${year}'_L3_'${name}'&dl=1' -O ${year}_L3_${name}
done
cd ../
done
}
