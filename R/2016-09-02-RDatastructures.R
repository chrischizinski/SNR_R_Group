# R Data structures, data wrangling, and graphics
# Chris Chizinski
# 09-02-16

options(stringsAsFactors = FALSE)

.libPaths("P:/RLibrary")

install.packages(c("ggplot2","tidyr","dplyr"))

library(ggplot2)
library(tidyr)
library(dplyr)

setwd("P:/R_user_group/Fall2016/") 
getwd()  #display your current working directory

#######################################################################

# vectors - sequence of numbers, characters, factors, strings
# vectors are 1 dimensional

a <- c(1 , 2, 3, 4, 5)
a

nrow(a)  # does not work because only 1D
dim(a) # does not work because only 1D

length(a)  # tells how many elements are in a

sd(a)/(sqrt(length(a)))

# matrices - 2 dimensional sequences

# Make a 5 x 4 matrix of 0's

matrix(0, nrow = 5, ncol =4)

# Make a 5 x 4 matrix of 1:20 with 1, 2, 3, 4 across row
b<-matrix(1:20, nrow = 5, ncol = 4, byrow= TRUE)

# matrices need to be all of the same type (class) of data
typeof(b)
?typeof
class(b)

c<-matrix(c(1:19,"A"), nrow = 5, ncol = 4, byrow= TRUE)

matrix(c(1:19,NA), nrow = 5, ncol = 4, byrow= TRUE)

matrix(c(1:19,NaN), nrow = 5, ncol = 4, byrow= TRUE)

# Dstats on matrices
sum(b)
colSums(b) # column sums
rowSums(b) # row sums

apply(b,2, max) # columns
apply(b,1, max) # by rows

apply(b, c(1,2), log)  # apply a function to each element in a matrices

#### 
a<-1
is.numeric(a)

a<-"A"
is.numeric(a)

a<-c("A","C","B")
typeof(a)
is.character(a)

is.factor(a)

a<-as.factor(a)
levels(a)

levels(a)<-c("A","C","B")
a<-factor(c("A","C","B"),levels = c("A","C","B"))

as.numeric(a)

# dataframe ############################################################
# You can have mixed characters, but need to be the same for each column
# 2 dimensional 
# all columns must have the same number of rows

a <- data.frame('first col' = 1:10, 
                'second col' = letters[1:10], 
                'third col' = factor(letters[1:10],levels = letters[10:1]))
a
str(a)

order(a$secondcol)
order(a$thirdcol)

sort(a$secondcol)
sort(a$thirdcol)

# indexing

a[2, 3] # second row, third column

a[10,] # all columns in tenth row
a[,2] # all rows in the second column
a$second.col
a$second.col[5]

a$second.col[c(5,7,9)]
a$second.col[-c(5,7,9)]

a[c(1,1,1),]

a[rep(1,times=10),]
length(a)

a[rep(1:nrow(a),times=3),]
a[rep(1:nrow(a),each=3),]

a[,"first.col"]
a[,c("first.col","second.col")]
a[,-"first.col"]

which(names(a)!="first.col")
a[,which(names(a)!="first.col")]
colnames(a)

a[,!names(a) %in% c("first.col","third.col")]
?'

a[a$second.col %in% c("a","c","e","h"),]

# lists 
c <- list()

c[[1]]<- c("a","b","c")
c[[2]]<- c(10,9,8,78,22)
c[[3]]<- a

c[1]
c[[1]]

c[["element1"]]<- c("a","b","c")
c[[2]]<- c(10,9,8,78,22)
c[[3]]<- a

?list

unlist(c)

