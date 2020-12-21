#Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' argument and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA.
     
pollutantmean<-function(directory, pollutant, id = 1:332) {
    y <- c()
    for(monitor in id){
        x <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
        data <- read.csv(x)[pollutant]
        y <- c(y, data[!is.na(data)])
    }
    
    mean(y)
}
      

#Write a function that reads a directory full of files and reports the number of completely observed cases in each data file. The function should return a data frame where the first column is the name of the file and the second column is the number of complete cases. 

complete <- function (directory, id = 1:332){
    complete_cases <- data.frame (id = 0, nobs = 0)
    for (monitor in id) {
        x <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
        data <- read.csv(x)
        finaldata <- data[(!is.na(data$sulfate) & !is.na(data$nitrate)), ]
        nobs <- nrow(finaldata)
        complete_cases <- rbind(complete_cases, data.frame(id = monitor, nobs = nobs))

    }
    complete_cases[-1,]
}


#Write a function that takes a directory of data files and a threshold for complete cases and calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. The function should return a vector of correlations for the monitors that meet the threshold requirement. If no monitors meet the threshold requirement, then the function should return a numeric vector of length 0

corr <- function(directory, threshold =0) {
    results <- numeric(0)
    complete_cases <- complete(directory)
    complete_cases <-complete_cases[complete_cases$nobs>=threshold, ]
    if(nrow(complete_cases)>0){
        for(monitor in complete_cases$id){
            x <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
            data <- read.csv(x)
            finaldata <- data[(!is.na(data$sulfate) & !is.na(data$nitrate)), ]
            sulfatedata <- finaldata["sulfate"]
            nitratedata <- finaldata["nitrate"]
            results <- c(results, cor(sulfatedata, nitratedata))
        }
    }
    results
}



