---
title: "Applied Multivarite:  Intro to Data Wrangling"
output: html_document
---



This class covers an introduction to wrangling and summarizing data using the functions from `tidyr` and `dplyr`.  This is only meant to serve as a brief introduction, as we will keep developing these skills throughout the semester.  I have a similar lesson on data wrangling from a previous semester [2016-09-23-Wrangling](https://chrischizinski.github.io/SNR_R_Group/2016-09-23-Wrangling) and information on joins [2016-09-29-Joining_Data_Sets](https://chrischizinski.github.io/SNR_R_Group/2016-09-29-Joining_Data_Sets).

[R script from class](https://github.com/chrischizinski/SNR_R_Group/blob/master/R/2017-09-01-Rclass_dplyr.R)


[Answers to last week challenges](https://github.com/chrischizinski/SNR_R_Group/blob/master/R/2017-09-01-Challenges_week1.R)



## Weekly challenge

### The data

Work with the ecology data set from datacarpentry.  An explanation of the data set can be found [here](http://www.datacarpentry.org/R-ecology-lesson/02-starting-with-data.html)


{% highlight r %}
library(tidyverse)

mydata <- read_csv("https://ndownloader.figshare.com/files/2292169")

glimpse(mydata)
{% endhighlight %}



{% highlight text %}
## Observations: 34,786
## Variables: 13
## $ record_id       <int> 1, 72, 224, 266, 349, 363, 435, 506, 588, 661,...
## $ month           <int> 7, 8, 9, 10, 11, 11, 12, 1, 2, 3, 4, 5, 6, 8, ...
## $ day             <int> 16, 19, 13, 16, 12, 12, 10, 8, 18, 11, 8, 6, 9...
## $ year            <int> 1977, 1977, 1977, 1977, 1977, 1977, 1977, 1978...
## $ plot_id         <int> 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2...
## $ species_id      <chr> "NL", "NL", "NL", "NL", "NL", "NL", "NL", "NL"...
## $ sex             <chr> "M", "M", NA, NA, NA, NA, NA, NA, "M", NA, NA,...
## $ hindfoot_length <int> 32, 31, NA, NA, NA, NA, NA, NA, NA, NA, NA, 32...
## $ weight          <int> NA, NA, NA, NA, NA, NA, NA, NA, 218, NA, NA, 2...
## $ genus           <chr> "Neotoma", "Neotoma", "Neotoma", "Neotoma", "N...
## $ species         <chr> "albigula", "albigula", "albigula", "albigula"...
## $ taxa            <chr> "Rodent", "Rodent", "Rodent", "Rodent", "Roden...
## $ plot_type       <chr> "Control", "Control", "Control", "Control", "C...
{% endhighlight %}

## In-class challenges

*1. create a new column for Species (Genus + specific epithet)*

*2. Average weight of Male Rodents*

*3.put data into long form*


## Take home challenges

*1. How many animals caught in each plot type?*

*2. How many species are in each taxa?*

*3. Average weight of each species?*

*4. Average weight of each Sex of each species?*

