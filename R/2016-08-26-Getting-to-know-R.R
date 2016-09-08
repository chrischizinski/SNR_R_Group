## Getting to know R
## 8-26-16
## Chris Chizinski 

# we can comment out text using the '#' symbol.  Anything to the right is commented

2+2 # we are adding two plus two 

# RStudio allows you to comment out blocks of code using control-shift-C

# we are going to try to do this
# and this
# or that


# Various ways to search for help  
?lm
help(lm)

??regression

## Top of your R script

## Getting to know R
## 8-26-16
## Chris Chizinski 

options(stringsAsFactors = FALSE) # set options first 
setwd("C:\\Users\\cchizinski2\\Documents\\DataDepot")  # two ways to describe paths on PC
setwd("C:/Users/cchizinski2/Documents/DataDepot")

setwd("C:/Users/cchizinski2/Documents/DataDepot") # for Mac

.libPaths("P:/RLibrary")  #setting your Library path
install.packages("ggplot2")  # installs ggplot into directory supplied above
library(ggplot2)  # loads library from that directory
#load packages at the very top
# so we wont miss packages that we depend on
# avoid conflicts among packages

install.packages(c("plyr","dplyr"))  # Beware of conflicting packages
library(dplyr)
library(plyr)

# R packages are a combination of functions, help, and datasets that can be loaded into the R environment by using library() or require()

update.packages()  #  update packages in Library directory
citation()  #  Call up citation information for base R
citation("ggplot2") #  Call up citation information on a package

sessionInfo()  #display session information
R.Version()  # display R version information  

#################################################################
## Getting to know R data types
#################################################################

2+2 # Use R like a calculator

# Single value
a <- 2 
a = 2

a 

a + 2

b <- 5 

a + b 

# multiple values
help(c)
a <- c(1, 2, 3, 4, 5) # numeric vector
b <- c("A", 1, 2, 3, "D") # character

# Character strings
c <- c("the", "fox", "jumps", "over", "the", "dog")
d <- c("the fox jumps over", "the dog")
e <- c("the fox jumps over  ", "the dog")
# R is sensitive to caps and white spaces
# d is not the same as D


d==e  # logic state

# Talk about error messages not being helpful
a <- (1, 2, 3, 4, 5)

# Factors
a <- factor(c("a","b","c"), levels = c("c","b","a"))
levels(a) # display levels 
rev(levels(a))

# convert factor to character
a.new <-as.character(a)

# convert a factor to numeric
a.num <- as.numeric(a)

# 
a <- c(1, 2, 3, 4, 5) # numeric vector
as.factor(a)
as.character(a)

2a <- as.character(a)  # cannot lead off object names with a number
a2 <- as.character(a)

is.factor(a) # is a factor
is.character(a) # is a charactor
is.numeric(a) # is numeric

# two dimensional arrays
a.matrix <- matrix(0, 4, 8)
ncol(a.matrix) # number of columns
nrow(a.matrix) # number of rows
dim(a.matrix) # dimensions of the matrix

b.matrix <- matrix(c(1:12), 3, 4, byrow = TRUE)
?matrix
colnames(b.matrix) # get column names

colnames(b.matrix) <- c("A1","A2","B1","B2")

rownames(b.matrix) # get column names
rownames(b.matrix) <- c("A","A","B")

c.matrix <- matrix(c(1:11,"Oops"), 3, 4, byrow = TRUE)  # Needs to be all of one type otherwise converts to characters

d.matrix <- matrix(c(1:11,NA), 3, 4, byrow = TRUE)  # Needs to be all characters

matrix(c(1:11,Inf), 3, 4, byrow = TRUE)
matrix(c(1:11,-Inf), 3, 4, byrow = TRUE)
matrix(c(1:11,NaN), 3, 4, byrow = TRUE)






