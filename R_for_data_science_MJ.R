# R for data science ----

#EXPLORE ----
## Loading library tidiverse to get access to ggplot

library(tidyverse)

## MPG access to data


# CHAPTER 3- Data visualisation ----
mpg


## Creating ggplot 

# From mpg data base %>%  create ggplot with geometry point mapped aesthetics 
# x means engine size and y car's fuel efficiency 

mpg %>% ggplot()+
  geom_point(mapping = aes(x=displ, y =hwy))


# How many rows and how many columns are in mpg dataset?

nrow(mpg)

ncol(mpg)

# 234 rows and 11 columns 


?mpg


## 3.2.4 Excercise 4: Make a scatter plot of hwy vs cyl

mpg %>% ggplot()+
  geom_point(mapping = aes(x=hwy, y=cyl))

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

## Kind of :/ 

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

# With histogram it seems to be more dificult 

ggplot(data = mpg, mapping = aes(x = displ)+
         geom_histogram()

      ### non lo so :/ 
      
      
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

#Why does this code not work?

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


## alt shift + k - show shourtcuts 


## END OF THE CHAPTER 

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

## CHAPTER 9- Introduction ----


