# Lecture 3: GGPLOT Aesthetics

## Quick Review of Joins
The idea of a join is to bring multiple data sets together that share a similar column.

Suppose we have these 2 tables, A and B respectively that we want to combine:

| a | b |
| - | - |
| 1 | x |
| 2 | y |
| 3 | z |

| a | c |
| - | - |
| 1 | q |
| 2 | r |
| 4 | s |

```
# Obeys the columns of the first argument
left_join(A,B)
```
| a | b | c |
| - | - | - |
| 1 | x | q |
| 2 | y | r |
| 3 | z | NA |

```
# Obeys the columns of the second argument
right_join(A,B)
```
| a | b | c |
| - | - | - |
| 1 | x | q |
| 2 | y | r |
| 4 | NA | s |

```
# Takes all available variables
full_join(A,B)
```
| a | b | c |
| - | - | - |
| 1 | x | q |
| 2 | y | r |
| 3 | z | NA |
| 4 | NA | s |

## GGPLOT: Aesthetics

### High Level Explanation
Notice that in the last lecture, we had an `aes()` argument in the initial ggplot. 

```
# produces a scatterplot
plot = ggplot(dataset, aes(x = xvar, y = yvar)) +
            geom_point(aes(blah))
```

These are the following moving parts for aes (what they change is kind of obvious):

* x
* y
* alpha (between 0 and 1)- how densely colored in the object is
* colour
* fill- color, but for bar graphs
* shape 
* size (positive number)

Some remarks:

* Typically, we will modify aesthetics of particular layers on top of the ggplot, not the full ggplot itself. 
* We can set the aesthetics to whatever values we want. Then the graph will change in the way you might expect. 
    * E.g. we set the color in this way: `geom_point(aes(color = "blue"))`the dots will all turn blue.
* Usually, however, we won't hard code a aesthetic. We usually want it to display other dimensions in the data - for example showing where a data point was collected or how much that particular point is weighted.
* For the rest of the lecture, I'll bring up a few examples. 

### Examples
Load in the diamonds data like last time.
