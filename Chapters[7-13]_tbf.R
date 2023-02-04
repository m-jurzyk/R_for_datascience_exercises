# CHAPTER 7-Exploratory data analysis ----

## Histogram 

library(tidyverse)

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)


smaller <- diamonds %>% 
  filter(carat < 3)

ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.1)

## It's better to use geom_freqpoly then histogram to show more lines 

ggplot(data = smaller, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)

ggplot(data = diamonds, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.01)




# Detection of unusual values 

unusual <- diamonds %>% 
  filter(y < 3 | y > 20) %>% 
  select(price, x, y, z) %>%
  arrange(y)

unusual

###7.3.4 Exercises ----

#Explore the distribution of each of the x, y, and z variables in diamonds.
#What do you learn? Think about a diamond and how you might decide which dimension
#is the length, width, and depth.

?diamonds

#x- length in mm (0–10.74)

diamonds %>%  ggplot(mapping = aes(x=x))+
  geom_histogram(binwidth = 0.01)


#y = width in mm (0–58.9)

diamonds %>%  ggplot(mapping = aes(x=y))+
  geom_histogram(binwidth = 0.01)


#z = depth in mm (0–31.8)

diamonds %>%  ggplot(mapping = aes(x=z))+
  geom_histogram(binwidth = 0.01)


# It's all about shape of diamond 

#Explore the distribution of price. Do you discover anything unusual or surprising?
#(Hint: Carefully think about the binwidth and make sure you try a wide range of values.)


diamonds %>%  ggplot(mapping = aes(x=price))+
  geom_histogram(binwidth = 0.1)

diamonds %>%  ggplot(mapping = aes(x=price))+
  geom_histogram(binwidth = 1)


## How many diamonds are 0.99 carat? How many are 1 carat?
#What do you think is the cause of the difference?

p1carat <- diamonds %>% 
  filter(carat==1) %>% 
  select(price,carat) %>%
  arrange(price) %>% 
  count()

p1carat

p2carat <- diamonds %>% 
  filter(carat==0.99) %>% 
  select(price,carat) %>%
  arrange(price) %>% 
  count()

p2carat

# 1558 diamonds are 1 carat and olny 23 are 0.99 carat 


## Missing values 

# drop row with strange values 


diamonds2 <- diamonds %>% 
  filter(between(y, 3, 20))

diamonds2

# But better is to put NA insted of missing values 

diamonds2 <- diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))

diamonds2


ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + 
  geom_point()

## WARNING Komunikat ostrzegawczy:Removed 9 rows containing missing values (`geom_point()`)

ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + 
  geom_point(na.rm = TRUE)

## Without warning 

## 

nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(mapping = aes(sched_dep_time)) + 
  geom_freqpoly(mapping = aes(colour = cancelled), binwidth = 1/4)


ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)

ggplot(diamonds) + 
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)

## BOXPLOT 
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) +
  coord_flip()

ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat, y = price), alpha = 1 / 100)
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))


# CHAPTER 8-Workflow: projects ----

## Press Cmd/Ctrl + Shift + F10 to restart RStudio.
#Press Cmd/Ctrl + Shift + S to rerun the current script.


# WRANGLE  ----

# CHAPTER 9- Introduction ----

# CHAPTER 10- Tibbles ----

library(tidyverse)

as.tibble(iris)

tibble(
  x=1:10,
  y=1,
  z= x^2+y
)


## tibble names 

tb <- tibble(
  `:)` = "smile", 
  ` ` = "space",
  `2000` = "number"
)

tb

tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE))


nycflights13::flights %>% 
  print(n = 10, width = Inf)

nycflights13::flights %>% 
  View()    


### 10.5 Exercises ----

#How can you tell if an object is a tibble? 
#(Hint: try printing mtcars, which is a regular data frame).

mtcars %>% (print)

mtcars %>%  view()

#CHAPTER 11- Data import ----

# Read CSV 

library(tidyverse)


#read_csv()

read_csv("/Users/maciejjurzyk/Downloads/EUvaccine.csv")

## Worse but faster way of loading data 

data.table::fread("/Users/maciejjurzyk/Downloads/EUvaccine.csv")


#CHAPTER  12- Tidy data----

##There are three interrelated rules which make a dataset tidy:

#Each variable must have its own column.
#Each observation must have its own row.
#Each value must have its own cell.

#CHAPTER 13- Relational data ----

library(tidyverse)
library(nycflights13)

flights

airlines

airports

planes

flights

###13.3.1 Exercises----
#add a surrogate key to flights.

f_key <-flights %>%  
  mutate(surrogate_key= row_number()) %>% 
  glimpse()

f_key %>% glimpse()

f_key %>% select(surrogate_key)


#Identify the keys in the following datasets

a12 <- Lahman::Batting

a12 %>%  glimpse()

a12 %>% 
  count(playerID) %>% 
  filter(n > 1)

a12 %>%
  group_by(playerID, yearID, stint) %>%
  filter(n() > 1)


planes

planes %>%
  count(tailnum) %>%
  filter(n > 1)


diamonds



