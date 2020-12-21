library(broom)
library(tidyverse)
library(Lahman)
library(dslabs)

#relationship between home runs and runs per game varies by baseball league.
dat <- Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(HR = HR/G,
         R = R/G) %>%
  select(lgID, HR, BB, R) 

dat %>% 
  group_by(lgID) %>% 
  do(tidy(lm(R ~ HR, data = .), conf.int = T)) %>% 
  filter(term == "HR") 

#otro ej
library(tidyverse)
library(HistData)
data("GaltonFamilies")
set.seed(1) # if you are using R 3.5 or earlier
set.seed(1, sample.kind = "Rounding") # if you are using R 3.6 or later
galton <- GaltonFamilies %>%
    group_by(family, gender) %>%
    sample_n(1) %>%
    ungroup() %>% 
    gather(parent, parentHeight, father:mother) %>%
    mutate(child = ifelse(gender == "female", "daughter", "son")) %>%
    unite(pair, c("parent", "child"))

galton
#Group by pair and summarize the number of observations in each group.
galton %>%
    group_by(pair) %>%
    summarize(n = n())


#correlation coefficients for fathers and daughters, fathers and sons, mothers and daughters and mothers and sons
#todos
galton %>%
    group_by(pair) %>%
    summarize(cor = cor(parentHeight, childHeight))

#minimo
galton %>%
    group_by(pair) %>%
    summarize(cor = cor(parentHeight, childHeight)) %>%
    filter(cor == min(cor))
#maximo
galton %>%
    group_by(pair) %>%
    summarize(cor = cor(parentHeight, childHeight)) %>%
    filter(cor == max(cor))


#Use lm() and the broom package to fit regression lines for each parent-child pair type. Compute the least squares estimates, standard errors, confidence intervals and p-values for the parentHeight coefficient for each pair.
galton3 <- galton %>% group_by(pair) %>% 
  do(tidy(lm(childHeight ~ parentHeight, data = .), conf.int = TRUE))
#estimate of the father-daughter coefficient: is the estimate
#For every 1-inch increase in mother's height, how many inches does the typical son's height increase: es el estimate

#sets of parent-child heights are significantly correlated at a p-value cut off of .05
galton3%>%filter(p.value<0.05)

#confidence intervals
galton3%>%
  select(pair, estimate, conf.low, conf.high) %>%
  ggplot(aes(pair, y = estimate, ymin = conf.low, ymax = conf.high)) +
  geom_errorbar() +
  geom_point()

#otra forma
galton %>%
    group_by(pair) %>%
    do(tidy(lm(childHeight ~ parentHeight, data = .), conf.int = TRUE)) %>%
    filter(term == "parentHeight" & p.value < .05)

#Because the confidence intervals overlap, the data are consistent with inheritance of height being independent of the child's or the parent's gender.


