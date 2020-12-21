#Each row contains one group of the experiment.
#Each group has a different combination of age, alcohol consumption, and tobacco consumption. The number of cancer cases and number of controls (individuals without cancer) are reported for each group.

#How many groups are in the study?
dim(esoph)[1]

#How many cases are there?
all_cases<-sum(esoph$ncases)

#How many controls are there?
all_controls<-sum(esoph$ncontrols)

all_cases<-sum(esoph$ncases)
all_controls<-sum(esoph$ncontrols)
alcoholmayora120<-esoph%>%filter(alcgp=="120+")
sum(alcoholmayora120$ncases)
sum(alcoholmayora120$ncontrols)
sum(alcoholmayora120$ncases)/(sum(alcoholmayora120$ncases)+sum(alcoholmayora120$ncontrols))

alcoholmasbajo<-esoph%>%filter(alcgp=="0-39g/day")
alcoholmasbajo
sum(alcoholmasbajo$ncases)/(sum(alcoholmasbajo$ncases)+sum(alcoholmasbajo$ncontrols))

tabaco1<-esoph%>%filter(tobgp%in%c("10-19","20-29","30+"))
tab1<-sum(tabaco1$ncases)
sum(tabaco1$ncases)/all_cases

sum(alcoholmayora120$ncases)/all_cases

tabacoalto<-esoph%>%filter(tobgp=="30+")
sum(tabacoalto$ncases)/all_cases

alcytabmayor<-esoph%>%filter(alcgp=="120+"&tobgp=="30+")
sum(alcytabmayor$ncases)/all_cases


alcotabalto<-esoph%>%filter(alcgp=="120+"|tobgp=="30+")
a<-sum(alcotabalto$ncases)/all_cases

#probability of a control de estar en el highest alcohol group
control_alcoholalto<-sum(alcoholmayora120$ncontrols)/all_controls

#probability of a case de estar en el highest alcohol group
case_alcoholalto<-sum(alcoholmayora120$ncases)/all_cases

#la cantidad de veces mayor que es la probabilidad de estar en el highest alcohol group being a case rather than being a control
case_alcoholalto/control_alcoholalto

#probability for control to be in the highest tobacco group
sum(tabacoalto$ncontrols)/all_controls

#For controls, the probability of being in the highest alcohol group and the highest tobacco group
sum(alcytabmayor$ncontrols)/all_controls

#For controls, the probability of being in the highest alcohol group or the highest tobacco group
b<-sum(alcotabalto$ncontrols)/all_controls


a<-sum(alcotabalto$ncases)/all_cases
b<-sum(alcotabalto$ncontrols)/all_controls
a/b



