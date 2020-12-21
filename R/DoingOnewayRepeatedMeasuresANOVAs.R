setwd("/home/macarena/Documentos/DesigningRunningAndAnalyzingExperimentsCourse/materials")
dataset <- read.csv("websearch2.csv")
dataset$Subject = factor(dataset$Subject)
dataset$Order = factor(dataset$Order)
View(dataset)
summary(dataset)

# view descriptive statistics by Engine
library(plyr)
ddply(dataset, ~ Engine, function(data) summary(data$Searches))
ddply(dataset, ~ Engine, summarise, Searches.mean=mean(Searches), Searches.sd=sd(Searches))

#order effect test on Searches using a paired-samples t-test assuming equal variances
library(reshape2)
dataset.wide.order = dcast(dataset, Subject ~ Order, value.var="Searches") # go wide
t.test(dataset.wide.order$"1", dataset.wide.order$"2", paired=TRUE, var.equal=TRUE)

#paired-samples t-test, assuming equal variances, on Searches by Engine
dataset.wide.eng = dcast(dataset, Subject ~ Engine, value.var="Searches") # go wide
View(dataset.wide.eng)
t.test(dataset.wide.eng$Bing, dataset.wide.eng$Google, paired=TRUE, var.equal=TRUE)

#nonparametric Wilcoxon signed-rank test on the Effort Likert-type ratings
dataset$Engine = factor(dataset$Engine)
library(coin)
wilcoxsign_test(Effort ~ Engine | Subject, data=dataset, distribution="exact")


setwd("/home/macarena/Documentos/DesigningRunningAndAnalyzingExperimentsCourse/materials")
dataset <- read.csv("websearch3.csv")
dataset$Subject = factor(dataset$Subject)
dataset$Order = factor(dataset$Order)
View(dataset)
summary(dataset)

# view descriptive statistics by Engine
library(plyr)
ddply(dataset, ~ Engine, function(data) summary(data$Searches))
ddply(dataset, ~ Engine, summarise, Searches.mean=mean(Searches), Searches.sd=sd(Searches))

# repeated measures ANOVA within order
library(ez)
m = ezANOVA(dv=Searches, within=Order, wid=Subject, data=dataset)
m$Mauchly
m$ANOVA

# repeated measures ANOVA within Engine
library(ez)
m = ezANOVA(dv=Searches, within=Engine, wid=Subject, data=dataset)
m$Mauchly
m$ANOVA


# manual post hoc pairwise comparisons with paired-samples t-tests
library(reshape2)	
dataset.wide.eng = dcast(dataset, Subject ~ Engine, value.var="Searches") # go wide
View(dataset.wide.eng)
se.sc = t.test(dataset.wide.eng$Google, dataset.wide.eng$Bing, paired=TRUE)
se.vc = t.test(dataset.wide.eng$Google, dataset.wide.eng$Yahoo, paired=TRUE)
sc.vc = t.test(dataset.wide.eng$Bing, dataset.wide.eng$Yahoo, paired=TRUE)
p.adjust(c(se.sc$p.value, se.vc$p.value, sc.vc$p.value), method="holm")

#Conduct a nonparametric Friedman test on the Effort Likert-type ratings. Calculate an asymptotic p-value.
library(coin)
dataset$Engine = factor(dataset$Engine)
friedman_test(Effort ~ Engine | Subject, data=dataset, distribution="asymptotic")

#post hoc
dataset.wide.eff = dcast(dataset, Subject ~ Engine, value.var="Effort")
se.sc = wilcox.test(dataset.wide.eff$Google, dataset.wide.eff$Bing, paired=TRUE, exact=FALSE)
se.vc = wilcox.test(dataset.wide.eff$Google, dataset.wide.eff$Yahoo, paired=TRUE, exact=FALSE)
sc.vc = wilcox.test(dataset.wide.eff$Bing, dataset.wide.eff$Yahoo, paired=TRUE, exact=FALSE)
p.adjust(c(se.sc$p.value, se.vc$p.value, sc.vc$p.value), method="holm")



