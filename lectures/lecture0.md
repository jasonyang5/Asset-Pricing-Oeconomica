# Lecture 0: Setup

## Part 1: Download R and R Studio
### R Installation

1. Go to https://cran.cnr.berkeley.edu/
    * Click on Download R for Windows or Mac
    * Click on base for windows, the .pkg file for mac
    * Make sure it's the most recent version- 3.5.2
2. Click through installation window


### R Studio Installation
Windows:

1. Go to https://www.rstudio.com/products/rstudio/download/
    * Click on free version
    * Download the respective package for your operating system

## Part 2: Version Control
We will be using Google Drive for version control. Would require a lot of unnecessary setup, and we aren't working together on a project anyways.

Go to this google drive link to access stuff:
https://drive.google.com/open?id=1rSByodjReBkqic_OIRAjxdrWloi0PPfz

Lectures, assignments, exercises will all be posted here.

## Part 3: Basic Problem- calculate beta using Base R

### Basic Setup
* Usually at the start of the file, you will import various packages using the library function. 
* Then, you will want to import your data using the `read_feather()` function.
    * What does it do? Try `?read_feather` in the console.
* Need to find the path to the file- which is in the form of a string. Your path will differ from others. It depends on where you downloaded it.

### Data Subset
Data has the following columns:

* ID
* Date
* Exchange Traded On
* Ticker
* Delist Date
* Delist Return
* Price
* Return
* Outstanding Shares
* Market Return
* SP Return
* Risk Free

Recall the definition of historical beta: cov(a,b)/var(b) where a is the security and b is the market you are calculating beta with respect to. 

What columns are relevant?
* ID
* Returns
* Market Returns

We can now subset out the data. We will be using the `which()` function- this is great for getting indexes of vectors that you want.
```
newdata = olddata[which(names(olddata) %in% c("ID", "Return", "MktReturn"))]
```
Broken down:

* Want to access certain columns of olddata, which `olddata[number]` does
* Which returns a vector of numbers for which a condition is true- see the documentation with `?which()`
* assigns this to newdata

### Calculate Beta
Now back onto the formula, what we generally want is in a few steps:
1. Group all the matching ID's together
2. compute var of the market for this entry
3. compute cov with the returns and the market

Repetition is involved: will want to make a function that just deals with one particular ID.

Let's start by making the function that starts after step 1- we already have a data frame containing all matching ID's.

From this data, we will compute cov(security,mkt)/var(mkt). So, we will need:

* Vector of security returns
* Vector of market returns

This is straightforward if we use the which function again.

Then, with these vectors we just compute cov / var to get the beta and return at the end.

```
calc_beta<-function(data)
{
    security = data[which(names(data) == "Return")]
    market = data[which(names(data) == "MktReturn")]

    beta = cov(security, market)/var(market)

    return(beta)
}
```

Now we need to string these together. We want a function that takes the entire data set, subsets it all by IDs, and then runs `calc_beta()` on it.

Just by initial setup, we can see how this function is already going to get pretty bulky- we will have to take all the relevant subsets of the data and *then* string everything together. 
\\ Whenever this happens, it's good practice to just make another function

```
group<-function(all_data)
{
    IDs = all_data[which(names(all_data) == "ID")]

    all_groups = map(.x = IDs,
                     .f = {function (id) all_data[which(all_data[[1]] == id),]})
    return(all_groups)
}
```

Now that we have all of the groups, we can just string it together.
```
get_betas<-function(all_groups)
{
    betas = map(.x = all_groups,
                .f = calc_beta)
    return(betas)
}
```
