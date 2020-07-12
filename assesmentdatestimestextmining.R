library(dslabs)
library(lubridate)
options(digits = 3)    # 3 significant digits
polls<- data(brexit_polls)

#How many polls had a start date (startdate) in April (month number 4)
dim(brexit_polls%>%filter(month(startdate)==4))[1]

#Use the round_date() function on the enddate column with the argument unit="week". How many polls ended the week of 2016-06-12?
dim(brexit_polls%>%filter(round_date(enddate, unit="week")== "2016-06-12"))[1]

#Use the weekdays() function from lubridate to determine the weekday on which each poll ended (enddate). On which weekday did the greatest number of polls end?
brex<-brexit_polls%>%mutate(weekdayend=weekdays(enddate))
dim(brex%>%filter(weekdayend == "lunes"))[1]
dim(brex%>%filter(weekdayend == "martes"))[1]
dim(brex%>%filter(weekdayend == "miércoles"))[1]
dim(brex%>%filter(weekdayend == "jueves"))[1]
dim(brex%>%filter(weekdayend == "viernes"))[1]
dim(brex%>%filter(weekdayend == "sábado"))[1]
dim(brex%>%filter(weekdayend == "domingo"))[1]

#más fácil: da una tabla con la cantidad que terminaron en cada día
table(weekdays(brexit_polls$enddate))


data(movielens)
datos<-as_datetime(movielens$timestamp)
#veo la cantidad de reviews por año
table(year(datos))
#veo cuál fue la mayor cantidad de rewiews en un año
max(table(year(datos)))
#veo la cantidad de reviews por hora
table(hour(datos))

#otro ej
library(tidyverse)
library(gutenbergr)
library(tidytext)
options(digits = 3)
gutenberg_metadata
#cuenta la cantidad de ids con pride and prejudice
table(str_detect(gutenberg_metadata$title, "Pride and Prejudice"))

#find the id for "pride and prejudice"
text<-gutenberg_works(title== "Pride and Prejudice", languages= "en")

#number of words present in pride and prejudice
text<- gutenberg_download(text)
words<-text%>% unnest_tokens(word, text)
count(words)

#filtra stopwords
words<-text%>% unnest_tokens(word, text)%>%filter(!word %in% stop_words$word)
#cuenta las palabras post filtrado
count(words)

#filtro palabras que tienen dígitos, ya sea que sean sólo dígitos o dígitos seguidos por letras
words1<-words%>%filter(!str_detect(word, "^[0-9]+"))
words2<-words1%>%count(word)
#cantidad de palabras que fueron usadas más de 100 veces
dim(words2%>%filter(n>100)))[1]
#palabra más usada y la cantidad de veces que fue usada
words2%>%filter(n==max(n))


afinn <- get_sentiments("afinn")
words<-text%>% unnest_tokens(word, text)%>%filter(!word %in% stop_words$word)
words<-words%>%filter(!str_detect(word, "^[0-9]+"))
#nos quedamos con las palabras que solo tienen sentimientos
afinn_sentiments<-words %>% inner_join(afinn, by = "word")
#la proporción de palabras con valor positivo
dim(afinn_sentiments%>%filter(value>0))[1]/dim(afinn_sentiments)[1]
#la cantidad de palabras con valor4
dim(afinn_sentiments%>%filter(value==4))[1]

