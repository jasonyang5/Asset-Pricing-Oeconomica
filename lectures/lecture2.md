# Lecture 2: GGPLOT
Setup code
```
# Setup Code --------------------------------------------------------------
basepath = "~/Downloads/"
titanicdata = read_csv(paste0(basepath, "titanic.csv"))
attach(diamonds)data("midwest", package = "ggplot2")


# survival rate for each class
pclass_vs_surv_rate = group_by(titanicdata, Pclass) %>%
  summarise(survival_rate = sum(Survived)/n())

# survival rate of each sex
sex_vs_surv_rate = group_by(titanicdata, Sex) %>%
  summarise(survival_rate = sum(Survived)/n())

# family relationships and survival rate
titanicdata = mutate(titanicdata, family = SibSp + Parch)

family_relation = group_by(titanicdata, family) %>%
  summarise(survival_rate = sum(Survived)/n(),
            num_obs = n())
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

Motivating Plot:
```
gg = ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state, size=popdensity)) + 
  geom_smooth(method="loess", se=F) + 
  xlim(c(0, 0.1)) + 
  ylim(c(0, 500000)) + 
  labs(subtitle="Area Vs Population", 
       y="Population", 
       x="Area", 
       title="Scatterplot", 
       caption = "Source: midwest")
```

Important features (of the code and the graph)

* You add more and more features on top of the original plot- see what happens when we comment out one or more lines
* This is a static plot yet it still contains a lot of information - the colors (aesthetic choices) allow us to display more dimensions of the data.

## Example 1: Visualizing Titanic Summary Data (simple bar, simple regression)
First, we will load in the summary data we created last time.


If we want to create a ggplot for one of these, we have to initialize the ggplot and then gradually add on more and more layers. 

Commands we will use:

* ggplot- initializes the plot
* geom_point()- graphs one point for each data you use
* geom_bar(stat = "identity")- graphs a bar for each data used (good for discrete data)
* geom_smooth- graphs a line using the regression method you specify through the data
* labs()- adds labels in the way you might expect

```
# Bar Plot
sex_surv_plot = ggplot(sex_vs_surv_rate, aes(x = Sex, y = survival_rate)) +
  geom_bar(stat = "identity")

# Example for the class to do
pclass_surv_plot = ggplot(pclass_vs_surv_rate, aes(x = Pclass, y = survival_rate)) +
  geom_bar(stat = "identity")

# regression plot
fam_surv_plot = ggplot(family_relation, aes(x = family, y = survival_rate)) +
  geom_point() +
  geom_smooth(method = lm)
```

## Example 2: Visualizing Diamonds Summary Data
```
diamonds2 = mutate(diamonds, volume = x*y*z, 
                    carat_bucket = ntile(carat, 50),
                    price_bucket = ntile(price, 100))

# relatively messy
carat_price_nobin = ggplot(diamonds2, aes(x = carat, y = price)) +
    geom_point(aes(col = cut, size = volume))

# slightly less messy
carat_price_plot_bin = ggplot(diamonds2, aes(x = carat, y = price_bucket)) +
  geom_point(aes(col = cut, size = volume))
```
Challenge question: why do these graphs look so different? (With this in mind, you should be careful of how your visualizations present the data)

# General Documentation (not included in the lecture)

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

## Graphing examples from the previous lecture
