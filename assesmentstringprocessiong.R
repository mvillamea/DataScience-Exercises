s <- c("5'10", "6'1\"", "5'8inches", "5'7.5")
tab <- data.frame(x = s)

#allow you to put the decimals in a third column called “decimal”. In this code, you extract three groups: one digit for “feet”, one or two digits for “inches”, and an optional decimal point followed by at least one digit for “decimal”.
 
extract(data = tab, col = x, into = c("feet", "inches", "decimal"), 
regex = "(\\d)'(\\d{1,2})(\\.\\d+)?") 


#pruebas para hacer tablas
schedule<- matrix(c("day", "staff", "Monday", "Mandy, Chris and Laura", "Tuesday", "Steve, Ruth and Frank"),ncol=2,byrow=TRUE)
schedule<-as.table(schedule)


#You have the following table, schedule:

>schedule
day		staff
Monday		Mandy, Chris and Laura
Tuesday		Steve, Ruth and Frank

schedule<-data.frame(day=c("Monday", "Tuesday"), staff=c("Mandy, Chris and Laura",  "Steve, Ruth and Frank"))

#2 commands would properly split the text in the “staff” column into each individual name

#This regex will correctly split each “staff” string into three names by properly accounting for the space after the comma as well as the spaces before and after the “and”, but it’s not the only one.
str_split(schedule$staff, ", | and ")

#This regex command is the same as the one above, except that the spaces are written as \\s, but it’s not the only one.
str_split(schedule$staff, ",\\s|\\sand\\s")

#code that would successfully turn your “Schedule” table into the following tidy table

> tidy
day     staff
<chr>   <chr>
Monday  Mandy
Monday  Chris
Monday  Laura
Tuesday Steve
Tuesday Ruth 
Tuesday Frank

tidy <- schedule %>% 
  mutate(staff = str_split(staff, ", | and ")) %>% 
  unnest()

#Using the gapminder data, you want to recode countries longer than 12 letters in the region “Middle Africa” to their abbreviations in a new column, “country_short”. 
dat <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(country_short = recode(country, 
                                "Central African Republic" = "CAR", 
                                "Congo, Dem. Rep." = "DRC",
                                "Equatorial Guinea" = "Eq. Guinea"))

 #otro ej
#Import raw Brexit referendum polling data from Wikipedia:
library(rvest)
library(tidyverse)
library(stringr)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
tab <- read_html(url) %>% html_nodes("table")
polls <- tab[[5]] %>% html_table(fill = TRUE)

#Update polls by changing the column names to c("dates", "remain", "leave", "undecided", "lead", "samplesize", "pollster", "poll_type", "notes") and only keeping rows that have a percent sign (%) in the remain column.

polls<-polls%>% rename(
		"dates"="Date(s) conducted",
		"remain"="Remain" ,
		"leave"="Leave" ,
		"undecided"="Undecided",
		"lead"="Lead"  ,
		"samplesize"="Sample" ,
		"pollster"="Conducted by",
		"poll_type"="Polling type",
		"notes"="Notes" 
		) %>%filter(str_detect(remain, "^\\d{1,2}?\\.?\\d?\\%$"))

#The remain and leave columns are both given in the format "48.1%": percentages out of 100% with a percent symbol.
#These commands converts the remain vector to a proportion between 0 and 1
as.numeric(str_replace(polls$remain, "%", ""))/100 #cambia el % por un espacio y al resultado lo divide por 100
parse_number(polls$remain)/100 #drops any non-numeric characters before or after the first number and then divides by 100.

#convert "N/A" in the undecided column to 0
str_replace(polls$undecided, "N/A", "0")
 
#extracts the end day and month when inserted into the blank in the code above
temp <- str_extract_all(polls$dates, _____)
end_date <- sapply(temp, function(x) x[length(x)]) # take last element (handles polls that cross month boundaries)

temp <- str_extract_all(polls$dates, "\\d+\\s[a-zA-Z]+")
end_date <- sapply(temp, function(x) x[length(x)])           

temp <- str_extract_all(polls$dates, "[0-9]+\\s[a-zA-Z]+")
end_date <- sapply(temp, function(x) x[length(x)])        

temp <- str_extract_all(polls$dates, "\\d{1,2}\\s[a-zA-Z]+")
end_date <- sapply(temp, function(x) x[length(x)])

temp <- str_extract_all(polls$dates, "\\d+\\s[a-zA-Z]{3,5}")
end_date <- sapply(temp, function(x) x[length(x)])


