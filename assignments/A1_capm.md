---
geometry: margin=2.5cm
---
# Project 1: CAPM
In this assignment, we will do a basic empirical test of the CAPM model.
Testing an asset pricing model typically follows the following steps:

1. Clean up returns data
2. Calculate relevant factors
3. Put the securities into buckets based on the factors
4. Regress the portfolios onto return

CAPM only has 1 factor- market $\beta$

## Part 0: Setup
Make sure to download the raw data from the Data folder on the google drive. We will be using returns_data_folder.zip and rf_data.csv.

Install these to your proper path, then load them into R using the appropriate read function `read_feather()`, `read_csv()`.

## Part 1: Cleaning
1. Now that you have installed the data, you can start looking through it and cleaning it. 
2. What are the variable names and what are their types?
    - You may want to change the variable names to be more descriptive. Documentation on these variable names is at the bottom
3. Do you see problems with any of the variable types? Which one(s)?
    - Don't worry if you haven't noticed yet, when you try working with them type errors will come up and you can change them then.
4. Convert the types accordingly using the `mutate()` function and the base R function for type conversions: `as.numeric(), as.character()` are the common ones.
5. Now we have the Stock Returns, Market Returns, but no Risk Free rate. Attach the Risk Free rate to the returns_data
    - Try using a `join()` function- you can find a helpful guide on http://stat545.com/bit001_dplyr-cheatsheet.html
    - You could certainly implement this with a for loop or map, but it would take a really long time to run, so try to use this dplyr based solution instead.
6. Compute excess return - return of the stock minus risk free rate
    - Be careful! The fama-french risk free rate data is the risk free return for a *year*, not a *month*. You will have to convert that yourself using some basic arithmetic.
7. Now record this data with the `write_feather()` function and hold onto it. We will be building off of this cleaned data in Part 2.

## Part 2.1: Summary Statistics


## Part 2.2: Calculate Beta

### Directions
We want to calculate the $\beta$ for each stock *ex ante*, i.e. before the returns we evaluate actually happen. 
So, only use data before January 1935 to calculate beta. 
You should exclude betas that don't have at least 5 years of returns observations. 

Before looking at the hints, try to come up with the method yourself. Then, refer to the lecture0 code and notes, then look at the hints. 

### Hints
1. We want to calculate $\beta$ for each stock before we regress it on returns. So, the data to compute beta must come *before* the actual regression observations.
2. Subset the returns data from beginning to January 1935
3. Using this data compute the beta for each stock
    * use `group_by()`
    * On each group, we want covariance of returns wrt market and variance of market return. 
    * On this dataset, divide cov/var to get the beta
    * What kind of beta did we just calculate? Why use this beta over the other form of beta we discussed in fall quarter?

## Part 3: Regression and Visualisation