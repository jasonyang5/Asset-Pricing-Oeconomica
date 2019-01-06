# Lecture 2: GGPLOT
```
# Import
library(ggplot2)
attach(diamonds) # we will be using diamonds as our example, like last time
```

## General Philosophy
Start with a very basic graph where you specify x and y axis, and then you keep adding on things that you want (using the + sign)
```
## Your ggplot always starts like this:
# Syntax:
ggplot(data, aes(x = xvar, y = yvar))
# Example:
ggplot(diamonds, aes(x = carat, y = price))
```
The example code will produce a blank plot

## Scatterplot
To make a scatterplot of the data, add geom_point
```
ggplot(diamonds, aes(x = carat, y = price)) +
    geom_point()
```

To add a regression line, add geom_smooth
```
ggplot(diamonds, aes(x = carat, y = price)) +
    geom_smooth(method = "lm")
```
Remarks:

* Usually you will want to combine both!
* Don't worry about other kinds of regressions like loess, quadratic, etc- we will cover that in the regression part of the quarter (in a few weeks). 
* Please do specify a method, the default (in my experience) is almost always not what I wanted it to be. 

## Axis Adjustments
Zoom in (points outside range will be considered in geom_smooth regression)
```
ggplot(diamonds, aes(x = carat, y = price)) +
    geom_smooth(method = "lm") +
    coord_cartesian(xlim = c(0, 0.5), ylim = c(0,15000))
```

## Labels
```
ggplot(diamonds, aes(x = carat, y = price)) +
    geom_smooth(method = "lm") +
    labs(title = "Diamond Price Vs Carat",
        subtitle = "Jason Yang",
        x = "Carats",
        y = "Price ($)")
```
