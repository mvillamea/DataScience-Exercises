library(tidyverse)
library(dslabs)
data(death_prob)
head(death_prob)

#death probability of a 50 year old female
fem50 <- death_prob%>%filter(age == 50 & sex == "Female")
probdeath_fem50<-fem50$prob

#The loss in the event of the policy holder's death is -$150,000 and the gain if the policy holder remains alive is the premium $1,150.
#What is the expected value of the company's net profit on one policy for a 50 year old female
-150000*probdeath_fem50+1150*(1-probdeath_fem50)

#Calculate the standard error of the profit on one policy for a 50 year old female.
abs(-150000-1150)*sqrt(probdeath_fem50*(1-probdeath_fem50))

#What is the expected value of the company's profit over all 1,000 policies for 50 year old females?
(-150000*probdeath_fem50+1150*(1-probdeath_fem50))*1000

#What is the standard error of the sum of the expected value over all 1,000 policies for 50 year old females?
abs(-150000-1150)*sqrt(probdeath_fem50*(1-probdeath_fem50))*sqrt(1000)

#Use the Central Limit Theorem to calculate the probability that the insurance company loses money on this set of 1,000 policies.
mu<-(-150000*probdeath_fem50+1150*(1-probdeath_fem50))*1000
sd<-abs(-150000-1150)*sqrt(probdeath_fem50*(1-probdeath_fem50))*sqrt(1000)
pnorm(0,mu,sd)

#Use death_prob to determine the probability of death within one year for a 50 year old male.
male50 <- death_prob%>%filter(age == 50 & sex == "Male")
probdeath_male50<-male50$prob
probdeath_male50

Use the formula for expected value of the sum of draws with the following values and solve for the premium  b.

#Use the formula for expected value of the sum of draws with the following values and solve for the premium  b
p <- probdeath_male50
mu_sum <- 700000
n <- 1000
a <- -150000

b <- (mu_sum/n-a*p)/(1-p)
b

#calculate the standard error
sd_sum<-abs(b-a)*sqrt(p*(1-p))*sqrt(n)

pnorm(0, mu_sum, sd_sum)

#we'll look at a scenario in which a lethal pandemic disease increases the probability of death within 1 year for a 50 year old to .015. Unable to predict the outbreak, the company has sold 1,000 $150,000 life insurance policies for $1,150.
mu<-(0.015*(-150000)+1150*(1-0.015))*1000

#What is the standard error of the expected value of the company's profits over 1,000 policies?
sd<-abs(1150+150000)*sqrt(0.015*(1-0.015))*sqrt(1000)

#What is the probability of the company losing money?
pnorm(0, mu, sd)

pnorm(-1000000, mu, sd)

#Investigate death probabilities p <- seq(.01, .03, .001).
#What is the lowest death probability for which the chance of losing money exceeds 90%
p <- seq(.01, .03, .001)
proba<-function(p){
    mu<-(p*(-150000)+1150*(1-p))*1000
    sd<-abs(1150+150000)*sqrt(p*(1-p))*sqrt(1000)
    pnorm(0,mu,sd)
    }
sapply(p, proba)
sapply(p,proba) > 0.9
p[which(sapply(p,proba) > 0.9)]
min(p[which(sapply(p,proba) > 0.9)])

#Investigate death probabilities p <- seq(.01, .03, .0025).
#What is the lowest death probability for which the chance of losing over $1 million exceeds 90%
p <- seq(.01, .03, .0025)
proba_perdermillon<-function(p){
                    mu<-(p*(-150000)+1150*(1-p))*1000
                    sd<-abs(1150+150000)*sqrt(p*(1-p))*sqrt(1000)
                    pnorm(-1000000,mu,sd)
                    }
sapply(p,proba)
sapply(p,proba) > 0.9
min(p[which(sapply(p,proba) > 0.9)])

#Define a sampling model for simulating the total profit over 1,000 loans with probability of claim p_loss = .015, loss of -$150,000 on a claim, and profit of $1,150 when there is no claim. Set the seed to 25, then run the model once.
set.seed(25, sample.kind = "Rounding")
simulated_loans <- sample(c(-150000,1150), 1000, replace = TRUE, prob = c(0.015, 1-0.015))
sum(simulated_loans)/(10^6)

#Set the seed to 27, then run a Monte Carlo simulation of your sampling model with 10,000 replicates to simulate the range of profits/losses over 1,000 loans.

set.seed(27, sample.kind = "Rounding")
results <- replicate(10000, {
          simulated_loans <- sample(c(-150000,1150), 1000, replace = TRUE, prob = c(0.015, 1-0.015))
          sum(simulated_loans)
          }
          )


#What is the observed probability of losing $1 million or more?
mean(results<=-1000000)


#Suppose that there is a massive demand for life insurance due to the pandemic, and the company wants to find a premium cost for which the probability of losing money is under 5%, assuming the death rate stays stable at  p=0.015 .
#Calculate the premium required for a 5% chance of losing money given  n=1000  loans, probability of death  p=0.015 , and loss per claim  l=−150000 . Save this premium as x for use in further questions.

p<-0.015
n<-1000
l<--150000

x<-seq(3000, 4000, 10)

proba_perder<-function(x){
              mu<-(p*(-150000)+x*(1-p))*1000
              sd<-abs(x+150000)*sqrt(p*(1-p))*sqrt(1000)
              pnorm(0,mu,sd)
              }

sapply(x,proba_perder)
min(x[which(sapply(x,proba_perder) < 0.05)])

x<-3270

mu<-(p*(-150000)+x*(1-p))*1000

#Run a Monte Carlo simulation with B=10000to determine the probability of losing money on 1,000 policies given the new premium x, loss on a claim of $150,000, and probability of claim  p=.015 . Set the seed to 28 before running your simulation.
#What is the probability of losing money here?
set.seed(28, sample.kind = "Rounding")

p<-0.015
n<-1000
l<--150000
x<-3270
results <- replicate(10000, {
          x<-3270
          simulated_loans <- sample(c(-150000,x), 1000, replace = TRUE, prob = c(0.015, 1-0.015))
          sum(simulated_loans)
          }
          )

mean(results<0)

#The company cannot predict whether the pandemic death rate will stay stable. Set the seed to 29, then write a Monte Carlo simulation that for each of  B=10000  iterations:
#randomly changes  p  by adding a value between -0.01 and 0.01 with sample(seq(-0.01, 0.01, length = 100), 1)
#uses the new random  p  to generate a sample of  n=1,000  policies with premium x and loss per claim  l=−150000 
#returns the profit over  n  policies (sum of random variable)
#The outcome should be a vector of  B  total profits. Use the results of the Monte Carlo simulation to answer the following three questions.

set.seed(29, sample.kind = "Rounding")
results <- replicate(10000, {
           x<-3270
           q<-sample(seq(-0.01, 0.01, length = 100), 1)
           p<-0.015+q
           simulated_loans <- sample(c(-150000,x), 1000, replace = TRUE, prob = c(p,1-p ))
           sum(simulated_loans)
          }
          )
mean(results)
mean(results<0)
mean(results<   -1000000)
    


