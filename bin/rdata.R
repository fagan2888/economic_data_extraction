data <-load('L3_1_DVA_FIN.RData')
newarr <- matrix(nrow=48*35,ncol=48*35)
for (i in 1:48){for (j in 1:48){newarr[1+(i-1)*35:i*35,(j-1)*35+1:j*35] = L3_1_DVA_FIN[1+(i-1)*35:i*35,(j-1)*35*48+1+(i-1)*35:(j-1)*35*48+i*35]}}



loadingnames <- function(filename){
  myenv <-new.env()
  load(filename,envir = myenv)
  rowname<-row.names(myenv$L3_1_DVA_FIN)
  colname<-colnames(myenv$L3_1_DVA_FIN)
  path1<- paste(filename,'rownames.csv',sep = "_")
  path2<- paste(filename,'colnames.csv',sep = "_")
  write.csv(rowname,file = path1)
  write.csv(colname,file=path2)
}

for(i in 1:15){
  year<- i+1999
  filename = paste(year,'L3_1_DVA_FIN.RData',sep='_')
  loading(filename)
}


loading <- function(filename){
  myenv <-new.env()
  load(filename,envir = myenv)
  path<- paste(filename,'.csv',sep = "")
  write.csv( myenv$L3_1_DVA_FIN, file = path)
}

mylist <- list()
for(i in 1:15){
  year<- i+1999
  mylist[i] <- paste(year,'L3_1_DVA_FIN.RData',sep='_')
}

for(i in 1:2){
  loading(mylist[i])
}
setwd()

#name:L3_2_DVA_INT  filename:2000_L3_2_DVA_INT.RData
dim_rowcol('2000_L3_2_DVA_INT.RData',2000)

dim_rowcol <- function(filename,year){
  filepath <- paste(year,'/',filename,sep = "")
  myenv<- new.env() 
  data<-load(filepath,envir = myenv )
  dat<-get(data,envir = myenv)
  rowname<-row.names(dat)
  colname<-colnames(dat)
  path1<- paste(filepath,'rownames.csv',sep = "_")
  path2<- paste(filepath,'colnames.csv',sep = "_")
  path3<- paste(filepath,'dim.csv',sep = "_")
  write.csv(rowname,file = path1)
  write.csv(colname,file=path2)
  write.csv(dim(dat),file=path3)
}
filnames <- list('L3_1_DVA_FIN.RData','L3_4_RDV.RData','L3_6_FVA_INT.RData','L3_2_DVA_INT.RData','L3_5_FVA_FIN.RData','L3_7_DDC.RData','L3_3_DVA_INTrex.RData','L3_5_MVA.RData','L3_8_FDC.RData')
years <- list(2000, 2005,2008 ,2011,2015)
for (i in 1:5){
  for (j in 1:9){
    dim_rowcol(paste(years[i],'_',filnames[j],sep = ''),years[i])  
  }
}