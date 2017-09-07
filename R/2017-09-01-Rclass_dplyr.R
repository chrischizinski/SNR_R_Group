# Data wrangling with the tidyverse
options(stringasfactor=FALSE)
.libPaths("P:/RLibrary")


library(tidyverse)
#tidyverse a series of package built around the philosophy of tidy data structures.
#Each variable forms a column
#Each observation froms a row
#Each observational unit forms a data table

# Standardization is key, maintain data in a consistent form that is vectorized

#no-no's 
#Column headers are value's
#Multiple variables stored in each column
#Variables stored in both rows and columns
#Multiple observational units stored in a single table
#A single observational unit is stored in multiple tables

## Tidying up your data with tidyr

data(mtcars)

head(mtcars)

mtcars$carnames <- rownames(mtcars)  # make column of car names from row names
rownames(mtcars) <- NULL

head(mtcars)

#gather()
#Wide format to long format
mtcars %>% 
  gather(attribute, value, -carnames) %>% 
  head()

mtcars %>% 
  gather(attribute, value, 1:11) %>% 
  head()

mtcars.long<-mtcars %>% 
  gather(attribute, value, mpg:carb)

head(mtcars.long)

### spread()
#Take data from long format to wide format
mtcars.wide<-mtcars.long %>% 
  spread(attribute,value)

head(mtcars.wide)

### seperate()
#break a single column into multiple columns
mtcars.wide2<-mtcars.wide %>% 
  separate(carnames, c("make","model"), sep = " ", extra = "merge", fill="right") 

head(mtcars.wide2)

### unite()
#combine multiple columns into a single column
glimpse(mtcars.wide2)

mtcars.wide2 %>% 
  unite(UID, make, cyl, hp, sep="_") %>% 
  head()

mtcars.wide2 %>% 
  unite(UID, make, cyl, hp, sep="_",remove="FALSE") %>% 
  head()

# ## complete()
# #create all possible combinations within data frame
# fake_data <- data.frame(group = c(1:2,1),
#                         item_id = c(1:2,2),
#                         item_name = c("a","b","b"),
#                         value1 = c(1:3),
#                         value2 = c(4:6))
# 
# fake_data %>% 
#   complete(group,nesting(item_id,item_name))
# 
# str(fake_data)
# 
# fake_data$item_name <-as.character(fake_data$item_name)
# 
# fake_data %>% 
#   complete(group,nesting(item_id,item_name),fill = list(value1 = 0, value2 = 0))

### dplyr
install.packages("hflights")
library(hflights)
data(hflights)
head(hflights)

str(hflights)

glimpse(hflights)

## Use indexing to subset data by flights to DFW
#1 way
dfw.flights <- hflights[hflights$Dest == "MCI",]
# 2 way, probably don't mention unless they do
dfw.flights <- hflights[which(hflights$Dest == "MCI"),]

# USe indexing to subset data by flights with in air time greater than 250 minutes

hflights[hflights$AirTime >=250,]  # and

# USe indexing to subset data by flights  in the 1st month and 1st day
#hflights[(hflights$Month == 1 | hflights$DayofMonth == 1),]  # or 
########
#Filter
# Only look at Sundays
hflights %>% 
  filter(DayOfWeek == 1) %>% head()
#Look at everyday but sunday
hflights %>% 
  filter(DayOfWeek != 1) %>% head()
#Just look at the weekend
hflights %>% 
  filter(DayOfWeek %in% c(1,6,7)) %>%
  head()
# look at weekdays
hflights %>% 
  filter(!DayOfWeek %in% c(1,6,7)) %>% 
  head()
#Commonly, need to filter NA's
hflights %>% 
  filter(!is.na(UniqueCarrier)) # Bring up non-NAs

# select()

head(hflights)
# drop one column
hflights %>% 
  select(-CancellationCode) %>% head()
# select a certain number of columns, drop the rest
hflights %>% 
  select(Year, UniqueCarrier, DepTime, ArrTime) %>% 
  head()
# put it together
hflights %>% 
  select(Year, UniqueCarrier, DepTime, ArrTime) %>% 
  filter(UniqueCarrier== "AA") %>% 
  head()

#logical statements
hflights %>% 
  select(starts_with("A")) %>% 
  head()

hflights %>% 
  select(matches("Taxi")) %>% 
  head()

hflights %>% 
  select(contains("Taxi")) %>% 
  head()

hflights %>% 
  select(everything()) %>% 
  head()

hflights %>% 
  select(Year:FlightNum) %>% 
  head()

hflights %>% 
  select(1:8) %>% 
  head()

#arrange
hflights %>% 
  arrange(Year,Month,DayofMonth) %>% 
  head()

hflights %>% 
  arrange(Year,desc(Month), desc(DayofMonth)) %>% 
  head()

# mutate

hflights %>% 
  select(UniqueCarrier,DepTime,ArrTime) %>%
  mutate(TravTime = (ArrTime-DepTime) * 60)->hflights_travel

hflights_travel %>% 
  mutate(mean_TravTime=percent_rank(TravTime)) %>% 
  head()
   
unique(hflights$Dest)
 
hflights %>% 
  filter(Dest %in% c("AUS","LAX","BOS")) %>% 
  mutate(Dest_Full=case_when(.$Dest=="AUS"~"Austin",
                             .$Dest=="LAX"~"Los Angles",
                             .$Dest=="BOS"~"Boston")) %>% 
  head()
#group_by

hflights %>% 
  group_by(UniqueCarrier) %>%
  mutate(TravTime = (ArrTime-DepTime) * 60) %>% 
  mutate(mean_TravTime = mean(TravTime,na.rm=TRUE)) %>% 
  glimpse()

#summarize

hflights %>% 
  filter(Month %in% c(1:4)) %>% 
  group_by(UniqueCarrier) %>% 
  mutate(TravelTime = ArrTime - DepTime) %>% 
  summarize(MeanTravel = mean(TravelTime,na.rm =TRUE),
            SDTravel = sd(TravelTime,na.rm =TRUE)) %>% 
  mutate(CVTravel = SDTravel/MeanTravel) %>% 
  head()


###joining
library(RCurl)
library(tidyverse)

publishers <- read_csv(getURL("https://raw.githubusercontent.com/chrischizinski/OFWIM_2016/master/data/publisher.csv"))

publishers

superheroes <- read_csv(getURL("https://raw.githubusercontent.com/chrischizinski/OFWIM_2016/master/data/superheroes.csv"))

superheroes
#inner_join
#mutating join
#returns dataset of superheros with matches in publisher
super_ij <- inner_join(superheroes, publishers, by = "publisher")
super_ij
#semi_join
#filtering join
super_sj <- semi_join(superheroes, publishers, by = "publisher")
super_sj
#left_join
#keeps all data from first dataset and columbns of second
super_lj <- left_join(superheroes, publishers, by = "publisher")
super_lj
#right_join
#
super_rj <- right_join(superheroes, publishers, by = "publisher")
super_rj
#anti_join
#keeps all rows that do not have a match 
super_aj <- anti_join(superheroes, publishers, by = "publisher")
super_aj
#full_join
super_fj <- full_join(superheroes, publishers, by = "publisher")
super_fj


