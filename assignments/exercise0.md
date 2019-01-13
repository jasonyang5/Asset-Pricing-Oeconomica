---
geometry: margin=2.5cm
---

# Exercise 0
You will notice in the code I uploaded on google drive (in Lectures folder- code_lecture0.R) that we frequently used the `which()` function to isolate particular columns or rows.
In this homework, we will use `which()` to make a function that selects columns based on column names, and filters based on some condition.

Setup: Copy this into your code window (top left) and click source button.
```
library(tidyverse)
library(feather)
# Go to the data folder on google drive and install the data, unzip it

# sometimes the directory is hard to set up, email me if you have problems
basepath = "~/Downloads/" # path to your data directory
returns_data = read_feather(paste0(basepath, "beta_returns_data.feather"))
```

## Problem 1: my_select
Write a function that takes in a data frame (excel sheet) and returns another data frame (excel sheet) with the given column names. 

```
my_select <- function(dataframe, names_vector)
{
    # your code goes here
}

# Example Output:
my_select(returns_data, c("Returns")) 
# should return another data frame only containing the returns column

my_select(returns_data, c("Returns", MktReturn))
# should return another data frame containing the returns column and market returns column
```

## Problem 2: my_filter
Write a function that takes in a data frame (excel sheet) and and returns a data frame that requires a column to equal something.

```
my_filter <- function(dataframe, col_name, equal_item)
{
    # your code goes here
}

# Example Output:
my_filter(returns_data, "Returns", 0.01)
# returns a data frame only containing the rows with return equal to 0.01 (1%)

my_filter(returns_data, ID, 14593)
# returns a data frame only containing Apple Stock (AAPL)
```

## Problem 3: my_group
Write a function that takes a large data frame and returns a list of subsets of that data frame based on the given column. 

This is similar to the group function we implemented in class, but instead it should take the column name as an *argument* instead of always being ID

```
my_group<-function(dataframe, col_name)
{
    # your code goes here
}
```