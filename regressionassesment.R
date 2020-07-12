library(Lahman)
library(tidyverse)
ibrary(broom)
 fit <- Teams %>% 
     filter(yearID %in% 1961:2001) %>% 
     mutate(BB = BB / G, 
           singles = (H - X2B - X3B - HR) / G, 
            doubles = X2B / G, 
            triples = X3B / G, 
            HR = HR / G,
            R = R / G) %>%  
     lm(R ~ BB + singles + doubles + triples + HR, data = .)
 coefs <- tidy(fit, conf.int = TRUE)
 coefs

#formula regresión
#intercept+cantbb*BB+cantsing*singles+cantdoubles*doubles+canttriples*triples+cantHR*HR

#Use the Teams data frame from the Lahman package. Fit a multivariate linear regression model to obtain the effects of BB and HR on Runs (R) in 1971. Use the tidy() function in the broom package to obtain the results in a data frame.
fit <- Teams %>% 
     filter(yearID == 1971) %>% 
     mutate(BB = BB / G, 
            HR = HR / G,
            R = R / G) %>%  
     lm(R ~ BB + HR, data = .)
 coefs <- tidy(fit, conf.int = TRUE)
 coefs
#The p-value for HR is less than 0.05, but the p-value of BB is greater than 0.05 (0.06), so the evidence is not strong enough to suggest that BB has a significant effect on runs at a p-value cutoff of 0.05.

#Repeat the above exercise to find the effects of BB and HR on runs (R) for every year from 1961 to 2018 using do() and the broom package.
#Make a scatterplot of the estimate for the effect of BB on runs over time and add a trend line with confidence intervals.
Teams %>% 
    filter(yearID %in% 1961:2018) %>% 
    group_by(yearID) %>% 
    do(tidy(lm(R~BB+HR, data= . ), conf.int = TRUE)) %>% 
    filter(term=="BB") %>% 
    ungroup() %>% 
    ggplot(aes(x=yearID, y= estimate)) +
    geom_point() + 
    geom_smooth(method = "lm")

#Fit a linear model on the results from Question 10 to determine the effect of year on the impact of BB
Teams %>% filter(yearID %in% 1961:2018) %>% 
          group_by(yearID) %>% 
          do(tidy(lm(R~BB+HR, data= . ), conf.int = TRUE)) %>% 
          filter(term=="BB") %>% 
          lm(estimate~yearID, data=.) %>% 
          tidy()

