---
geometry: margin=2.5cm
---
# Lecture 4: Broom and DPLYR
## Reminder: Broom Functions
```
attach(diamonds)
vol_price_reg = lm(volume ~ price, diamonds)

tidy(vol_price_reg)
glance(vol_price_reg)
augment(vol_price_reg)
```

## Problem we will solve today
What we have: a data frame with an output variable and many input variables- like the diamonds data.

What we want: a way to regress every input variable on the output variable

What we need (ingredients for the LM function):

* A data frame for each variable that has the appropriate x value on one column and then the associated price on the next column
* This could be easily implemented with group_by if we had the x values in the rows, not the columns
* Turns out, transforming this data into a format we want is actaully quite easy

## Tidyr and do
Tidyr is a a package contained within the tidyverse that lets you reshape data. 
There are two functions: `gather()` and `spread()`, and in many ways you can think of them as inverses of eachother. 

**Gather Function**
```
## Given a data frame, compresses into 2 columns named key or value
gather(data, key, value, -excluded, -excluded ...)

## setup
mtcars = cbind(mtcars, car_names = rownames(mtcars))
cdc_data = read_csv(path to cdc data if I can find it)

## Example 1:
gather(mtcars2, key = "statistic", value = "value")
gather(mtcars2, key = "statistic", value = "value", -car_names)
```

**Do Function**

You can think of do as a more generalized version of summarise (you don't want it to replace summarise, though, since it isn't as fast). 

You can specify the columns to be whatever objects you want- lists, numbers,  regression objects, other data frames, etc. 

## Putting it all together
```
# prepare the data
diamonds_regression = gather(diamonds2, key = "x_value", value = "value", -price)

# do lots of regressions- tells us which ones are the best
regressions = group_by(diamonds_regression, x_value) %>%
    do(linear_model = lm(price ~ value, .))

# now that we have a table of regression objects, we can make them look nice
# with the broom package and the map function
accuracy_stats = map(.x = regressions[[2]],
                     .f = glance) %>%
                 bind_rows()
```