#In a model for sons’ heights vs fathers’ heights, what is the least squares estimate (LSE) for  β1  if we assume  β^0  is 36?
rss <- function(beta0, beta1, data){
    resid <- galton_heights$son - (beta0+beta1*galton_heights$father)
    return(sum(resid^2))
}
beta1 = seq(0, 1, len=nrow(galton_heights))
results <- data.frame(beta1 = beta1,
                      rss = sapply(beta1, rss, beta0 = 36))
results %>% ggplot(aes(beta1, rss)) + geom_line() + 
  geom_line(aes(beta1, rss), col=2)

#Load the Lahman library and filter the Teams data frame to the years 1961-2001. Run a linear model in R predicting the number of runs per game based on both the number of bases on balls per game and the number of home runs per game.
#What is the coefficient for bases on balls?
library(Lahman)
library(tidyverse)
library(dslabs)
dat <- Teams %>% filter(yearID %in% 1961:2001)%>%
    mutate(HR_per_game = HR / G, R_per_game = R / G, BB_per_game = BB / G) 
fit <- lm(R_per_game ~ BB_per_game + HR_per_game, data = dat)
fit
summary(fit)

#plot the predictions and confidence intervals for our linear model of sons’ heights
#forma 1
galton_heights %>% ggplot(aes(father, son)) +
    geom_point() +
    geom_smooth(method = "lm")

#forma 2
model <- lm(son ~ father, data = galton_heights)
predictions <- predict(model, interval = c("confidence"), level = 0.95)
data <- as_tibble(predictions) %>% bind_cols(father = galton_heights$father)

ggplot(data, aes(x = father, y = fit)) +
    geom_line(color = "blue", size = 1) + 
    geom_ribbon(aes(ymin=lwr, ymax=upr), alpha=0.2) + 
    geom_point(data = galton_heights, aes(x = father, y = son))

#ejercicio nuevo
set.seed(1989) #if you are using R 3.5 or earlier
set.seed(1989, sample.kind="Rounding") #if you are using R 3.6 or later
library(HistData)
data("GaltonFamilies")
options(digits = 3)    # report 3 significant digits

female_heights <- GaltonFamilies %>%     
    filter(gender == "female") %>%     
    group_by(family) %>%     
    sample_n(1) %>%     
    ungroup() %>%     
    select(mother, childHeight) %>%     
    rename(daughter = childHeight)

# fit regression line to predict mother's height from daughter's height
fit <- lm(mother ~ daughter, data = female_heights)
fit

# height of the first mother in the set
female_heights[1]

#height of the first mother in the set according to the model
44.18+69*0.31

#OTRO EJERCICIO
library(Lahman)
bat_02 <- Batting %>% filter(yearID == 2002) %>%
    mutate(pa = AB + BB, singles = (H - X2B - X3B - HR)/pa, bb = BB/pa) %>%
    filter(pa >= 100) %>%
    select(playerID, singles, bb)
#Now compute a similar table but with rates computed over 1999-2001. Keep only rows from 1999-2001 where players have 100 or more plate appearances, calculate each player's single rate and BB rate per season, then calculate the average single rate (mean_singles) and average BB rate (mean_bb) per player over those three seasons.
bat <- Batting %>% filter(yearID %in% 1999:2001) %>%
    mutate(pa = AB + BB, singles = (H - X2B - X3B - HR)/pa, bb = BB/pa) %>%
    filter(pa >= 100) %>%
    select(playerID, singles, bb)%>% 
	group_by(playerID) %>% 
	summarize(mean_bb = mean(bb), mean_singles = mean(singles)) 

sum( bat$mean_singles > 0.2)
sum(bat$mean_bb > 0.2)

#Use inner_join() to combine the bat_02 table with the table of 1999-2001 rate averages you created in the previous question.
newbat<-inner_join(bat_02,bat)
#correlation between 2002 singles rates and 1999-2001 average singles rates
newbat%>%summarize(r = cor(singles, mean_singles)) %>%
    pull(r)
#correlation between 2002 BB rates and 1999-2001 average BB rates
newbat%>%summarize(r = cor(bb, mean_bb)) %>%
    pull(r)

#scatterplots of mean_singles versus singles
newbat%>%ggplot(aes(singles, mean_singles))+
    geom_point(alpha = 0.5)
#mean_bb versus bb
newbat%>%ggplot(aes(bb, mean_bb))+
    geom_point(alpha = 0.5)
#linear model to predict 2002 singles given 1999-2001 mean_singles
fit <- lm(singles ~ mean_singles, data = newbat)
fit
#linear model to predict 2002 bb given 1999-2001 mean_bb
fit2 <- lm(bb ~ mean_bb, data = newbat)
fit2
