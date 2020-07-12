set.seed(16)
act_scores<- replicate(B, {
    simulated_data <- rnorm(10000, 20.9, 5.7)    
    simulated_data    
})


set.seed(16)
act_scores <- rnorm(10000, 20.9, 5.7)  
mean(act_scores)
sd(act_scores)
sum(act_scores>=36)
sum(act_scores>30)/10000
mean(act_scores>30)
mean(act_scores<=10)
x<-1:36
f_x<-dnorm(x, 20.9, 5.7)
plot(x,f_x)

z_scores<-(act_scores-mean(act_scores))/sd(act_scores)

CDF <- function(x){
  mean(act_scores<=x)
}

y<-1:36

sapply(y,CDF)

qnorm(0.95,20.9,5.7)

p <- seq(0.01, 0.99, 0.01)
sample_quantiles<-quantile(act_scores, p)
theoretical_quantiles<-qnorm(p,20.9, 5.7)

plot(theoretical_quantiles,sample_quantiles)
