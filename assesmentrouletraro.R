prob<-5/38
notprob<-1-prob
exp<-prob*6-notprob
se<-abs(6+1)*sqrt(prob*notprob)
mean(exp*500)

average exp value es lo mismo que exp value
average se es dividir se por la raiz de la cantidad que te digan
expsum<-(exp)*500
sesum<-se*sqrt(500)
pnorm(0,expsum,sesum)
