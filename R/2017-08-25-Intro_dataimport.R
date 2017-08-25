myNUMs <- c(1,2,3,4,5,6,7)
myNUMs

myNUMs[4]

library(tidyverse)

#Check the base folder that you are working in
getwd()
setwd("C:\\Users\\micha\\Desktop")

#import a data set
mydata <- read_csv("https://ndownloader.figshare.com/files/2292169")

##Check dataset
mydata
class(mydata)

mydata2 <- as.data.frame(mydata)
mydata2
ncol(mydata)
nrow(mydata)
dim(mydata)


head(mydata2)

mydata[y , x]
mydata[1:6,]
mydata[1:6, 3:4]
mydata[1:6, c(3,7)]
mydata[1:6, c(3:4)]

glimpse(mydata)
glimpse(mydata2)

str(mydata2)




#Change plot_id to factor

##can access a single variable (column) in dataframe with a $ sign
mydata[,"plot_id"]
mydata[,5]
mydata$plot_id
mydata$plot_id[1]
mydata[1,5]

##Check what type of variable is stored in this column
class(mydata$sex)

##Change the data type of 
MF <- as.factor(mydata$sex)

mydata$sex <- MF

class(mydata$sex)

levels(mydata$sex)
nlevels(mydata$sex)
factor(mydata$sex, levels=c("M", "F"))

plot(mydata$sex)

is.na(mydata$sex)
no_sex <- is.na(mydata$sex)
sum(no_sex)

sum( is.na(mydata$sex) )

###OR as one step
mydata$sex <- as.factor(mydata$sex)


#DATES

library(lubridate)
dates <- paste(mydata$year, mydata$month, mydata$day, sep="-")
dates
class(dates)

dates <- ymd(dates)
class(dates)
sum( is.na(dates) )

datefails <- which( is.na(dates) )
class(datefails)
mydata[datefails,2:4]

mydata$date <- dates



##As one line
mydata$date <- ymd(paste(mydata$year, mydata$month, mydata$day, sep="-"))
class(mydata$date)



###CHALLENGES
##1. average hindfoot_length

mean(mydata$hindfoot_length)
sum(is.na(mydata$hindfoot_length))
mean(mydata$hindfoot_length, na.rm=T)

##2. How many are above and below average

mydata$hindfoot_length<29.28793
mydata$hindfoot_length<mean(mydata$hindfoot_length, na.rm=T)

smaller<-mydata$hindfoot_length<mean(mydata$hindfoot_length, na.rm=T) 

sum(smaller, na.rm=T)

