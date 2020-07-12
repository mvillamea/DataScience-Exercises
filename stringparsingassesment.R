
#Your regex command tells R to look for either 4 or 5 lowercase letters in a row anywhere in the string. This is true for the animals “puppy” and “Moose”.
animals <- c("cat", "puppy", "Moose", "MONKEY")
pattern <- "[a-z]{4,5}"
str_detect(animals, pattern)


#This regex pattern looks for an “m” followed by zero or more “o” characters. This is true for all strings in the animal vector.
#This regex pattern looks for an “m” followed by zero or one “o” characters. This is true for all strings in the animal vector. Even though “moose” has two “o”s after the “m”, it still matches the pattern.
animals <- c("moose", "monkey", "meerkat", "mountain lion")
pattern <- “mo*”
str_detect(animals, pattern)

animals <- c("moose", "monkey", "meerkat", "mountain lion")
pattern <- “mo?”
str_detect(animals, pattern)


You are working on some data from different universities. You have the following vector:

> schools
[1] "U. Kentucky"                 "Univ New Hampshire"          "Univ. of Massachusetts"      "University Georgia"         
[5] "U California"                "California State University"
You want to clean this data to match the full names of each university:

> final
[1] "University of Kentucky"      "University of New Hampshire" "University of Massachusetts" "University of Georgia"         
[5] "University of California"    "California State University"

schools %>% 
    str_replace("^Univ\\.?\\s|^U\\.?\\s", "University ") %>% 
    str_replace("^University of |^University ", "University of ")


#[1] "5'3" "5'5" "6 1" "5 .11" "5, 12"

problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
pattern_with_groups <- "^([4-7])[,\\.](\\d*)$"
str_replace(problems, pattern_with_groups, "\\1'\\2")

#[1] "5'3" "5'5" "6'1" "5 .11" "5, 12"
problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
pattern_with_groups <- "^([4-7])[,\\.\\s](\\d*)$"
str_replace(problems, pattern_with_groups, "\\1'\\2")


yes <- c("5 feet 7inches", "5 7")
no <- c("5ft 9 inches", "5 ft 9 inches")
s <- c(yes, no)

converted <- s %>% 
  str_replace("feet|foot|ft", "'") %>% 
  str_replace("inches|in|''|\"", "") %>% 
  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")

pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
str_detect(converted, pattern)
[1]  TRUE TRUE FALSE FALSE



converted <- s %>% 
    str_replace("\\s*(feet|foot|ft)\\s*", "'") %>% 
    str_replace("\\s*(inches|in|''|\")\\s*", "") %>% 
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")
pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
str_detect(converted, pattern)
[1]  TRUE TRUE TRUE TRUE

converted <- s %>% 
    str_replace("\\s+feet|foot|ft\\s+", "'") %>% 
    str_replace("\\s+inches|in|''|\"\\s+", "") %>% 
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")
pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
str_detect(converted, pattern)
[1] FALSE  TRUE  TRUE  TRUE

converted <- s %>% 
    str_replace("\\s*|feet|foot|ft", "'") %>% 
    str_replace("\\s*|inches|in|''|\"", "") %>% 
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") 
pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
str_detect(converted, pattern)
[1] FALSE FALSE FALSE FALSE

converted <- s %>% 
    str_replace_all("\\s", "") %>% 
    str_replace("\\s|feet|foot|ft", "'") %>% 
    str_replace("\\s|inches|in|''|\"", "") %>% 
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") 
pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
str_detect(converted, pattern)
[1]  TRUE FALSE  TRUE  TRUE

