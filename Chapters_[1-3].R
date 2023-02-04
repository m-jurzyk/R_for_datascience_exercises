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
       