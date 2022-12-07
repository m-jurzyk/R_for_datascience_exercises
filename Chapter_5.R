#CHAPTER 5- Data transformation---- 

# Loading libraries 

library(nycflights13)

library(tidyverse)

library(dplyr)

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

##EXCERCISE Departed between midnight and 6am (inclusive)

flights %>% filter(dep_time>=0 & dep_time<=600)

## DONE!

##EXCERCISE Another useful dplyr filtering helper is between(). What does it do? 
#Can you use it to simplify the code needed to answer the previous challenges?

flights %>% filter(dep_time, between(c)) ## Non lo so :( MJ QUESTION 

#EXCERCISE How many flights have a missing dep_time? What other variables are missing? 
#What might these rows represent?

f1 <-flights %>% filter(is.na(dep_time))

nrow(f1)


## 8255? 

### 5.3 Arrange ----

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
  arrange(select(f2,speed))

## MJ QUESTION  how to show selected and arranged column? 


# EXCERCISE: Which flights travelled the farthest? Which travelled the shortest?

arrange(flights,distkm),

arrange(flights, desc(distkm))

## MJ QUESTION:: How to show only arranged columns 


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

f3 <- flights %>% transmute(flights$speed <- flights$distkm/flights$air_time_h)

arrange(f3,desc(speed))

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
