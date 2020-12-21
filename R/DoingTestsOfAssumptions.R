setwd("/home/macarena/Documentos/DesigningRunningAndAnalyzingExperimentsCourse/materials")
dataset <- read.csv("designtime.csv")
View(dataset)
dataset$Subject = factor(dataset$Subject)

#boxplot
library(plyr)
library(tidyverse)
dataset%>%ggplot(aes(Tool, Time)) + geom_boxplot()

#Testing ANOVA
#Shapiro test
shapiro.test(dataset[dataset$Tool == "Illustrator",]$Time)
shapiro.test(dataset[dataset$Tool == "InDesign",]$Time)

#Shapiro test on residuals
m = aov(Time ~ Tool, data=dataset) # fit model
shapiro.test(residuals(m)) # test residuals

#Testing homoscedasticity
library(car)
leveneTest(Time ~ Tool, data=dataset, center=median) #Brown-Forsythe test

#Testing for lognormality
library(MASS)
fit = fitdistr(dataset[dataset$Tool == "Illustrator",]$Time, "lognormal")$estimate
ks.test(dataset[dataset$Tool == "Illustrator",]$Time, "plnorm", meanlog=fit[1], sdlog=fit[2], exact=TRUE)
fit = fitdistr(dataset[dataset$Tool == "InDesign",]$Time, "lognormal")$estimate
ks.test(dataset[dataset$Tool == "InDesign",]$Time, "plnorm", meanlog=fit[1], sdlog=fit[2], exact=TRUE)


# create a new column in dataset defined as log(Time)
dataset$logTime = log(dataset$Time) # log transform

#descriptive statistics by Tool
ddply(dataset, ~ Tool, summarise, Time.mean=mean(Time), Time.sd=sd(Time))

#Running independent-samples t-test 
t.test(logTime ~ Tool, data=dataset, var.equal=TRUE)

#Running nonparametric equivalent of independent-samples t-test - Mann-Whitney U test
library(coin)
dataset$Tool = factor(dataset$Tool)
wilcox.test(Time ~ Tool, data=dataset, distribution="exact")
