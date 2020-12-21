Load the following web page, which contains information about Major League Baseball payrolls, into R: https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm

library(rvest)
url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)
We learned that tables in html are associated with the table node.  Use the html_nodes() function and the table node type to extract the first table. Store it in an object nodes:

nodes <- html_nodes(h, "table")
The html_nodes() function returns a list of objects of class xml_node. We can see the content of each one using, for example, the html_text() function. You can see the content for an arbitrarily picked component like this:

html_text(nodes[[8]])
If the content of this object is an html table, we can use the html_table() function to convert it to a data frame:

html_table(nodes[[8]])


#Many tables on this page are team payroll tables, with columns for rank, team, and one or more money values.
#Convert the first four tables in nodes to data frames and inspect them.
3Which of the first four nodes are tables of team payroll?
html_table(nodes[[1]])
html_table(nodes[[2]])
html_table(nodes[[3]])
html_table(nodes[[4]])

#For the last 3 components of nodes, which of the following are true? (Check all correct answers.)
html_table(nodes[[18]])
html_table(nodes[[19]])
html_table(nodes[[20]])


tab_1<-html_table(nodes[[10]])
tab_2<-html_table(nodes[[18]])
#me quedo con las primeras tres columnas
tab1<-tab_1%>%select("Team", "Payroll", "Averge")
#remove first row
tab1<-tab1[-1,]
tab2<-tab_2[-1,]
#change the names
tab1<-setNames(tab1, c("Team", "Payroll", "Average"))
tab2<-setNames(tab1, c("Team", "Payroll", "Average"))
#unimos tablas
full_join(tab1, tab2, by = "Team")


#otra forma que ni anduvo aunque es la que dieron en el curso
tab_1 <- html_table(nodes[[10]])
tab_2 <- html_table(nodes[[19]])
col_names <- c("Team", "Payroll", "Average")
tab_1 <- tab_1[-1, -1]
tab_2 <- tab_2[-1,]
names(tab_2) <- col_names
names(tab_1) <- col_names
full_join(tab_1,tab_2, by = "Team")

#OTRO EJERCICIO
library(rvest)
library(tidyverse)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
h <- read_html(url)
tab <- html_nodes(h, "table")
length(tab)
html_table(tab[[5]], fill=TRUE)
length(html_table(tab[[5]], fill=TRUE))

