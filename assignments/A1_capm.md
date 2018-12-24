# Assignment 1: CAPM
In this assignment, we will do a basic empirical test of the CAPM model.
Testing an asset pricing model typically follows the following steps:

1. Clean up returns data
2. Calculate relevant factors
3. Put the securities into portfolios (buckets) based on the factors
4. Regress the portfolios onto return

CAPM only has 1 factor- market $\beta$

## Part 0: Setup
(Insert directions on how to install the skeleton code and whatnot)

## Part 1: Cleaning
1. Now that you have installed the data, you can start looking through it and cleaning it. 
2. What are the variable names and what are their types?
    - You may want to change the variable names to be more descriptive. Documentation on these variable names is at the bottom
3. Do you see problems with any of the variable types? Which one(s)?
    - Don't worry if you haven't noticed yet, when you try working with them type errors will come up and you can change them then.
4. Convert the types accordingly using the ```mutate()``` function and the base R function for type conversions: ```as.numeric(), as.character()``` are the common ones.
5. Now we have the Stock Returns, Market Returns, but no Risk Free rate. Attach the Risk Free rate to the returns_data using ```mutate()```
    - Hint: In principle, you would use ```case_when()``` when you just want to do key-value pairs, but it's impractical to write a case for each month (500+).
    - Try using the ```left_join()``` function- you can find a helpful guide on http://stat545.com/bit001_dplyr-cheatsheet.html
    - You could certainly implement this with a for loop or map, but it would take a really long time to run, so try to use this dplyr based solution instead.
6. Compute excess return - return of the stock minus risk free rate
    - Be careful! The fama-french risk free rate data is the risk free return for a *year*, not a *month*. You will have to convert that yourself using some basic arithmetic.
7. Now record this data with the ```write_feather()``` function and hold onto it. We will be building off of this cleaned data in Part 2.

## Part 2: Summary Statistics


## Part 3: Calculate Beta

## Part 4: 