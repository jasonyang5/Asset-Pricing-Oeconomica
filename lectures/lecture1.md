# Lecture 1: Base DPLYR
Base DPLYR are functions used for manipulationg / moving around data frames
## Setup and Skeleton Code
In this lecture I will be using the diamonds dataset and titanic dataset
```
# Please run this skeleton code

# tidyverse is a super-package containing dplyr and many other packages we 
# will be learning to use this quarter
install.packages(tidyverse)
library(tidyverse) 

# Here's how you access the data:
attach(diamonds)
library(nycflights13)
```
TODO: (write all this data to a csv so students can open in excel)
\\ Documentation for diamonds Data: https://ggplot2.tidyverse.org/reference/diamonds.html
\\ Documentation for flights data: https://www.transtats.bts.gov/DatabaseInfo.asp?DB_ID=120&Link=0

## Core Functions and Syntax
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
filter(dataset, condition1, condition2) # multiple conditions mean that the rows must satisfy /all/ of them 
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

## A note on Literal Evaluation (for variables)



