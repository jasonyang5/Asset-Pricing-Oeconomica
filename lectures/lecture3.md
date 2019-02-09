---
geometry: margin=2.5cm
---
# Lecture 3- Regression

## Motivation
We learned earlier that the CAPM model suggests a function that allows us to know Return ($R$) if we know market $\beta$.
$$R = \beta(R_p) + R_f$$
Now, the model posits that the parameters (coefficient on $\beta$ and y-intercept) should be the market Risk Premium and the Risk Free Rate.
We can test this relationship using a linear regression - given a lot of returns data and market betas we can find the best parameters. 

## Derivation of OLS
Estimating linear coefficients applies to a wider class of problems. Suppose this is the true relationship between an output $y$ and data $x$. 
$$y = \beta_0 + \beta_1x + \epsilon$$
We don't know how the random error $\epsilon$ will go, so the best we can do is an estimate $y_e$
$$y_e = \beta_0 + \beta_1x$$
We want to choose the best $\beta$ values so that way $y_e$ is closest to the true $y$.

The squared error is $(y-y_e)^2$.
We can plug in to get squared error is $(y - \beta_0 - \beta_1x)^2$
And since we have lots of datas, we want to minimize the sum of all of these squared errors for all of our observations. 

Now this is just a simple calculus problem: we want to do this:
$$\min \sum_{i=1}^{n}(y_i - \beta_0 - \beta_1x_i)^2$$
Which just requires taking the derivative and setting it equal to zero. I won't do that now, but you should have the tools to do this once you complete Math 153, or have access to wolfram alpha. 

**Remark**: This derivation of the linear function is only dependent on the data given as is. 
We do not know if this is even an accurate way to describe the real true data generating process $y$

With that in mind, what might make $y_e$ a poor estimate of $y$?

It turns out that when errors are normally distributed and $\mathbb{E}(\epsilon)=0$, then this way of computing $\beta$ is the best we can do - the "Maximum Likelihood Estimate". 

No wrong answers: do you think errors in say stock returns data are normally distributed? (We should probably define our terms- what error means?) 
How might we test this qualitatively?

## Practical Applications
Lots of problems are secretly linear if you transform one of the variables. 
A common one in Economics is the logarithm function. 

## R Syntax
To do a linear regression, use the `lm()` function: it takes a formula and data

We will use the broom package which has some helpful functions that make it easy to see what the output of the regression is (and access it)
```
attach(diamonds)
vol_price_reg = lm(volume ~ price, diamonds)

tidy(vol_price_reg)
glance(vol_price_reg)
augment(vol_price_reg)
```

If you want to test your model on test data you just add it to the regression points (usually we won't do this since we want to test some mathematical model, so we use the whole test data, but if your formula is purely statistical you would do this)
```
get_regression_points(vol_price_reg, newdata = test_data)
```

## Example
1. Calculate LM for some arbitrary continuous variable
2. Get the predictions for all the poitns in the data
3. Get the residuals (probably using `mutate()`)
4. Plot the residuals- see if they are normally distributed

```
# prepare the data
diamonds_regression = gather(diamonds2, key = "x_value", value = "value", -price)

# do lots of regressions- tells us which ones are the best
regressions = group_by(diamonds_regression, x_value) %>%
    do(glance(lm(price ~ value, .)))
```


