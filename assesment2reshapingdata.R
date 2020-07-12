co2_wide <- data.frame(matrix(co2, ncol = 12, byrow = TRUE)) %>% 
      setNames(1:12) %>%
    mutate(year = as.character(1959:1997))
#Use the gather() function to make this dataset tidy. Call the column with the CO2 measurements co2 and call the month column month. Name the resulting object co2_tidy.

co2_tidy <- gather(co2_wide,month,co2,-year)

#Use co2_tidy to plot CO2 versus month with a different curve for each year:

co2_tidy %>% ggplot(aes(as.numeric(month), co2, color = year)) + geom_line()


#Load the admissions dataset from dslabs, which contains college admission information for men and women across six majors, and remove the applicants percentage column:

library(dslabs)
data(admissions)
dat <- admissions %>% select(-applicants)
#one row for each major
dat_tidy <- spread(dat, gender, admitted)

#use the admissions dataset to create the object tmp, which has columns major, gender, key and value:

tmp <- gather(admissions, key, value, admitted:applicants)
tmp
#Combine the key and gender and create a new column called column_name to get a variable with the following values: admitted_men, admitted_women, applicants_men and applicants_women. Save the new data as tmp2.
tmp2 <- unite(tmp, column_name, c(key, gender))


