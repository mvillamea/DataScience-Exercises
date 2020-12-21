# suggested libraries and options
library(tidyverse)
options(digits = 3)

# load brexit_polls object
library(dslabs)
data(brexit_polls)

p <- 0.481    # official proportion voting "Remain"
d <- 2*p-1    # official spread

#The final proportion of voters choosing "Remain" was  p=0.481 . Consider a poll with a sample of  N=1500  voters.
N<-1500
#expected value of voters choosing remain
mu<-N*p
mu
#standard error of the total number of voters choosing remain
sd<- sqrt(N*p*(1-p))
sd

#the expected value of the proportion of "Remain" voters
mu_hat<-p
mu_hat

#the standard error of the proportion of "Remain" voters
sd_hat<-sqrt(p*(1-p)/N)
sd_hat

#expected value of d
mu_d<- 2*mu_hat-1
mu_d

#standard error of the spread d
sd_d<- 2*sd_hat
sd_d

#average of the observed spreads 
avg_spread<-mean(brexit_polls$spread)
avg_spread

#standard deviation of the observed spread
sd_spread<-sd(brexit_polls$spread)
sd_spread

#d=2x-1
brexit_polls <- brexit_polls %>%
        mutate(x_hat = (spread+1)/2 )

#the average of x_hat, the estimates of the parameter  p
avg_x_hat<- mean(brexit_polls$x_hat)
avg_x_hat

#the standard deviation of x_hat

sd_x_hat<-sd(brexit_polls$x_hat)
sd_x_hat



#consider the first poll
data(brexit_polls)
first_poll<-brexit_polls[1,]
x_hat <- (first_poll$spread+1)/2
se_hat<-sqrt(x_hat*(1-x_hat)/first_poll$samplesize)

#lower bound of the 95% confidence interval 
lower<-x_hat-qnorm(0.975)*se_hat
lower

#upper bound of the 95% confidence interval
upper<-x_hat+qnorm(0.975)*se_hat
upper


#Create the data frame june_polls containing only Brexit polls ending in June 2016 (enddate of "2016-06-01" and later). We will calculate confidence intervals for all polls and determine how many cover the true value of  d .
#First, use mutate() to calculate a plug-in estimate se_x_hat for the standard error of the estimate  SE^[X]  for each poll given its sample size and value of  X^  (x_hat). Second, use mutate() to calculate an estimate for the standard error of the spread for each poll given the value of se_x_hat. Then, use mutate() to calculate upper and lower bounds for 95% confidence intervals of the spread. Last, add a column hit that indicates whether the confidence interval for each poll covers the correct spread  d=−0.038 .
brexit_polls <- brexit_polls %>%mutate(x_hat = (spread+1)/2)
x_hat*2-1

june_polls<-brexit_polls%>%filter(enddate >= "2016-06-01")%>%mutate(se_x_hat = sqrt(x_hat*(1-x_hat)/samplesize))%>%mutate(lower = (x_hat*2-1)-qnorm(0.975)*2*se_x_hat, upper = (x_hat*2-1)+qnorm(0.975)*2*se_x_hat)%>%mutate(is_d = ( lower< -0.038 & -0.038< upper) )

#proportion of polls that have a confidence interval that covers the value 0
sum(june_polls$lower<0 & june_polls$upper>0)/nrow(june_polls)

#proportion of polls that predict "Remain" (confidence interval entirely above 0)
sum(june_polls$lower>0)/nrow(june_polls)

#proportion of polls that have a confidence interval covering the true value of  d
sum(june_polls$is_d == TRUE)/nrow(june_polls)


#Group and summarize the june_polls object by pollster to find the proportion of hits for each pollster and the number of polls per pollster. Use arrange() to sort by hit rate.

june_polls<-june_polls %>% 
            group_by(pollster) %>%
            summarize( prop_hit = mean(is_d == TRUE) , num_polls = n() ) %>%
            arrange (prop_hit)

#Make a boxplot of the spread in june_polls by poll type
june_polls<-brexit_polls%>%filter(enddate >= "2016-06-01")%>%mutate(se_x_hat = sqrt(x_hat*(1-x_hat)/samplesize))%>%mutate(lower = (x_hat*2-1)-qnorm(0.975)*2*se_x_hat, upper = (x_hat*2-1)+qnorm(0.975)*2*se_x_hat)%>%mutate(is_d = ( lower< -0.038 & -0.038< upper) )

june_polls<- june_polls%>%mutate(spread = x_hat*2-1)

june_polls%>%ggplot(aes (poll_type, spread) ) + geom_boxplot()

#Calculate the confidence intervals of the spread combined across all polls in june_polls, grouping by poll type. Recall that to determine the standard error of the spread, you will need to double the standard error of the estimate.
combined_by_type <- june_polls %>%
        group_by(poll_type) %>%
        summarize(N = sum(samplesize),
                  spread = sum(spread*samplesize)/N,
                  p_hat = (spread + 1)/2)

combined_by_type<- combined_by_type %>% mutate (se = sqrt(p_hat*(1-p_hat)/N), lower = (p_hat*2-1)-qnorm(0.975)*2*se, upper = (p_hat*2-1)+qnorm(0.975)*2*se)

#online voters
combined_by_type%>%filter(poll_type == "Online")

combined_by_type%>%ggplot(aes (poll_type, spread) ) + geom_boxplot()



