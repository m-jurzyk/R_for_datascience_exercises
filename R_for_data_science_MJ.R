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
    geom_histogram()

      ### non lo so :/  - problems with histogram
      
      
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
        geom_point() + 
        geom_smooth(),

## Prediction: mpg mapped x- engine size, y- efficiency, color- drive type
## Scatterplot with line smooth without se?

## Reality - 3 diffrent lines and smooth of drive? - kind of unexpected 


# Graphs will look the same- it's only difrent way of writing 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(),

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

flights$distkm <- flights$distance/0.62137,

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

