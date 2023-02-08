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

microbenchmark::microbenchmark(
  fixed = str_detect(sentences, fixed("the")),
  regex = str_detect(sentences, "the"),
  times = 20
  
  a1 <- "\u00e1"
  a2 <- "a\u0301"
  c(a1, a2)
  
  a1==a2  
  
  
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