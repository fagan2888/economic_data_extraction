#! /usr/bin/env Rscript 
dim_rowcol <- function(filename,year){
    filname<-paste(year,'/',year,'_',filename,sep = "")
    path1<- paste(filname,'row.csv',sep = "_")
    path2<- paste(filname,'col.csv',sep = "_")
    path3<- paste(filname,'dim.csv',sep = "_")
    if (!file.exists(path1)){
  filepath <- paste(year,'/',year,'_',filename,'.RData',sep = "")
  myenv<- new.env()
data<-load(filepath,envir = myenv)
  dat<-get(data,envir = myenv)
  rowname<-row.names(dat)
  colname<-colnames(dat)
  write.csv(rowname,file = path1)
  write.csv(colname,file=path2)
        write.csv(dim(dat),file=path3)}
    else{print ('ok')}
}



filnames <- list('L3_1_DVA_FIN','L3_2_DVA_INT','L3_3_DVA_INTrex','L3_4_RDV','L3_5_FVA_FIN','L3_5_MVA','L3_6_FVA_INT','L3_7_DDC','L3_8_FDC')
years <- list(2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010,2011)
for (i in 4:8){
  for (j in 1:9){
    dim_rowcol(filnames[j],years[i])
  }
}

#setwd('/Share/home/chenxupeng/projects/economics/')

