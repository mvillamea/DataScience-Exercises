library(tidyverse)
library(dslabs)
data(stars)
options(digits = 3)  

#Question 1
#Load the stars data frame from dslabs. This contains the name, absolute magnitude, temperature in degrees Kelvin, and spectral class of selected stars. Absolute magnitude (shortened in these problems to simply "magnitude") is a function of star luminosity, where negative values of magnitude have higher luminosity.
#What is the mean magnitude?
mean(stars$magnitude)
#What is the standard deviation of magnitude?
sd(stars$magnitude)

#Question 2
#Make a density plot of the magnitude.
#How many peaks are there in the data?
stars%>%ggplot(aes(magnitude, y= ..count..))+geom_density(alpha=0.2) 

#Question 3
#Examine the distribution of star temperature.
#Which of these statements best characterizes the temperature distribution?
stars%>%ggplot(aes(temp, y= ..count..))+geom_density(alpha=0.2) 
stars%>%ggplot(aes(temp, y= ..density..))+geom_density(alpha=0.2) 

#Question 4
#Make a scatter plot of the data with temperature on the x-axis and magnitude on the y-axis and examine the relationship between the variables. Recall that lower magnitude means a more luminous (brighter) star.
stars%>%ggplot(aes(temp, magnitude))+geom_point()

#Question 5
#For various reasons, scientists do not always follow straight conventions when making plots, and astronomers usually transform values of star luminosity and temperature before plotting. Flip the y-axis so that lower values of magnitude are at the top of the axis (recall that more luminous stars have lower magnitude) using scale_y_reverse(). Take the log base 10 of temperature and then also flip the x-axis.
stars%>%ggplot(aes(temp, magnitude))+geom_point()+scale_x_log10()+scale_y_reverse()+scale_x_reverse()

#Question 6
#The trends you see allow scientists to learn about the evolution and lifetime of stars. The primary group of stars to which most stars belong we will call the main sequence stars (discussed in question 4). Most stars belong to this main sequence, however some of the more rare stars are classified as “old” and “evolved” stars. These stars tend to be hotter stars, but also have low luminosity, and are known as white dwarfs.

#Question 8
#We can now identify whether specific stars are main sequence stars, red giants or white dwarfs. Add text labels to the plot to answer these questions. You may wish to plot only a selection of the labels, repel the labels, or zoom in on the plot in RStudio so you can locate specific stars.
stars%>%ggplot(aes(temp, magnitude))+geom_point()+geom_text(aes(label= star))

#Question 9
#Remove the text labels and color the points by star type. This classification describes the properties of the star's spectrum, the amount of light produced at various wavelengths.
stars%>%ggplot(aes(temp, magnitude, color=type))+geom_point()



