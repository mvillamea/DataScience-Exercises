setwd("/home/macarena/Documentos/JohnsHopkins/Curso2")
data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

library(tidyverse)

#la función best calcula el hospital de un estado que tiene el menor death rate para un outcome
best <- function(state, outcome) {
     data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
     #data <-data%>%filter(na.rm = TRUE)
     ## Check that state and outcome are valid
     if (!(state %in% data$State)) {
          stop("invalid state")
     }

     if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {
         stop("invalid outcome")
     }

     else {
         hospital_in_state<- data%>%filter(State == state)
         if(outcome == "heart attack") {
         hospital_in_state <- hospital_in_state%>%filter(!is.na(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
         lower<-hospital_in_state%>%filter(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == min(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
         ordenado_alf <- sort(lower$Hospital.Name)
         best_hospital <- ordenado_alf[1]
         }
         if(outcome == "heart failure") {
         hospital_in_state <- hospital_in_state%>%filter(!is.na(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
         lower<-hospital_in_state%>%filter(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure == min(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
         ordenado_alf <- sort(lower$Hospital.Name)
         best_hospital <- ordenado_alf[1]
         }
         if(outcome == "pneumonia") {
         hospital_in_state <- hospital_in_state%>%filter(!is.na(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
         lower<-hospital_in_state%>%filter(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia == min(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
         ordenado_alf <- sort(lower$Hospital.Name)
         best_hospital <- ordenado_alf[1]
         }
     ## Return hospital name in that state with lowest 30-day death
     }
     
     best_hospital
## rate
}

