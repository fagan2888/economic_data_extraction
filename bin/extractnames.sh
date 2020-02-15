#!/bin/bash
{
for year in '1995' '1996' '1997' '1998' '1999' ; do
cd ${year}
for name in 'L3_1_DVA_FIN' 'L3_2_DVA_INT' 'L3_3_DVA_INTrex' 'L3_4_RDV' 'L3_5_FVA_FIN' 'L3_5_MVA' 'L3_6_FVA_INT' 'L3_7_DDC' 'L3_8_FDC'; do
awk 'NR==1{print}'  ${year}_${name}.csv > ${year}_${name}_row.csv     
awk -F',' '{print $1}'  ${year}_${name}.csv > ${year}_${name}_col.csv
done
cd ../
done
}
