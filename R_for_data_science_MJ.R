# R for data science ----
# My exercises in R language, November 2022
# Fist chapter 

#CHAPTER 1- EXPLORE ----
## Loading tidiverse library to get access to ggplot

library(tidyverse)

## MPG access to data
# CHAPTER 2- Introduction ----
# CHAPTER 3- Data visualization ----

mpg

# CMD + enter - run a command 

head(mpg) # First few rows of mpg

## Creating ggplot 

# From mpg data base %>%  create ggplot with geometry point mapped aesthetics 
# x means engine size and y car's fuel efficiency 

mpg %>% ggplot()+
  geom_point(mapping = aes(x=displ, y =hwy))

# How many rows and how many columns are in mpg dataset?

nrow(mpg)

ncol(mpg)

# 234 rows and 11 columns 

?mpg # I can also ask for help with mpg data using ?mgp 

## 3.2.4 Excercise 4: Make a scatter plot of hwy vs cyl

mpg %>% 
  ggplot()+
  geom_point(mapping = aes(x=cyl, y=hwy))
 

## Prego! 

#What happens if you make a scatter plot of class vs drv? 
#Why is the plot not useful?

mpg %>% ggplot()+
  geom_point(mapping = aes(x=class, y=drv))


## it is showing only random examples of driven train type with the type of the car 

## Adding class value to plot 

mpg %>% ggplot()+
  geom_point(mapping = aes(x=displ, y =hwy, color= class))

## now size insted of colour

mpg %>% ggplot()+
  geom_point(mapping = aes(x=displ, y =hwy, size= class))

## transparency - alpha 

mpg %>% ggplot()+
  geom_point(mapping = aes(x=displ, y =hwy, alpha= class))

## diffrent shapes 

mpg %>% ggplot()+
  geom_point(mapping = aes(x=displ, y =hwy, shape= class))

library(patchwork)

a1<- mpg %>% ggplot()+
  geom_point(mapping = aes(x=displ, y =hwy, alpha= class))

a2<- mpg %>% ggplot()+
  geom_point(mapping = aes(x=displ, y =hwy, shape= class))

a1|a2

## Kind of- but it's working 

## Colour blue 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")


###3.3.1 Exercises
#What’s gone wrong with this code? Why are the points not blue?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue")) 

## Color is mapped as aesthetics and ggplot is creating value - blue 
# Color I suppouse is random 


#  Which variables in mpg are categorical? Which variables are continuous?
# (Hint: type ?mpg to read the documentation for the data set).
# How can you see this information when you run mpg?

?mpg


ggplot(data = mpg) +
geom_point(mapping = aes(x = displ, y = hwy))



# FACETS 

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))+
  facet_wrap(~class, nrow = 2)

# Facets witch 2 rows

#Facets with grid 

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))+
  facet_grid(drv~cyl)


### 3.5 Exercises ----

##What happens if you facet on a continuous variable?

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))+
  facet_wrap(~cty,nrow =2)

#What do the empty cells in plot with facet_grid(drv ~ cyl) mean?
#How do they relate to this plot?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))+
  facet_grid(drv~cyl)

?facet_wrap


## GEOM smooth 


a3<- ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))


a4<- ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))


a3|a4

## Diffrent types of geom_smooth 

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )


## Duplicate plot (point and smooth line)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))


## now the same but without duplication

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

###3.6.1 Exercises----

#What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_line()+
  geom_boxplot()

# With histogram it seems to be more difficult 

ggplot(data = mpg, mapping = aes(x=hwy)+
    geom_histogram())

      ### non lo so :/  - problems with histogram
      
      
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
        geom_point() + 
        geom_smooth()

## Prediction: mpg mapped x- engine size, y- efficiency, color- drive type
## Scatterplot with line smooth without se?

## Reality - 3 diffrent lines and smooth of drive? - kind of unexpected 


# Graphs will look the same- it's only difrent way of writing 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# Success! 

# Recreate the R code necessary to generate the following graphs.

# no.1 
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy), se=FALSE)

# NICE! 

# no.2

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy, group = drv), se=FALSE)

#SUCESS! 

#no.3 

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy, color=drv)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy, color = drv), se=FALSE)

#DONE!

#no.4

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy, color=drv)) +
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy), se=FALSE)

#DONE

#no.5 

mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, y = hwy, color=drv))+
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy, linetype = drv), se=FALSE)

#DONE!


### 3.7 Statistics information ----

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

?diamond

ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )


## Color- outline color/ fill - color of bar 

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))


ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))


# Clarity value 

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))


ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")


ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")



ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")


ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()


### The end of chapter

## CHAPTER4- Workflow basics----
### 4.4 Workflow basics - Excercises----

#Why does this code not work? Excercise 

my_variable <- 10

my_variable

my_variable 

# letter 'i' was broken 

library(tidyverse)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

filter(mpg, cyl == 8)
filter(diamonds, carat > 3)

## Fixed
## alt shift + k - show shortcuts 
## all exercises - done!  
## END OF THE CHAPTER 

#CHAPTER 5- Data transformation---- 

# Loading libraries 

library(nycflights13)

library(tidyverse)

library(dplyr)

## I don't know why I do have a lot of errors :/ 

###5.2.4 Data Transformation Exercises ----
#Find all flights that

# EXCERCISE Had an arrival delay of two or more hours

flights %>%  filter(arr_delay>120)

#EXCERCISE Flew to Houston (IAH or HOU)

flights %>% head
colnames(flights)


flights %>% filter(dest=="HOU"|dest=="IAH") # Answer 

view(flights)

flights

#EXCERCISE Were operated by United, American, or Delta

?flights

viwe(airlines) ## To check airlines carrier / full name corelation 

flights %>% filter(carrier=="UA"|carrier=="AA"|carrier=="DL") # Answer 

## UA, AA, DL United, American, Delta 

#EXCERCISE Departed in summer (July, August, and September)

flights %>% filter(month==7|month==8|month==9)

##EXCERCISE Arrived more than two hours late, but didn’t leave late

flights %>% filter(dep_delay<=0 & arr_delay>120)

##EXCERCISE Were delayed by at least an hour, but made up over 30 minutes in flight


flights %>% filter(dep_delay>60 & arr_delay<=30)

## Actually - right inswer is 

flights %>% filter(dep_delay>=60 & dep_delay- arr_delay > 30)

##EXCERCISE Departed between midnight and 6am (inclusive)

flights %>% filter(dep_time>=0 & dep_time<=600)

## DONE!

##EXCERCISE Another useful dplyr filtering helper is between(). What does it do? 
#Can you use it to simplify the code needed to answer the previous challenges?

flights %>% filter(dep_time, between(c)) ## Non lo so :( MJ QUESTION 

# Answer: 

flights %>% filter(between(arr_delay,0,120))

flights %>% filter(between(month,7,9))

#EXCERCISE How many flights have a missing dep_time? What other variables are missing? 
#What might these rows represent?

f1 <-flights %>% filter(is.na(dep_time))

nrow(f1)

# OR 

flights %>% filter(is.na(dep_time)) %>% count("NA")


# To know how many values are missing in whole database I am going to use summary

summary(flights)


# now I know exact number of missing values on difrent variables 
# mostly in dep_deley, arr_tim oraz arr_delay


### 5.3 Arrange ----


# EXCEERCISE 1 How could you use arrange() to sort all missing values to the start?

flights %>% arrange(desc(is.na(dep_time)))

#EXCERCISE Sort flights to find the most delayed flights. Find the flights that left earliest.


flights %>% arrange(desc(dep_delay)) ## MOST delayed flight 

flights %>% arrange(arr_time)


##EXCERCISE Flights that have the smallest number of depatrute delay, and the highest of 
#arrival delay

flights %>% arrange(dep_delay,desc(arr_delay))


#EXCERCISE Sort flights to find the fastest (highest speed) flights.


## I need to find speed value- need to create column speed (dist/time)
# distance in miles conversion to kmh

flights$distkm <- flights$distance/0.62137

## show km 

select(flights, distkm)

## 336k rows of distances 

## Time in hours: ~ Airtime/60 


flights$air_time_h <- flights$air_time/60

flights %>% select(air_time_h)

flights %>% arrange(speed)


## MJ Speed column  


flights$speed <- flights$distkm/flights$air_time_h

f2 <- arrange(flights,desc(speed)) %>% 
arrange(select(f2,speed)) %>% 

f3 <-flights %>%  mutate(speed_1=distkm/air_time_h)

f3 %>%  arrange(desc(speed_1)) %>% 
  select(speed_1, dest, flight, tailnum)



# But I can make it super quick 

flights %>% arrange(desc(distance/air_time))


# EXCERCISE: Which flights traveled the farthest? Which traveled the shortest?

# The Shortest flights 
f3 %>%  
  arrange(distance) %>% 
  select(speed_1, dest, flight, tailnum, distance)

# The longest flights 
f3 %>%  
  arrange(desc(distance)) %>% 
  select(speed_1, dest, flight, tailnum, distance)



#EXCERCISE: How could you use arrange() to sort all missing values to the start?
#(Hint: use is.na()).

flights %>%  arrange(desc(is.na(dep_time)))



### 5.4 Select  ----

select(flights, year, month, day)

#Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time,
#and arr_delay from flights.


flights %>%  select(dep_time, dep_delay, arr_time, arr_delay)

flights %>%  select(dep_time:arr_delay, -sched_dep_time, -sched_arr_time)

# probably more ways 


#What happens if you include the name of a variable 
#multiple times in a select() call?

f1 %>% select(f1, year)

## Like this?? non lo so :/ MJ QUESTION 


#What does the any_of() function do? 
#Why might it be helpful in conjunction with this vector?

p1 <- c("year", "month", "day", "dep_delay", "arr_delay")

flights %>%  select(any_of(p1))

### MJ QUESTION - non lo so :/ 

### 5.5 Mutate ----

# I tried to count speed by using dist km and air time in hours 

flights$speed <- flights$distkm/flights$air_time_h

f2 <- arrange(flights,desc(speed))

## I couldn't find connection between arrange function and select

# Insted of using mutate i used transmutate and I left only one column 

f4 <- flights %>% transmute(flights$speed <- flights$distkm/flights$air_time_h)

arrange(f4,desc(speed)) %>% 
  
  
  
### 5.5.2 Exercises ----

#Currently dep_time and sched_dep_time are convenient to look at,
#but hard to compute with because they’re not really continuous numbers. 
#Convert them to a more convenient representation of number of minutes since midnight.

flights %>%  select(dep_time, sched_dep_time)

flights %>%  transmute(dep_time= , sched_dep_time)

transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100)

transmute(flights,
          sched_dep_time,
          hour = sched_dep_time %/% 100,
          minute = sched_dep_time %% 100)


#Modular arithmetic: %/% (integer division) and %% (remainder), where x == y * (x %/% y) + (x %% y). 
#Modular arithmetic is a handy tool because it allows you to break integers up into pieces.
#For example, in the flights dataset, you can compute hour and minute from dep_time with:



#Compare air_time with arr_time - dep_time. What do you expect to see?
#What do you see? What do you need to do to fix it?

#air time: amount of time spent in the air in minutes

# arr_time and dep_time Scheduled departure and arrival times (format HHMM or HMM), local tz.

# I expect to see wrong calculations because first I need to fix units



flights %>%  select(air_time, arr_time, dep_time)

# I dont know how to fix it MJ QUESTION 


#Find the 10 most delayed flights using a ranking function. 
#How do you want to handle ties? Carefully read the documentation for min_rank().

flights %>% mutate(rank=min_rank(desc(dep_delay))) %>% 
  arrange(rank) %>% 
  select(rank,everything())


# What does 1:3 + 1:10 return? Why?

1:3 + 1:10


###5.6 Summarise ----

summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))


### 5.6.1. Combining multiple operations with the pipe ---- 

by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
)
delay <- filter(delay, count > 20, dest != "HNL")

ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)



### Another way is using %>%  

delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")



### 5.6.3. Counts ----

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay)
  )

ggplot(data = delays, mapping = aes(x = delay)) + 
  geom_freqpoly(binwidth = 10)

### definitely I need to turn back to this chapter in the future! 

# I turned back!

### 5.7.1. Excercises Grouped mutates (and filters) ----


#Which plane (tailnum) has the worst on-time record?

flights %>% 
  filter(!is.na(tailnum)) %>% 
  mutate(na_czas = !is.na(arr_time) & (arr_delay<=0))%>% 
  group_by(tailnum) %>% 
  summarise(na_czas = mean(na_czas), n = n()) %>% 
  filter(min_rank(na_czas) == 1) %>% 
  arrange((n))

flights %>%
  filter(!is.na(tailnum)) %>%
  mutate(on_time = !is.na(arr_time) & (arr_delay <= 0)) %>%
  group_by(tailnum) %>%
  summarise(on_time = mean(on_time), n = n()) %>%
  filter(min_rank(on_time) == 1)

#What time of day should you fly if you want to avoid delays as much as possible?

flights %>% 
  filter(!is.na(arr_delay)) %>% 
  group_by(hour) %>% 
  summarise(arr_delay=mean(arr_delay, na.rm= TRUE)) %>% 
  arrange(hour) %>% 
  ggplot(mapping = aes(x=hour,y=arr_delay))+
  geom_point()



#For each destination, compute the total minutes of delay. For each flight, 
#compute the proportion of the total delay for its destination.

?flights



flights %>% 
  filter(arr_delay>0) %>% 
  group_by(dest, origin, carrier, flight) %>% 
  summarise(arr_delay = sum(arr_delay)) %>% 
  group_by(dest) %>% 
  arrange(desc(arr_delay))

## + Proportion  

flights %>% 
  filter(arr_delay>0) %>% 
  group_by(dest, origin, carrier, flight) %>% 
  summarise(arr_delay = sum(arr_delay)) %>% 
  group_by(dest) %>% 
  arrange(desc(arr_delay)) %>% 
  mutate(arr_delay_prop= arr_delay/sum(arr_delay)) %>% 
  arrange(dest, desc(arr_delay_prop)) %>% 
  select(carrier,flight,origin,dest,arr_delay_prop)


#Delays are typically temporally correlated: even once the problem that caused 
#the initial delay has been resolved, later flights are delayed to allow
#earlier flights to leave. Using lag() explore how the delay of a flight is
#related to the delay of the immediately preceding flight.


corelated_delays <- flights %>% 
  arrange(origin,dest,month,day,dep_time) %>% 
  mutate(dep_delay_lag = lag(dep_delay)) %>% 
  filter(!is.na(dep_delay), !is.na(dep_delay_lag))

corelated_delays %>%  select (dep_delay_lag,everything())


corelated_delays %>%  
  group_by(dep_delay_lag) %>% 
  summarise(dep_delay_mean=mean(dep_delay)) %>% 
  ggplot(mapping = aes(x=dep_delay_lag,y=dep_delay_mean))+
  geom_point()


#Look at each destination. Can you find flights that are suspiciously fast? 
#(i.e. flights that represent a potential data entry error).
#Compute the air time of a flight relative to the shortest flight to that
#destination. Which flights were most delayed in the air?


standardized_flights <- flights %>%
  filter(!is.na(air_time)) %>%
  group_by(dest, origin) %>%
  mutate(
    air_time_mean = mean(air_time),
    air_time_sd = sd(air_time),
    n = n()
  ) %>%
  ungroup() %>%
  mutate(air_time_standard = (air_time - air_time_mean) / (air_time_sd + 1)) %>% 
  ggplot(air_ti)

standardized_flights %>% select(air_time_standard, everything())


## I used solution book to track this questions :/ 


##Exercise 5.7.7

#Find all destinations that are flown by at least two carriers. 
#Use that information to rank the carriers.

flights %>% 
  group_by(dest) %>% 
  mutate(n_carriers= n_distinct(carrier)) %>% 
  filter(n_carriers>1) %>% 
  group_by(carrier) %>% 
  summarise(n_dest= n_distinct(dest)) %>% 
  arrange(desc(n_dest)) %>% 
  mutate(rank= min_rank(desc(n_dest))) %>% 
  ggplot(mapping = aes(x=carrier,y=n_dest,colour=rank))+
  geom_point()




# CHAPTER 6-Workflow: scripts ----

# CHAPTER- 6 Scripts 

library(dplyr)
library(nycflights13)


not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))


## Chapter about workflow and sharing scripts, valuable information


## END 

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

##There are three interrelated rules which make a data set tidy:

#Each variable must have its own column.
#Each observation must have its own row.
#Each value must have its own cell.


###12.1 Introduction  ----

#“Happy families are all alike; every unhappy family is unhappy 
#in its own way.” –– Leo Tolstoy

#“Tidy datasets are all alike, but every messy dataset is
#messy in its own way.” –– Hadley Wickham


library(tidyverse)

####12.2.1 Exercises ----

#_1a Using prose, describe how the variables and observations
#are organised in each of the sample tables.

table1

# In table1 each row represents country year cases and population
# it's tidy 

# In table2 problem is with count value, there is a combination of data
# for sure not one observation / value 

table2

# In table3 in column rate also we can see some calculations 

table3

#In table4? 

table4a
table4b

#_2a Compute the rate for table2, and table4a + table4b.
#You will need to perform four operations:
  
#a) Extract the number of TB cases per country per year.

library(dplyr)

?table2
table2

t2_cases <- table2 %>%  filter(type == "cases") %>% 
  rename(cases=count) %>% 
  arrange(country,year)


t2_population <- table2 %>% filter(type== "population") %>% 
  rename(population=count) %>% 
  arrange(country,year)

t2_population

table1

#b) Extract the matching population per country per year.
#c) Divide cases by population, and multiply by 10000.

t2_cases_per_cap <- tibble(
  year= t2_cases$year,
  country=t2_cases$country,
  cases=t2_cases$cases,
  population=t2_population$population
) %>% 
  mutate(cases_per_cap = cases/population*10000) %>% 
  select(country,year,cases_per_cap)

t2_cases_per_cap

#d) Store back in the appropriate place.

t2_cases_per_cap <- t2_cases_per_cap %>%
  mutate(type = "cases_per_cap") %>%
  rename(count = cases_per_cap)

bind_rows(table2, t2_cases_per_cap) %>%
  arrange(country, year, type, count)

#Which representation is easiest to work with? Which is hardest? Why?

#3_a Recreate the plot showing change in cases over time using 
#table2 instead of table1. What do you need to do first?

ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))



table2 %>% 
  filter(type=="cases") %>% 
  ggplot(aes(year, count))+
  geom_line(aes(group=country))





#CHAPTER 13- Relational data ----

##13.1 Introduction ----

##13.2 nycflights13 ----
 

library(tidyverse)
library(nycflights13)

flights

airlines

airports

planes

flights

####13.2.1 Exercises ----

#_1a Imagine you wanted to draw (approximately) the route each plane flies from 
#its origin to its destination. What variables would you need? 
#What tables would you need to combine?

# Data about origin and destination, i can find it in table flights connected to airports 

flights_latlon <- flights %>%
  inner_join(select(airports, origin = faa, origin_lat = lat, origin_lon = lon),
             by = "origin"
  ) %>%
  inner_join(select(airports, dest = faa, dest_lat = lat, dest_lon = lon),
             by = "dest"
  )

flights_latlon %>%
  slice(1:100) %>%
  ggplot(aes(
    x = origin_lon, xend = dest_lon,
    y = origin_lat, yend = dest_lat
  )) +
  borders("state") +
  geom_segment(arrow = arrow(length = unit(0.1, "cm"))) +
  coord_quickmap() +
  labs(y = "Latitude", x = "Longitude")

#Code and map found on solution guide book

#_2a I forgot to draw the relationship between weather and airports. 
#What is the relationship and how should it appear in the diagram?

# It's relation between origin and faa 

#_3a Weather only contains information for the origin (NYC) airports. 
#If it contained weather records for all airports in the USA,
#what additional relation would it define with flights?

# We need to define relation between based on flights data

#_4a We know that some days of the year are “special”, and fewer people than 
#usual fly on them. How might you represent that data as a data frame?
#What would be the primary keys of that table? How would it connect to the 
#existing tables?

special_days <- tribble(
  ~year, ~month, ~day, ~holiday_name, 
  2023, 05, 27, "My birthday")
)

## 13.3 Keys ----

planes %>% 
  count(tailnum) %>% 
  filter(n > 1)

## One of the ways to check if it's primary key 


flights %>% 
  count(year, month, day, flight) %>% 
  filter(n > 1)

## It's not unique 

####13.3.1 Exercises----

#_1a add a surrogate key to flights.

f_key <-flights %>%  
mutate(surrogate_key= row_number()) %>% 
glimpse()

f_key %>% glimpse()

f_key %>% select(surrogate_key)


#_2a Identify the keys in the following data sets

a12 <- Lahman::Batting

a12 %>%
  count(playerID, yearID, stint) %>%
  filter(n > 1) %>% 
  nrow()


## Primary Key is mix ID, year and stint 


planes

planes %>%
  count(tailnum) %>%
  filter(n > 1) %>% 
  nrow()

#tailnum

diamonds %>% glimpse()

diamonds %>% 
count(carat,cut,color,clarity,table,depth,price,x,y,z) %>% 
  filter(n>1) %>% 
  nrow()

## There is no primary key 

babynames::babynames %>% 
  glimpse()

babynames %>% 
  count(sex,name,year) %>% 
  filter(n>1) %>% 
  nrow()

# sex, name and year 

nasaweather::atmos%>% 
  count(lat,long,month,year) %>% 
  filter(n>1) %>% 
  nrow()

#lat,long,month, year

fueleconomy::vehicles %>% 
  count(id) %>% 
  filter(n>1) %>% 
  nrow()
  
# ID primary key 

## 13.4 Mutating joins----

flights2 <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2

flights2 %>%
  select(-origin, -dest) %>% 
  left_join(airlines, by = "carrier")

# We can do the same using mutate 

flights2 %>%
  select(-origin, -dest) %>% 
  mutate(name = airlines$name[match(carrier, airlines$carrier)])

####13.4.1 Understanding joins ----

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)

####13.4.2 Inner join ----

x %>% 
  inner_join(y, by = "key")

####13.4.3 Outer joins ----

## Left join should be defoult one and then if I have reason I can use other joins

####13.4.4 Duplicate keys----


#One table has duplicate keys.

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  1, "x4"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2"
)
left_join(x, y, by = "key")

#Both tables have duplicate keys.

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  3, "x4"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  2, "y3",
  3, "y4"
)
left_join(x, y, by = "key")

## Hmm error 


####13.4.5 Defining the key columns----

flights2 %>% 
  left_join(weather)

#Natural join 


flights2 %>% 
  left_join(planes, by = "tailnum")

# join by "x" - in this case by tailnum

flights2 %>% 
  left_join(airports, c("dest" = "faa"))

# join by = c("a" = "b")


flights2 %>% 
  left_join(airports, c("origin" = "faa"))


####13.4.6 Exercises----

#_1a Compute the average delay by destination, then join on the airports data 
#frame so you can show the spatial distribution of delays. 
#Here’s an easy way to draw a map of the United States:


airports %>%
  semi_join(flights, c("faa" = "dest")) %>%
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()


flights %>% glimpse()

airports %>% glimpse()

flights %>% 
  group_by(dest) %>% 
  mutate(avg_delay=mean(arr_delay, na.rm=TRUE)) %>% 
  select(dest,arr_delay,avg_delay) %>% 
  left_join(airports, "faa"=dest)

# Close but not enought :/ 


avg_dest_delays <-
  flights %>%
  group_by(dest) %>%
  # arrival delay NA's are cancelled flights
  summarise(delay = mean(arr_delay, na.rm = TRUE)) %>%
  inner_join(airports, by = c(dest = "faa"))

avg_dest_delays %>%
  ggplot(aes(lon, lat, colour = delay)) +
  borders("state") +
  geom_point() +
  coord_quickmap()


#_2a Add the location of the origin and destination (i.e. the lat and lon) to flights.

flights %>% 
  left_join(airports, c("dest" = "faa")) %>% 
  select(year:dep_delay,lat,lon)


#_3a Is there a relationship between the age of a plane and its delays?

?flights

?planes

planes %>% glimpse()

p1 <- planes %>% 
  mutate(y1=year)

p1 %>% inner_join(flights)


flights %>% 
  full_join(p1) %>% select(y1)


# FLAG to do  ----


#_4 What weather conditions make it more likely to see a delay?


flight_weather <-
  flights %>%
  inner_join(weather, by = c(
    "origin" = "origin",
    "year" = "year",
    "month" = "month",
    "day" = "day",
    "hour" = "hour"
  ))

flight_weather %>%
  group_by(precip) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = precip, y = delay)) +
  geom_line() + geom_point()


flight_weather %>%
  ungroup() %>%
  mutate(visib_cat = cut_interval(visib, n = 10)) %>%
  group_by(visib_cat) %>%
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = visib_cat, y = dep_delay)) +
  geom_point()

# FLAG to do  ----


##13.5 Filtering joins ----

top_dest <- flights %>%
  count(dest, sort = TRUE) %>%
  head(10)
top_dest


flights %>% 
  filter(dest %in% top_dest$dest)


# SEMI JOIN 

flights %>% 
  semi_join(top_dest)

# oposite - anti join

flights %>%
  anti_join(planes, by = "tailnum") %>%
  count(tailnum, sort = TRUE)


### 13.5.1 Exercises ----

#_1a What does it mean for a flight to have a missing tailnum?
#What do the tail numbers that don’t have a matching record in planes have in common? 
#(Hint: one variable explains ~90% of the problems.)

?flights

flights %>%
  anti_join(planes, by = "tailnum") %>% 
  select

#Flag to do ---- 

#_2a Filter flights to only show flights with planes that have flown at least 100 flights.

flights %>%
  filter(!is.na(tailnum)) %>%
  group_by(tailnum) %>%
  mutate(n = n()) %>%
  filter(n >= 100)



#_3a Combine fueleconomy::vehicles and fueleconomy::common 
#to find only the records for the most common models

?fueleconomy::vehicles

?fueleconomy::common


common %>% glimpse()

vehicles %>% glimpse()

vehicles %>%
  distinct(model, make) %>%
  group_by(model) %>%
  filter(n() > 1) %>%
  arrange(model)

#Flag to do ---- 



#_4a Find the 48 hours (over the course of the whole year) that have the worst delays.
#Cross-reference it with the weather data. Can you see any patterns?


### 13.6 Join problems ----

# Join workflow 

#Start by identifying the variables that form the primary key in each table. 


airports %>% count(alt, lon) %>% filter(n > 1)

# trap - it's not a primary key 

#Check that none of the variables in the primary key are missing.

#Check that your foreign keys match primary keys in another table

# Use anti_join


### 13.7 Set operations ---- 

#intersect(x, y): return only observations in both x and y.
#union(x, y): return unique observations in x and y.
#setdiff(x, y): return observations in x, but not in y.

df1 <- tribble(
  ~x, ~y,
  1,  1,
  2,  1
)
df2 <- tribble(
  ~x, ~y,
  1,  1,
  1,  2
)

intersect(df1, df2)

# Note that we get 3 rows, not 4


setdiff(df1, df2)

setdiff(df2, df1)


#CHAPTER 14- STRINGR ----


# Loading packages 

library(tidyverse)
library(stringr)

string1 <- "This is a string"

string2 <- 'If I want to include a "quote" inside a string, I use single quotes'


# writelines function 

x <- c("\"","\\")

x

writeLines(x)


# Help in Quotes

?"'"

#Combining strings

str_c("x","y")

str_c("x","y","z")

str_c("x","y", sep = ",")

## Prefix / Sufix 

str_c ("prefix-", c("a","b","c"),"-suffix")

# separators 

str_c("x","y", sep = ",")


x <- c("abc", NA)


# Replacing NA 

str_c("|-",x,"|-")
str_c("|-",str_replace_na(x),"|-")


# If function 

name <- "Hadley"

time_of_day <- "evening"

birthday <- FALSE
str_c("Good", time_of_day, " ", name, if (birthday) " Birthday")

str_c(c("x","y","z"),collapse= ",")


# STR SUB

## 14.3 Matching patterns with regular expressions

#14.3.1 Basic matches

x <- c("apple", "banana", "pear")

str_view(x,"an")

str_view(x, ".a..")

dot <- "\\."

str_view(c("abc", "a.c", "bef"), "a\\.c")

x <- "a\\b"

writeLines(x)

str_view(x,"\\\\")

## 14.3.1 Exercises ---- 

# Explain why each of these strings don’t match a \: "\", "\\", "\\\".

#"\": This will escape the next character in the R string.
#"\\": This will resolve to \ in the regular expression, which will escape 
#the next character in the regular expression.
#"\\\": The first two backslashes will resolve to a
#literal backslash in the regular expression
#the third will escape the next character.
#So in the regular expression, this will escape some escaped character.

str_length("s123sdaweqwe") # Number of characters in string 

c <- "s123sdaweqwe"

str_length(c)

str_to_upper(c)

str_to_title(c)

d <- "make a sentence for ME"

str_to_sentence(d)

str_trim("      TRIM    ")
## Found on solution book*** 

#Exercise 14.3.1

#What patterns will the regular expression \..\..\..
#match? How would you represent it as a string?


str_view(c(".a.b.c", ".a.b", "....."), c("\\..\\..\\.."), match = TRUE)

#14.3.2 Anchors

x <- c("apple", "banana", "pear")

str_view(x, "a$") # The end of the string

str_view(x, "^a") # Start of the string

#To remember which is which, try this mnemonic which I learned from Evan Misshula: 
  #if you begin with power (^), you end up with money ($).

x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")

str_view(x, "^apple$")


###14.3.2Exercises ---- 

#Given the corpus of common words in stringr::words, 
#create regular expressions that find all words that:

x <- c(words)

head(words)

# Ends with X

str_view(x, "x$", match=TRUE)

# Starts with Y 

str_view(x, "^y", match=TRUE)

# Are exactly three letters long. (Don’t cheat by using str_length()!)

str_view(x, "^...$", match = TRUE)

#Have seven letters or more.

str_view(x, "........", match = TRUE)

str_view(c("grey","gray"), "gr(e|a)y")

###14.3.3 Exercises----

#Create regular expressions to find all words that:

#Start with a vowel.

x <- words

str_view(x,"^[a,e,i,o,u,y]", match=TRUE)

str_subset(stringr::words, "^[aeiou]")

#That only contain consonants. (Hint: thinking about matching “not”-vowels.)

str_subset(stringr::words, "[aeiou]", negate = TRUE)

#Words that end with “-ed” but not ending in “-eed”.

str_subset(stringr::words, "[^e]ed$")

#Words ending in ing or ise:

str_subset(stringr::words, "[i(ng|se)]$")

str_subset(x,"[aeiou]", negate=TRUE)

#Words that end with "ed"

str_view(x,"ed$", match=TRUE)

#Words that end with "ed, but not ending in "eed".

str_view(x,"[^e]ed$", match=TRUE)

#Words ending in "ING" or "ISE"

str_view(x,"i(ng|se)", match=TRUE)


#Is Q always followed by a "u"

str_view(x,"q[^u]", match=TRUE)

# Create a regular expression that will match telephone numbers as commonly
#written in your country.

x <- c("123-456-789", "(123)456-789", "(123) 456-780", "123-125-251")

str_view(x, "(\\(?\\d{3})")


## Regular Expressions in R - exercises 


letters = c("abc", "abdd", "abcd", "xyz")
str_match(letters, "abc")

numbers = c("42", "421", "411!", "24")

str_match(numbers, "42")


str_match(phone_numbers, pattern)



##14.x.x----Excercises with regexr.com / regegex one 


##14.3.4 Repetition ----

# How many times pattern matches 

#? 0 or 1 
#+ 1 or more
#* 0 or more 


x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"

str_view(x, "C[LX]+")

### 14.3.4.1 Exercises ---- 

#1_

# ?={0,1}
# +={1,}
# *={0,}

#2_

#^.*$ - every string 

#"\\{.+\\}" - will match every string with sing in {}

#\d{4}-\d{2}-\d{2} - 4 digits, 2 digits, 2 digits,

#"\\\\{4}" - \\\\\\\\ - four backslashes 



#Create regular expressions to find all words that:

#Start with three consonants.

str_view(words, "^[^aeiou]{3}", match= TRUE)

#Have three or more vowels in a row.

str_view(words, "[^aeiou]{3,}", match= TRUE)

#Have two or more vowel-consonant pairs in a row.

str_view(words, "([aeiou][^aeiou]){2,}", match= TRUE)

##14.3.5 Grouping and backreferences ----

str_view(fruit, "(..)\\1", match = TRUE)

#(.)\1\1 _ "(.)(.)\\2\\1"_ (..)\1: _ "(.).\\1.\\1": _ "(.)(.)(.).*\\3\\2\\1"

#1.(.)\1\1: The same character appearing three times in a row. E.g. "aaa"
#2."(.)(.)\\2\\1": A pair of characters followed by the
#same pair of characters in reversed order. E.g. "abba".
#3. (..)\1: Any two characters repeated. E.g. "a1a1".
#4. (.).\\1.\\1": A character followed by any character
#the original character, any other character, the original character again.
#E.g. "abaca", "b8b.b".
#5 "(.)(.)(.).*\\3\\2\\1" Three characters followed by zero or more 
#characters of any kind followed by the same three characters but
#in reverse order. E.g. "abcsgasgddsadgsdgcba" or "abccba" or "abc1cba".

## Solution: https://jrnold.github.io/r4ds-exercise-solutions/strings.html

#Construct regular expressions to match words that:

#Start and end with the same character.

str_subset(words, "^(.)((.*\\1$)|\\1?$)")


### 14.4.1 Exercises ---- 

#Find all words that start or end with x.

words[str_detect(words,"^x|x$")]

#Find all words that start with a vowel and end with a consonant.

words[str_detect(words,"^[aeiou].*[^aeiou]$")]

#Are there any words that contain at least one of each different vowel?

words[str_detect(words,"[a].*[e].*[i].*[o].*[u]")]

# O words 

#What word has the higher number of vowels? What word has the highest proportion of vowels?
#(Hint: what is the denominator?)

vowels <-str_count(words,"[aeiou]")

words[which(vowels == max(vowels))]

prop_vowels <-str_count(words,"[aeiou]") / str_length(words)

words[which(prop_vowels == max(prop_vowels))]

# but how to delete "a"?

x <- c("apple", "banana", "pear")
str_count(x, "a")


##14.4.2 Extract matches ---- 

stringr::sentences# Harvard sentences 

colors <- c("red", "oragne", "yellow", "green", "blue", "purple")

color_match <- str_c(colors, collapse = "|")

color_match

has_color <- str_subset(sentences, color_match)

matches <- str_extract(has_color, color_match)

matches

more <- sentences[str_count(sentences, color_match)>1]

str_view_all(more,color_match)

str_extract_all(more,color_match, simplify = TRUE)

x <- c("a", "a b", "a b c")

str_extract_all(x, "[a-z]", simplify = TRUE)


###14.4.2.1 Exercises ---- 

#From the Harvard sentences data, extract:
  
#The first word from each sentence.

str_extract(sentences, "^\\w+")

#All words ending in ing.

str_extract(sentences, "^\\w+ing")

enging_ing <- ("^\\w+ing")

sentences %>% 
  str_subset(enging_ing) %>% 
  head()

str_match(sentences, enging_ing)


#All plurals

str_extract(sentences, "^\\w+s")  # not exactly 

##14.4.3 Grouped matches ---- 

noun <- "(a|the) ([^ ]+)"

str_extract(sentences, noun)

has_noun <- sentences %>%
  str_subset(noun) %>%
  head(10)


has_noun %>% 
  str_match(noun)


tibble(sentence = sentences) %>% 
  tidyr::extract(
    sentence, c("article", "noun"), "(a|the) ([^ ]+)", 
    remove = FALSE
  )


###14.4.3.1 Exercises ----

#Find all words that come after a “number” like “one”, “two”, “three” etc. 
#Pull out both the number and the word.

numbers <- c("one", "two", "three", "four", "five", "six", "seven", "eight", "nine")

numbers_match <- str_c(numbers, collapse = "|")

numbers_match

numword <- "\\b(one|two|three|four|five|six|seven|eight|nine) +(\\w+)"

has_number <- str_subset(sentences, numword)

has_number %>% head()


#Find all contractions. Separate out the pieces before and after the apostrophe.


contraction <- "([\\w]+)'([\\w+]+)"

sentences[str_detect(sentences, contraction)] %>%
  str_extract(contraction) %>% 
  str_split("'")

##14.4.4 Replacing matches----

x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-")

str_replace_all(x, "[aeiou]", "-")

x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three"))

sentences %>% 
  str_replace("([^ ]+) ([^ ]+) ([^ ]+)", "\\1 \\3 \\2") %>% 
  head(5)

###14.4.4.1 Exercises ----

#Replace all forward slashes in a string with backslashes.

str_replace_all("past/present/future", "/", "\\\\")

#Implement a simple version of str_to_lower() using replace_all().

str_replace_all("Maciej, Jurzyk", "[A-Z]", "[a-z]") # not working 

name <- c("Maciej", "Jurzyk")

replacements <- c("A" = "a", "B" = "b", "C" = "c", "D" = "d", "E" = "e",
                  "F" = "f", "G" = "g", "H" = "h", "I" = "i", "J" = "j", 
                  "K" = "k", "L" = "l", "M" = "m", "N" = "n", "O" = "o", 
                  "P" = "p", "Q" = "q", "R" = "r", "S" = "s", "T" = "t", 
                  "U" = "u", "V" = "v", "W" = "w", "X" = "x", "Y" = "y", 
                  "Z" = "z")

lower_words <- str_replace_all(name, pattern = replacements)
head(lower_words)

#Switch the first and last letters in words. Which of those strings are still words?

swapped <- str_replace_all(words, "^([A-Za-z])(.*)([A-Za-z])$", "\\3\\2\\1")

intersect(swapped, words)

##14.4.5 Splitting----

sentences %>%
  head(5) %>% 
  str_split(" ")

"a|b|c|d" %>% 
  str_split("\\|") %>% 
  .[[1]]

sentences %>%
  head(5) %>% 
  str_split(" ", simplify = TRUE)

fields <- c("Name: Hadley", "Country: NZ", "Age: 35")
fields %>% str_split(": ", n = 2, simplify = TRUE)

x <- "This is a sentence.  This is another sentence."
str_view_all(x, boundary("word"))

##14.4.5.1 Exercises ----

#Split up a string like "apples, pears, and bananas" into individual components.

x <- c("apples", "pears", "bananas")
 
str_split(x, ", +(and +)?")[[1]]


#Why is it better to split up by boundary("word") than " "?

#What does splitting with an empty string ("") do?
#Experiment, and then read the documentation.

##14.4.6 Find matches ----

#str_locate() and str_locate_all() give you the starting and ending 
#positions of each match. These are particularly useful when none of the other 
#functions does exactly what you want. You can use str_locate() to find the 
#matching pattern, str_sub() to extract and/or modify them.


##14.5 Other types of pattern ----

bananas <- c("banana", "Banana", "BANANA")
str_view(bananas, regex("banana", ignore_case = TRUE))

x <- "Line 1\nLine 2\nLine 3"
str_extract_all(x, "^Line")[[1]]

str_extract_all(x, regex("^Line", multiline = TRUE))[[1]]

phone <- regex("
  \\(?     # optional opening parens
  (\\d{3}) # area code
  [) -]?   # optional closing parens, space, or dash
  (\\d{3}) # another three numbers
  [ -]?    # optional space or dash
  (\\d{3}) # three more numbers
  ", comments = TRUE)

str_match("514-791-8141", phone)



  
### 14.5.1 Exercises ----  
  
#How would you find all strings containing \ with regex() vs. with fixed()
  
  str_subset(c("a\\b", "ab"), "\\\\")
  
  str_subset(c("a\\b", "ab"), fixed("\\"))
  
  
#What are the five most common words in sentences?
  
  
##14.6 Other uses of regular expressions  ----
  
  apropos("replace")
  
  head(dir(pattern = "\\.Rmd$"))
  
  
##14.7 stringi ----
  
  library(stringi)


  
###14.7.1 Exercises ---- 
  
  #Find the stringi functions that:
  
  #Count the number of words.
  
  stri_count_words(sentences)
  
  #Find duplicated strings.
  
  stri_duplicated(sentences)
  
  #Generate random text.
  
  stri_rand_strings(5,5)
  
  
  #How do you control the language that stri_sort() uses for sorting? To do**
  
  #Additional exercises stringi 
  
  
  s0 <- ""
  
  s <- "JRC Ispra"
  
  s1 <- s
  
  s2 <- substring(s, 1,3)
  
  
  stri_isempty(s0)
  
  stri_length(s);length(s)
  
  stri_locale_get()
  
  stri_compare(s2,s) # if stri  1 > stri 2 = 1, stri1 < stri2 = -1 stri1=stri2 = 0
  
  stri_sort(c(s0,s,s1,s2))

  toupper("JRC Ispra"); stri_trans_toupper("Ispra")
  
  tolower("JRC")
  
## THE END OF CHAPTER - so long :o 
  
#CHAPTER 15- Factors ---- 
  

##15.1 Introduction ---- 
  
library(tidyverse)
library(forcats)  

x1 <- c("Dec", "Apr", "Jan", "Mar")  

x2 <- c("Dec", "Apr", "Jun", "Mrr")

sort(x1)  

month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

y1 <- factor(x1, levels = month_levels)

y2 <- factor(x2, levels = month_levels)

sort(y2)

y3 <- parse_factor(x2, levels=month_levels)

factor(x1)


##15.3 General Social Survey ----

forcats::gss_cat


?gss_cat

gss_cat %>% 
  count(race)

ggplot(gss_cat, aes(race)) +
  geom_bar()

ggplot(gss_cat, aes(race)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE)

###15.3.1 Exercises ----
#_1a Explore the distribution of rincome (reported income).
#What makes the default bar chart hard to understand?
#How could you improve the plot?

ggplot(gss_cat, aes(rincome)) +
  geom_bar()+
  coord_flip()

#_2a What is the most common relig in this survey? 
#What’s the most common partyid?

ggplot(gss_cat, aes(relig)) +
  geom_bar()+
  coord_flip()

#Protestant 

ggplot(gss_cat, aes(partyid)) +
  geom_bar()+
  coord_flip()

#Independent 

#_3a Which relig does denom (denomination) apply to? 
#How can you find out with a table?
#How can you find out with a visualisation?

levels(gss_cat$denom)


gss_cat %>%
  filter(!denom %in% c(
    "No answer", "Other", "Don't know", "Not applicable",
    "No denomination"
  )) %>%
  count(relig)


##15.4 Modifying factor order ----

summary(gss_cat[["tvhours"]])

gss_cat %>%
  filter(!is.na(tvhours)) %>%
  ggplot(aes(x = tvhours)) +
  geom_histogram(binwidth = 1)

relig <- gss_cat %>% 
  group_by(relig) %>% 
  summarise(
    age= mean(age, na.rm=TRUE),
    tvhours = mean(tvhours, na.rm=TRUE),
    n=n()
  )
ggplot(relig,aes(tvhours, relig)) +
  geom_point()


ggplot(relig, aes(tvhours, fct_reorder(relig,tvhours)))+
  geom_point()


relig %>% 
  mutate(relig=fct_reorder(relig,tvhours)) %>% 
  ggplot(aes(tvhours,relig))+
  geom_point()

rincome <- gss_cat %>% 
  group_by(rincome) %>% 
  summarize(
    age = mean(age,na.rm=TRUE),
    tvhours=mean(tvhours, na.rm=TRUE),
    n=n()
  )

ggplot(
  rincome,
  aes(age,fct_reorder(rincome,age))
)+ 
  geom_point()


ggplot(
  rincome, 
  aes(age, fct_relevel(rincome, "Not applicable"))
)+
  geom_point()

#1 
by_age <- gss_cat %>% 
  filter(!is.na(age)) %>% 
  group_by(age, marital) %>% 
  count() %>% 
  mutate(prop=n/sum(n))

ggplot(by_age, aes(age, prop, color= marital))+
  geom_line(na.rm=TRUE)

ggplot(by_age,
  aes(age, prop, color= fct_reorder2(marital, age, prop))
)+
  geom_line()+
  labs(color="marital"))

#2 
by_age <- gss_cat %>%
  filter(!is.na(age)) %>%
  count(age, marital) %>%
  group_by(age) %>%
  mutate(prop = n / sum(n))

ggplot(by_age, aes(age, prop, colour = marital)) +
  geom_line(na.rm = TRUE)

ggplot(by_age, aes(age, prop, colour = fct_reorder2(marital, age, prop))) +
  geom_line() +
  labs(colour = "marital")


gss_cat %>%
  mutate(marital = marital %>% fct_infreq() %>% fct_rev()) %>%
  ggplot(aes(marital)) +
  geom_bar()


####15.4.1 Exercises ----

#_1a There are some suspiciously high numbers in tvhours.
#Is the mean a good summary?

gss_cat %>% summary()

summary(gss_cat[["tvhours"]])


gss_cat %>%
  filter(!is.na(tvhours)) %>%
  ggplot(aes(x = tvhours)) +
  geom_bar()


#_2aFor each factor in gss_cat identify whether the order of the
#levels is arbitrary or principled.

keep(gss_cat, is.factor) %>% names()

levels(gss_cat[["marital"]])

levels(gss_cat[["race"]])

levels(gss_cat[["rincome"]])

levels(gss_cat[["denom"]])

levels(gss_cat[["relig"]])




#_3a Why did moving “Not applicable” to the front 
#of the levels move it to the bottom of the plot?


#  level “Not applicable” is  an integer with value  1


##15.5 Modifying factor levels ----

gss_cat %>% count(partyid)

gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat"
  )) %>%
  count(partyid)


gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat",
                              "Other"                 = "No answer",
                              "Other"                 = "Don't know",
                              "Other"                 = "Other party"
  )) %>%
  count(partyid)


gss_cat %>%
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat")
  )) %>%
  count(partyid)


gss_cat %>%
  mutate(relig = fct_lump(relig)) %>%
  count(relig)


####15.5.1 Exercises ----
#_1a How have the proportions of people identifying as Democrat,
#Republican, and Independent changed over time?


levels(gss_cat$partyid)
gss_cat %>%
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat")
  )) %>%
count(year,partyid) %>% 
  group_by(year) %>% 
  mutate(p=n/sum(n)) %>% 
  ggplot(aes(
    x = year, y = p,
    colour = fct_reorder2(partyid, year, p)
  )) +
  geom_point() +
  geom_line() +
  labs(colour = "Party ID.")


#_2a How could you collapse rincome into a small set of categories?

#Flag to do ---- 


#CHAPTER 16- Dates and times ----

##16.1 Introduction ---- 

library(tidyverse)
library(lubridate)
library(nycflights13)

##16.2 Creating date/times ----

today()
now()


### 16.2.1 From strings ----
ymd("2017-01-31")

mdy("January 31st, 2017")

dmy("31-Jan-2017")

ymd(20170131)

ymd_hms("2017-01-31 20:11:59")

mdy_hm("01/31/2017 08:01")

ymd(20170131, tz = "UTC")

###16.2.2 From individual components ----

flights %>% 
  select(year, month, day, hour, minute)

flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute))


make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(
    dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
    sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)
  ) %>% 
  select(origin, dest, ends_with("delay"), ends_with("time"))

flights_dt %>% 
  ggplot(aes(dep_time))+
  geom_freqpoly(binwidth= 86400)

#86400 seconds = 1 day 

flights_dt %>% 
  filter(dep_time<ymd(20130102)) %>% 
  ggplot(aes(dep_time))+
  geom_freqpoly(binwidth= 600)

# 600 seconds = 10 minutes 

###16.2.3 From other types ----

as_datetime(today())

as_date(now())

as_datetime(60 * 60 * 10)

as_date(365 * 10 + 2)

#### Exercises 

#_1a What happens if you parse a string that contains invalid dates?

ymd(c("2010-10-10", "bananas"))

#failed to parse. 

#_2a What does the tzone argument to today() do? Why is it important?
?today

today(tzone="UTC")

d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14" # Dec 30, 2014

mdy(d1)

ymd(d2)

dmy(d3)

mdy(d4)

mdy(d5)


##16.3 Date-time components----

###16.3.1 Getting components----

datetime <- ymd_hms("2016-07-08 12:34:56")

year(datetime)
#> [1] 2016
month(datetime)
#> [1] 7
mday(datetime)
#> [1] 8

yday(datetime)
#> [1] 190
wday(datetime)
#> [1] 6


month(datetime, label = TRUE)
wday(datetime, label = TRUE, abbr = FALSE)

flights_dt %>% 
  mutate(wday = wday(dep_time, label = TRUE)) %>% 
  ggplot(aes(x = wday)) +
  geom_bar()


flights_dt %>% 
  mutate(minute = minute(dep_time)) %>% 
  group_by(minute) %>% 
  summarise(
    avg_delay = mean(arr_delay, na.rm = TRUE),
    n = n()) %>% 
  ggplot(aes(minute, avg_delay)) +
  geom_line()
 

sched_dep <- flights_dt %>% 
  mutate(minute = minute(sched_dep_time)) %>% 
  group_by(minute) %>% 
  summarise(
    avg_delay = mean(arr_delay, na.rm = TRUE),
    n = n())

ggplot(sched_dep, aes(minute, avg_delay)) +
  geom_line()

ggplot(sched_dep, aes(minute, n)) +
  geom_line()

#### 16.3.4 Exercises

#_1a How does the distribution of flight times within a day 
#change over the course of the year?

#_2a Compare dep_time, sched_dep_time and dep_delay.
#Are they consistent? Explain your findings.

#_3a Compare air_time with the duration between the departure and arrival. 
#Explain your findings. (Hint: consider the location of the airport.)