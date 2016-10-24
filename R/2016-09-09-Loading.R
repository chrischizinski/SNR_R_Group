.libPaths("P:/RLibrary")

# .RData - R's data format

data(iris)

head(iris)

newiris <- iris
head(newiris)

ls() # display objects in the global environment

rm(iris)

ls()

rm(list=ls()) # removes everything from your global environment

save(newiris, file = "P:/R_user_group/Fall2016/newiris.RData")
save.image(file="P:/R_user_group/Fall2016/dataexampleimage.RData")

rm(newiris)

load(file="P:/R_user_group/Fall2016/newiris.RData")
load(file="P:/R_user_group/Fall2016/dataexampleimage.RData")

##  tidyverse
install.packages("devtools")
library(devtools)

install_github("hadley/tidyverse")
library(tidyverse)

library(readr)


## CSV and TSV
?read_csv
#Land crabs on Christmas Island, relationships to burrowing density
land_crabs <- read_csv("Z:/RClass/data/ExperimentalDesignData/chpt5/green.csv")
land_crabs_df <- as.data.frame(land_crabs)

head(land_crabs)

?read_tsv
land_crabs_txt <- read_tsv("Z:/RClass/data/ExperimentalDesignData/chpt5/green_txt.txt")
head(land_crabs_txt)

## xls or xlsx
library(readxl)

?read_excel
land_crabs<-read_excel("Z:/RClass/data/ExperimentalDesignData/chpt5/green.xls")
head(land_crabs)

land_crabs<-read_excel("Z:/RClass/data/ExperimentalDesignData/chpt5/green.xls", sheet = "Sheet2")
land_crabs<-read_excel("Z:/RClass/data/ExperimentalDesignData/chpt5/green.xls", sheet = 2)
land_crabs<-read_excel("Z:/RClass/data/ExperimentalDesignData/chpt5/green.xls", sheet = 2, na="NA")

land_crabs


## SAS, SPSS, and Stata
library(haven)

?read_sas

iris_sas<-read_sas("Z:/RClass/data/iris.sas7bdat")

?read_spss
iris_spss<-read_spss("Z:/RClass/data/iris.sav")
write_sav(iris_spss,path="Z:/RClass/data/iris_spss.sav")

## Reading from a github repository
install.packages("RCurl")
library(RCurl)
#library(readr)

land_crabs<- read_csv(getURL("https://raw.githubusercontent.com/chrischizinski/SNR_R_Group/master/data/ExperimentalDesignData/chpt5/green.csv"))
land_crabs

#Rdata
install.packages("repmis")
library(repmis)
source_data("https://github.com/chrischizinski/SNR_R_Group/blob/master/data/iris_from_git.RData?raw=true")

?reshape

## Tidying data
.libPaths("P:/RLibrary")
library(tidyverse)

data(mtcars)
head(mtcars)
str(mtcars)

mtcars$carname<-rownames(mtcars)
rownames(mtcars) <- NULL

# Messing with tidyr
mtcars %>% 
  gather(attribute, value, -carname)

mtcars %>% 
  gather(attribute, value, mpg:carb)

mtcars %>% 
  gather(attribute, value, 1:11)

mtcars.long<-mtcars %>% 
    gather(attribute, value, -carname)

mtcars.wide <- mtcars.long %>% 
                spread(attribute, value)

### seperate and unite

set.seed(1)

date <- as.Date("2016-01-01") + 0:14
hour <- sample(1:24, 15)
min <- sample(1:60, 15)
sec <- sample(1:60, 15)
event <- sample(letters, 15)

newdata<- data.frame(date, hour, min, sec, event)














