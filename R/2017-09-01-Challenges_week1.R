#data explaination 
# http://www.datacarpentry.org/R-ecology-lesson/02-starting-with-data.html
library(readr)
mydata <- read_csv("https://ndownloader.figshare.com/files/2292169")

###CHALLENGES
##1. average hindfoot_length
mean(mydata$hindfoot_length)
nadata <- na.omit(mydata)
glimpse(nadata)
avg <- mean(mydata$hindfoot_length, na.rm=T)

##2. How many are above and below average
#step 1 - find average
avg <- mean(mydata$hindfoot_length, na.rm=T)
#step 2- index to get only value in number below
lessthan <- mydata$hindfoot_length < avg 
lessthan
#step 3 - count the number of rows
sum(lessthan, na.rm=T)

##TAKE HOME CHALLENGES
##email R script to michael.whitby@huskers.unl.edu

# What are the names of the plot types (treatments) in the experiment?

unique(mydata$plot_type)
levels(as.factor(mydata$plot_type))

# How many species caught?
length(unique(mydata$species_id))

nlevels(as.factor(mydata$species_id))

# How many species of birds? Rodents?
unique(mydata$taxa)

IS_bird <- mydata$taxa =="Bird"
sum(IS_bird)

Bird_spp=mydata[IS_bird, ]

unique(Bird_spp$species_id)

# Average weight of Male Rodents?
IS_Rodent <- mydata$taxa =="Rodent"

RODENTS=mydata[IS_Rodent, ]

M_RODENTS = RODENTS[RODENTS$sex=="M",]

mean(M_RODENTS$weight, na.rm=T)


# Average weight of Female Rodents?

F_RODENTS = RODENTS[RODENTS$sex=="F",]

mean(F_RODENTS$weight, na.rm=T)

RODENTS$sex <- as.factor(RODENTS$sex)
plot(RODENTS$weight~RODENTS$sex)


?t.test

t.test(RODENTS$weight~RODENTS$sex)
