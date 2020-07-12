options(digits = 3)    # report 3 significant digits
library(tidyverse)
library(titanic)

titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>%
  mutate(Survived = factor(Survived),
         Pclass = factor(Pclass),
         Sex = factor(Sex))
titanic%>%
  ggplot(aes(x = Age, y = ..count.., fill = Sex)) + 
  geom_density(alpha=0.2) 


#qqplot
titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>%
  mutate(Survived = factor(Survived),
         Pclass = factor(Pclass),
         Sex = factor(Sex))%>%filter(!is.na(Age))
params <- titanic %>%
  filter(!is.na(Age)) %>%
  summarize(mean = mean(Age), sd = sd(Age))
titanic%>%ggplot(aes(sample = Age)) + geom_qq(dparams = params)

#bar plot

options(digits = 3)    # report 3 significant digits
library(tidyverse)
library(titanic)

titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>%
  mutate(Survived = factor(Survived),
         Pclass = factor(Pclass),
         Sex = factor(Sex))%>%filter(!is.na(Age))
titanic%>% ggplot(aes(Sex, fill=Survived)) +
  geom_bar(position = position_dodge()) 

#box plot
options(digits = 3)    # report 3 significant digits
library(tidyverse)
library(titanic)

titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>%
  mutate(Survived = factor(Survived),
         Pclass = factor(Pclass),
         Sex = factor(Sex))%>%filter(!is.na(Fare))%>%filter(Fare>0)
titanic%>%group_by(Survived)%>%ggplot(aes(Fare, Survived))+ scale_x_continuous(trans = "log2") + geom_boxplot( alpha = 0.2)+ geom_point(size = 1)

#otra forma
titanic %>%
    filter(Fare > 0) %>%
    ggplot(aes(Survived, Fare)) +
    geom_boxplot() +
    scale_y_continuous(trans = "log2") +
    geom_jitter(alpha = 0.2)

# barplot of passenger class filled by survival
titanic %>%
    ggplot(aes(Pclass, fill = Survived)) +
    geom_bar() +
    ylab("Count")
# barplot of passenger class filled by survival with position_fill
titanic %>%
    ggplot(aes(Pclass, fill = Survived)) +
    geom_bar(position = position_fill()) +
    ylab("Proportion")
# Barplot of survival filled by passenger class with position_fill
titanic %>%
    ggplot(aes(Survived, fill = Pclass)) +
    geom_bar(position = position_fill()) +
    ylab("Proportion")


  
