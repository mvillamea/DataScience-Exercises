
set.seed(1) # set.seed(1, sample.kind="Rounding") if using R 3.6 or later
disease <- sample(c(0,1), size=1e6, replace=TRUE, prob=c(0.98,0.02))
test <- rep(NA, 1e6)
test[disease==0] <- sample(c(0,1), size=sum(disease==0), replace=TRUE, prob=c(0.90,0.10))
test[disease==1] <- sample(c(0,1), size=sum(disease==1), replace=TRUE, prob=c(0.15, 0.85))

#calculate the probability that a test is positive
mean(test)

#The probability of having the disease given a negative test:
mean(disease[test==0])

#The probability of having the disease if the test is positive:
mean(disease[test==1])

#If a patient's test is positive, how much does that increase their risk of having the disease?
#First calculate the probability of having the disease given a positive test, then divide by the probability of having the disease.
mean(disease[test==1])/mean(disease)

#OTRO EJERCICIO

library(dslabs)
data("heights")

#Round the heights to the closest inch. Plot the estimated conditional probability  P(x)=Pr(Male|height=x)  for each  x .
heights %>% 
	mutate(height = round(height)) %>%
	group_by(height) %>%
	summarize(p = mean(sex == "Male")) %>%
        qplot(height, p, data =.)

#use the quantile  0.1,0.2,…,0.9  and the cut() function to assure each group has the same number of points. Note that for any numeric vector x, you can create groups based on quantiles like this: cut(x, quantile(x, seq(0, 1, 0.1)), include.lowest = TRUE)

ps <- seq(0, 1, 0.1)
heights %>% 
	mutate(g = cut(height, quantile(height, ps), include.lowest = TRUE)) %>%
	group_by(g) %>%
	summarize(p = mean(sex == "Male"), height = mean(height)) %>%
	qplot(height, p, data =.)


library(MASS)
library(tidyverse)
Sigma <- 9*matrix(c(1,0.5,0.5,1), 2, 2)
dat <- MASS::mvrnorm(n = 10000, c(69, 69), Sigma) %>%
	data.frame() %>% setNames(c("x", "y"))
plot(dat)
#estimate the conditional expectations and make a plot.

ps <- seq(0, 1, 0.1)
dat %>% mutate(g = cut(x, quantile(x, ps), include.lowest = TRUE)) %>%
group_by(g) %>%
summarize(y = mean(y), x = mean(x)) %>%
	qplot(x, y, data =.)
