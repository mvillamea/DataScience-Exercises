setwd("/home/macarena/Documentos/JohnsHopkins/Curso2")
read.table("hw1_data.csv")
tablita<-read.csv("hw1_data.csv")
tablita[1:2,]
nrow(tablita)
tablita[152:153,]
tablita[47,]
tab<-tablita[,1]
tab2<-tablita$Ozone
sum(is.na(tab2))
good<-complete.cases(tab2)
mean(tab2[good])

library(tidyverse)
tab3<-tablita%>%filter("Ozone">31 & "Temp">90)
tab4<-tab3$Solar.R
ind<-complete.cases(tab4)
mean(tab4[ind])

