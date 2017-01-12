install.packages('googlesheets')

library(googlesheets)
library(tidyverse)

gs_ls()  # find what spread sheets are available

# get the Britain Elects google sheet
ed <- gs_title("EcologicalDetective")
ed

survey_data <- gs_read(ss=ed)
head(survey_data)

glimpse(survey_data)

names(survey_data)
survey_questions <- data.frame(new = c("Timestamp",paste("Q",2:ncol(survey_data),sep="")), old = names(survey_data))
names(survey_data) <- c("Timestamp",paste("Q",2:ncol(survey_data),sep=""))
glimpse(survey_data)

## Dealing with time and dates
library(lubridate)

survey_data$Timestamp # look at the specific column

class(survey_data$Timestamp)  # character data

## classic way
test<-as.POSIXlt(survey_data$Timestamp, format = "%m/%d/%Y %H:%M:%S")
test
class(test)

# R has a specific class for times and dates (can get very complicated),  the lubridate package (a hadley wickham product) makes this much faster
# several functions exist to allow us to write in the dates depending on how it is formated
# ymd(), dmy(), hms(), ymd_hms()

?dmy_hms

mdy_hms(survey_data$Timestamp, tz = "America/Chicago")  # http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

mdy_hms("Jan 1 2017 12:00:00")
mdy_hms("January 1, 2017 12:00:00")

survey_data$Timestamp<-mdy_hms(survey_data$Timestamp, tz = "America/Chicago")
glimpse(survey_data)


# lubridate also allows us to extract information easily from our date and time
hour(survey_data$Timestamp)
minute(survey_data$Timestamp)
second(survey_data$Timestamp)

year(survey_data$Timestamp) # extract year
leap_year(survey_data$Timestamp)  # TRUE/FALSE is a leap year
month(survey_data$Timestamp) # extract month
day(survey_data$Timestamp) # extract day

wday(survey_data$Timestamp) # extract day of week
wday(survey_data$Timestamp, label = TRUE)
yday(survey_data$Timestamp) # extract day
mday(survey_data$Timestamp)

email_sent<-mdy_hm("January 9, 2017 9:39",  tz = "America/Chicago")
email_sent

intv_data<-interval(email_sent,survey_data$Timestamp[-1])
as.period(intv_data)

as.period(intv_data)
as.period(intv_data, unit = "sec")

as.numeric(as.period(intv_data, unit = "sec"))
as.numeric(as.period(intv_data, unit = "sec"))/60

survey_data$Timestamp + days(2)
survey_data$Timestamp + seconds(2)

## Lets plot

survey_data_rev <- survey_data %>% 
                    select(-Q2) %>% 
                    arrange(Timestamp) %>% 
                    mutate(TakeSurvey = 1,
                           cuml_Order = cumsum(TakeSurvey),
                           prop_complete = cuml_Order/sum(TakeSurvey)) 

ggplot(data = survey_data_rev) + 
  geom_line(aes(x = Timestamp, y = prop_complete), linetype = "dotted") +
  geom_point(aes(x = Timestamp, y = prop_complete, color = Q3)) +
  # coord_cartesian(ylim = c(0,1), expand = FALSE) +
  labs(y = "Proportion complete" , x = "Time") +
  scale_color_manual(values = c("Yes" = "blue","No" = "red","Maybe" = "purple")) +
  theme_mine()


email_sent - days(1)
time_stop <- email_sent +days(4)

ggplot(data = survey_data_rev) + 
  geom_line(aes(x = Timestamp, y = prop_complete), linetype = "dotted") +
  geom_point(aes(x = Timestamp, y = prop_complete, color = Q3)) +
  # coord_cartesian(ylim = c(0,1), expand = FALSE) +
  labs(y = "Proportion complete" , x = "Time") +
  scale_color_manual(values = c("Yes" = "blue","No" = "red","Maybe" = "purple")) +
  scale_x_datetime(limits = c(email_sent,time_stop)) + 
  theme_mine()

library(scales)

ggplot(data = survey_data_rev) + 
  geom_line(aes(x = Timestamp, y = prop_complete), linetype = "dotted") +
  geom_point(aes(x = Timestamp, y = prop_complete, color = Q3)) +
  # coord_cartesian(ylim = c(0,1), expand = FALSE) +
  labs(y = "Proportion complete" , x = "Time") +
  scale_color_manual(values = c("Yes" = "blue","No" = "red","Maybe" = "purple")) +
  scale_x_datetime(limits = c(email_sent-days(1),time_stop), breaks = date_breaks("1 days")) + 
  theme_mine()

ggplot(data = survey_data_rev) + 
  geom_line(aes(x = Timestamp, y = prop_complete), linetype = "dotted") +
  geom_point(aes(x = Timestamp, y = prop_complete, color = Q3)) +
  coord_cartesian(ylim = c(0,1), expand = FALSE) +
  labs(y = "Proportion complete" , x = "Time") +
  scale_color_manual(values = c("Yes" = "blue","No" = "red","Maybe" = "purple")) +
  scale_x_datetime(limits = c(email_sent-days(1),time_stop), breaks = date_breaks("1 days"), labels = date_format("%b-%d")) + 
  theme_mine()

ggplot(data = survey_data_rev) + 
  geom_vline(aes(xintercept = as.numeric(email_sent)), linetype = "dashed", color = "grey") +
  geom_line(aes(x = Timestamp, y = prop_complete), linetype = "dotted") +
  geom_point(aes(x = Timestamp, y = prop_complete, color = Q3)) +
  coord_cartesian(ylim = c(0,1), expand = FALSE) +
  labs(y = "Proportion complete" , x = "Time") +
  scale_color_manual(values = c("Yes" = "blue","No" = "red","Maybe" = "purple")) +
  scale_x_datetime(limits = c(email_sent-days(1),time_stop), breaks = date_breaks("1 days"), labels = date_format("%b-%d")) + 
  theme_mine()

ggplot(data = survey_data_rev) + 
  geom_vline(aes(xintercept = as.numeric(email_sent)), linetype = "dashed", color = "grey") +
  geom_line(aes(x = Timestamp, y = prop_complete), linetype = "dotted") +
  geom_point(aes(x = Timestamp, y = prop_complete, color = Q3)) +
  coord_cartesian(ylim = c(0,1.01), expand = FALSE) +
  labs(y = "Proportion complete" , x = "Time") +
  scale_color_manual(values = c("Yes" = "blue","No" = "red","Maybe" = "purple")) +
  scale_x_datetime(limits = c(email_sent-days(1),time_stop), breaks = date_breaks("12 hours"), labels = date_format("%b-%d %H:%M")) + 
  theme_mine() + 
  theme(legend.position = c(0.9,0.10),
        axis.text.x = element_text(angle = 90))
  

