# Data wrangling with the tidyverse

.libPaths("P:/RLibrary")

library(devtools)

install_github("Hadley/tidyverse", force = TRUE)

library(tidyverse)


## Tidying up your data with tidyr

data(mtcars)

head(mtcars)

mtcars$carnames <- rownames(mtcars)  # make column of car names from row names
rownames(mtcars) <- NULL

#gather()

mtcars %>% 
  gather(attribute, value, -carnames)

mtcars %>% 
  gather(attribute, value, 1:11)

mtcars.long<-mtcars %>% 
              gather(attribute, value, mpg:carb)

### spread()

mtcars.wide<-mtcars.long %>% 
              spread(attribute,value)

### seperate()
mtcars.wide %>% 
  separate(carnames, c("make","model"), sep = " ", extra = "merge", fill="right")

### unite()

set.seed(12345)

date <- as.Date("2016-01-01") + 0:14
hour <- sample(1:24, 15)
min <- sample(1:60, 15)
sec <- sample(1:60, 15)
event <- sample(letters, 15)

made_up_data<-data.frame(date,hour, min, sec, event)

made_up_data %>% 
  unite(time, hour, min, sec, sep=":") %>% 
  unite(datetime, date, time, sep = " ")

## complete()

fake_data <- data.frame(group = c(1:2,1),
                        item_id = c(1:2,2),
                        item_name = c("a","b","b"),
                        value1 = c(1:3),
                        value2 = c(4:6))

fake_data %>% 
  complete(group,nesting(item_id,item_name))

str(fake_data)

fake_data$item_name <-as.character(fake_data$item_name)

fake_data %>% 
  complete(group,nesting(item_id,item_name),fill = list(value1 = 0, value2 = 0))

### dplyr
install.packages("hflights")
library(hflights)
data(hflights)
head(hflights)

str(hflights)


## data.frame of flights to DFW
dfw.flights <- hflights[hflights$Dest == "DFW",]
dfw.flights <- hflights[which(hflights$Dest == "DFW"),]

# Month 1 and DayofMonth 1

hflights[(hflights$month == 1 & hflights$DayofMonth == 1),]  # and
hflights[(hflights$month == 1 | hflights$DayofMonth == 1),]  # or 

hflights %>% 
  filter(Month ==1,
         DayofMonth %in% c(1,6,7)) %>% head()

hflights %>% 
  filter(UniqueCarrier != "AA")

hflights %>% 
  filter(!UniqueCarrier %in% c("AA", "UA"))

hflights %>% 
  filter(!is.na(UniqueCarrier)) # Bring up non-NAs

# select()

head(hflights)

hflights %>% 
  select(-CancellationCode) %>% head()

hflights %>% 
  select(Month, UniqueCarrier, FlightNum) %>% head()


hflights %>% 
  select(starts_with("A")) %>% head()

hflights %>% 
  select(matches("Taxi")) %>% head()

hflights %>% 
  select(contains("Taxi")) %>% head()

hflights %>% 
  select(everything()) %>% head()


hflights %>% 
  select(Year:FlightNum) %>% head()

hflights %>% 
  select(1:8) %>% head()

hflights %>% 
  arrange(UniqueCarrier,Year,Month, DayofMonth) %>% head(20)

hflights %>% 
  arrange(desc(UniqueCarrier),desc(Year),Month, DayofMonth) %>% head(20)

# mutate(0

hflights %>% 
  select(UniqueCarrier,DepTime,ArrTime) %>%
  mutate(TravTime = (ArrTime-DepTime) * 60)


  unique(hflights$UniqueCarrier)

  hflights %>% 
    filter(Month %in% c(1:4)) %>% 
    group_by(UniqueCarrier) %>% 
    mutate(TravelTime = ArrTime - DepTime) %>% 
    summarize(MeanTravel = mean(TravelTime,na.rm =T),
              SDTravel = sd(TravelTime,na.rm =T)) %>% 
    mutate(CVTravel = SDTravel/MeanTravel)

