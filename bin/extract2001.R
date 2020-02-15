#! /usr/bin/env Rscript 
extract2001 <- function(filename,year){
    filname<-paste('out','/',year,'/',year,'_',filename,sep = "")
    path1<- paste(filname,'tochn.csv',sep = "_")
    path2<- paste(filname,'chnto.csv',sep = "_")

  filepath <- paste(year,'/',year,'_',filename,'.RData',sep = "")
  myenv<- new.env()
  data<-load(filepath,envir = myenv)
  dat<-get(data,envir = myenv)
  datt<-dat[,,7]

  my.array1 <- array(dim=c(35,35*41))
  for (i in 1:41){
      left<-1+35*(i-1)
      right<-35*i
      my.array1[,left:right]<-datt[left:right,left:right]
  }
  dataframe1 <-data.frame(my.array1)
  colname<-unlist(read.csv('countrynamesasrow.txt'))
  colnames(dataframe1)<-(colname)

    my.array2 <- array(dim=c(35,35*41))
    for (i in 1:41){
        left<-1+35*(i-1)
        right<-35*i
        my.array2[,left:right]<-dat[211:245,211:245,i]
    }
dataframe2 <-data.frame(my.array2)
colnames(dataframe2)<-colname
  write.csv(dataframe1,file = path1)
  write.csv(dataframe2,file=path2)
}



filnames <- list('L3_1_DVA_FIN','L3_2_DVA_INT','L3_3_DVA_INTrex','L3_4_RDV','L3_5_FVA_FIN','L3_5_MVA','L3_6_FVA_INT','L3_7_DDC','L3_8_FDC')
years <- list(2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010,2011)
for (i in 6){
  for (j in 3:9){
    extract2001(filnames[j],years[i])
  }
}

#setwd('/Share/home/chenxupeng/projects/economics/')

