setwd("/home/macarena/Documentos/DesigningRunningAndAnalyzingExperimentsCourse/materials")
dataset <- read.csv("alphabets.csv")
View(dataset)
dataset$Alphabet = factor(dataset$Alphabet)

#average text entry speed in words per minute (WPM) of the EdgeWrite alphabet
library(tidyverse)
EdgeWrite <- dataset%>%filter(Alphabet == "EdgeWrite")
mean(EdgeWrite$WPM)

#Conduct Shapiro-Wilk normality tests on the WPM response for each Alphabet.
#Unistrokes
shapiro.test(dataset[dataset$Alphabet == "Unistrokes",]$WPM)

#Graffiti
shapiro.test(dataset[dataset$Alphabet == "Graffiti",]$WPM)

#Edgewrite
shapiro.test(dataset[dataset$Alphabet == "EdgeWrite",]$WPM)

#Shapiro-Wilk normality test on the residuals of a WPM by Alphabet model
m = aov(WPM ~ Alphabet, data=dataset) # fit model
shapiro.test(residuals(m)) # test residuals

#Brown-Forsythe homoscedasticity test on WPM by Alphabet
library(car)
leveneTest(WPM ~ Alphabet, data=dataset, center=median) #Brown-Forsythe test

#One-way ANOVA on WPM by Alphabet
m = aov(WPM ~ Alphabet, data=dataset) # fit model
anova(m)

# simultaneous pairwise comparisons among levels of Alphabet using the Tukey approach
library(multcomp)
dataset$Alphabet = factor(dataset$Alphabet)
summary(glht(m, mcp(Alphabet="Tukey")), test=adjusted(type="holm")) 

# Kruskal-Wallis test
library(coin)
kruskal_test(WPM ~ Alphabet, data=dataset, distribution="asymptotic")

# manual post hoc Mann-Whitney U pairwise comparisons
# note: wilcox_test we used above doesn't take two data vectors, so use wilcox.test
EW_G = wilcox.test(dataset[dataset$Alphabet == "EdgeWrite",]$WPM, dataset[dataset$Alphabet == "Graffiti",]$WPM, exact=FALSE)
EW_U = wilcox.test(dataset[dataset$Alphabet == "EdgeWrite",]$WPM, dataset[dataset$Alphabet == "Unistrokes",]$WPM, exact=FALSE)
G_U = wilcox.test(dataset[dataset$Alphabet == "Graffiti",]$WPM, dataset[dataset$Alphabet == "Unistrokes",]$WPM, exact=FALSE)
p.adjust(c(EW_G$p.value, EW_U$p.value, G_U$p.value), method="holm")
