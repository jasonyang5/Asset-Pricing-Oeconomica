# R Base Exercises and Resources

## Resource: Base R Tutorial
Read the following pages on this website (https://www.tutorialspoint.com/r/index.htm)

Basic Syntax
Data Types
Variables
Operators
Decision Making
Loops
Functions
Strings
Vectors
Matrices
Arrays
Factors
Data Frames

Note that you can use equals sign (=) instead of (<-) for assigning variables.

Of course, you can skip the sections you feel like you already know well.

Feel free to email me any questions! jfyang@uchicago.edu

## Resource: Maps
(See hand written notes, uploaded to google drive)

## Problem 1: Loops, Maps, and Variables
Write a function that adds all of the numbers together in a vector (relevant section: Loops, and Map Resource) first using a loop, then using a map.
```
my_sum_loop<-function(numbers)
{
    # your code goes here
}

my_sum_map<-function(numbers)
{
    # your code goes here
}
```

## Problem 2: Decisionmaking
Write a function that determines the tax bracket of an individual based on their income and the following breakdown:
Greater than 500,000: 50
Greater than 250,000: 35
Greater than 100,000: 20
Less than 100,000: 10
```
tax_bracket<-function(income)
{
    # your code goes here
}
```

Now write a function that returns a vector of tax brackets given a vector of incomes
```
tax_bracket_many<-function(incomes)
{
    # your code goes here
}
```

## Problem 3: Decisionmaking (and loops or maps)
Write a function that takes a vector and an item, then returns the indices that equal the item given
```
my_which<-function(vector, item)
{
    # your code goes here
}
```