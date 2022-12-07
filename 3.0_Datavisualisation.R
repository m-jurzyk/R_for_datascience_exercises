# R for data science, chapter 3 - Data visualisation 

## Loading library tidiverse to get access to ggplot

library(tidyverse)

## MPG access to data

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


## EXCERCISES 

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

#3.6.1 Exercises

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


## 3.7 Statistics information 

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

## NEW CHAPTER

# 4.4 Workflow basics - Excercises 

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

# CHAPTER 5 - Data transformation 

# Loading libraries 

library(nycflights13)

library(tidyverse)

library(dplyr)

### 5.2.4 Exercises
#Find all flights that

#Had an arrival delay of two or more hours

flights %>%  filter(arr_delay>120)

#Flew to Houston (IAH or HOU)

flights %>% head
colnames(flights)


flights %>% filter(dest=="HOU"|dest=="IAH") # Answer 

view(flights)

flights

#Were operated by United, American, or Delta

?flights

viwe(airlines) ## To check airlines carrier / full name corelation 

flights %>% filter(carrier=="UA"|carrier=="AA"|carrier=="DL") # Answer 

## UA, AA, DL United, American, Delta 

#Departed in summer (July, August, and September)

flights %>% filter(month==7|month==8|month==9)

##Arrived more than two hours late, but didn’t leave late

flights %>% filter(dep_delay<=0 & arr_delay>120)

##Were delayed by at least an hour, but made up over 30 minutes in flight


flights %>% filter(dep_delay>60 & arr_delay<=30)

##Departed between midnight and 6am (inclusive)

flights %>% filter(dep_time>=0 & dep_time<=600)

## DONE!

##Another useful dplyr filtering helper is between(). What does it do? 
#Can you use it to simplify the code needed to answer the previous challenges?

flights %>% filter(dep_time, between(c)) ## Non lo so :( 

#How many flights have a missing dep_time? What other variables are missing? 
#What might these rows represent?

f1 <-flights %>% filter(is.na(dep_time))

nrow(f1)



## 8255? 

# CHAPTER 5.3 Arrange

#Sort flights to find the most delayed flights. Find the flights that left earliest.

flights %>% arrange(dep_delay,desc(arr_delay))

## Flights that have the smallest number of depatrute delay, and the highest of 
#arrival delay

?flights

#Sort flights to find the fastest (highest speed) flights.


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


## Speed 

flights$speed <- flights$distkm/flights$air_time_h

arrange(flights, speed)
select(flights,speed)

## how to show selected and arranged column? 


#Which flights travelled the farthest? Which travelled the shortest?

arrange(flights,distkm)

arrange(flights, desc(distkm))

## How to show only arranged columns 


