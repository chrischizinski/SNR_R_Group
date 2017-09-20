#data explaination 
# http://www.datacarpentry.org/R-ecology-lesson/02-starting-with-data.html
library(tidyverse)
library(lubridate)
mydata <- read_csv("https://ndownloader.figshare.com/files/2292169")

glimpse(mydata)

###EMAIL to michael.whitby@huskers.unl.edu if taking for credit.
###FYI: I just send a list of who completed the assignment to Chris - refer any questions about the class to him 

# IN CLASS
#1.put data into long form
mydata %>% 
gather(attribute,value,sex:weight) %>% 
  glimpse()


#2.create new columns in one pipe  - 
##a.Species (Genus + specific epithet)
mydata<-mydata %>% 
  unite(UID,genus,species, sep=' ')
head(mydata_n)

##b. Date column 
mydata<-mydata %>% 
  unite(Date,year,month,day, sep='-', remove=FALSE) %>% 
  mutate(Date=ymd(Date)) 
head(mydata)

# all together
mydata<-mydata %>% 
  unite(spp,genus,species, sep=' ', remove=FALSE) %>% 
  unite(Date,year,month,day, sep='-', remove=FALSE) %>% 
  mutate(Date=ymd(Date))
head(mydata)


#3.Average weight of Male and Female rodents - in one table!
mydata %>% 
  filter(taxa=="Rodent") %>% 
  group_by(sex) %>% 
  summarise(mean_weight=mean(weight,na.rm=TRUE))


#############################################################################
######################TAKE home challenges###################################
#############################################################################


#1. How many animals caught in each plot type?
mydata %>% 
  group_by(plot_type) %>% 
  summarize(count=n())

# A tibble: 5 ? 2
#plot_type count
#<chr> <int>
 # 1                   Control 15611
#2  Long-term Krat Exclosure  5118
#3          Rodent Exclosure  4233
#4 Short-term Krat Exclosure  5906
#5         Spectab exclosure  3918


#2. How many species are in each taxa?
mydata %>% 
  group_by(taxa) %>% 
  summarize(count=n_distinct(spp))

# A tibble: 4 ? 2
#taxa count
#<chr> <int>
# 1    Bird    11
#2  Rabbit     1
#3 Reptile     7
#4  Rodent    29


#3. Average hindfoot length of each Rodent species?
mydata %>% 
  filter(taxa=="Rodent") %>% 
  group_by(spp) %>% 
  summarize(mean_length=mean(hindfoot_length,na.rm=TRUE))

# A tibble: 29 ? 2
#UID mean_length
#<chr>       <dbl>
#  1  Ammospermophilus harrisi    33.00000
#2           Baiomys taylori    13.00000
#3       Chaetodipus baileyi    26.11592
#4   Chaetodipus intermedius    22.22222
#5  Chaetodipus penicillatus    21.75157
#6           Chaetodipus sp.    19.50000
#7        Dipodomys merriami    35.98235
#8           Dipodomys ordii    35.60755
#9             Dipodomys sp.         NaN
#10    Dipodomys spectabilis    49.94887
# ... with 19 more rows

#4. Average weight of all rodents during of each season 
#- (Spring = MARCH-MAY, SUMMER= JUNE-AUGUST, FALL=SEPT-NOV, WINTER = DEC-FEB) <- USE MUTATE and case_when to create a season column
mydata %>% 
  filter(taxa=="Rodent") %>% 
  mutate(Season=case_when(.$month %in% c(3,4,5)~"Spring",
                          .$month %in% c(6,7,8)~"Summer",
                          .$month %in% c(9,10,11)~"Fall",
                          .$month %in% c(12,1,2)~"Winter")) %>% 
  group_by(spp,Season) %>% 
  summarize(mean_weight=mean(weight,na.rm=TRUE))

# A tibble: 4 ? 2
#Season mean_weight
#<chr>       <dbl>
#  1   Fall    43.57334
#2 Spring    44.80459
#3 Summer    41.02269
#4 Winter    40.84584
