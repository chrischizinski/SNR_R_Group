---
title: "R Data Structures"
author: "Christopher Chizinski"
date: "September 02, 2016"
output: html_document
tags: [R, Data structures]
---



# Working with data in R

There are lots of great references out there to help orient you with R and R data structures.  One of the best is the section on data structures in the [*Advanced R*](http://adv-r.had.co.nz/Data-structures.html) book by Hadley Wickham.  Hadley provides numerous details on differences among the structures and a lot of the nitty gritty on those structures.  This lesson is suppose to provide a "working knowledge" of data structures in R, but I strongly encourage you to dive into more.  

## Vectors
The basic form of data structure in R is the vector.  

Vectors have the following structure:

* sequence of numbers, characters, factors, strings
  * all must be the same in the sequence
* vectors are 1 dimensional

We create objects using the `=` or the `<-` in R.  In the example below, we create a sequence of numerical values as object `a`.  The `c` below means combine.  

{% highlight r %}
a <- c(1 , 2, 3, 4, 5)

a  # display the results of a
{% endhighlight %}



{% highlight text %}
## [1] 1 2 3 4 5
{% endhighlight %}

There is a couple of ways we can look at structure of objects that we create in R.


{% highlight r %}
typeof(a)  # displays the type or storage mode of an object
{% endhighlight %}



{% highlight text %}
## [1] "double"
{% endhighlight %}



{% highlight r %}
class(a) # displays the class of the object
{% endhighlight %}



{% highlight text %}
## [1] "numeric"
{% endhighlight %}



{% highlight r %}
dim(a)  # dimensions of the object [rows by columns]
{% endhighlight %}



{% highlight text %}
## NULL
{% endhighlight %}



{% highlight r %}
length(a)  # number of elements in the vector
{% endhighlight %}



{% highlight text %}
## [1] 5
{% endhighlight %}



{% highlight r %}
nrow(a) # number of rows -- doesnt work because a is 1-dimensional
{% endhighlight %}



{% highlight text %}
## NULL
{% endhighlight %}



{% highlight r %}
ncol(a) # number of columns -- doesnt work because a is 1-dimensional
{% endhighlight %}



{% highlight text %}
## NULL
{% endhighlight %}



{% highlight r %}
str(a) #displays the structure of an object
{% endhighlight %}



{% highlight text %}
##  num [1:5] 1 2 3 4 5
{% endhighlight %}

Once we create an object, we can use functions on that object


{% highlight r %}
sum(a)  # vector sum  of a
{% endhighlight %}



{% highlight text %}
## [1] 15
{% endhighlight %}



{% highlight r %}
mean(a) # vector mean  of a
{% endhighlight %}



{% highlight text %}
## [1] 3
{% endhighlight %}



{% highlight r %}
sd(a)  # standard deviation of a
{% endhighlight %}



{% highlight text %}
## [1] 1.581139
{% endhighlight %}



{% highlight r %}
sd(a)/(sqrt(length(a))) # or chains of functions (i.e., standard error)
{% endhighlight %}



{% highlight text %}
## [1] 0.7071068
{% endhighlight %}

There are many types of classes that we can use in R.  

* Numeric:  numbers
* Characters:  character
  * Strings:  sequence of characters, whitespace is important
* Factors:  characters with a order
  * can be defined with `levels()`


{% highlight r %}
b<- c(1,2,3,4,5,6)  #numeric
class(b)
{% endhighlight %}



{% highlight text %}
## [1] "numeric"
{% endhighlight %}



{% highlight r %}
c<- c("A", "B", "C")  #character
class(c)
{% endhighlight %}



{% highlight text %}
## [1] "character"
{% endhighlight %}



{% highlight r %}
d<- factor(c("A", "B", "C"), levels = c("A","C","B"))  # factor
class(d)
{% endhighlight %}



{% highlight text %}
## [1] "factor"
{% endhighlight %}

We can convert among classes


{% highlight r %}
b<- c(1,2,3,4,5,6)  #numeric
class(b)
{% endhighlight %}



{% highlight text %}
## [1] "numeric"
{% endhighlight %}



{% highlight r %}
b.c <-as.character(b) #convert to character
class(b.c)
{% endhighlight %}



{% highlight text %}
## [1] "character"
{% endhighlight %}



{% highlight r %}
b.f <-as.factor(b) #convert to factor
class(b.f)
{% endhighlight %}



{% highlight text %}
## [1] "factor"
{% endhighlight %}



{% highlight r %}
levels(b.f)
{% endhighlight %}



{% highlight text %}
## [1] "1" "2" "3" "4" "5" "6"
{% endhighlight %}



{% highlight r %}
c<- c("A", "B", "C")  #character
class(c)
{% endhighlight %}



{% highlight text %}
## [1] "character"
{% endhighlight %}



{% highlight r %}
c.n<- as.numeric(c)  # converting to numeric from character DOES NOT work
{% endhighlight %}



{% highlight text %}
## Warning: NAs introduced by coercion
{% endhighlight %}



{% highlight r %}
d<- factor(c("A", "B", "C"), levels = c("A","C","B"))  # factor
class(d)
{% endhighlight %}



{% highlight text %}
## [1] "factor"
{% endhighlight %}



{% highlight r %}
d.c<- as.character(d)  # but we can convert a factor to character
class(d.c)
{% endhighlight %}



{% highlight text %}
## [1] "character"
{% endhighlight %}



{% highlight r %}
d.c  # notice it strips off the levels of the string
{% endhighlight %}



{% highlight text %}
## [1] "A" "B" "C"
{% endhighlight %}



{% highlight r %}
d.n<- as.numeric(d)  # and can convert a factor to numeric
class(d.n)
{% endhighlight %}



{% highlight text %}
## [1] "numeric"
{% endhighlight %}



{% highlight r %}
d.n  # notice the values become the levels of the factor
{% endhighlight %}



{% highlight text %}
## [1] 1 3 2
{% endhighlight %}

We can run functions that will provide a logic (TRUE or FALSE) on the type of data


{% highlight r %}
is.numeric(b)  # is numeric?
{% endhighlight %}



{% highlight text %}
## [1] TRUE
{% endhighlight %}



{% highlight r %}
is.factor(b) # is factor?
{% endhighlight %}



{% highlight text %}
## [1] FALSE
{% endhighlight %}



{% highlight r %}
is.character(b) # is character?
{% endhighlight %}



{% highlight text %}
## [1] FALSE
{% endhighlight %}

## Matrices

Matrices have the following structure:

* rows and columns of numbers, characters, or strings
  * Liek vectors, all rows and columns must be the same class of data
* vectors are 2 dimensional (rows by columns)


{% highlight r %}
# Make a 5 x 4 matrix of 0's
matrix(0, nrow = 5, ncol =4)
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0    0
## [2,]    0    0    0    0
## [3,]    0    0    0    0
## [4,]    0    0    0    0
## [5,]    0    0    0    0
{% endhighlight %}



{% highlight r %}
# Make a 5 x 4 matrix of 1:20 with 1, 2, 3, 4 across row
b<-matrix(1:20, nrow = 5, ncol = 4, byrow= TRUE)
b
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3] [,4]
## [1,]    1    2    3    4
## [2,]    5    6    7    8
## [3,]    9   10   11   12
## [4,]   13   14   15   16
## [5,]   17   18   19   20
{% endhighlight %}

All the data in a matrix must be the same type


{% highlight r %}
#  One character will convert the entire matrix to character
c<-matrix(c(1:19,"A"), nrow = 5, ncol = 4, byrow= TRUE)
c
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3] [,4]
## [1,] "1"  "2"  "3"  "4" 
## [2,] "5"  "6"  "7"  "8" 
## [3,] "9"  "10" "11" "12"
## [4,] "13" "14" "15" "16"
## [5,] "17" "18" "19" "A"
{% endhighlight %}



{% highlight r %}
# However you can have missing data (NA)
matrix(c(1:19,NA), nrow = 5, ncol = 4, byrow= TRUE)
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3] [,4]
## [1,]    1    2    3    4
## [2,]    5    6    7    8
## [3,]    9   10   11   12
## [4,]   13   14   15   16
## [5,]   17   18   19   NA
{% endhighlight %}



{% highlight r %}
# but you can have positive infinite data (Inf)
matrix(c(1:19,Inf), nrow = 5, ncol = 4, byrow= TRUE)
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3] [,4]
## [1,]    1    2    3    4
## [2,]    5    6    7    8
## [3,]    9   10   11   12
## [4,]   13   14   15   16
## [5,]   17   18   19  Inf
{% endhighlight %}



{% highlight r %}
# or negative infinite data (-Inf)
matrix(c(1:19,-Inf), nrow = 5, ncol = 4, byrow= TRUE)
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3] [,4]
## [1,]    1    2    3    4
## [2,]    5    6    7    8
## [3,]    9   10   11   12
## [4,]   13   14   15   16
## [5,]   17   18   19 -Inf
{% endhighlight %}



{% highlight r %}
# or Not a Number (NaN)
matrix(c(1:19,NaN), nrow = 5, ncol = 4, byrow= TRUE)
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3] [,4]
## [1,]    1    2    3    4
## [2,]    5    6    7    8
## [3,]    9   10   11   12
## [4,]   13   14   15   16
## [5,]   17   18   19  NaN
{% endhighlight %}

Like the vectors, we can run functions on matrices.  There are several that will calculate column or row statistics, otherwise there are ways to run functions on the elements of a matrices.  


{% highlight r %}
sum(b)  # calculate the sum of all elements in a matrix
{% endhighlight %}



{% highlight text %}
## [1] 210
{% endhighlight %}



{% highlight r %}
colSums(b) # column sums
{% endhighlight %}



{% highlight text %}
## [1] 45 50 55 60
{% endhighlight %}



{% highlight r %}
rowSums(b) # row sums
{% endhighlight %}



{% highlight text %}
## [1] 10 26 42 58 74
{% endhighlight %}



{% highlight r %}
# 2 is by column and 1 is by row
apply(b,2, max) # column max
{% endhighlight %}



{% highlight text %}
## [1] 17 18 19 20
{% endhighlight %}



{% highlight r %}
apply(b,1, max) # row max
{% endhighlight %}



{% highlight text %}
## [1]  4  8 12 16 20
{% endhighlight %}



{% highlight r %}
apply(b, c(1,2), log)  # apply a function to each element in a matrices
{% endhighlight %}



{% highlight text %}
##          [,1]      [,2]     [,3]     [,4]
## [1,] 0.000000 0.6931472 1.098612 1.386294
## [2,] 1.609438 1.7917595 1.945910 2.079442
## [3,] 2.197225 2.3025851 2.397895 2.484907
## [4,] 2.564949 2.6390573 2.708050 2.772589
## [5,] 2.833213 2.8903718 2.944439 2.995732
{% endhighlight %}

# Data.frames

Data.frames are the most common types of data that you will likely work with in R.  They are a lot like matrices but they offer another level of flexibility.  This is the type of data that is most often read in from other types of files (.csv, .tab, .txt)

Data.frames have the following structure:

* rows by columns of numbers, characters, factors, strings
  * all must be the same in the sequence WITHIN a column
* data.frames are 2 dimensional (row by column)


{% highlight r %}
a <- data.frame('first col' = 1:10, 
                'second col' = letters[1:10], 
                'third col' = factor(letters[1:10],levels = letters[10:1]))

a
{% endhighlight %}



{% highlight text %}
##    first.col second.col third.col
## 1          1          a         a
## 2          2          b         b
## 3          3          c         c
## 4          4          d         d
## 5          5          e         e
## 6          6          f         f
## 7          7          g         g
## 8          8          h         h
## 9          9          i         i
## 10        10          j         j
{% endhighlight %}



{% highlight r %}
names(a)  # display column headers
{% endhighlight %}



{% highlight text %}
## [1] "first.col"  "second.col" "third.col"
{% endhighlight %}



{% highlight r %}
colnames(a) # display column headers, also works with matrices
{% endhighlight %}



{% highlight text %}
## [1] "first.col"  "second.col" "third.col"
{% endhighlight %}



{% highlight r %}
rownames(a) # display row names, default is just the row number
{% endhighlight %}



{% highlight text %}
##  [1] "1"  "2"  "3"  "4"  "5"  "6"  "7"  "8"  "9"  "10"
{% endhighlight %}



{% highlight r %}
str(a)  # display structure of a
{% endhighlight %}



{% highlight text %}
## 'data.frame':	10 obs. of  3 variables:
##  $ first.col : int  1 2 3 4 5 6 7 8 9 10
##  $ second.col: chr  "a" "b" "c" "d" ...
##  $ third.col : Factor w/ 10 levels "j","i","h","g",..: 10 9 8 7 6 5 4 3 2 1
{% endhighlight %}



{% highlight r %}
head(a) #display first six rows of a
{% endhighlight %}



{% highlight text %}
##   first.col second.col third.col
## 1         1          a         a
## 2         2          b         b
## 3         3          c         c
## 4         4          d         d
## 5         5          e         e
## 6         6          f         f
{% endhighlight %}



{% highlight r %}
tail(a) # display last six rows of a
{% endhighlight %}



{% highlight text %}
##    first.col second.col third.col
## 5          5          e         e
## 6          6          f         f
## 7          7          g         g
## 8          8          h         h
## 9          9          i         i
## 10        10          j         j
{% endhighlight %}


## Indexing

There are a lot of new packages (e.g., tidyr, dplyr) that make working with certain rows and columns a lot easier.  However, they can not do everything and it pays off to work with indices (manipulated the rows and columns) that will pay dividends when trying to work with your own data.  


{% highlight r %}
a[2, 3] # second row, third column
{% endhighlight %}



{% highlight text %}
## [1] b
## Levels: j i h g f e d c b a
{% endhighlight %}



{% highlight r %}
a[10,] # all columns in tenth row
{% endhighlight %}



{% highlight text %}
##    first.col second.col third.col
## 10        10          j         j
{% endhighlight %}



{% highlight r %}
a[,2] # all rows in the second column
{% endhighlight %}



{% highlight text %}
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j"
{% endhighlight %}



{% highlight r %}
a$second.col # Within data.frames you can select a column with the `$` 
{% endhighlight %}



{% highlight text %}
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j"
{% endhighlight %}



{% highlight r %}
a$second.col[5] # fifth position in column 'second.col'
{% endhighlight %}



{% highlight text %}
## [1] "e"
{% endhighlight %}



{% highlight r %}
# Choose multiple elements
a$second.col[c(5,7,9)] # fifth, seventh, ninth position in column 'second.col'
{% endhighlight %}



{% highlight text %}
## [1] "e" "g" "i"
{% endhighlight %}



{% highlight r %}
# Removing elements with the `-` 
a$second.col[-c(5,7,9)]
{% endhighlight %}



{% highlight text %}
## [1] "a" "b" "c" "d" "f" "h" "j"
{% endhighlight %}



{% highlight r %}
#  Repeat multiple rows
a[c(1,1,1),]
{% endhighlight %}



{% highlight text %}
##     first.col second.col third.col
## 1           1          a         a
## 1.1         1          a         a
## 1.2         1          a         a
{% endhighlight %}



{% highlight r %}
#  Can also use the function `rep()`
a[rep(1,times=10),]
{% endhighlight %}



{% highlight text %}
##     first.col second.col third.col
## 1           1          a         a
## 1.1         1          a         a
## 1.2         1          a         a
## 1.3         1          a         a
## 1.4         1          a         a
## 1.5         1          a         a
## 1.6         1          a         a
## 1.7         1          a         a
## 1.8         1          a         a
## 1.9         1          a         a
{% endhighlight %}



{% highlight r %}
length(a)
{% endhighlight %}



{% highlight text %}
## [1] 3
{% endhighlight %}



{% highlight r %}
# Understanding differences between `times` and `each`
a[rep(1:nrow(a),times=3),]  # repeats the sequence 3 times
{% endhighlight %}



{% highlight text %}
##      first.col second.col third.col
## 1            1          a         a
## 2            2          b         b
## 3            3          c         c
## 4            4          d         d
## 5            5          e         e
## 6            6          f         f
## 7            7          g         g
## 8            8          h         h
## 9            9          i         i
## 10          10          j         j
## 1.1          1          a         a
## 2.1          2          b         b
## 3.1          3          c         c
## 4.1          4          d         d
## 5.1          5          e         e
## 6.1          6          f         f
## 7.1          7          g         g
## 8.1          8          h         h
## 9.1          9          i         i
## 10.1        10          j         j
## 1.2          1          a         a
## 2.2          2          b         b
## 3.2          3          c         c
## 4.2          4          d         d
## 5.2          5          e         e
## 6.2          6          f         f
## 7.2          7          g         g
## 8.2          8          h         h
## 9.2          9          i         i
## 10.2        10          j         j
{% endhighlight %}



{% highlight r %}
a[rep(1:nrow(a),each=3),]  # repeats each row three times
{% endhighlight %}



{% highlight text %}
##      first.col second.col third.col
## 1            1          a         a
## 1.1          1          a         a
## 1.2          1          a         a
## 2            2          b         b
## 2.1          2          b         b
## 2.2          2          b         b
## 3            3          c         c
## 3.1          3          c         c
## 3.2          3          c         c
## 4            4          d         d
## 4.1          4          d         d
## 4.2          4          d         d
## 5            5          e         e
## 5.1          5          e         e
## 5.2          5          e         e
## 6            6          f         f
## 6.1          6          f         f
## 6.2          6          f         f
## 7            7          g         g
## 7.1          7          g         g
## 7.2          7          g         g
## 8            8          h         h
## 8.1          8          h         h
## 8.2          8          h         h
## 9            9          i         i
## 9.1          9          i         i
## 9.2          9          i         i
## 10          10          j         j
## 10.1        10          j         j
## 10.2        10          j         j
{% endhighlight %}



{% highlight r %}
#  If named, you can also call on the row and column name
a[,"first.col"]
{% endhighlight %}



{% highlight text %}
##  [1]  1  2  3  4  5  6  7  8  9 10
{% endhighlight %}



{% highlight r %}
a[,c("first.col","second.col")]
{% endhighlight %}



{% highlight text %}
##    first.col second.col
## 1          1          a
## 2          2          b
## 3          3          c
## 4          4          d
## 5          5          e
## 6          6          f
## 7          7          g
## 8          8          h
## 9          9          i
## 10        10          j
{% endhighlight %}



{% highlight r %}
# a[,-"first.col"]  #does not work

which(names(a)!="first.col") # use which and ! to NOT select column
{% endhighlight %}



{% highlight text %}
## [1] 2 3
{% endhighlight %}



{% highlight r %}
a[,which(names(a)!="first.col")]
{% endhighlight %}



{% highlight text %}
##    second.col third.col
## 1           a         a
## 2           b         b
## 3           c         c
## 4           d         d
## 5           e         e
## 6           f         f
## 7           g         g
## 8           h         h
## 9           i         i
## 10          j         j
{% endhighlight %}



{% highlight r %}
# use `%in%` to get rows or columns in contained within a vector
a[,!names(a) %in% c("first.col","third.col")]
{% endhighlight %}



{% highlight text %}
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j"
{% endhighlight %}



{% highlight r %}
a[a$second.col %in% c("a","c","e","h"),]
{% endhighlight %}



{% highlight text %}
##   first.col second.col third.col
## 1         1          a         a
## 3         3          c         c
## 5         5          e         e
## 8         8          h         h
{% endhighlight %}

## Lists

Lists are the most flexible data structure and pretty much can handle what ever you throw at them.  While there may be some out there that have a better idea on what and how to use lists, I tend to use them as a flexible structure to store data.  

As you could or might exist they are the loosest, or the wild west, when it comes to data types and storage.  I tend to use lists when I am running simulations or loops. 


{% highlight r %}
# lists 
c <- list()  # create and empty list

c[[1]]<- c("a","b","c")  # assign elements to that list, characters, numbers, vectors, data.frames, other lists
c[[2]]<- c(10,9,8,78,22)
c[[3]]<- a

c[1]  # pull up elements of the list, notice the difference
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "a" "b" "c"
{% endhighlight %}



{% highlight r %}
c[[1]]
{% endhighlight %}



{% highlight text %}
## [1] "a" "b" "c"
{% endhighlight %}



{% highlight r %}
c[["element1"]]<- c("a","b","c")
c[[2]]<- c(10,9,8,78,22)
c[[3]]<- a


unlist(c)  #unlist the list into a vector
{% endhighlight %}



{% highlight text %}
##                                                                  
##          "a"          "b"          "c"         "10"          "9" 
##                                          first.col1   first.col2 
##          "8"         "78"         "22"          "1"          "2" 
##   first.col3   first.col4   first.col5   first.col6   first.col7 
##          "3"          "4"          "5"          "6"          "7" 
##   first.col8   first.col9  first.col10  second.col1  second.col2 
##          "8"          "9"         "10"          "a"          "b" 
##  second.col3  second.col4  second.col5  second.col6  second.col7 
##          "c"          "d"          "e"          "f"          "g" 
##  second.col8  second.col9 second.col10   third.col1   third.col2 
##          "h"          "i"          "j"         "10"          "9" 
##   third.col3   third.col4   third.col5   third.col6   third.col7 
##          "8"          "7"          "6"          "5"          "4" 
##   third.col8   third.col9  third.col10    element11    element12 
##          "3"          "2"          "1"          "a"          "b" 
##    element13 
##          "c"
{% endhighlight %}

