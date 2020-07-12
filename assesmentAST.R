#44 preguntas
X<-sample(c(1, -0.25), 44, replace = TRUE, prob = c(1/5, 4/5))

#1 pregunta
X<-sample(c(1, -0.25), 1, replace = TRUE, prob = c(1/5, 4/5))

exp<-1*(1/5)-0.25*(4/5)

se<-(abs(1+0.25)*sqrt((1/5)*(4/5)))*sqrt(44)

1-pnorm(8,exp,se)

set.seed(21)

B<-10000

S <- replicate(B, {
  simulated_test <- sample(c(1, -0.25), 44, replace = TRUE, prob = c(1/5, 4/5))
  sum(simulated_test)
})

mean(S>=8)


expnuevo<-11


p <- seq(0.25, 0.95, 0.05)


range <- 0:44 #to give a range of possible scores on the test

mean_range <- mean(range)

sd_range <- sd(range)

qnorm(0.8, mean_range, sd_range)

[1] 33.054

qnorm(0.85, mean_range, sd_range)

[1] 35.612
