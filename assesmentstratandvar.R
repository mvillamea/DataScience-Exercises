set.seed(1989) #if you are using R 3.5 or earlier
set.seed(1989, sample.kind="Rounding") #if you are using R 3.6 or later
library(HistData)
data("GaltonFamilies")

female_heights <- GaltonFamilies%>%     
    filter(gender == "female") %>%     
    group_by(family) %>%     
    sample_n(1) %>%     
    ungroup() %>%     
    select(mother, childHeight) %>%     
    rename(daughter = childHeight)

mu_x <- mean(female_heights$mother)
mu_y <- mean(female_heights$daughter)
s_x <- sd(female_heights$mother)
s_y <- sd(female_heights$daughter)
c(mu_x, s_x, mu_y, s_y)
r <- cor(female_heights$mother, female_heights$daughter)
r

m <- r * s_y/s_x
m
b <- mu_y - m*mu_x
b

#What percent of the variability in daughter heights is explained by the mother's height?
r*r*100

#A mother has a height of 60 inches. What is the conditional expected value of her daughter's height given the mother's height?
mu_y+r*((60-mu_x)/s_x)*s_y
