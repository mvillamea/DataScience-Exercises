library(dplyr)
library(dslabs)
data(gapminder)
data2<-gapminder%>% filter(continent=="Africa",year==2012, fertility<=3, life_expectancy>=70)
df<-select(data2, country,region)

library(dplyr)
library(ggplot2)
library(dslabs)
data(gapminder)
gapminder %>%
    filter(country == "Cambodia", year>=1960&year<=2010) %>%
    ggplot(aes(year, life_expectancy, color=country)) +
    geom_line()

#omite NA
library(dplyr)
library(dslabs)
data(gapminder)
daydollars<-mutate(gapminder, dollars_per_day=gdp/population/365)%>%filter(year==2010,continent=="Africa")%>%na.omit() # write your code here
daydollars

# geom density
daydollars %>% ggplot(aes(dollars_per_day)) + scale_x_continuous(trans = "log2")+geom_density()

#smooth density diferentes para 1970 y 2010
#con una modif
library(dplyr)
library(ggplot2)
library(dslabs)
data(gapminder)
gapminder %>% 
  mutate(dollars_per_day = gdp/population/365) %>%
  filter(continent == "Africa" & year %in% c(1970,2010) & !is.na(dollars_per_day)) %>%
  ggplot(aes(dollars_per_day, fill = region)) + 
  geom_density(bw = 0.5, position = "stack") + 
  scale_x_continuous(trans = "log2") + 
  facet_grid(year ~ .)

#We are going to continue looking at patterns in the gapminder dataset by plotting infant mortality rates versus dollars per day for African countries.
library(dplyr)
library(ggplot2)
library(dslabs)
data(gapminder)
gapminder_Africa_2010 <-gapminder %>% 
  mutate(dollars_per_day = gdp/population/365) %>%
  filter(continent == "Africa" & year== 2010 & !is.na(dollars_per_day))  # create the mutated dataset
gapminder_Africa_2010%>%ggplot(aes(dollars_per_day, infant_mortality, color=region)) + geom_point()

#con x en log2
gapminder_Africa_2010 %>%ggplot(aes(dollars_per_day, infant_mortality, color=region)) + geom_point()+scale_x_continuous(trans = "log2")

#agregamos labels
gapminder_Africa_2010 %>%ggplot(aes(dollars_per_day, infant_mortality, color=region, label=country)) + geom_point()+scale_x_continuous(trans = "log2")+geom_text() 

#comparo 1970 y 2010
library(dplyr)
library(ggplot2)
library(dslabs)
data(gapminder)
gapminder %>% 
  mutate(dollars_per_day = gdp/population/365) %>%
  filter(continent == "Africa" & year %in% c(1970, 2010) & !is.na(dollars_per_day) & !is.na(infant_mortality)) %>%
  ggplot(aes(dollars_per_day, infant_mortality, color = region, label = country)) +
  geom_text() + 
  scale_x_continuous(trans = "log2") +
  facet_grid(year~.)


