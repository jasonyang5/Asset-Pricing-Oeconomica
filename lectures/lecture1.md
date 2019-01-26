---
geometry: margin=2.5cm
---
# Lecture 1: Base DPLYR
Base DPLYR are functions used for manipulationg / moving around data frames
## Setup and Skeleton Code
In this lecture I will be using the diamonds dataset and titanic dataset
```
# Please run this skeleton code

# tidyverse is a super-package containing dplyr and many other packages we 
# will be learning to use this quarter
library(tidyverse) 
```
Documentation for diamonds Data: https://ggplot2.tidyverse.org/reference/diamonds.html

Documentation for titanic Data: https://www.kaggle.com/c/titanic/data (data dictionary)

Documentation for flights data (only used in documentation section at the bottom): https://www.transtats.bts.gov/DatabaseInfo.asp?DB_ID=120&Link=0

## Motivation
We saw that picking columns by name(s) is beneficial because it's not dependent on what order the columns are in. The $ is not sufficient if you want to pick multiple columns. 

And, we often would like to pick rows based on some variable's condition. 

We could mitigate some of these factors by making an abstraction- as you have done on the homework. But, note that a complete (easy to use) one isn't possible for filter. 

This time we will be using `select()`, `filter()`, `group_by()`, and two new functions- `mutate()` and `summarise()`. These take a data frame and make a data frame. 

And, `join()` functions, these combine multiple data frames. 

## Quick Review
What do each of the hw functions do and when might you use them?
`select()`, `filter()`, `group()`

## Visual Explanations of Mutate, Summarise, Join
See separate PDF file

## Example Problem: Basic Summary Stats Titanic Dataset
Now we will work through another example, this time we have access to these great DPLYR functions!

```
library(tidyverse)

basepath = "whatever your basepath is"
data = read_csv(paste0(basepath, "titanic.csv"))
```

We will use the titanic data set from kaggle and use it to get various summary statistics. 
```
# Mean Survival
# want to compute number of survivals / number of observations
summarise(data, sum(Survived)/n())

# Count NAs in all the datas- kick out bungy variables
count_nas<-function(column)
{
  return(sum(is.na(column)))
}

na_data = summarise_all(data, count_nas)

# Survival variation with class
group_by(data, Pclass) %>%
    summarise(surv_rate = sum(Survived)/n(), num_obs = n())

# New variable: familial relationships
mutate(data, relationships = SibSp + Parch)

# Survival variation with the new variable
(similar to above)

# Take examples of things to compute
```

## Data Set Joins
In this section we use the diamonds data
```
attach(diamonds)

# Associate each cut type with a number
distinct_cuts = select(diamonds, cut) %>%
  distinct()
cut_codebook = data_frame(cut = distinct_cuts[[1]],
                          num_cut = c(1,2,3,4,5))

# Join the data together
diamonds2 = full_join(diamonds, cut_codebook) %>%
  select(-cut)

# Associate cut type and price
cut_type_vs_price = group_by(diamonds2, num_cut) %>%
  summarise(avg_price = mean(price), sd = sd(price))

# Make volume
TODO: Include example about making volume, then compare that to prices (perhaps you will want a regression)
```

# Reference Documentation (not in lecture)
* select()- pick columns by name
```
# Syntax:
select(dataset, colname1, colname2, ...)
# Example:
select(diamonds, carat)
select(diamonds, x, y)
```
* filter()- pick rows that satisfy a condition
```
# Syntax:
# multiple conditions mean that the rows must satisfy /all/ of them 
filter(dataset, condition1, condition2) 
# Example:
filter(diamonds, carat > 0.5)
filter(diamonds, carat > 0.5 | x > 2) # or statement
filter(diamonds, carat > 0.5 & x > 2) # and statement
filter(diamonds, carat > 0.5, x > 2) # equivalent to and statement
```
* arrange()- sorts data frame based on columns given
```
# Syntax:
arrange(dataset, col1, col2, ...)
arrange(dataset, desc(col1, col2, ...), col3 ...) # use desc for colnames you want to do in descending order
# Example:
arrange(diamonds, carat)
arrange(diamonds, desc(carat))
```
* transmute()/mutate()- returns a modified data frame with a new column that is based on existing columns
```
# Syntax:
mutate(dataset, colname = what to do)
# Example (from dplyr vignette):
# mutate adds the columns
mutate(flights, 
    gain = arr_delay - dep_delay,
    gain_per_hour = gain / (air_time / 60))
# transmute only keeps the newly produced columns
mutate(flights, 
    gain = arr_delay - dep_delay,
    gain_per_hour = gain / (air_time / 60))
```
* summarise()- provides some summary of the data in the form of a single row (typically used with group_by, unless you only want summary statistics)
```
# Syntax
summarise(dataset, new_colname = some function)
# Example
summarise(diamonds, avg_carats = mean(carat))
```
* group_by()- returns a set of dataframes that share a common column/variable value
```
# Syntax
group_by(dataset, colname)
# Example
group_by(diamonds, cut) # dataframe with each cut type
```
You usually combine all of the above together to get very powerful summary statistics
```
# Combination Example (from dplyr vignette):
by_tailnum = group_by(flights, tailnum)
delay = summarise(by_tailnum, 
    count = n(), 
    dist = mean(distance, na.rm = TRUE), 
    delay = mean(arr_delay, na.rm = TRUE))
significant_delays = filter(delay, count > 20, dist < 2000)
```
Try to see what happens at each step!
* if_else()- applies an if else statement to a vector, returning another vector of same length
``` 
# Syntax:
if_else(condition, what to return in true case, what to return in false case)
# Example:
big_boys = mutate(diamonds, 
    big_or_no = if_else(carat > 0.7, "big", "no"))
```
if_else ensures that the true case and false case are both of the same type.
* ifelse()
Same as if_else byt does not have type check
* case_when()- if, else if, else if, else
```
# Syntax:
# Example:
```
* %>% - pipe operator- used for visually appealing function composition
