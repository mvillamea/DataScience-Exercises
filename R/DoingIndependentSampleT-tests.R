setwd("/home/macarena/Documentos/DesigningRunningAndAnalyzingExperimentsCourse/materials")
dataset <- read.csv("timeonsite.csv")
View(dataset)
dataset$Subject = factor(dataset$Subject)

library(tidyverse)
#number of subjects exposed to A
subjects_A <- dataset%>%filter(Site == "A")
dim(subjects_A)[1]
#number of subjects exposed to B
subjects_B <- dataset%>%filter(Site == "B")
dim(subjects_B)[1]

#descriptive statistics by site
library(plyr)
summary(dataset)
ddply(dataset, ~ Site, function(dataset) summary(dataset$Time))

#independent-samples t-test
t.test(Time ~ Site, data=dataset, var.equal=TRUE)

# graph histograms and a boxplot
hist(dataset[dataset$Site == "A",]$Time)
hist(dataset[dataset$Site == "B",]$Time)

