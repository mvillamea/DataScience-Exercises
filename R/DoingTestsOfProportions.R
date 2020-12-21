setwd("/home/macarena/Documentos/DesigningRunningAndAnalyzingExperimentsCourse/materials")
data <- read.csv("deviceprefs.csv")
View(data)
data$Subject = factor(data$Subject)
summary(data)

library(tidyverse)
#dataset only with disability
disability <- data%>%filter(Disability == "1")
dim(disability)

#dataset only without disability
no_disability <- data%>%filter(Disability == "0")

#performing a chi-squared test ignoring disabilities
prfs <- xtabs( ~ Pref , data=data)
View(prfs)
chisq.test(prfs)

#Binomial test for people without disabilities
dis = binom.test(dim(disability)[1], nrow(data), p=1/2)
plot(df[df$Disability == "1",]$Pref)
binom.test(sum(df[df$Disability == "1",]$Pref == "touchpad"), nrow(df[df$Disability == "1",]), p=1/2)

#Binomial test for people with disabilities
no_dis = binom.test(dim(no_disability)[1], nrow(data), p=1/2)

#performing a chi-squared test considering disabilities
prfs <- xtabs( ~ Pref + Disability , data=data)
View(prfs)
chisq.test(prfs)

#Performing a two sample G-test
library(DescTools) #tiene Gtest y es para R 4.0
GTest(prfs)

#Performing a Fisher test
fisher.test(prfs)