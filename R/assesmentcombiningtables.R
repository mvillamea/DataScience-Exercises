library(Lahman)
top <- Batting %>% 
  filter(yearID == 2016) %>%
  arrange(desc(HR)) %>%    # arrange by descending HR count
  slice(1:10)    # take entries 1-10
top %>% as_tibble()

Master %>% as_tibble()
#Use the correct join or bind function to create a combined table of the names and statistics of the top 10 home run (HR) hitters for 2016. This table should have the player ID, first name, last name, and number of HR for the top 10 players. Name this data frame top_names.

top_names1 <- top %>%left_join(Master)%>% select(playerID, nameFirst, nameLast, HR)


#Filter this data frame to the 2016 salaries, then use the correct bind join function to add a salary column to the top_names data frame from the previous question. Name the new data frame top_salary.

top_salary <- Salaries %>% filter(yearID==2016) %>%
  right_join(top_names) %>%
  select(nameFirst, nameLast, teamID, HR, salary)
top_salary

Inspect the AwardsPlayers table. Filter awards to include only the year 2016.

#How many players from the top 10 home run hitters won at least one award in 2016?
awards<-AwardsPlayers%>%filter(yearID==2016)
intersect(top_names1$playerID,awards$playerID)
setdiff(awards$playerID,top_names1$playerID)

