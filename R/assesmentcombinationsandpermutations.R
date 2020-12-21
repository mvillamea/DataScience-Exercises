PERMUTATIONS
#In the 200m dash finals in the Olympics, 8 runners compete for 3 medals (order matters). In the 2012 Olympics, 3 of the 8 runners were from Jamaica and the other 5 were from different countries. The three medals were all won by Jamaica (Usain Bolt, Yohan Blake, and Warren Weir).
#Use the information above to help you answer the following four questions.

#How many different ways can the 3 medals be distributed across 8 runners?
dim(permutations(8,3)) #miras sólo el primer valor que te da

#How many different ways can the 3 medals be distributed across 3 runners?
dim(permutations(3,3)) #miras sólo el primer valor que te da

#What is the probability that all 3 medals are won by Jamaica?
 #Respuesta de la primera/rta se la segunda



#Run a Monte Carlo simulation on this vector representing the countries of the 8 runners in this race:
runners <- c("Jamaica", "Jamaica", "Jamaica", "USA", "Ecuador", "Netherlands", "France", "South Africa")
#For each iteration of the Monte Carlo simulation, within a replicate() loop, select 3 runners representing the 3 medalists and check whether they are all from Jamaica. Repeat this simulation 10,000 times. Set the seed to 1 before running the loop.

#Calculate the probability that all the runners are from Jamaica.
set.seed(1)
B<-10000
prizesJamaican <- replicate(B, {
  runners <- c("Jamaica", "Jamaica", "Jamaica", "USA", "Ecuador", "Netherlands", "France", "South Africa")
  alljamaica<-c("Jamaica", "Jamaica", "Jamaica")
  winners<- sample(runners,3)
  all(winners=="Jamaica")
})
mean(prizesJamaican)

COMBINATIONS
#A restaurant manager wants to advertise that his lunch special offers enough choices to eat different meals every day of the year. He doesn't think his current special actually allows that number of choices, but wants to change his special if needed to allow at least 365 choices.

#A meal at the restaurant includes 1 entree, 2 sides, and 1 drink. He currently offers a choice of 1 entree from a list of 6 options, a choice of 2 different sides from a list of 6 options, and a choice of 1 drink from a list of 2 options.

#How many meal combinations are possible with the current menu?
dim(combinations(6,1))[1]*dim(combinations(6,2))[1]*dim(combinations(2,1))[1]

#How many combinations are possible if he expands his original special to 3 drink options?
dim(combinations(6,1))[1]*dim(combinations(6,2))[1]*dim(combinations(3,1))[1]

#How many meal combinations are there if customers can choose from 6 entrees, 3 drinks, and select 3 sides from the current 6 options?
dim(combinations(6,1))[1]*dim(combinations(6,3))[1]*dim(combinations(3,1))[1]



