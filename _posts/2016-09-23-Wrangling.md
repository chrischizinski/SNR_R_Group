---
title: "Wrangling data"
output: html_document
tags: [R, dplyr, tidyr, tidyverse ]
---



All the data that we use is in our [repository](https://github.com/chrischizinski/SNR_R_Group/tree/master/data).


Now that you have your data in R, no matter the process you took to get it there, you will undoubtedly need to manipulate the data.  Manipulation (i.e. tidying) will involve getting your data in a format and "looking" the way you want so you can analyze the data. This does not sound like a big process but until a few years ago it was.  You needed to have a strong understanding of indices (discussed last week), combining various aspects, or using functions that were not particularly user friendly (`aggregate` and `reshape` as examples).  Luckily, with the development of the `tidyverse` there are [`tidyr`](https://github.com/hadley/tidyr) and [`dplyr`](https://github.com/hadley/dplyr) packages the process of tidying and manipulating your data has been revolutionized.  The two packages `dplyr` and `tidyr`  provide the "grammar of data manipulation"

### Why use dplyr and tidyr?

1. **Speed** - dplyr and tidyr are *really* fast  
2. **Readability** - the code syntax is straightforward and easy to read  
3. **Chaining** - *never break the chain*. More on this later
4. **Integrates with ggplot2** - plot your data in the same workflow 

The concept of `tidyr` and `dplyr` follows some of the [philosophy](http://vita.had.co.nz/papers/tidy-data.html) of set out with the development of `ggplot2` (we will be getting to this soon).

Something that is new to this approach is the idea of pipes.  Pipes were originally developed in the [`magrittr`](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html) as a means to simplify and streamline R code.  Pipes look like this `%>%` and can be quick keyed in RStudio using `Ctrl+Shift+M` in PC and  `Cmd+Shift+M` in Mac. Pipes essentially mean to take the data from one step and pass it through to the next step (think of it like water flowing through a pipe) creating a sequence of data steps. 

To top it off, there is also an excellent [cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) created by the folks at RStudio. 

### Lets get tidying


{% highlight r %}
library(tidyr)
{% endhighlight %}

Tidyr is designed to help manipulate data sets, allowing you to convert between wide and long formats, fill in missing values and combinations, separate or merge multiple columns, rename and create new variables, and summarize data according to grouping variables.

Tidy data should have the following forms

* Each variable forms a column
* Each observation forms a row
* Each type of observational unit forms a table

The main verbs in tidyr

- `gather()` and `spread()` convert data between wide and long format
- `separate()` and `unite()` separate a single column into multiple columns and vice versa
- `complete()` turns implicit missing values in explicit missing values by completing missing data combinations

### and to dplyr

There are many verbs in dplyr (check out the cheatsheet) but the main ones are

- `filter()`  selects specific rows based on user-defined criteria
- `select()`  selects specific columns
- `arrange()` reorder rows
- `mutate()` creates new columns (variables)
- `summarise()` reduces variables to values
- `group_by()` creates groups that can be operated on

### Demonstrate on some "canned data"

#### Getting the data set up

R has many datasets that can be used to explore various functions.  


{% highlight r %}
library(tidyverse)
{% endhighlight %}



{% highlight text %}
## Loading tidyverse: tibble
## Loading tidyverse: readr
## Loading tidyverse: purrr
## Loading tidyverse: dplyr
{% endhighlight %}



{% highlight text %}
## Conflicts with tidy packages ----------------------------------------------
{% endhighlight %}



{% highlight text %}
## filter(): dplyr, stats
## lag():    dplyr, stats
{% endhighlight %}



{% highlight r %}
data(mtcars)  #mtcar dataset

head(mtcars)
{% endhighlight %}



{% highlight text %}
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
{% endhighlight %}



{% highlight r %}
# mtcars has the make and model of the car in the rownames.  We should not keep important data as an attribute in the dataset.  Move the rownames to a column in the data

mtcars$car_names <- rownames(mtcars)

#remove that info from rownames

rownames(mtcars) <- NULL

head(mtcars)
{% endhighlight %}



{% highlight text %}
##    mpg cyl disp  hp drat    wt  qsec vs am gear carb         car_names
## 1 21.0   6  160 110 3.90 2.620 16.46  0  1    4    4         Mazda RX4
## 2 21.0   6  160 110 3.90 2.875 17.02  0  1    4    4     Mazda RX4 Wag
## 3 22.8   4  108  93 3.85 2.320 18.61  1  1    4    1        Datsun 710
## 4 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1    Hornet 4 Drive
## 5 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2 Hornet Sportabout
## 6 18.1   6  225 105 2.76 3.460 20.22  1  0    3    1           Valiant
{% endhighlight %}

#### gather()

`gather()` is a useful function to take data from a wide format to a long format.  The function is pretty robust and many ways can be used to achieve the same outcome. 

`gather()` requirements

  1. data, if you are chaining (i.e., using pipes this is not required
  2. new column name of the columns to gather (will use column headers)
  3. new column name to put the values in (i.e., value from the element in the cell)
  


{% highlight r %}
mtcars %>% 
  gather(attribute, value, -car_names) %>%  # gather everything except car_names
  head()
{% endhighlight %}



{% highlight text %}
##           car_names attribute value
## 1         Mazda RX4       mpg  21.0
## 2     Mazda RX4 Wag       mpg  21.0
## 3        Datsun 710       mpg  22.8
## 4    Hornet 4 Drive       mpg  21.4
## 5 Hornet Sportabout       mpg  18.7
## 6           Valiant       mpg  18.1
{% endhighlight %}



{% highlight r %}
mtcars %>% 
  gather(attribute, value, 1:11) %>% # use the column numbers
  head()
{% endhighlight %}



{% highlight text %}
##           car_names attribute value
## 1         Mazda RX4       mpg  21.0
## 2     Mazda RX4 Wag       mpg  21.0
## 3        Datsun 710       mpg  22.8
## 4    Hornet 4 Drive       mpg  21.4
## 5 Hornet Sportabout       mpg  18.7
## 6           Valiant       mpg  18.1
{% endhighlight %}



{% highlight r %}
mtcars.long<-mtcars %>% 
              gather(attribute, value, mpg:carb)  # or the column names
head(mtcars.long)
{% endhighlight %}



{% highlight text %}
##           car_names attribute value
## 1         Mazda RX4       mpg  21.0
## 2     Mazda RX4 Wag       mpg  21.0
## 3        Datsun 710       mpg  22.8
## 4    Hornet 4 Drive       mpg  21.4
## 5 Hornet Sportabout       mpg  18.7
## 6           Valiant       mpg  18.1
{% endhighlight %}

#### spread()

`spread()` does the opposite of `gather()`.  It takes a column and spreads it among multiple columns.  We can use the long format that we just created and convert it to a wide format.  

`spread()` requirements

  1. data, if you are chaining (i.e., using pipes this is not required
  2.  column name that will become the new column headers
  3. the values that will be put into the elements of the spread columns


{% highlight r %}
mtcars.wide<-mtcars.long %>% 
              spread(attribute,value)

head(mtcars.wide)
{% endhighlight %}



{% highlight text %}
##            car_names am carb cyl disp drat gear  hp  mpg  qsec vs    wt
## 1        AMC Javelin  0    2   8  304 3.15    3 150 15.2 17.30  0 3.435
## 2 Cadillac Fleetwood  0    4   8  472 2.93    3 205 10.4 17.98  0 5.250
## 3         Camaro Z28  0    4   8  350 3.73    3 245 13.3 15.41  0 3.840
## 4  Chrysler Imperial  0    4   8  440 3.23    3 230 14.7 17.42  0 5.345
## 5         Datsun 710  1    1   4  108 3.85    4  93 22.8 18.61  1 2.320
## 6   Dodge Challenger  0    2   8  318 2.76    3 150 15.5 16.87  0 3.520
{% endhighlight %}

#### separate()

`separate()` takes the elements of a column (usually a string) and will break them into multiple columns.  

`separate()` requirements

  1. data, if you are chaining (i.e., using pipes this is not required
  2. column name that will be split
  3. names of the columns that will be created with a split.  Should be in ecapsulated in a parenthesis with the column names in quotes
  4. the value that should be used as the separator 
  5. any options


{% highlight r %}
mtcars.wide %>% 
  separate(car_names, c("make","model"), sep = " ") %>%  #note that the elements with mutiple spaces in this case get dropped, as indicated by warnings
  head()
{% endhighlight %}



{% highlight text %}
## Warning: Too many values at 3 locations: 11, 13, 19
{% endhighlight %}



{% highlight text %}
## Warning: Too few values at 1 locations: 31
{% endhighlight %}



{% highlight text %}
##       make      model am carb cyl disp drat gear  hp  mpg  qsec vs    wt
## 1      AMC    Javelin  0    2   8  304 3.15    3 150 15.2 17.30  0 3.435
## 2 Cadillac  Fleetwood  0    4   8  472 2.93    3 205 10.4 17.98  0 5.250
## 3   Camaro        Z28  0    4   8  350 3.73    3 245 13.3 15.41  0 3.840
## 4 Chrysler   Imperial  0    4   8  440 3.23    3 230 14.7 17.42  0 5.345
## 5   Datsun        710  1    1   4  108 3.85    4  93 22.8 18.61  1 2.320
## 6    Dodge Challenger  0    2   8  318 2.76    3 150 15.5 16.87  0 3.520
{% endhighlight %}



{% highlight r %}
# These dropped elements can be preserved with a couple of options
mtcars.wide %>% 
  separate(car_names, c("make","model"), sep = " ", extra = "merge", fill="right") %>%  #note that the elements with mutiple spaces in this case get dropped
  head()  #extra tells how to keep the extra elements and fill tells where to put it
{% endhighlight %}



{% highlight text %}
##       make      model am carb cyl disp drat gear  hp  mpg  qsec vs    wt
## 1      AMC    Javelin  0    2   8  304 3.15    3 150 15.2 17.30  0 3.435
## 2 Cadillac  Fleetwood  0    4   8  472 2.93    3 205 10.4 17.98  0 5.250
## 3   Camaro        Z28  0    4   8  350 3.73    3 245 13.3 15.41  0 3.840
## 4 Chrysler   Imperial  0    4   8  440 3.23    3 230 14.7 17.42  0 5.345
## 5   Datsun        710  1    1   4  108 3.85    4  93 22.8 18.61  1 2.320
## 6    Dodge Challenger  0    2   8  318 2.76    3 150 15.5 16.87  0 3.520
{% endhighlight %}

#### unite()

`unite()` takes the elements of multiple columns and will combine into a single columns.  

`unite()` requirements

  1. data, if you are chaining (i.e., using pipes this is not required
  2. column name that will be split
  3. names of the column that will be created with the combined dataset
  4. the columns that will be combined
  5. the seperator that will be used

To do this, lets explore this with some made up data.


{% highlight r %}
set.seed(12345)

date <- seq(as.Date("2016-01-01"),as.Date("2016-01-15"), by="day") # sequence of dates by 1 day increments
hour <- sample(1:24, 15)  # random sample of 1 to 25, 15 values
min <- sample(1:60, 15) # random sample of 1 to 60, 15 values
sec <- sample(1:60, 15) # random sample of 1 to 60, 15 values
event <- sample(letters, 15) # random sample of 15 letters

made_up_data<-data.frame(date,hour, min, sec, event) # combine in a single data.frame

head(made_up_data)
{% endhighlight %}



{% highlight text %}
##         date hour min sec event
## 1 2016-01-01   18  28  48     i
## 2 2016-01-02   21  23   1     b
## 3 2016-01-03   17  24  11     y
## 4 2016-01-04   19  11  39     x
## 5 2016-01-05   10  54  21     n
## 6 2016-01-06    4  25  20     u
{% endhighlight %}

To create a column that has date and time, will require two steps.  First creating the time value (separtor = :) and then time and date (separator = " ").


{% highlight r %}
made_up_data %>% 
  unite(time, hour, min, sec, sep=":") %>% # combine hour, min, sec, with a ':' separator
  unite(datetime, date, time, sep = " ") # then create the previously created time column with the date with a " " separator
{% endhighlight %}



{% highlight text %}
##               datetime event
## 1  2016-01-01 18:28:48     i
## 2   2016-01-02 21:23:1     b
## 3  2016-01-03 17:24:11     y
## 4  2016-01-04 19:11:39     x
## 5  2016-01-05 10:54:21     n
## 6   2016-01-06 4:25:20     u
## 7   2016-01-07 6:18:47     q
## 8   2016-01-08 9:52:60     f
## 9  2016-01-09 12:37:33     d
## 10  2016-01-10 15:33:7     m
## 11  2016-01-11 1:20:40     h
## 12  2016-01-12 2:35:22     k
## 13 2016-01-13 22:27:45     w
## 14 2016-01-14 14:57:37     s
## 15 2016-01-15 23:59:12     c
{% endhighlight %}


#### complete()

There is often data that you will get that is 'incomplete', meaning that there is not a full factorial representation of the data (i.e., we do not have all possible combinations of the factors and data).  This can have profound influences in calculating catch or harvest per unit effort (i.e., a zero at one site is not being represented, thus inflating your CPUE).

Previously, you had to use the function `expand.grid()`, then full join with the original dataset, and then replace the NAs with zeros.  This could, depending on your dataset, create several lines of code and prone to errors.

tidyr's `complete()` simplifies this process.  

`complete()` requirements

  1. data, if you are chaining (i.e., using pipes this is not required
  2. column name that will be split
  3. names of the column that will be created with the combined dataset
  4. the columns that will be combined
  5. the seperator that will be used
  
First we will create a data set.  What do you notice about the data
?

{% highlight r %}
fake_data <- data.frame(group = c(1:2,1),
                        item_id = c(1:2,2),
                        item_name = c("a","b","b"),
                        value1 = c(1:3),
                        value2 = c(4:6))

fake_data
{% endhighlight %}



{% highlight text %}
##   group item_id item_name value1 value2
## 1     1       1         a      1      4
## 2     2       2         b      2      5
## 3     1       2         b      3      6
{% endhighlight %}

You should see we are missing a single row, the group 1, item_id 1, with item_name a.  We can fill that in with `complete()`


{% highlight r %}
fake_data %>% 
  complete(group,nesting(item_id,item_name))
{% endhighlight %}



{% highlight text %}
## # A tibble: 4 × 5
##   group item_id item_name value1 value2
##   <dbl>   <dbl>     <chr>  <int>  <int>
## 1     1       1         a      1      4
## 2     1       2         b      3      6
## 3     2       1         a     NA     NA
## 4     2       2         b      2      5
{% endhighlight %}



{% highlight r %}
# complete, by default, fills in missing values with NAs.  We can fill in other values with the fill() command.  Notice, you must list how each variable should be filled in

fake_data %>% 
  complete(group,nesting(item_id,item_name),fill = list(value1 = 0, value2 = 0))
{% endhighlight %}



{% highlight text %}
## # A tibble: 4 × 5
##   group item_id item_name value1 value2
##   <dbl>   <dbl>     <chr>  <dbl>  <dbl>
## 1     1       1         a      1      4
## 2     1       2         b      3      6
## 3     2       1         a      0      0
## 4     2       2         b      2      5
{% endhighlight %}

### Now let's get looking at `dplyr()`

To lets start looking at `dplyr()`, we should install the `hlflights` data set.  This data includes the characteristics of flights leaving and entering the houston airport.  


{% highlight r %}
# install.packages("hflights")
library(hflights)
data(hflights)
head(hflights)
{% endhighlight %}



{% highlight text %}
##      Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 5424 2011     1          1         6    1400    1500            AA
## 5425 2011     1          2         7    1401    1501            AA
## 5426 2011     1          3         1    1352    1502            AA
## 5427 2011     1          4         2    1403    1513            AA
## 5428 2011     1          5         3    1405    1507            AA
## 5429 2011     1          6         4    1359    1503            AA
##      FlightNum TailNum ActualElapsedTime AirTime ArrDelay DepDelay Origin
## 5424       428  N576AA                60      40      -10        0    IAH
## 5425       428  N557AA                60      45       -9        1    IAH
## 5426       428  N541AA                70      48       -8       -8    IAH
## 5427       428  N403AA                70      39        3        3    IAH
## 5428       428  N492AA                62      44       -3        5    IAH
## 5429       428  N262AA                64      45       -7       -1    IAH
##      Dest Distance TaxiIn TaxiOut Cancelled CancellationCode Diverted
## 5424  DFW      224      7      13         0                         0
## 5425  DFW      224      6       9         0                         0
## 5426  DFW      224      5      17         0                         0
## 5427  DFW      224      9      22         0                         0
## 5428  DFW      224      9       9         0                         0
## 5429  DFW      224      6      13         0                         0
{% endhighlight %}



{% highlight r %}
str(hflights)
{% endhighlight %}



{% highlight text %}
## 'data.frame':	227496 obs. of  21 variables:
##  $ Year             : int  2011 2011 2011 2011 2011 2011 2011 2011 2011 2011 ...
##  $ Month            : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ DayofMonth       : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ DayOfWeek        : int  6 7 1 2 3 4 5 6 7 1 ...
##  $ DepTime          : int  1400 1401 1352 1403 1405 1359 1359 1355 1443 1443 ...
##  $ ArrTime          : int  1500 1501 1502 1513 1507 1503 1509 1454 1554 1553 ...
##  $ UniqueCarrier    : chr  "AA" "AA" "AA" "AA" ...
##  $ FlightNum        : int  428 428 428 428 428 428 428 428 428 428 ...
##  $ TailNum          : chr  "N576AA" "N557AA" "N541AA" "N403AA" ...
##  $ ActualElapsedTime: int  60 60 70 70 62 64 70 59 71 70 ...
##  $ AirTime          : int  40 45 48 39 44 45 43 40 41 45 ...
##  $ ArrDelay         : int  -10 -9 -8 3 -3 -7 -1 -16 44 43 ...
##  $ DepDelay         : int  0 1 -8 3 5 -1 -1 -5 43 43 ...
##  $ Origin           : chr  "IAH" "IAH" "IAH" "IAH" ...
##  $ Dest             : chr  "DFW" "DFW" "DFW" "DFW" ...
##  $ Distance         : int  224 224 224 224 224 224 224 224 224 224 ...
##  $ TaxiIn           : int  7 6 5 9 9 6 12 7 8 6 ...
##  $ TaxiOut          : int  13 9 17 22 9 13 15 12 22 19 ...
##  $ Cancelled        : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ CancellationCode : chr  "" "" "" "" ...
##  $ Diverted         : int  0 0 0 0 0 0 0 0 0 0 ...
{% endhighlight %}

To 'move around' and select various of aspects of this data set we can use [indices](https://chrischizinski.github.io/SNR_R_Group/2016-09-02-DataStructures) ,as discussed last week,  but you can see this can get complicated when we want to incorporate multiple aspects across mutiple columns.  


{% highlight r %}
## data.frame of flights to DFW
dfw.flights <- hflights[hflights$Dest == "DFW",]  # using the logical approach
dfw.flights <- hflights[which(hflights$Dest == "DFW"),]  # using the row approach with which()

# Month 1 and DayofMonth 1

hflights[(hflights$month == 1 & hflights$DayofMonth == 1),]  # and
{% endhighlight %}



{% highlight text %}
##  [1] Year              Month             DayofMonth       
##  [4] DayOfWeek         DepTime           ArrTime          
##  [7] UniqueCarrier     FlightNum         TailNum          
## [10] ActualElapsedTime AirTime           ArrDelay         
## [13] DepDelay          Origin            Dest             
## [16] Distance          TaxiIn            TaxiOut          
## [19] Cancelled         CancellationCode  Diverted         
## <0 rows> (or 0-length row.names)
{% endhighlight %}



{% highlight r %}
hflights[(hflights$month == 1 | hflights$DayofMonth == 1),]  # or 
{% endhighlight %}



{% highlight text %}
##  [1] Year              Month             DayofMonth       
##  [4] DayOfWeek         DepTime           ArrTime          
##  [7] UniqueCarrier     FlightNum         TailNum          
## [10] ActualElapsedTime AirTime           ArrDelay         
## [13] DepDelay          Origin            Dest             
## [16] Distance          TaxiIn            TaxiOut          
## [19] Cancelled         CancellationCode  Diverted         
## <0 rows> (or 0-length row.names)
{% endhighlight %}

or we can use the simplified approach in `dplyr()`


{% highlight r %}
hflights %>% 
  filter(Month ==1,
         DayofMonth %in% c(1,6,7)) %>% head()  # use '%in%' to incorporate multiple values, '==' does not work
{% endhighlight %}



{% highlight text %}
##   Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier FlightNum
## 1 2011     1          1         6    1400    1500            AA       428
## 2 2011     1          6         4    1359    1503            AA       428
## 3 2011     1          7         5    1359    1509            AA       428
## 4 2011     1          1         6     728     840            AA       460
## 5 2011     1          6         4     719     821            AA       460
## 6 2011     1          7         5     711     827            AA       460
##   TailNum ActualElapsedTime AirTime ArrDelay DepDelay Origin Dest Distance
## 1  N576AA                60      40      -10        0    IAH  DFW      224
## 2  N262AA                64      45       -7       -1    IAH  DFW      224
## 3  N493AA                70      43       -1       -1    IAH  DFW      224
## 4  N520AA                72      41        5        8    IAH  DFW      224
## 5  N251AA                62      44      -14       -1    IAH  DFW      224
## 6  N478AA                76      42       -8       -9    IAH  DFW      224
##   TaxiIn TaxiOut Cancelled CancellationCode Diverted
## 1      7      13         0                         0
## 2      6      13         0                         0
## 3     12      15         0                         0
## 4      6      25         0                         0
## 5      8      10         0                         0
## 6     24      10         0                         0
{% endhighlight %}



{% highlight r %}
hflights %>% 
  filter(UniqueCarrier != "AA") # not equali
{% endhighlight %}



{% highlight text %}
##        Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 1      2011     1          1         6    1824    2106            AS
## 2      2011     1          2         7    1823    2103            AS
## 3      2011     1          3         1    1827    2107            AS
## 4      2011     1          4         2    1845    2132            AS
## 5      2011     1          5         3    1821    2109            AS
## 6      2011     1          6         4    1834    2133            AS
## 7      2011     1          7         5    1823    2118            AS
## 8      2011     1          8         6    1822    2112            AS
## 9      2011     1          9         7    1938    2228            AS
## 10     2011     1         10         1    1820    2159            AS
## 11     2011     1         11         2    1820      12            AS
## 12     2011     1         12         3    1822    2129            AS
## 13     2011     1         13         4    1820    2113            AS
## 14     2011     1         14         5    1818    2114            AS
## 15     2011     1         15         6    1822    2131            AS
## 16     2011     1         16         7    1822    2138            AS
## 17     2011     1         17         1    1818    2149            AS
## 18     2011     1         18         2    1836    2130            AS
## 19     2011     1         19         3    1820    2102            AS
## 20     2011     1         20         4    1822    2135            AS
## 21     2011     1         21         5    1827    2136            AS
## 22     2011     1         22         6    1816    2100            AS
## 23     2011     1         23         7    1818    2104            AS
## 24     2011     1         24         1    1824    2109            AS
## 25     2011     1         25         2    1826    2101            AS
## 26     2011     1         26         3    1830    2115            AS
## 27     2011     1         27         4    1832    2110            AS
## 28     2011     1         28         5    1821    2052            AS
## 29     2011     1         29         6    1821    2042            AS
## 30     2011     1         30         7    1821    2128            AS
## 31     2011     1         31         1    1827    2111            AS
## 32     2011     1          1         6     654    1124            B6
## 33     2011     1          1         6    1639    2110            B6
## 34     2011     1          2         7     703    1113            B6
## 35     2011     1          2         7    1604    2040            B6
## 36     2011     1          3         1     659    1100            B6
## 37     2011     1          3         1    1801    2200            B6
## 38     2011     1          4         2     654    1103            B6
## 39     2011     1          4         2    1608    2034            B6
## 40     2011     1          5         3     700    1103            B6
## 41     2011     1          5         3    1544    1954            B6
## 42     2011     1          6         4    1532    1943            B6
## 43     2011     1          7         5     654    1117            B6
## 44     2011     1          7         5    1542    1956            B6
## 45     2011     1          8         6     654    1058            B6
## 46     2011     1          9         7     653    1059            B6
## 47     2011     1          9         7    1618    2057            B6
## 48     2011     1         10         1     656    1102            B6
## 49     2011     1         10         1    1554    2001            B6
## 50     2011     1         11         2     653    1053            B6
## 51     2011     1         11         2      NA      NA            B6
## 52     2011     1         12         3    1532    1953            B6
## 53     2011     1         13         4    1522    1938            B6
## 54     2011     1         14         5     808    1229            B6
## 55     2011     1         14         5    1534    2015            B6
## 56     2011     1         15         6     700    1114            B6
## 57     2011     1         16         7     652    1055            B6
## 58     2011     1         16         7    1551    2004            B6
## 59     2011     1         17         1     730    1135            B6
## 60     2011     1         17         1    1531    1946            B6
## 61     2011     1         18         2     659    1102            B6
## 62     2011     1         18         2    1647    2056            B6
## 63     2011     1         19         3      NA      NA            B6
## 64     2011     1         20         4    1538    1952            B6
## 65     2011     1         21         5     656    1104            B6
## 66     2011     1         21         5    1725    2135            B6
## 67     2011     1         22         6     701    1106            B6
## 68     2011     1         23         7     658    1058            B6
## 69     2011     1         23         7    1535    1933            B6
## 70     2011     1         24         1     707    1059            B6
## 71     2011     1         24         1    1532    1923            B6
## 72     2011     1         25         2     658    1102            B6
## 73     2011     1         25         2    1623    2029            B6
## 74     2011     1         26         3    1535    1941            B6
## 75     2011     1         27         4      NA      NA            B6
## 76     2011     1         28         5     655    1107            B6
## 77     2011     1         28         5    1538    2013            B6
## 78     2011     1         29         6     657    1128            B6
## 79     2011     1         30         7     651    1106            B6
## 80     2011     1         30         7    1659    2118            B6
## 81     2011     1         31         1     659    1111            B6
## 82     2011     1         31         1    1532    1942            B6
## 83     2011     1         31         1     924    1413            CO
## 84     2011     1         31         1    1825    1925            CO
## 85     2011     1         31         1    1554    1650            CO
## 86     2011     1         31         1    1522    1632            CO
## 87     2011     1         31         1    1536    1635            CO
## 88     2011     1         31         1    1916    2103            CO
## 89     2011     1         31         1     747     936            CO
## 90     2011     1         31         1    1803    1927            CO
## 91     2011     1         31         1    1206    1631            CO
## 92     2011     1         31         1    1425    1848            CO
## 93     2011     1         31         1     607    1022            CO
## 94     2011     1         31         1    1041    1449            CO
## 95     2011     1         31         1     728     856            CO
## 96     2011     1         31         1    1433    1629            CO
## 97     2011     1         31         1    1422    1647            CO
## 98     2011     1         31         1    1750    1921            CO
## 99     2011     1         31         1    1442    1842            CO
## 100    2011     1         31         1     851    1052            CO
## 101    2011     1         31         1    1919    2231            CO
## 102    2011     1         31         1    1155    1324            CO
## 103    2011     1         31         1     726     915            CO
## 104    2011     1         31         1    1259    1554            CO
## 105    2011     1         31         1    2116    2344            CO
## 106    2011     1         31         1    1551    2009            CO
## 107    2011     1         31         1    1024    1621            CO
## 108    2011     1         31         1     912    1138            CO
## 109    2011     1         31         1    1020    1421            CO
## 110    2011     1         31         1     916    1336            CO
## 111    2011     1         31         1    1301    1356            CO
## 112    2011     1         31         1    1554    1918            CO
## 113    2011     1         31         1    1850    2211            CO
## 114    2011     1         31         1     727    1120            CO
## 115    2011     1         31         1    1240    1526            CO
## 116    2011     1         31         1    1129    1351            CO
## 117    2011     1         31         1    1615    1741            CO
## 118    2011     1         31         1    1145    1255            CO
## 119    2011     1         31         1     735    1220            CO
## 120    2011     1         31         1    1046    1221            CO
## 121    2011     1         31         1    2102    2216            CO
## 122    2011     1         31         1     854    1137            CO
## 123    2011     1         31         1    1949       2            CO
## 124    2011     1         31         1    1431    1643            CO
## 125    2011     1         31         1    1312    1413            CO
## 126    2011     1         31         1    1248    1628            CO
## 127    2011     1         31         1     742    1217            CO
## 128    2011     1         31         1    1033    1420            CO
## 129    2011     1         31         1    1432    1656            CO
## 130    2011     1         31         1    1320    1420            CO
## 131    2011     1         31         1    1047    1526            CO
## 132    2011     1         31         1    1902    2022            CO
## 133    2011     1         31         1    1316    1643            CO
## 134    2011     1         31         1    1031    1203            CO
## 135    2011     1         31         1     725    1117            CO
## 136    2011     1         31         1    1156    1555            CO
## 137    2011     1         31         1     749    1216            CO
## 138    2011     1         31         1    1701    2036            CO
## 139    2011     1         31         1    1911    2118            CO
## 140    2011     1         31         1    1924    2026            CO
## 141    2011     1         31         1    1909    2254            CO
## 142    2011     1         31         1    1049    1507            CO
## 143    2011     1         31         1      NA      NA            CO
## 144    2011     1         31         1    1925    2202            CO
## 145    2011     1         31         1     554     818            CO
## 146    2011     1         31         1    1250    1638            CO
## 147    2011     1         31         1    2157      53            CO
## 148    2011     1         31         1    1911    2011            CO
## 149    2011     1         31         1    1305    1746            CO
## 150    2011     1         31         1     906    1056            CO
## 151    2011     1         31         1    1148    1327            CO
## 152    2011     1         31         1      NA      NA            CO
## 153    2011     1         31         1     855    1322            CO
## 154    2011     1         31         1    2056    2217            CO
## 155    2011     1         31         1    1738    1939            CO
## 156    2011     1         31         1    1322    1807            CO
## 157    2011     1         31         1    1257    1627            CO
## 158    2011     1         31         1     934    1149            CO
## 159    2011     1         31         1     638    1021            CO
## 160    2011     1         31         1    1146    1421            CO
## 161    2011     1         31         1    1611    1955            CO
## 162    2011     1         31         1     917    1120            CO
## 163    2011     1         31         1    1748    2001            CO
## 164    2011     1         31         1    1901    2332            CO
## 165    2011     1         31         1     740    1052            CO
## 166    2011     1         31         1    2102    2222            CO
## 167    2011     1         31         1    1429    1608            CO
## 168    2011     1         31         1    1313    1516            CO
## 169    2011     1         31         1    1540    1833            CO
## 170    2011     1         31         1    1930    2225            CO
## 171    2011     1         31         1    1429    1542            CO
## 172    2011     1         31         1     714    1103            CO
## 173    2011     1         31         1    1543    1948            CO
## 174    2011     1         31         1    1917    2234            CO
## 175    2011     1         31         1    1915    2248            CO
## 176    2011     1         31         1    1120    1355            CO
## 177    2011     1         31         1    1737    2003            CO
## 178    2011     1         31         1    1550    2012            CO
## 179    2011     1         31         1    1034    1348            CO
## 180    2011     1         31         1    1440    1630            CO
## 181    2011     1         31         1     749    1044            CO
## 182    2011     1         31         1    1807    2030            CO
## 183    2011     1         31         1    1130    1233            CO
## 184    2011     1         31         1    1940    2349            CO
## 185    2011     1         31         1    1239    1409            CO
## 186    2011     1         31         1     906    1058            CO
## 187    2011     1         31         1    1144    1241            CO
## 188    2011     1         31         1    1308    1646            CO
## 189    2011     1         31         1    1423    1652            CO
## 190    2011     1         31         1    2137       9            CO
## 191    2011     1         31         1    1930    2224            CO
## 192    2011     1         31         1    1653    1748            CO
## 193    2011     1         31         1    1440    1731            CO
## 194    2011     1         31         1    2143    2338            CO
## 195    2011     1         31         1     729    1002            CO
## 196    2011     1         31         1     722    1125            CO
## 197    2011     1         31         1    1347    1654            CO
## 198    2011     1         31         1    1012    1351            CO
## 199    2011     1         31         1    1550    1736            CO
## 200    2011     1         31         1     842    1027            CO
## 201    2011     1         31         1    1311    1731            CO
## 202    2011     1         31         1    2105    2311            CO
## 203    2011     1         31         1    1107    1352            CO
## 204    2011     1         31         1    1805    2211            CO
## 205    2011     1         31         1    2120    2323            CO
## 206    2011     1         31         1     725    1040            CO
## 207    2011     1         31         1     851    1241            CO
## 208    2011     1         31         1    1558    1812            CO
## 209    2011     1         31         1    1446    1557            CO
## 210    2011     1         31         1    1754    2056            CO
## 211    2011     1         31         1    1309    1656            CO
## 212    2011     1         31         1    2107    2247            CO
## 213    2011     1         31         1     727     911            CO
## 214    2011     1         31         1    1859    2023            CO
## 215    2011     1         31         1    1900    1953            CO
## 216    2011     1         31         1     934    1149            CO
## 217    2011     1         31         1    1903    2228            CO
## 218    2011     1         31         1    2101    2215            CO
## 219    2011     1         31         1    1229    1540            CO
## 220    2011     1         31         1    1035    1351            CO
## 221    2011     1         31         1    2053    2235            CO
## 222    2011     1         31         1    1048    1354            CO
## 223    2011     1         31         1    1022    1433            CO
## 224    2011     1         31         1    2105    2157            CO
## 225    2011     1         31         1    1918    2247            CO
## 226    2011     1         31         1     920    1116            CO
## 227    2011     1         31         1    1559    1722            CO
## 228    2011     1         31         1    1756    2133            CO
## 229    2011     1         31         1    1900    2142            CO
## 230    2011     1         31         1    1757    1943            CO
## 231    2011     1         31         1    2113    2215            CO
## 232    2011     1         31         1    1434    1539            CO
## 233    2011     1         31         1    1039    1406            CO
## 234    2011     1         31         1    1731    1948            CO
## 235    2011     1         31         1    1312    1615            CO
## 236    2011     1         31         1    1358    1702            CO
## 237    2011     1         31         1    1847    2040            CO
## 238    2011     1         31         1     900    1006            CO
## 239    2011     1         31         1    1901    2203            CO
## 240    2011     1         31         1    1454    1638            CO
## 241    2011     1         31         1     723    1036            CO
## 242    2011     1         31         1    1753    1843            CO
## 243    2011     1         31         1    1153    1353            CO
## 244    2011     1         31         1    1139    1350            CO
## 245    2011     1         31         1    1423    1541            CO
## 246    2011     1         31         1     845     944            CO
## 247    2011     1         31         1    1216    1356            CO
## 248    2011     1         31         1    1743    2141            CO
## 249    2011     1         31         1     850    1004            CO
## 250    2011     1         31         1    2100    2252            CO
## 251    2011     1         31         1    1029    1251            CO
## 252    2011     1         31         1    1604    1910            CO
## 253    2011     1         31         1    1910    2212            CO
## 254    2011     1         31         1    1801    1918            CO
## 255    2011     1         31         1    1548    1956            CO
## 256    2011     1         31         1     913    1028            CO
## 257    2011     1         31         1    1558    1936            CO
## 258    2011     1         31         1    1809    1943            CO
## 259    2011     1         31         1    1030    1341            CO
## 260    2011     1         31         1    1325    1538            CO
## 261    2011     1         31         1    1732    1853            CO
## 262    2011     1         31         1      NA      NA            CO
## 263    2011     1         31         1     911    1144            CO
## 264    2011     1         31         1    1733    1901            CO
## 265    2011     1         31         1    2113    2253            CO
## 266    2011     1         31         1    1008    1145            CO
## 267    2011     1         31         1     753    1032            CO
## 268    2011     1         31         1    1911    2220            CO
## 269    2011     1         31         1    1252    1559            CO
## 270    2011     1         31         1     940    1233            CO
## 271    2011     1         31         1    1926    2318            CO
## 272    2011     1         31         1    1742    1835            CO
## 273    2011     1         31         1     902    1107            CO
## 274    2011     1         31         1    1608    1709            CO
## 275    2011     1         31         1    1317    1623            CO
## 276    2011     1         31         1    1749    1938            CO
## 277    2011     1         31         1    1447    1644            CO
## 278    2011     1         31         1    1027    1136            CO
## 279    2011     1         31         1    1922    2229            CO
## 280    2011     1         31         1    1145    1557            CO
## 281    2011     1         31         1    1232    1637            CO
## 282    2011     1         31         1    1432    1817            CO
## 283    2011     1         31         1    1305    1628            CO
## 284    2011     1         31         1    1737    1947            CO
## 285    2011     1         31         1     904    1217            CO
## 286    2011     1         31         1    1139    1319            CO
## 287    2011     1         31         1    1757    2007            CO
## 288    2011     1         30         7     925    1410            CO
## 289    2011     1         30         7    1829    1930            CO
## 290    2011     1         30         7    1550    1651            CO
## 291    2011     1         30         7    1525    1626            CO
## 292    2011     1         30         7    1532    1633            CO
## 293    2011     1         30         7    1914    2125            CO
## 294    2011     1         30         7     754     953            CO
## 295    2011     1         30         7    1756    1933            CO
## 296    2011     1         30         7    1205    1622            CO
## 297    2011     1         30         7    1443    1851            CO
## 298    2011     1         30         7     600    1014            CO
## 299    2011     1         30         7    1051    1520            CO
## 300    2011     1         30         7     736     843            CO
## 301    2011     1         30         7    1441    1610            CO
## 302    2011     1         30         7    1258    1550            CO
## 303    2011     1         30         7    2128    2252            CO
## 304    2011     1         30         7    1446    1834            CO
## 305    2011     1         30         7     935    1203            CO
## 306    2011     1         30         7    1920    2236            CO
## 307    2011     1         30         7    1200    1326            CO
## 308    2011     1         30         7     559     717            CO
## 309    2011     1         30         7    1305    1606            CO
## 310    2011     1         30         7    2200      19            CO
## 311    2011     1         30         7    1607    2033            CO
## 312    2011     1         30         7    1022    1615            CO
## 313    2011     1         30         7     900    1101            CO
## 314    2011     1         30         7    1024    1429            CO
## 315    2011     1         30         7     923    1339            CO
## 316    2011     1         30         7    1304    1408            CO
## 317    2011     1         30         7    1555    1943            CO
## 318    2011     1         30         7    1848    2224            CO
## 319    2011     1         30         7    1236    1500            CO
## 320    2011     1         30         7    1143    1359            CO
## 321    2011     1         30         7    1550    1712            CO
## 322    2011     1         30         7    1144    1248            CO
## 323    2011     1         30         7    1047    1200            CO
## 324    2011     1         30         7    2112    2301            CO
## 325    2011     1         30         7     848    1104            CO
## 326    2011     1         30         7    1925       5            CO
## 327    2011     1         30         7    1433    1622            CO
## 328    2011     1         30         7    1315    1425            CO
## 329    2011     1         30         7    1305    1702            CO
## 330    2011     1         30         7    1130    1326            CO
## 331    2011     1         30         7    1031    1426            CO
## 332    2011     1         30         7    1459    1715            CO
## 333    2011     1         30         7    1316    1425            CO
## 334    2011     1         30         7    1046    1518            CO
## 335    2011     1         30         7    1801    1940            CO
## 336    2011     1         30         7    1315    1639            CO
## 337    2011     1         30         7    1026    1158            CO
## 338    2011     1         30         7     722    1054            CO
## 339    2011     1         30         7    1157    1607            CO
## 340    2011     1         30         7     745    1209            CO
## 341    2011     1         30         7    1706    2050            CO
## 342    2011     1         30         7    1813    2046            CO
## 343    2011     1         30         7    2004    2128            CO
## 344    2011     1         30         7    1919    2335            CO
## 345    2011     1         30         7    1043    1509            CO
## 346    2011     1         30         7    1855    2044            CO
## 347    2011     1         30         7    1930    2230            CO
## 348    2011     1         30         7    1255    1644            CO
## 349    2011     1         30         7    2141      10            CO
## 350    2011     1         30         7    1912    2032            CO
## 351    2011     1         30         7    1319    1811            CO
## 352    2011     1         30         7     916    1032            CO
## 353    2011     1         30         7    1151    1331            CO
## 354    2011     1         30         7    1934    2318            CO
## 355    2011     1         30         7     855    1319            CO
## 356    2011     1         30         7    2106    2212            CO
## 357    2011     1         30         7    1748    1954            CO
## 358    2011     1         30         7    1350    1749            CO
## 359    2011     1         30         7    1302    1657            CO
## 360    2011     1         30         7     926    1125            CO
## 361    2011     1         30         7     735    1114            CO
## 362    2011     1         30         7    1142    1444            CO
## 363    2011     1         30         7    1609    2001            CO
## 364    2011     1         30         7    1749    2011            CO
## 365    2011     1         30         7    1909      23            CO
## 366    2011     1         30         7     800    1059            CO
## 367    2011     1         30         7    2100    2229            CO
## 368    2011     1         30         7    1420    1540            CO
## 369    2011     1         30         7    1312    1451            CO
## 370    2011     1         30         7    1539    1832            CO
## 371    2011     1         30         7    1910    2215            CO
## 372    2011     1         30         7    1428    1533            CO
## 373    2011     1         30         7    1548    1958            CO
## 374    2011     1         30         7    1921    2321            CO
## 375    2011     1         30         7    1908    2300            CO
## 376    2011     1         30         7    1124    1316            CO
## 377    2011     1         30         7    1744    2008            CO
## 378    2011     1         30         7    1931    2159            CO
## 379    2011     1         30         7    1553    2030            CO
## 380    2011     1         30         7    1034    1356            CO
## 381    2011     1         30         7    1452    1610            CO
## 382    2011     1         30         7    1806    2109            CO
## 383    2011     1         30         7    1132    1233            CO
## 384    2011     1         30         7    1904    2324            CO
## 385    2011     1         30         7    1239    1408            CO
## 386    2011     1         30         7     905    1032            CO
## 387    2011     1         30         7    1141    1251            CO
## 388    2011     1         30         7    1320    1712            CO
## 389    2011     1         30         7    1455    1727            CO
## 390    2011     1         30         7    2135    2346            CO
## 391    2011     1         30         7    2026    2335            CO
## 392    2011     1         30         7     906    1046            CO
## 393    2011     1         30         7    1653    1757            CO
## 394    2011     1         30         7    1516    1741            CO
## 395    2011     1         30         7    2100    2320            CO
## 396    2011     1         30         7     729     936            CO
## 397    2011     1         30         7    1342    1648            CO
## 398    2011     1         30         7    1102    1443            CO
## 399    2011     1         30         7    1540    1728            CO
## 400    2011     1         30         7     845    1015            CO
## 401    2011     1         30         7    1319    1752            CO
## 402    2011     1         30         7    2106    2259            CO
## 403    2011     1         30         7    1053    1411            CO
## 404    2011     1         30         7    1812    2234            CO
## 405    2011     1         30         7    2108    2345            CO
## 406    2011     1         30         7     727    1040            CO
## 407    2011     1         30         7     851    1230            CO
## 408    2011     1         30         7    1603    1820            CO
## 409    2011     1         30         7    1441    1534            CO
## 410    2011     1         30         7    1700    2002            CO
## 411    2011     1         30         7    1304    1642            CO
## 412    2011     1         30         7    2105    2302            CO
## 413    2011     1         30         7     725     839            CO
## 414    2011     1         30         7    1931    2109            CO
## 415    2011     1         30         7    1922    2032            CO
## 416    2011     1         30         7     915    1128            CO
## 417    2011     1         30         7    1904    2305            CO
## 418    2011     1         30         7    2123    2223            CO
## 419    2011     1         30         7    1037    1406            CO
## 420    2011     1         30         7    2050    2227            CO
## 421    2011     1         30         7    1127    1559            CO
## 422    2011     1         30         7    2104    2200            CO
## 423    2011     1         30         7    1924    2357            CO
## 424    2011     1         30         7     927    1113            CO
## 425    2011     1         30         7    1616    1731            CO
## 426    2011     1         30         7    1915    2215            CO
## 427    2011     1         30         7    1805    2019            CO
## 428    2011     1         30         7    1444    1536            CO
## 429    2011     1         30         7    1011    1348            CO
## 430    2011     1         30         7    1755    2034            CO
## 431    2011     1         30         7    1323    1639            CO
## 432    2011     1         30         7    1813    1914            CO
## 433    2011     1         30         7    1402    1707            CO
## 434    2011     1         30         7    1900    2132            CO
## 435    2011     1         30         7     858     950            CO
## 436    2011     1         30         7    1919    2242            CO
## 437    2011     1         30         7    1451    1628            CO
## 438    2011     1         30         7     724    1028            CO
## 439    2011     1         30         7    1757    2206            CO
## 440    2011     1         30         7    1319    1515            CO
## 441    2011     1         30         7    1137    1351            CO
## 442    2011     1         30         7    1418    1538            CO
## 443    2011     1         30         7     839     940            CO
## 444    2011     1         30         7    1235    1431            CO
## 445    2011     1         30         7    1750    2203            CO
## 446    2011     1         30         7    2057    2258            CO
## 447    2011     1         30         7    1029    1251            CO
## 448    2011     1         30         7    1647    1956            CO
## 449    2011     1         30         7    1918    2250            CO
## 450    2011     1         30         7    1747    1904            CO
## 451    2011     1         30         7    1605    2006            CO
## 452    2011     1         30         7     928    1031            CO
## 453    2011     1         30         7    1555    1958            CO
## 454    2011     1         30         7    1802    1955            CO
## 455    2011     1         30         7    1032    1354            CO
## 456    2011     1         30         7    1345    1547            CO
## 457    2011     1         30         7    1752    1907            CO
## 458    2011     1         30         7    1909    2057            CO
## 459    2011     1         30         7    1750    1913            CO
## 460    2011     1         30         7    2234       2            CO
## 461    2011     1         30         7     935    1105            CO
## 462    2011     1         30         7    2057    2140            CO
## 463    2011     1         30         7     722     943            CO
## 464    2011     1         30         7    1944    2324            CO
## 465    2011     1         30         7    1249    1550            CO
## 466    2011     1         30         7     930    1149            CO
## 467    2011     1         30         7    1937      13            CO
## 468    2011     1         30         7    1749    1842            CO
## 469    2011     1         30         7     857    1040            CO
## 470    2011     1         30         7    1704    1805            CO
## 471    2011     1         30         7    1332    1644            CO
## 472    2011     1         30         7    1803    1954            CO
## 473    2011     1         30         7    1453    1632            CO
## 474    2011     1         30         7    1038    1214            CO
## 475    2011     1         30         7    1924    2310            CO
## 476    2011     1         30         7    1146    1629            CO
##        FlightNum TailNum ActualElapsedTime AirTime ArrDelay DepDelay
## 1            731  N614AS               282     255       -4       -1
## 2            731  N627AS               280     257       -7       -2
## 3            731  N627AS               280     260       -3        2
## 4            731  N618AS               287     268       22       20
## 5            731  N607AS               288     273       -1       -4
## 6            731  N624AS               299     278       23        9
## 7            731  N611AS               295     274        8       -2
## 8            731  N607AS               290     269        2       -3
## 9            731  N609AS               290     253       78       73
## 10           731  N626AS               339     315       49       -5
## 11           731  N626AS                NA      NA       NA       -5
## 12           731  N619AS               307     284       19       -3
## 13           731  N627AS               293     273        3       -5
## 14           731  N627AS               296     270        4       -7
## 15           731  N627AS               309     287       21       -3
## 16           731  N627AS               316     291       28       -3
## 17           731  N612AS               331     310       39       -7
## 18           731  N617AS               294     276       20       11
## 19           731  N622AS               282     265       -8       -5
## 20           731  N622AS               313     284       25       -3
## 21           731  N622AS               309     288       26        2
## 22           731  N644AS               284     269      -10       -9
## 23           731  N624AS               286     269       -6       -7
## 24           731  N644AS               285     251       -1       -1
## 25           731  N607AS               275     255       -9        1
## 26           731  N607AS               285     255        5        5
## 27           731  N627AS               278     262        0        7
## 28           731  N627AS               271     256      -18       -4
## 29           731  N627AS               261     246      -28       -4
## 30           731  N627AS               307     264       18       -4
## 31           731  N607AS               284     259        1        2
## 32           620  N324JB               210     181        5       -6
## 33           622  N324JB               211     188       61       54
## 34           620  N324JB               190     172       -6        3
## 35           622  N324JB               216     176       31       19
## 36           620  N229JB               181     166      -19       -1
## 37           622  N206JB               179     165      111      136
## 38           620  N267JB               189     168      -16       -6
## 39           622  N267JB               206     175       25       23
## 40           620  N708JB               183     167      -14        0
## 41           624  N644JB               190     166       -6        9
## 42           624  N641JB               191     175      -17       -3
## 43           620  N641JB               203     172        0       -6
## 44           624  N564JB               194     175       -4        7
## 45           620  N630JB               184     162      -19       -6
## 46           620  N599JB               186     163      -18       -7
## 47           624  N625JB               219     196       57       43
## 48           620  N625JB               186     166      -15       -4
## 49           624  N504JB               187     170        1       19
## 50           620  N504JB               180     161      -24       -7
## 51           624  N537JB                NA      NA       NA       NA
## 52           624  N504JB               201     177       -7       -3
## 53           624  N597JB               196     178      -22      -13
## 54           620  N597JB               201     185       72       68
## 55           624  N729JB               221     189       15       -1
## 56           620  N503JB               194     173       -3        0
## 57           620  N706JB               183     166      -22       -8
## 58           624  N565JB               193     176        4       16
## 59           620  N523JB               185     168       18       30
## 60           624  N779JB               195     173      -14       -4
## 61           620  N779JB               183     162      -15       -1
## 62           624  N729JB               189     164       56       72
## 63           624  N504JB                NA      NA       NA       NA
## 64           624  N760JB               194     161       -8        3
## 65           620  N760JB               188     164      -13       -4
## 66           624  N598JB               190     173       95      110
## 67           620  N527JB               185     161      -11        1
## 68           620  N580JB               180     162      -19       -2
## 69           624  N599JB               178     164      -27        0
## 70           620  N605JB               172     156      -18        7
## 71           624  N536JB               171     156      -37       -3
## 72           620  N589JB               184     162      -15       -2
## 73           624  N621JB               186     167       29       48
## 74           624  N659JB               186     165      -19        0
## 75           624  N569JB                NA      NA       NA       NA
## 76           620  N594JB               192     172      -10       -5
## 77           624  N655JB               215     196       13        3
## 78           620  N508JB               211     180       11       -3
## 79           620  N606JB               195     175      -11       -9
## 80           624  N606JB               199     176       78       84
## 81           620  N661JB               192     172       -6       -1
## 82           624  N629JB               190     169      -18       -3
## 83             1  N69063               529     492       23       -1
## 84             5  N17245                60      42       -9        0
## 85             6  N77520                56      40       -5       -1
## 86            33  N16647                70      42       -2       -3
## 87            35  N35204                59      32        7        1
## 88            47  N76522               227     199        2        6
## 89            52  N67134               229     201        5        2
## 90            59  N57870               144     116       15       28
## 91            60  N68159               205     165       -2        1
## 92            62  N17126               203     163       -9        0
## 93            89  N76529               195     175        2        7
## 94           106  N66051               188     162      -26       -4
## 95           128  N75436                88      49       18       -2
## 96           137  N73283               236     199       14        5
## 97           146  N57862               145     114       64       77
## 98           150  N34282               211     189        6       15
## 99           158  N13750               180     142        7       -3
## 100          170  N35407               241     225      -27        1
## 101          190  N35260               132     107      -12       -1
## 102          197  N75853               209     172        3        0
## 103          199  N14228               169     128        8        1
## 104          206  N39418               115      91      -10       -1
## 105          209  N24715               268     256      -15       -7
## 106          210  N37408               198     166      -15        1
## 107          212  N53441               237     215       -4        9
## 108          220  N33132               206     161       32        7
## 109          226  N19621               181     161        2        0
## 110          232  N33266               200     165      -15       -4
## 111          241  N14629                55      27       -2       -4
## 112          244  N37274               144     121      -16        9
## 113          250  N59630               141     121      -18        0
## 114          258  N77520               173     145       -1       -3
## 115          267  N45440               286     263        7        5
## 116          270  N37420               262     228        1        4
## 117          275  N14242               146     122       16       25
## 118          279  N37274                70      45        4        0
## 119          282  N79279               225     195        4        0
## 120          297  N27421               215     190       13       11
## 121          299  N17244               134     119      -10        8
## 122          309  N33294               283     254        8        4
## 123          310  N77867               193     164       33       49
## 124          320  N39416               192     159       12        1
## 125          323  N36207                61      44      -10       -3
## 126          326  N38257               160     143      -16       -2
## 127          332  N73276               215     177        4       -3
## 128          358  N39728               167     146       -5       -2
## 129          370  N27213               264     229        5        7
## 130          379  N19638                60      39       -2        0
## 131          382  N36272               219     188       -5       -3
## 132          397  N33286               200     182       20       28
## 133          400  N39415               147     109        6        1
## 134          403  N35271               212     194       -1        1
## 135          404  N78501               172     146       -5       -5
## 136          406  N73270               179     143        3       -4
## 137          408  N66056               207     170        1       -1
## 138          410  N73299               155     138      -19       -2
## 139          421  N37298               247     231       80       91
## 140          423  N33266                62      41       -8       -1
## 141          426  N78506               165     143      -12       -1
## 142          432  N16713               198     169        1        4
## 143          442                        NA      NA       NA       NA
## 144          444  N76514               157     117        3        5
## 145          446  N26208               144     117      -16       -6
## 146          458  N17233               168     149       -7       -5
## 147          467  N78285               296     276       58       42
## 148          479  N16217                60      43       -8       -2
## 149          482  N78509               221     190       -3        0
## 150          497  N74856               230     187       23        1
## 151          499  N37267               159     127        2       -2
## 152          500                        NA      NA       NA       NA
## 153          510  N38268               207     183        2        0
## 154          511  N77520                81      60        5        1
## 155          520  N75432               181     161       -2       -2
## 156          532  N76269               225     178       22        2
## 157          534  N79402               150     125      -16       -3
## 158          542  N75436               195     174        2        4
## 159          544  N13624               163     136       -8       -7
## 160          546  N77518               155     116       -1        1
## 161          558  N16709               164     143      -11       -4
## 162          559  N76515               243     202       15        2
## 163          570  N75436               253     236       -4        3
## 164          582  N19621               211     188       -1        6
## 165          586  N17126               132     102       -7       -5
## 166          597  N33203               200     179      -10        0
## 167          599  N57864               159     124        6        3
## 168          601  N26208               183     131       36        9
## 169          606  N77510               113      90      -11        0
## 170          616  N33294               175     139       24       20
## 171          623  N77261                73      44        5       -1
## 172          626  N16647               169     154      -17       -6
## 173          632  N12238               185     166      -25       -2
## 174          644  N37267               137     116       -3       22
## 175          658  N37273               153     128       -6       10
## 176          663  N14115               215     195       33       -5
## 177          667  N57869               266     249        0       12
## 178          682  N78501               202     180      -25        0
## 179          686  N56859               134     105        0       -1
## 180          697  N37293               230     191       20        0
## 181          706  N23708               115      92      -11       -1
## 182          709  N37409               263     245      -13        2
## 183          723  N77510                63      44       -8       -5
## 184          732  N33262               189     157       44       50
## 185          738  N38403               210     194       -3       -1
## 186          739  N75432               232     193       16        1
## 187          741  N37290                57      32        0       -1
## 188          744  N76254               158     125       -7       -2
## 189          746  N78524               149     114       -8        3
## 190          752  N73278               212     189       10       -2
## 191          755  N11641               114      89      -10       -1
## 192          763  N73291                55      42      -15       -2
## 193          767  N37422               291     255       12        5
## 194          770  N37281               235     224       24       50
## 195          771  N26226               273     237        2       -1
## 196          776  N37252               183     155      -11       -3
## 197          786  N75851               127     105        6       12
## 198          788  N46625               159     132      -12       -4
## 199          795  N76502               226     198        8       10
## 200          799  N57855               165     133        0       -3
## 201          810  N78003               200     168       -4        1
## 202          820  N37255               186     158       19       10
## 203         1006  N18220               105      89       -2       17
## 204         1010  N73259               186     161       -9       15
## 205         1046  N79402               123     106       -4       25
## 206         1048  N73283               135     107       -8        0
## 207         1058  N24702               170     149       -7       -2
## 208         1070  N73406               254     231       -8       -2
## 209         1079  N14230                71      40       10        1
## 210         1086  N57855               122     100       97      114
## 211         1088  N14219               167     127        3        4
## 212         1095  N73270               220     201        7       12
## 213         1097  N14231               224     192       14       -3
## 214         1099  N75858               144     121       -9       -1
## 215         1411  N14604                53      31       -9       -5
## 216         1416  N33262               255     238       15       19
## 217         1417  N46625               145     126      -32       -2
## 218         1423  N62631                74      42        4       -4
## 219         1427  N11641               131     113      -15        0
## 220         1448  N75429               136     108      -16       -5
## 221         1459  N87513               222     201        2        3
## 222         1462  N16617               126      98      -25       -8
## 223         1476  N76503               191     158       -1        0
## 224         1479  N33264                52      37       -7        1
## 225         1488  N16701               149     121      -24       -2
## 226         1495  N77867               236     195        5       -5
## 227         1497  N75425               203     181      -10       -1
## 228         1499  N77295               157     138      -13        0
## 229         1506  N35407               102      89      -24        0
## 230         1511  N14704               226     203       -9       -3
## 231         1533  N72405                62      30       20       13
## 232         1541  N16646                65      30       15        4
## 233         1544  N14613               147     128        5       24
## 234         1546  N37253               137     114      -17        3
## 235         1548  N32404               123     106      -24       -3
## 236         1562  N76516               124     101       27       33
## 237         1568  N17627               113      87      -16       -3
## 238         1583  N36207                66      32       10        0
## 239         1586  N75428               122     103       -9        6
## 240         1589  N34222               224     189       21       12
## 241         1590  N27213               133     106      -12       -2
## 242         1603  N77525                50      29       -8       -2
## 243         1605  N37255               240     207       18        3
## 244         1620  N75433               191     163       11        4
## 245         1621  N16701                78      58        1        3
## 246         1623  N38727                59      42       -9        0
## 247         1629  N39726               220     198      -11       -4
## 248         1632  N24702               178     161      -19        0
## 249         1639  N18622                74      55       -4        0
## 250         1644  N76504               232     217      -13       10
## 251         1646  N37409               142     116      -12       -1
## 252         1648  N37252               126     106      -21       -1
## 253         1662  N17229               122      97       -9        0
## 254         1674  N16646               137     109       12        8
## 255         1676  N36280               188     159       -1        3
## 256         1679  N14219                75      39       -2      -12
## 257         1688  N27610               158     128      -17       -2
## 258         1689  N12225               214     192        6       12
## 259         1690  N77295               131     105      -22       -5
## 260         1695  N26210               253     212       32       10
## 261         1705  N16649                81      56       -1       -3
## 262         1711                        NA      NA       NA       NA
## 263         1714  N37273               273     235        8       -4
## 264         1715  N19638               148     120       -4       -2
## 265         1717  N77296               220     194       20       13
## 266         1723  N77296               217     202       -3       -2
## 267         1746  N35204               159     117       32       28
## 268         1748  N75433               129     108      -11        6
## 269         1757  N18622               127      85        0        2
## 270         1767  N87513               293     266       19       10
## 271         1776  N76503               172     142      -10       11
## 272         1779  N37277                53      35       -5        3
## 273         1783  N18223               185     154       11        2
## 274         1787  N18223                61      41        2       13
## 275         1790  N37281               126     105      -17       -3
## 276         1795  N73860               229     200        6        4
## 277         1821  N14731               237     199       14        7
## 278         1823  N16646                69      42       -3       -3
## 279         1830  N39423               127     103      -18       -3
## 280         1832  N78285               192     172      -13        0
## 281         1836  N73278               185     153       -9        2
## 282         1844  N24706               165     128       -4       -3
## 283         1850  N19623               143     121       -4       10
## 284         1858  N26226               130     104       -6       -1
## 285         1873  N14242               133     101      -11       -6
## 286         1882  N17620               160     140      -13        9
## 287         1889  N21723               250     228        6       17
## 288            1  N76064               525     493       20        0
## 289            5  N35271                61      43       -4        4
## 290            6  N17627                61      38       -4       -5
## 291           33  N17620                61      43       -8        0
## 292           35  N16649                61      32        5       -3
## 293           47  N77520               251     203       23        3
## 294           52  N13113               239     201       22        9
## 295           59  N57862               157     120       21       21
## 296           60  N76156               197     171      -11        0
## 297           62  N19130               188     164       -6       18
## 298           89  N26215               194     171        2        0
## 299          106  N67058               209     167       13        6
## 300          128  N54711                67      40        5        6
## 301          137  N18223               209     185       -5       13
## 302          146  N57855               172     119        7       -7
## 303          150  N37281               204     188       15       31
## 304          158  N33714               168     147       -1        1
## 305          170  N57439               268     230       49       45
## 306          190  N37267               136     107       -7        0
## 307          197  N57863               206     162       10        5
## 308          199  N14250               138     119      -20       -1
## 309          206  N37434               121      93        2        5
## 310          209  N15710               259     244       20       37
## 311          210  N79402               206     169        9       17
## 312          212  N53441               233     212       -5        7
## 313          220  N29124               181     153        0       -5
## 314          226  N14613               185     153       15        4
## 315          232  N77510               196     172       -7        3
## 316          241  N14645                64      31       10       -1
## 317          244  N16647               168     136        9       10
## 318          250  N73259               156     126       -1       -2
## 319          267  N27205               264     241      -19        1
## 320          270  N75428               256     227       14       18
## 321          275  N37252               142     121      -13        0
## 322          279  N38257                64      39        2       -1
## 323          297  N75426               193     175      -15        0
## 324          299  N12225               169     119       35       18
## 325          309  N77520               256     239      -20       -2
## 326          310  N57869               220     161       36       25
## 327          320  N78438               169     152       -9        3
## 328          323  N33262                70      43        2        0
## 329          326  N12225               177     144       18       15
## 330          352  N23721               176     127       14       -5
## 331          358  N37274               175     139        6       -4
## 332          370  N14231               256     233       24       34
## 333          379  N14604                69      36        3       -4
## 334          382  N76269               212     190       -8       -4
## 335          397  N37287               219     179       10       -1
## 336          400  N19638               144     103       -1        0
## 337          403  N14230               212     190       -1       -4
## 338          404  N37252               152     135      -28       -8
## 339          406  N18243               190     144       15       -3
## 340          408  N76062               204     180        2       -5
## 341          410  N73270               164     145       -5        3
## 342          421  N36280               273     231       48       33
## 343          423  N16632                84      40       54       39
## 344          426  N17245               196     151       29        9
## 345          432  N13750               206     171        8       -2
## 346          442  N16646               109      64       22        0
## 347          444  N27421               180     142       31       10
## 348          458  N33284               169     144       -1        0
## 349          467  N75428               269     249       15       26
## 350          479  N73276                80      37       16        2
## 351          482  N77525               232     185       22       14
## 352          497  N75858               196     170       -1        6
## 353          499  N12221               160     114       11        1
## 354          500  N79521               164     113       28        9
## 355          510  N75425               204     172        7        0
## 356          511  N54711                66      53        0       11
## 357          520  N47414               186     159       13        8
## 358          532  N35260               179     163        4       30
## 359          534  N37409               175     143       14        2
## 360          542  N79279               179     155      -17       -4
## 361          544  N18622               159     135      -10      -10
## 362          546  N11206               182     127       27       -3
## 363          558  N21723               172     146       -5       -6
## 364          570  N35407               262     232        6        4
## 365          582  N16642               254     198       50       14
## 366          586  N19130               119      99        5       15
## 367          597  N36444               209     178        1        2
## 368          599  N74856               140     118      -20       -4
## 369          601  N76529               159     118       11        8
## 370          606  N76523               113      93      -12       -1
## 371          616  N18220               185     145       14        0
## 372          623  N36272                65      42       -4       -2
## 373          632  N76522               190     169      -15        3
## 374          644  N12221               180     131       44       26
## 375          658  N37274               172     144        6        3
## 376          663  N13110               172     147       -1       -1
## 377          667  N75851               264     239        5       19
## 378          670  N76504               268     228       41       41
## 379          682  N26215               217     194       -7        3
## 380          686  N75851               142     101       13       -1
## 381          697  N38403               198     177        0       12
## 382          709  N32404               303     255       26        1
## 383          723  N78524                61      43       -3       -3
## 384          732  N36272               200     170       19       14
## 385          738  N76515               209     190       -4       -1
## 386          739  N47414               207     185       -5        0
## 387          741  N76523                70      30       15       -4
## 388          744  N16709               172     128       19       10
## 389          746  N87527               152     120       22       30
## 390          752  N37298               191     167      -13       -4
## 391          755  N17620               129      90       61       55
## 392          756  N76519               220     197      -14       -9
## 393          763  N37281                64      43       -6       -2
## 394          767  N75432               265     247        2       21
## 395          770  N37293               260     231        9       10
## 396          771  N32404               247     229      -22       -1
## 397          786  N75853               126     107        0        7
## 398          788  N39728               161     138        0       -3
## 399          795  N26226               228     204        0        0
## 400          799  N77867               150     121       -7        0
## 401          810  N74007               213     175       17        9
## 402          820  N37409               173     150        7       11
## 403         1006  N73299               138      93       22        3
## 404         1010  N14653               202     171        8       22
## 405         1046  N75853               157     126       18       13
## 406         1048  N87527               133     111       -3        2
## 407         1058  N39726               159     145      -13       -2
## 408         1070  N73406               257     224        0        3
## 409         1079  N79521                53      39      -13       -4
## 410         1086  N77867               122     100       43       60
## 411         1088  N54711               158     128      -11       -1
## 412         1095  N18243               237     203       22       10
## 413         1097  N76522               194     176      -13       -5
## 414         1099  N77510               158     122       37       31
## 415         1411  N38268                70      30       30       17
## 416         1416  N73276               253     234       -1        0
## 417         1417  N59630               181     138        5       -1
## 418         1423  N53441                60      43       12       18
## 419         1448  N17719               149     111        4       -3
## 420         1459  N76516               217     201       -6        0
## 421         1476  N16632               212     187       82       63
## 422         1479  N33284                56      34       -4        0
## 423         1488  N23721               213     141       46        4
## 424         1495  N39418               226     194        7        2
## 425         1497  N78501               195     174       -1       16
## 426         1506  N77430               120      89        9       15
## 427         1511  N14731               254     204       27        5
## 428         1541  N14653                52      31       12       14
## 429         1544  N32626               157     134       -6       -4
## 430         1546  N79279               159     125       29       27
## 431         1548  N37408               136     109        0        8
## 432         1558  N77295                61      30       23       18
## 433         1562  N76516               125     106        7       12
## 434         1568  N14613               152      96       36       10
## 435         1583  N38417                52      31       -1       -2
## 436         1586  N37420               143     101       30       24
## 437         1589  N76254               217     195       11        9
## 438         1590  N21723               124     107      -20       -1
## 439         1603  N73299               189     151       21        2
## 440         1605  N38417               236     198       51       40
## 441         1620  N37420               194     153       17        2
## 442         1621  N16646                80      55       -2       -2
## 443         1623  N37409                61      42       -8       -6
## 444         1629  N15710               236     218       19       10
## 445         1632  N39726               193     172        3        7
## 446         1644  N73283               241     220       -7        7
## 447         1646  N35407               142     115       -7       -1
## 448         1648  N38257               129     112      -15        2
## 449         1662  N34222               152      99       29        8
## 450         1674  N11641               137     108       -2       -6
## 451         1676  N75433               181     154        9       20
## 452         1679  N76288                63      40        1       -2
## 453         1688  N16617               183     155        5       -5
## 454         1689  N14237               233     201       18        5
## 455         1690  N37255               142     109       -4       -3
## 456         1695  N76505               242     211       26       15
## 457         1705  N76503                75      55       -5       -1
## 458         1711  N16649               108      59       28        8
## 459         1715  N19621               143     124        8       15
## 460         1717  N38417               208     195       89       94
## 461         1723  N35271               210     193       -8       -1
## 462         1728  N37408                43      27      -15       -3
## 463         1746  N38403               141     115      -12       -3
## 464         1748  N57439               160     107       53       39
## 465         1757  N16642               121      88       -9       -1
## 466         1767  N37293               259     237      -20        0
## 467         1776  N14219               216     156       45       22
## 468         1779  N33262                53      34        2       10
## 469         1783  N17229               163     138      -11       -3
## 470         1787  N17614                61      38       58       69
## 471         1790  N73283               132     109        4       12
## 472         1795  N57852               231     203       22       18
## 473         1821  N24715               219     200        2       13
## 474         1823  N14653                96      44       35        3
## 475         1830  N30401               166     105       23       -1
## 476         1832  N33266               223     173       24        1
##        Origin Dest Distance TaxiIn TaxiOut Cancelled CancellationCode
## 1         IAH  SEA     1874      7      20         0                 
## 2         IAH  SEA     1874      7      16         0                 
## 3         IAH  SEA     1874      4      16         0                 
## 4         IAH  SEA     1874      8      11         0                 
## 5         IAH  SEA     1874      5      10         0                 
## 6         IAH  SEA     1874      3      18         0                 
## 7         IAH  SEA     1874      7      14         0                 
## 8         IAH  SEA     1874      6      15         0                 
## 9         IAH  SEA     1874      5      32         0                 
## 10        IAH  SEA     1874      4      20         0                 
## 11        IAH  SEA     1874      4      18         0                 
## 12        IAH  SEA     1874      5      18         0                 
## 13        IAH  SEA     1874      5      15         0                 
## 14        IAH  SEA     1874      7      19         0                 
## 15        IAH  SEA     1874      4      18         0                 
## 16        IAH  SEA     1874      5      20         0                 
## 17        IAH  SEA     1874      4      17         0                 
## 18        IAH  SEA     1874      4      14         0                 
## 19        IAH  SEA     1874      7      10         0                 
## 20        IAH  SEA     1874      3      26         0                 
## 21        IAH  SEA     1874      7      14         0                 
## 22        IAH  SEA     1874      4      11         0                 
## 23        IAH  SEA     1874      5      12         0                 
## 24        IAH  SEA     1874      3      31         0                 
## 25        IAH  SEA     1874      4      16         0                 
## 26        IAH  SEA     1874      6      24         0                 
## 27        IAH  SEA     1874      5      11         0                 
## 28        IAH  SEA     1874      3      12         0                 
## 29        IAH  SEA     1874      3      12         0                 
## 30        IAH  SEA     1874      6      37         0                 
## 31        IAH  SEA     1874      6      19         0                 
## 32        HOU  JFK     1428      6      23         0                 
## 33        HOU  JFK     1428     12      11         0                 
## 34        HOU  JFK     1428      6      12         0                 
## 35        HOU  JFK     1428      9      31         0                 
## 36        HOU  JFK     1428      3      12         0                 
## 37        HOU  JFK     1428      5       9         0                 
## 38        HOU  JFK     1428      9      12         0                 
## 39        HOU  JFK     1428      8      23         0                 
## 40        HOU  JFK     1428      4      12         0                 
## 41        HOU  JFK     1428     14      10         0                 
## 42        HOU  JFK     1428      7       9         0                 
## 43        HOU  JFK     1428      6      25         0                 
## 44        HOU  JFK     1428      9      10         0                 
## 45        HOU  JFK     1428      9      13         0                 
## 46        HOU  JFK     1428      3      20         0                 
## 47        HOU  JFK     1428     11      12         0                 
## 48        HOU  JFK     1428      4      16         0                 
## 49        HOU  JFK     1428      7      10         0                 
## 50        HOU  JFK     1428      5      14         0                 
## 51        HOU  JFK     1428     NA      NA         1                B
## 52        HOU  JFK     1428      8      16         0                 
## 53        HOU  JFK     1428      8      10         0                 
## 54        HOU  JFK     1428      7       9         0                 
## 55        HOU  JFK     1428      8      24         0                 
## 56        HOU  JFK     1428      4      17         0                 
## 57        HOU  JFK     1428      4      13         0                 
## 58        HOU  JFK     1428      5      12         0                 
## 59        HOU  JFK     1428      4      13         0                 
## 60        HOU  JFK     1428      7      15         0                 
## 61        HOU  JFK     1428      6      15         0                 
## 62        HOU  JFK     1428      4      21         0                 
## 63        HOU  JFK     1428     NA      NA         1                A
## 64        HOU  JFK     1428     16      17         0                 
## 65        HOU  JFK     1428      5      19         0                 
## 66        HOU  JFK     1428      6      11         0                 
## 67        HOU  JFK     1428      3      21         0                 
## 68        HOU  JFK     1428      6      12         0                 
## 69        HOU  JFK     1428      6       8         0                 
## 70        HOU  JFK     1428      4      12         0                 
## 71        HOU  JFK     1428      4      11         0                 
## 72        HOU  JFK     1428      8      14         0                 
## 73        HOU  JFK     1428      7      12         0                 
## 74        HOU  JFK     1428      6      15         0                 
## 75        HOU  JFK     1428     NA      NA         1                B
## 76        HOU  JFK     1428      4      16         0                 
## 77        HOU  JFK     1428      7      12         0                 
## 78        HOU  JFK     1428      7      24         0                 
## 79        HOU  JFK     1428      8      12         0                 
## 80        HOU  JFK     1428     13      10         0                 
## 81        HOU  JFK     1428      8      12         0                 
## 82        HOU  JFK     1428      9      12         0                 
## 83        IAH  HNL     3904      6      31         0                 
## 84        IAH  MSY      305      3      15         0                 
## 85        IAH  SAT      191      2      14         0                 
## 86        IAH  MSY      305      7      21         0                 
## 87        IAH  AUS      140      7      20         0                 
## 88        IAH  LAX     1379      8      20         0                 
## 89        IAH  LAX     1379     11      17         0                 
## 90        IAH  DEN      862     12      16         0                 
## 91        IAH  EWR     1400     29      11         0                 
## 92        IAH  EWR     1400     16      24         0                 
## 93        IAH  EWR     1400      6      14         0                 
## 94        IAH  EWR     1400      8      18         0                 
## 95        IAH  MSY      305      6      33         0                 
## 96        IAH  LAX     1379     10      27         0                 
## 97        IAH  ORD      925     15      16         0                 
## 98        IAH  ONT     1334      5      17         0                 
## 99        IAH  DCA     1208      4      34         0                 
## 100       IAH  SFO     1635      6      10         0                 
## 101       IAH  MIA      964      5      20         0                 
## 102       IAH  LAS     1222      8      29         0                 
## 103       IAH  DEN      862     12      29         0                 
## 104       IAH  TPA      787      4      20         0                 
## 105       IAH  PDX     1825      4       8         0                 
## 106       IAH  EWR     1400     16      16         0                 
## 107       IAH  SJU     2007      6      16         0                 
## 108       IAH  PHX     1009      8      37         0                 
## 109       IAH  BWI     1235      5      15         0                 
## 110       IAH  LGA     1416      4      31         0                 
## 111       IAH  AUS      140      5      23         0                 
## 112       IAH  CLE     1091      5      18         0                 
## 113       IAH  RDU     1043      5      15         0                 
## 114       IAH  DCA     1208      4      24         0                 
## 115       IAH  SEA     1874      9      14         0                 
## 116       IAH  SFO     1635      7      27         0                 
## 117       IAH  DEN      862      8      16         0                 
## 118       IAH  SAT      191      3      22         0                 
## 119       IAH  BOS     1597      5      25         0                 
## 120       IAH  LAS     1222      7      18         0                 
## 121       IAH  DEN      862      6       9         0                 
## 122       IAH  PDX     1825      5      24         0                 
## 123       IAH  EWR     1400      7      22         0                 
## 124       IAH  PHX     1009      7      26         0                 
## 125       IAH  MSY      305      2      15         0                 
## 126       IAH  BWI     1235      4      13         0                 
## 127       IAH  LGA     1416      7      31         0                 
## 128       IAH  DCA     1208      3      18         0                 
## 129       IAH  SFO     1635      6      29         0                 
## 130       IAH  SAT      191      3      18         0                 
## 131       IAH  BOS     1597     10      21         0                 
## 132       IAH  LAS     1222      7      11         0                 
## 133       IAH  IND      845      5      33         0                 
## 134       IAH  SAN     1303      4      14         0                 
## 135       IAH  IAD     1190      5      21         0                 
## 136       IAH  IAD     1190     13      23         0                 
## 137       IAH  EWR     1400     11      26         0                 
## 138       IAH  IAD     1190      9       8         0                 
## 139       IAH  SJC     1609      2      14         0                 
## 140       IAH  MSY      305      2      19         0                 
## 141       IAH  BWI     1235      4      18         0                 
## 142       IAH  LGA     1416      6      23         0                 
## 143       IAH  TUL      429     NA      NA         1                B
## 144       IAH  ORD      925     18      22         0                 
## 145       IAH  ORD      925     11      16         0                 
## 146       IAH  DCA     1208      4      15         0                 
## 147       IAH  SEA     1874      5      15         0                 
## 148       IAH  SAT      191      3      14         0                 
## 149       IAH  BOS     1597     11      20         0                 
## 150       IAH  LAS     1222      7      36         0                 
## 151       IAH  DEN      862      6      26         0                 
## 152       IAH  IND      845     NA      NA         1                B
## 153       IAH  EWR     1400      7      17         0                 
## 154       IAH  MFE      316      4      17         0                 
## 155       IAH  PHX     1009      8      12         0                 
## 156       IAH  LGA     1416      7      40         0                 
## 157       IAH  PIT     1117      7      18         0                 
## 158       IAH  SLC     1195      4      17         0                 
## 159       IAH  CLE     1091      6      21         0                 
## 160       IAH  ORD      925     10      29         0                 
## 161       IAH  DCA     1208      5      16         0                 
## 162       IAH  SNA     1347      6      35         0                 
## 163       IAH  SFO     1635      7      10         0                 
## 164       IAH  BOS     1597      7      16         0                 
## 165       IAH  MCO      853      9      21         0                 
## 166       IAH  LAS     1222      9      12         0                 
## 167       IAH  DEN      862     10      25         0                 
## 168       IAH  DEN      862     18      34         0                 
## 169       IAH  TPA      787      6      17         0                 
## 170       IAH  MSP     1034     11      25         0                 
## 171       IAH  MSY      305      3      26         0                 
## 172       IAH  BWI     1235      4      11         0                 
## 173       IAH  LGA     1416      5      14         0                 
## 174       IAH  CLE     1091      5      16         0                 
## 175       IAH  DCA     1208      9      16         0                 
## 176       IAH  EGE      935      4      16         0                 
## 177       IAH  SEA     1874      6      11         0                 
## 178       IAH  BOS     1597      9      13         0                 
## 179       IAH  MCO      853      8      21         0                 
## 180       IAH  LAS     1222      7      32         0                 
## 181       IAH  TPA      787      3      20         0                 
## 182       IAH  PDX     1825      7      11         0                 
## 183       IAH  MSY      305      2      17         0                 
## 184       IAH  LGA     1416      5      27         0                 
## 185       IAH  SAN     1303      3      13         0                 
## 186       IAH  SAN     1303      4      35         0                 
## 187       IAH  AUS      140      5      20         0                 
## 188       IAH  CLE     1091      5      28         0                 
## 189       IAH  ORD      925     11      24         0                 
## 190       IAH  SLC     1195      5      18         0                 
## 191       IAH  ATL      689      9      16         0                 
## 192       IAH  MSY      305      3      10         0                 
## 193       IAH  SEA     1874      6      30         0                 
## 194       IAH  SFO     1635      5       6         0                 
## 195       IAH  SFO     1635      7      29         0                 
## 196       IAH  PHL     1324      9      19         0                 
## 197       IAH  MCO      853      6      16         0                 
## 198       IAH  DTW     1076      8      19         0                 
## 199       IAH  LAX     1379     13      15         0                 
## 200       IAH  DEN      862     17      15         0                 
## 201       IAH  EWR     1400     14      18         0                 
## 202       IAH  PHX     1009      6      22         0                 
## 203       IAH  TPA      787      3      13         0                 
## 204       IAH  EWR     1400      9      16         0                 
## 205       IAH  ORD      925      7      10         0                 
## 206       IAH  FLL      965      3      25         0                 
## 207       IAH  DCA     1208      4      17         0                 
## 208       IAH  SFO     1635      5      18         0                 
## 209       IAH  SAT      191      3      28         0                 
## 210       IAH  MCO      853      6      16         0                 
## 211       IAH  DTW     1076      6      34         0                 
## 212       IAH  LAX     1379      7      12         0                 
## 213       IAH  LAS     1222      7      25         0                 
## 214       IAH  DEN      862     12      11         0                 
## 215       IAH  AUS      140      6      16         0                 
## 216       IAH  SJC     1609      3      14         0                 
## 217       IAH  PIT     1117      6      13         0                 
## 218       IAH  MSY      305      6      26         0                 
## 219       IAH  CLT      913      6      12         0                 
## 220       IAH  FLL      965      5      23         0                 
## 221       IAH  SNA     1347      8      13         0                 
## 222       IAH  RSW      861      5      23         0                 
## 223       IAH  PHL     1324     14      19         0                 
## 224       IAH  SAT      191      3      12         0                 
## 225       IAH  DTW     1076      6      22         0                 
## 226       IAH  LAX     1379      8      33         0                 
## 227       IAH  LAS     1222      7      15         0                 
## 228       IAH  DCA     1208      4      15         0                 
## 229       IAH  TPA      787      4       9         0                 
## 230       IAH  SNA     1347      8      15         0                 
## 231       IAH  AUS      140      7      25         0                 
## 232       IAH  AUS      140      5      30         0                 
## 233       IAH  CLE     1091      4      15         0                 
## 234       IAH  ORD      925     13      10         0                 
## 235       IAH  FLL      965      4      13         0                 
## 236       IAH  RSW      861      4      19         0                 
## 237       IAH  MCI      643      7      19         0                 
## 238       IAH  AUS      140      5      29         0                 
## 239       IAH  MCO      853      7      12         0                 
## 240       IAH  SAN     1303      4      31         0                 
## 241       IAH  MIA      964      6      21         0                 
## 242       IAH  AUS      140      5      16         0                 
## 243       IAH  LAX     1379      9      24         0                 
## 244       IAH  PHX     1009      6      22         0                 
## 245       IAH  MFE      316      3      17         0                 
## 246       IAH  MSY      305      3      14         0                 
## 247       IAH  SNA     1347      5      17         0                 
## 248       IAH  LGA     1416      5      12         0                 
## 249       IAH  MFE      316      6      13         0                 
## 250       IAH  SMF     1609      3      12         0                 
## 251       IAH  ORD      925     11      15         0                 
## 252       IAH  FLL      965      5      15         0                 
## 253       IAH  RSW      861      4      21         0                 
## 254       IAH  ELP      667      6      22         0                 
## 255       IAH  PHL     1324     11      18         0                 
## 256       IAH  SAT      191      3      33         0                 
## 257       IAH  DTW     1076      7      23         0                 
## 258       IAH  SAN     1303      4      18         0                 
## 259       IAH  MIA      964      5      21         0                 
## 260       IAH  LAX     1379     11      30         0                 
## 261       IAH  MFE      316      4      21         0                 
## 262       IAH  OKC      395     NA      NA         1                B
## 263       IAH  SMF     1609      5      33         0                 
## 264       IAH  ABQ      744      8      20         0                 
## 265       IAH  SAN     1303      3      23         0                 
## 266       IAH  ONT     1334      4      11         0                 
## 267       IAH  ORD      925     12      30         0                 
## 268       IAH  FLL      965      5      16         0                 
## 269       IAH  ATL      689     17      25         0                 
## 270       IAH  SEA     1874      9      18         0                 
## 271       IAH  PHL     1324      7      23         0                 
## 272       IAH  SAT      191      3      15         0                 
## 273       IAH  TUS      936      7      24         0                 
## 274       IAH  DFW      224      4      16         0                 
## 275       IAH  MIA      964      5      16         0                 
## 276       IAH  LAX     1379     15      14         0                 
## 277       IAH  SNA     1347      7      31         0                 
## 278       IAH  MSY      305      5      22         0                 
## 279       IAH  PBI      956      5      19         0                 
## 280       IAH  LGA     1416      7      13         0                 
## 281       IAH  PHL     1324     21      11         0                 
## 282       IAH  CLE     1091      7      30         0                 
## 283       IAH  RDU     1043      6      16         0                 
## 284       IAH  OMA      781     10      16         0                 
## 285       IAH  MCO      853      6      26         0                 
## 286       IAH  HDN      986      5      15         0                 
## 287       IAH  SMF     1609      5      17         0                 
## 288       IAH  HNL     3904     13      19         0                 
## 289       IAH  MSY      305      3      15         0                 
## 290       IAH  SAT      191      6      17         0                 
## 291       IAH  MSY      305      5      13         0                 
## 292       IAH  AUS      140      9      20         0                 
## 293       IAH  LAX     1379     15      33         0                 
## 294       IAH  LAX     1379      7      31         0                 
## 295       IAH  DEN      862      8      29         0                 
## 296       IAH  EWR     1400     12      14         0                 
## 297       IAH  EWR     1400      9      15         0                 
## 298       IAH  EWR     1400      8      15         0                 
## 299       IAH  EWR     1400     14      28         0                 
## 300       IAH  MSY      305      6      21         0                 
## 301       IAH  LAX     1379     10      14         0                 
## 302       IAH  ORD      925     15      38         0                 
## 303       IAH  ONT     1334      4      12         0                 
## 304       IAH  DCA     1208      4      17         0                 
## 305       IAH  SFO     1635      8      30         0                 
## 306       IAH  MIA      964      4      25         0                 
## 307       IAH  LAS     1222      7      37         0                 
## 308       IAH  DEN      862      5      14         0                 
## 309       IAH  TPA      787      5      23         0                 
## 310       IAH  PDX     1825      5      10         0                 
## 311       IAH  EWR     1400      9      28         0                 
## 312       IAH  SJU     2007      5      16         0                 
## 313       IAH  PHX     1009      9      19         0                 
## 314       IAH  BWI     1235      6      26         0                 
## 315       IAH  LGA     1416      7      17         0                 
## 316       IAH  AUS      140      6      27         0                 
## 317       IAH  CLE     1091      7      25         0                 
## 318       IAH  RDU     1043      9      21         0                 
## 319       IAH  SEA     1874      6      17         0                 
## 320       IAH  SFO     1635      5      24         0                 
## 321       IAH  DEN      862      5      16         0                 
## 322       IAH  SAT      191      3      22         0                 
## 323       IAH  LAS     1222      6      12         0                 
## 324       IAH  DEN      862     24      26         0                 
## 325       IAH  PDX     1825      4      13         0                 
## 326       IAH  EWR     1400      6      53         0                 
## 327       IAH  PHX     1009      7      10         0                 
## 328       IAH  MSY      305      3      24         0                 
## 329       IAH  BWI     1235      5      28         0                 
## 330       IAH  GUC      886      4      45         0                 
## 331       IAH  DCA     1208     20      16         0                 
## 332       IAH  SFO     1635      7      16         0                 
## 333       IAH  SAT      191      4      29         0                 
## 334       IAH  BOS     1597      5      17         0                 
## 335       IAH  LAS     1222      7      33         0                 
## 336       IAH  IND      845      5      36         0                 
## 337       IAH  SAN     1303      3      19         0                 
## 338       IAH  IAD     1190      7      10         0                 
## 339       IAH  IAD     1190      9      37         0                 
## 340       IAH  EWR     1400     11      13         0                 
## 341       IAH  IAD     1190      6      13         0                 
## 342       IAH  SJC     1609      5      37         0                 
## 343       IAH  MSY      305     10      34         0                 
## 344       IAH  BWI     1235      7      38         0                 
## 345       IAH  LGA     1416      5      30         0                 
## 346       IAH  TUL      429      7      38         0                 
## 347       IAH  ORD      925      5      33         0                 
## 348       IAH  DCA     1208      3      22         0                 
## 349       IAH  SEA     1874      6      14         0                 
## 350       IAH  SAT      191      6      37         0                 
## 351       IAH  BOS     1597      8      39         0                 
## 352       IAH  LAS     1222      7      19         0                 
## 353       IAH  DEN      862      5      41         0                 
## 354       IAH  IND      845      9      42         0                 
## 355       IAH  EWR     1400     12      20         0                 
## 356       IAH  MFE      316      4       9         0                 
## 357       IAH  PHX     1009      5      22         0                 
## 358       IAH  LGA     1416      6      10         0                 
## 359       IAH  PIT     1117      6      26         0                 
## 360       IAH  SLC     1195      7      17         0                 
## 361       IAH  CLE     1091      7      17         0                 
## 362       IAH  ORD      925     15      40         0                 
## 363       IAH  DCA     1208      5      21         0                 
## 364       IAH  SFO     1635      8      22         0                 
## 365       IAH  BOS     1597      6      50         0                 
## 366       IAH  MCO      853      6      14         0                 
## 367       IAH  LAS     1222      7      24         0                 
## 368       IAH  DEN      862      6      16         0                 
## 369       IAH  DEN      862     10      31         0                 
## 370       IAH  TPA      787      5      15         0                 
## 371       IAH  MSP     1034      5      35         0                 
## 372       IAH  MSY      305      3      20         0                 
## 373       IAH  LGA     1416      6      15         0                 
## 374       IAH  CLE     1091      5      44         0                 
## 375       IAH  DCA     1208      4      24         0                 
## 376       IAH  EGE      935     11      14         0                 
## 377       IAH  SEA     1874      7      18         0                 
## 378       IAH  SFO     1635      7      33         0                 
## 379       IAH  BOS     1597      5      18         0                 
## 380       IAH  MCO      853      7      34         0                 
## 381       IAH  LAS     1222      5      16         0                 
## 382       IAH  PDX     1825      9      39         0                 
## 383       IAH  MSY      305      3      15         0                 
## 384       IAH  LGA     1416      4      26         0                 
## 385       IAH  SAN     1303      4      15         0                 
## 386       IAH  SAN     1303      3      19         0                 
## 387       IAH  AUS      140      4      36         0                 
## 388       IAH  CLE     1091      4      40         0                 
## 389       IAH  ORD      925     14      18         0                 
## 390       IAH  SLC     1195      9      15         0                 
## 391       IAH  ATL      689     14      25         0                 
## 392       IAH  SNA     1347      7      16         0                 
## 393       IAH  MSY      305      4      17         0                 
## 394       IAH  SEA     1874      7      11         0                 
## 395       IAH  SFO     1635      7      22         0                 
## 396       IAH  SFO     1635      7      11         0                 
## 397       IAH  MCO      853      6      13         0                 
## 398       IAH  DTW     1076      7      16         0                 
## 399       IAH  LAX     1379      7      17         0                 
## 400       IAH  DEN      862     15      14         0                 
## 401       IAH  EWR     1400     16      22         0                 
## 402       IAH  PHX     1009      3      20         0                 
## 403       IAH  TPA      787      4      41         0                 
## 404       IAH  EWR     1400      8      23         0                 
## 405       IAH  ORD      925      6      25         0                 
## 406       IAH  FLL      965      4      18         0                 
## 407       IAH  DCA     1208      3      11         0                 
## 408       IAH  SFO     1635      9      24         0                 
## 409       IAH  SAT      191      3      11         0                 
## 410       IAH  MCO      853      6      16         0                 
## 411       IAH  DTW     1076      7      23         0                 
## 412       IAH  LAX     1379     15      19         0                 
## 413       IAH  LAS     1222      6      12         0                 
## 414       IAH  DEN      862      5      31         0                 
## 415       IAH  AUS      140      6      34         0                 
## 416       IAH  SJC     1609      5      14         0                 
## 417       IAH  PIT     1117      9      34         0                 
## 418       IAH  MSY      305      3      14         0                 
## 419       IAH  FLL      965      4      34         0                 
## 420       IAH  SNA     1347      6      10         0                 
## 421       IAH  PHL     1324      6      19         0                 
## 422       IAH  SAT      191      4      18         0                 
## 423       IAH  DTW     1076      7      65         0                 
## 424       IAH  LAX     1379     13      19         0                 
## 425       IAH  LAS     1222      6      15         0                 
## 426       IAH  TPA      787      5      26         0                 
## 427       IAH  SNA     1347     16      34         0                 
## 428       IAH  AUS      140      5      16         0                 
## 429       IAH  CLE     1091      7      16         0                 
## 430       IAH  ORD      925     11      23         0                 
## 431       IAH  FLL      965      4      23         0                 
## 432       IAH  AUS      140      6      25         0                 
## 433       IAH  RSW      861      5      14         0                 
## 434       IAH  MCI      643      7      49         0                 
## 435       IAH  AUS      140      7      14         0                 
## 436       IAH  MCO      853      6      36         0                 
## 437       IAH  SAN     1303      3      19         0                 
## 438       IAH  MIA      964      5      12         0                 
## 439       IAH  DCA     1208      8      30         0                 
## 440       IAH  LAX     1379      8      30         0                 
## 441       IAH  PHX     1009      6      35         0                 
## 442       IAH  MFE      316      5      20         0                 
## 443       IAH  MSY      305      3      16         0                 
## 444       IAH  SNA     1347      6      12         0                 
## 445       IAH  LGA     1416      5      16         0                 
## 446       IAH  SMF     1609      6      15         0                 
## 447       IAH  ORD      925     10      17         0                 
## 448       IAH  FLL      965      5      12         0                 
## 449       IAH  RSW      861      5      48         0                 
## 450       IAH  ELP      667      4      25         0                 
## 451       IAH  PHL     1324      5      22         0                 
## 452       IAH  SAT      191      3      20         0                 
## 453       IAH  DTW     1076      8      20         0                 
## 454       IAH  SAN     1303      2      30         0                 
## 455       IAH  MIA      964      6      27         0                 
## 456       IAH  LAX     1379      8      23         0                 
## 457       IAH  MFE      316      4      16         0                 
## 458       IAH  OKC      395      6      43         0                 
## 459       IAH  ABQ      744      5      14         0                 
## 460       IAH  SAN     1303      3      10         0                 
## 461       IAH  ONT     1334      3      14         0                 
## 462       IAH  AUS      140      4      12         0                 
## 463       IAH  ORD      925     13      13         0                 
## 464       IAH  FLL      965      4      49         0                 
## 465       IAH  ATL      689     10      23         0                 
## 466       IAH  SEA     1874      5      17         0                 
## 467       IAH  PHL     1324      5      55         0                 
## 468       IAH  SAT      191      3      16         0                 
## 469       IAH  TUS      936      6      19         0                 
## 470       IAH  DFW      224      4      19         0                 
## 471       IAH  MIA      964      7      16         0                 
## 472       IAH  LAX     1379     10      18         0                 
## 473       IAH  SNA     1347      5      14         0                 
## 474       IAH  MSY      305      3      49         0                 
## 475       IAH  PBI      956      4      57         0                 
## 476       IAH  LGA     1416      5      45         0                 
##        Diverted
## 1             0
## 2             0
## 3             0
## 4             0
## 5             0
## 6             0
## 7             0
## 8             0
## 9             0
## 10            0
## 11            1
## 12            0
## 13            0
## 14            0
## 15            0
## 16            0
## 17            0
## 18            0
## 19            0
## 20            0
## 21            0
## 22            0
## 23            0
## 24            0
## 25            0
## 26            0
## 27            0
## 28            0
## 29            0
## 30            0
## 31            0
## 32            0
## 33            0
## 34            0
## 35            0
## 36            0
## 37            0
## 38            0
## 39            0
## 40            0
## 41            0
## 42            0
## 43            0
## 44            0
## 45            0
## 46            0
## 47            0
## 48            0
## 49            0
## 50            0
## 51            0
## 52            0
## 53            0
## 54            0
## 55            0
## 56            0
## 57            0
## 58            0
## 59            0
## 60            0
## 61            0
## 62            0
## 63            0
## 64            0
## 65            0
## 66            0
## 67            0
## 68            0
## 69            0
## 70            0
## 71            0
## 72            0
## 73            0
## 74            0
## 75            0
## 76            0
## 77            0
## 78            0
## 79            0
## 80            0
## 81            0
## 82            0
## 83            0
## 84            0
## 85            0
## 86            0
## 87            0
## 88            0
## 89            0
## 90            0
## 91            0
## 92            0
## 93            0
## 94            0
## 95            0
## 96            0
## 97            0
## 98            0
## 99            0
## 100           0
## 101           0
## 102           0
## 103           0
## 104           0
## 105           0
## 106           0
## 107           0
## 108           0
## 109           0
## 110           0
## 111           0
## 112           0
## 113           0
## 114           0
## 115           0
## 116           0
## 117           0
## 118           0
## 119           0
## 120           0
## 121           0
## 122           0
## 123           0
## 124           0
## 125           0
## 126           0
## 127           0
## 128           0
## 129           0
## 130           0
## 131           0
## 132           0
## 133           0
## 134           0
## 135           0
## 136           0
## 137           0
## 138           0
## 139           0
## 140           0
## 141           0
## 142           0
## 143           0
## 144           0
## 145           0
## 146           0
## 147           0
## 148           0
## 149           0
## 150           0
## 151           0
## 152           0
## 153           0
## 154           0
## 155           0
## 156           0
## 157           0
## 158           0
## 159           0
## 160           0
## 161           0
## 162           0
## 163           0
## 164           0
## 165           0
## 166           0
## 167           0
## 168           0
## 169           0
## 170           0
## 171           0
## 172           0
## 173           0
## 174           0
## 175           0
## 176           0
## 177           0
## 178           0
## 179           0
## 180           0
## 181           0
## 182           0
## 183           0
## 184           0
## 185           0
## 186           0
## 187           0
## 188           0
## 189           0
## 190           0
## 191           0
## 192           0
## 193           0
## 194           0
## 195           0
## 196           0
## 197           0
## 198           0
## 199           0
## 200           0
## 201           0
## 202           0
## 203           0
## 204           0
## 205           0
## 206           0
## 207           0
## 208           0
## 209           0
## 210           0
## 211           0
## 212           0
## 213           0
## 214           0
## 215           0
## 216           0
## 217           0
## 218           0
## 219           0
## 220           0
## 221           0
## 222           0
## 223           0
## 224           0
## 225           0
## 226           0
## 227           0
## 228           0
## 229           0
## 230           0
## 231           0
## 232           0
## 233           0
## 234           0
## 235           0
## 236           0
## 237           0
## 238           0
## 239           0
## 240           0
## 241           0
## 242           0
## 243           0
## 244           0
## 245           0
## 246           0
## 247           0
## 248           0
## 249           0
## 250           0
## 251           0
## 252           0
## 253           0
## 254           0
## 255           0
## 256           0
## 257           0
## 258           0
## 259           0
## 260           0
## 261           0
## 262           0
## 263           0
## 264           0
## 265           0
## 266           0
## 267           0
## 268           0
## 269           0
## 270           0
## 271           0
## 272           0
## 273           0
## 274           0
## 275           0
## 276           0
## 277           0
## 278           0
## 279           0
## 280           0
## 281           0
## 282           0
## 283           0
## 284           0
## 285           0
## 286           0
## 287           0
## 288           0
## 289           0
## 290           0
## 291           0
## 292           0
## 293           0
## 294           0
## 295           0
## 296           0
## 297           0
## 298           0
## 299           0
## 300           0
## 301           0
## 302           0
## 303           0
## 304           0
## 305           0
## 306           0
## 307           0
## 308           0
## 309           0
## 310           0
## 311           0
## 312           0
## 313           0
## 314           0
## 315           0
## 316           0
## 317           0
## 318           0
## 319           0
## 320           0
## 321           0
## 322           0
## 323           0
## 324           0
## 325           0
## 326           0
## 327           0
## 328           0
## 329           0
## 330           0
## 331           0
## 332           0
## 333           0
## 334           0
## 335           0
## 336           0
## 337           0
## 338           0
## 339           0
## 340           0
## 341           0
## 342           0
## 343           0
## 344           0
## 345           0
## 346           0
## 347           0
## 348           0
## 349           0
## 350           0
## 351           0
## 352           0
## 353           0
## 354           0
## 355           0
## 356           0
## 357           0
## 358           0
## 359           0
## 360           0
## 361           0
## 362           0
## 363           0
## 364           0
## 365           0
## 366           0
## 367           0
## 368           0
## 369           0
## 370           0
## 371           0
## 372           0
## 373           0
## 374           0
## 375           0
## 376           0
## 377           0
## 378           0
## 379           0
## 380           0
## 381           0
## 382           0
## 383           0
## 384           0
## 385           0
## 386           0
## 387           0
## 388           0
## 389           0
## 390           0
## 391           0
## 392           0
## 393           0
## 394           0
## 395           0
## 396           0
## 397           0
## 398           0
## 399           0
## 400           0
## 401           0
## 402           0
## 403           0
## 404           0
## 405           0
## 406           0
## 407           0
## 408           0
## 409           0
## 410           0
## 411           0
## 412           0
## 413           0
## 414           0
## 415           0
## 416           0
## 417           0
## 418           0
## 419           0
## 420           0
## 421           0
## 422           0
## 423           0
## 424           0
## 425           0
## 426           0
## 427           0
## 428           0
## 429           0
## 430           0
## 431           0
## 432           0
## 433           0
## 434           0
## 435           0
## 436           0
## 437           0
## 438           0
## 439           0
## 440           0
## 441           0
## 442           0
## 443           0
## 444           0
## 445           0
## 446           0
## 447           0
## 448           0
## 449           0
## 450           0
## 451           0
## 452           0
## 453           0
## 454           0
## 455           0
## 456           0
## 457           0
## 458           0
## 459           0
## 460           0
## 461           0
## 462           0
## 463           0
## 464           0
## 465           0
## 466           0
## 467           0
## 468           0
## 469           0
## 470           0
## 471           0
## 472           0
## 473           0
## 474           0
## 475           0
## 476           0
##  [ reached getOption("max.print") -- omitted 223776 rows ]
{% endhighlight %}



{% highlight r %}
hflights %>% 
  filter(!UniqueCarrier %in% c("AA", "UA"))  #  choose multiple 'not' in categories.  NOTE: '!' flips the logical TRUE to FALSE
{% endhighlight %}



{% highlight text %}
##        Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 1      2011     1          1         6    1824    2106            AS
## 2      2011     1          2         7    1823    2103            AS
## 3      2011     1          3         1    1827    2107            AS
## 4      2011     1          4         2    1845    2132            AS
## 5      2011     1          5         3    1821    2109            AS
## 6      2011     1          6         4    1834    2133            AS
## 7      2011     1          7         5    1823    2118            AS
## 8      2011     1          8         6    1822    2112            AS
## 9      2011     1          9         7    1938    2228            AS
## 10     2011     1         10         1    1820    2159            AS
## 11     2011     1         11         2    1820      12            AS
## 12     2011     1         12         3    1822    2129            AS
## 13     2011     1         13         4    1820    2113            AS
## 14     2011     1         14         5    1818    2114            AS
## 15     2011     1         15         6    1822    2131            AS
## 16     2011     1         16         7    1822    2138            AS
## 17     2011     1         17         1    1818    2149            AS
## 18     2011     1         18         2    1836    2130            AS
## 19     2011     1         19         3    1820    2102            AS
## 20     2011     1         20         4    1822    2135            AS
## 21     2011     1         21         5    1827    2136            AS
## 22     2011     1         22         6    1816    2100            AS
## 23     2011     1         23         7    1818    2104            AS
## 24     2011     1         24         1    1824    2109            AS
## 25     2011     1         25         2    1826    2101            AS
## 26     2011     1         26         3    1830    2115            AS
## 27     2011     1         27         4    1832    2110            AS
## 28     2011     1         28         5    1821    2052            AS
## 29     2011     1         29         6    1821    2042            AS
## 30     2011     1         30         7    1821    2128            AS
## 31     2011     1         31         1    1827    2111            AS
## 32     2011     1          1         6     654    1124            B6
## 33     2011     1          1         6    1639    2110            B6
## 34     2011     1          2         7     703    1113            B6
## 35     2011     1          2         7    1604    2040            B6
## 36     2011     1          3         1     659    1100            B6
## 37     2011     1          3         1    1801    2200            B6
## 38     2011     1          4         2     654    1103            B6
## 39     2011     1          4         2    1608    2034            B6
## 40     2011     1          5         3     700    1103            B6
## 41     2011     1          5         3    1544    1954            B6
## 42     2011     1          6         4    1532    1943            B6
## 43     2011     1          7         5     654    1117            B6
## 44     2011     1          7         5    1542    1956            B6
## 45     2011     1          8         6     654    1058            B6
## 46     2011     1          9         7     653    1059            B6
## 47     2011     1          9         7    1618    2057            B6
## 48     2011     1         10         1     656    1102            B6
## 49     2011     1         10         1    1554    2001            B6
## 50     2011     1         11         2     653    1053            B6
## 51     2011     1         11         2      NA      NA            B6
## 52     2011     1         12         3    1532    1953            B6
## 53     2011     1         13         4    1522    1938            B6
## 54     2011     1         14         5     808    1229            B6
## 55     2011     1         14         5    1534    2015            B6
## 56     2011     1         15         6     700    1114            B6
## 57     2011     1         16         7     652    1055            B6
## 58     2011     1         16         7    1551    2004            B6
## 59     2011     1         17         1     730    1135            B6
## 60     2011     1         17         1    1531    1946            B6
## 61     2011     1         18         2     659    1102            B6
## 62     2011     1         18         2    1647    2056            B6
## 63     2011     1         19         3      NA      NA            B6
## 64     2011     1         20         4    1538    1952            B6
## 65     2011     1         21         5     656    1104            B6
## 66     2011     1         21         5    1725    2135            B6
## 67     2011     1         22         6     701    1106            B6
## 68     2011     1         23         7     658    1058            B6
## 69     2011     1         23         7    1535    1933            B6
## 70     2011     1         24         1     707    1059            B6
## 71     2011     1         24         1    1532    1923            B6
## 72     2011     1         25         2     658    1102            B6
## 73     2011     1         25         2    1623    2029            B6
## 74     2011     1         26         3    1535    1941            B6
## 75     2011     1         27         4      NA      NA            B6
## 76     2011     1         28         5     655    1107            B6
## 77     2011     1         28         5    1538    2013            B6
## 78     2011     1         29         6     657    1128            B6
## 79     2011     1         30         7     651    1106            B6
## 80     2011     1         30         7    1659    2118            B6
## 81     2011     1         31         1     659    1111            B6
## 82     2011     1         31         1    1532    1942            B6
## 83     2011     1         31         1     924    1413            CO
## 84     2011     1         31         1    1825    1925            CO
## 85     2011     1         31         1    1554    1650            CO
## 86     2011     1         31         1    1522    1632            CO
## 87     2011     1         31         1    1536    1635            CO
## 88     2011     1         31         1    1916    2103            CO
## 89     2011     1         31         1     747     936            CO
## 90     2011     1         31         1    1803    1927            CO
## 91     2011     1         31         1    1206    1631            CO
## 92     2011     1         31         1    1425    1848            CO
## 93     2011     1         31         1     607    1022            CO
## 94     2011     1         31         1    1041    1449            CO
## 95     2011     1         31         1     728     856            CO
## 96     2011     1         31         1    1433    1629            CO
## 97     2011     1         31         1    1422    1647            CO
## 98     2011     1         31         1    1750    1921            CO
## 99     2011     1         31         1    1442    1842            CO
## 100    2011     1         31         1     851    1052            CO
## 101    2011     1         31         1    1919    2231            CO
## 102    2011     1         31         1    1155    1324            CO
## 103    2011     1         31         1     726     915            CO
## 104    2011     1         31         1    1259    1554            CO
## 105    2011     1         31         1    2116    2344            CO
## 106    2011     1         31         1    1551    2009            CO
## 107    2011     1         31         1    1024    1621            CO
## 108    2011     1         31         1     912    1138            CO
## 109    2011     1         31         1    1020    1421            CO
## 110    2011     1         31         1     916    1336            CO
## 111    2011     1         31         1    1301    1356            CO
## 112    2011     1         31         1    1554    1918            CO
## 113    2011     1         31         1    1850    2211            CO
## 114    2011     1         31         1     727    1120            CO
## 115    2011     1         31         1    1240    1526            CO
## 116    2011     1         31         1    1129    1351            CO
## 117    2011     1         31         1    1615    1741            CO
## 118    2011     1         31         1    1145    1255            CO
## 119    2011     1         31         1     735    1220            CO
## 120    2011     1         31         1    1046    1221            CO
## 121    2011     1         31         1    2102    2216            CO
## 122    2011     1         31         1     854    1137            CO
## 123    2011     1         31         1    1949       2            CO
## 124    2011     1         31         1    1431    1643            CO
## 125    2011     1         31         1    1312    1413            CO
## 126    2011     1         31         1    1248    1628            CO
## 127    2011     1         31         1     742    1217            CO
## 128    2011     1         31         1    1033    1420            CO
## 129    2011     1         31         1    1432    1656            CO
## 130    2011     1         31         1    1320    1420            CO
## 131    2011     1         31         1    1047    1526            CO
## 132    2011     1         31         1    1902    2022            CO
## 133    2011     1         31         1    1316    1643            CO
## 134    2011     1         31         1    1031    1203            CO
## 135    2011     1         31         1     725    1117            CO
## 136    2011     1         31         1    1156    1555            CO
## 137    2011     1         31         1     749    1216            CO
## 138    2011     1         31         1    1701    2036            CO
## 139    2011     1         31         1    1911    2118            CO
## 140    2011     1         31         1    1924    2026            CO
## 141    2011     1         31         1    1909    2254            CO
## 142    2011     1         31         1    1049    1507            CO
## 143    2011     1         31         1      NA      NA            CO
## 144    2011     1         31         1    1925    2202            CO
## 145    2011     1         31         1     554     818            CO
## 146    2011     1         31         1    1250    1638            CO
## 147    2011     1         31         1    2157      53            CO
## 148    2011     1         31         1    1911    2011            CO
## 149    2011     1         31         1    1305    1746            CO
## 150    2011     1         31         1     906    1056            CO
## 151    2011     1         31         1    1148    1327            CO
## 152    2011     1         31         1      NA      NA            CO
## 153    2011     1         31         1     855    1322            CO
## 154    2011     1         31         1    2056    2217            CO
## 155    2011     1         31         1    1738    1939            CO
## 156    2011     1         31         1    1322    1807            CO
## 157    2011     1         31         1    1257    1627            CO
## 158    2011     1         31         1     934    1149            CO
## 159    2011     1         31         1     638    1021            CO
## 160    2011     1         31         1    1146    1421            CO
## 161    2011     1         31         1    1611    1955            CO
## 162    2011     1         31         1     917    1120            CO
## 163    2011     1         31         1    1748    2001            CO
## 164    2011     1         31         1    1901    2332            CO
## 165    2011     1         31         1     740    1052            CO
## 166    2011     1         31         1    2102    2222            CO
## 167    2011     1         31         1    1429    1608            CO
## 168    2011     1         31         1    1313    1516            CO
## 169    2011     1         31         1    1540    1833            CO
## 170    2011     1         31         1    1930    2225            CO
## 171    2011     1         31         1    1429    1542            CO
## 172    2011     1         31         1     714    1103            CO
## 173    2011     1         31         1    1543    1948            CO
## 174    2011     1         31         1    1917    2234            CO
## 175    2011     1         31         1    1915    2248            CO
## 176    2011     1         31         1    1120    1355            CO
## 177    2011     1         31         1    1737    2003            CO
## 178    2011     1         31         1    1550    2012            CO
## 179    2011     1         31         1    1034    1348            CO
## 180    2011     1         31         1    1440    1630            CO
## 181    2011     1         31         1     749    1044            CO
## 182    2011     1         31         1    1807    2030            CO
## 183    2011     1         31         1    1130    1233            CO
## 184    2011     1         31         1    1940    2349            CO
## 185    2011     1         31         1    1239    1409            CO
## 186    2011     1         31         1     906    1058            CO
## 187    2011     1         31         1    1144    1241            CO
## 188    2011     1         31         1    1308    1646            CO
## 189    2011     1         31         1    1423    1652            CO
## 190    2011     1         31         1    2137       9            CO
## 191    2011     1         31         1    1930    2224            CO
## 192    2011     1         31         1    1653    1748            CO
## 193    2011     1         31         1    1440    1731            CO
## 194    2011     1         31         1    2143    2338            CO
## 195    2011     1         31         1     729    1002            CO
## 196    2011     1         31         1     722    1125            CO
## 197    2011     1         31         1    1347    1654            CO
## 198    2011     1         31         1    1012    1351            CO
## 199    2011     1         31         1    1550    1736            CO
## 200    2011     1         31         1     842    1027            CO
## 201    2011     1         31         1    1311    1731            CO
## 202    2011     1         31         1    2105    2311            CO
## 203    2011     1         31         1    1107    1352            CO
## 204    2011     1         31         1    1805    2211            CO
## 205    2011     1         31         1    2120    2323            CO
## 206    2011     1         31         1     725    1040            CO
## 207    2011     1         31         1     851    1241            CO
## 208    2011     1         31         1    1558    1812            CO
## 209    2011     1         31         1    1446    1557            CO
## 210    2011     1         31         1    1754    2056            CO
## 211    2011     1         31         1    1309    1656            CO
## 212    2011     1         31         1    2107    2247            CO
## 213    2011     1         31         1     727     911            CO
## 214    2011     1         31         1    1859    2023            CO
## 215    2011     1         31         1    1900    1953            CO
## 216    2011     1         31         1     934    1149            CO
## 217    2011     1         31         1    1903    2228            CO
## 218    2011     1         31         1    2101    2215            CO
## 219    2011     1         31         1    1229    1540            CO
## 220    2011     1         31         1    1035    1351            CO
## 221    2011     1         31         1    2053    2235            CO
## 222    2011     1         31         1    1048    1354            CO
## 223    2011     1         31         1    1022    1433            CO
## 224    2011     1         31         1    2105    2157            CO
## 225    2011     1         31         1    1918    2247            CO
## 226    2011     1         31         1     920    1116            CO
## 227    2011     1         31         1    1559    1722            CO
## 228    2011     1         31         1    1756    2133            CO
## 229    2011     1         31         1    1900    2142            CO
## 230    2011     1         31         1    1757    1943            CO
## 231    2011     1         31         1    2113    2215            CO
## 232    2011     1         31         1    1434    1539            CO
## 233    2011     1         31         1    1039    1406            CO
## 234    2011     1         31         1    1731    1948            CO
## 235    2011     1         31         1    1312    1615            CO
## 236    2011     1         31         1    1358    1702            CO
## 237    2011     1         31         1    1847    2040            CO
## 238    2011     1         31         1     900    1006            CO
## 239    2011     1         31         1    1901    2203            CO
## 240    2011     1         31         1    1454    1638            CO
## 241    2011     1         31         1     723    1036            CO
## 242    2011     1         31         1    1753    1843            CO
## 243    2011     1         31         1    1153    1353            CO
## 244    2011     1         31         1    1139    1350            CO
## 245    2011     1         31         1    1423    1541            CO
## 246    2011     1         31         1     845     944            CO
## 247    2011     1         31         1    1216    1356            CO
## 248    2011     1         31         1    1743    2141            CO
## 249    2011     1         31         1     850    1004            CO
## 250    2011     1         31         1    2100    2252            CO
## 251    2011     1         31         1    1029    1251            CO
## 252    2011     1         31         1    1604    1910            CO
## 253    2011     1         31         1    1910    2212            CO
## 254    2011     1         31         1    1801    1918            CO
## 255    2011     1         31         1    1548    1956            CO
## 256    2011     1         31         1     913    1028            CO
## 257    2011     1         31         1    1558    1936            CO
## 258    2011     1         31         1    1809    1943            CO
## 259    2011     1         31         1    1030    1341            CO
## 260    2011     1         31         1    1325    1538            CO
## 261    2011     1         31         1    1732    1853            CO
## 262    2011     1         31         1      NA      NA            CO
## 263    2011     1         31         1     911    1144            CO
## 264    2011     1         31         1    1733    1901            CO
## 265    2011     1         31         1    2113    2253            CO
## 266    2011     1         31         1    1008    1145            CO
## 267    2011     1         31         1     753    1032            CO
## 268    2011     1         31         1    1911    2220            CO
## 269    2011     1         31         1    1252    1559            CO
## 270    2011     1         31         1     940    1233            CO
## 271    2011     1         31         1    1926    2318            CO
## 272    2011     1         31         1    1742    1835            CO
## 273    2011     1         31         1     902    1107            CO
## 274    2011     1         31         1    1608    1709            CO
## 275    2011     1         31         1    1317    1623            CO
## 276    2011     1         31         1    1749    1938            CO
## 277    2011     1         31         1    1447    1644            CO
## 278    2011     1         31         1    1027    1136            CO
## 279    2011     1         31         1    1922    2229            CO
## 280    2011     1         31         1    1145    1557            CO
## 281    2011     1         31         1    1232    1637            CO
## 282    2011     1         31         1    1432    1817            CO
## 283    2011     1         31         1    1305    1628            CO
## 284    2011     1         31         1    1737    1947            CO
## 285    2011     1         31         1     904    1217            CO
## 286    2011     1         31         1    1139    1319            CO
## 287    2011     1         31         1    1757    2007            CO
## 288    2011     1         30         7     925    1410            CO
## 289    2011     1         30         7    1829    1930            CO
## 290    2011     1         30         7    1550    1651            CO
## 291    2011     1         30         7    1525    1626            CO
## 292    2011     1         30         7    1532    1633            CO
## 293    2011     1         30         7    1914    2125            CO
## 294    2011     1         30         7     754     953            CO
## 295    2011     1         30         7    1756    1933            CO
## 296    2011     1         30         7    1205    1622            CO
## 297    2011     1         30         7    1443    1851            CO
## 298    2011     1         30         7     600    1014            CO
## 299    2011     1         30         7    1051    1520            CO
## 300    2011     1         30         7     736     843            CO
## 301    2011     1         30         7    1441    1610            CO
## 302    2011     1         30         7    1258    1550            CO
## 303    2011     1         30         7    2128    2252            CO
## 304    2011     1         30         7    1446    1834            CO
## 305    2011     1         30         7     935    1203            CO
## 306    2011     1         30         7    1920    2236            CO
## 307    2011     1         30         7    1200    1326            CO
## 308    2011     1         30         7     559     717            CO
## 309    2011     1         30         7    1305    1606            CO
## 310    2011     1         30         7    2200      19            CO
## 311    2011     1         30         7    1607    2033            CO
## 312    2011     1         30         7    1022    1615            CO
## 313    2011     1         30         7     900    1101            CO
## 314    2011     1         30         7    1024    1429            CO
## 315    2011     1         30         7     923    1339            CO
## 316    2011     1         30         7    1304    1408            CO
## 317    2011     1         30         7    1555    1943            CO
## 318    2011     1         30         7    1848    2224            CO
## 319    2011     1         30         7    1236    1500            CO
## 320    2011     1         30         7    1143    1359            CO
## 321    2011     1         30         7    1550    1712            CO
## 322    2011     1         30         7    1144    1248            CO
## 323    2011     1         30         7    1047    1200            CO
## 324    2011     1         30         7    2112    2301            CO
## 325    2011     1         30         7     848    1104            CO
## 326    2011     1         30         7    1925       5            CO
## 327    2011     1         30         7    1433    1622            CO
## 328    2011     1         30         7    1315    1425            CO
## 329    2011     1         30         7    1305    1702            CO
## 330    2011     1         30         7    1130    1326            CO
## 331    2011     1         30         7    1031    1426            CO
## 332    2011     1         30         7    1459    1715            CO
## 333    2011     1         30         7    1316    1425            CO
## 334    2011     1         30         7    1046    1518            CO
## 335    2011     1         30         7    1801    1940            CO
## 336    2011     1         30         7    1315    1639            CO
## 337    2011     1         30         7    1026    1158            CO
## 338    2011     1         30         7     722    1054            CO
## 339    2011     1         30         7    1157    1607            CO
## 340    2011     1         30         7     745    1209            CO
## 341    2011     1         30         7    1706    2050            CO
## 342    2011     1         30         7    1813    2046            CO
## 343    2011     1         30         7    2004    2128            CO
## 344    2011     1         30         7    1919    2335            CO
## 345    2011     1         30         7    1043    1509            CO
## 346    2011     1         30         7    1855    2044            CO
## 347    2011     1         30         7    1930    2230            CO
## 348    2011     1         30         7    1255    1644            CO
## 349    2011     1         30         7    2141      10            CO
## 350    2011     1         30         7    1912    2032            CO
## 351    2011     1         30         7    1319    1811            CO
## 352    2011     1         30         7     916    1032            CO
## 353    2011     1         30         7    1151    1331            CO
## 354    2011     1         30         7    1934    2318            CO
## 355    2011     1         30         7     855    1319            CO
## 356    2011     1         30         7    2106    2212            CO
## 357    2011     1         30         7    1748    1954            CO
## 358    2011     1         30         7    1350    1749            CO
## 359    2011     1         30         7    1302    1657            CO
## 360    2011     1         30         7     926    1125            CO
## 361    2011     1         30         7     735    1114            CO
## 362    2011     1         30         7    1142    1444            CO
## 363    2011     1         30         7    1609    2001            CO
## 364    2011     1         30         7    1749    2011            CO
## 365    2011     1         30         7    1909      23            CO
## 366    2011     1         30         7     800    1059            CO
## 367    2011     1         30         7    2100    2229            CO
## 368    2011     1         30         7    1420    1540            CO
## 369    2011     1         30         7    1312    1451            CO
## 370    2011     1         30         7    1539    1832            CO
## 371    2011     1         30         7    1910    2215            CO
## 372    2011     1         30         7    1428    1533            CO
## 373    2011     1         30         7    1548    1958            CO
## 374    2011     1         30         7    1921    2321            CO
## 375    2011     1         30         7    1908    2300            CO
## 376    2011     1         30         7    1124    1316            CO
## 377    2011     1         30         7    1744    2008            CO
## 378    2011     1         30         7    1931    2159            CO
## 379    2011     1         30         7    1553    2030            CO
## 380    2011     1         30         7    1034    1356            CO
## 381    2011     1         30         7    1452    1610            CO
## 382    2011     1         30         7    1806    2109            CO
## 383    2011     1         30         7    1132    1233            CO
## 384    2011     1         30         7    1904    2324            CO
## 385    2011     1         30         7    1239    1408            CO
## 386    2011     1         30         7     905    1032            CO
## 387    2011     1         30         7    1141    1251            CO
## 388    2011     1         30         7    1320    1712            CO
## 389    2011     1         30         7    1455    1727            CO
## 390    2011     1         30         7    2135    2346            CO
## 391    2011     1         30         7    2026    2335            CO
## 392    2011     1         30         7     906    1046            CO
## 393    2011     1         30         7    1653    1757            CO
## 394    2011     1         30         7    1516    1741            CO
## 395    2011     1         30         7    2100    2320            CO
## 396    2011     1         30         7     729     936            CO
## 397    2011     1         30         7    1342    1648            CO
## 398    2011     1         30         7    1102    1443            CO
## 399    2011     1         30         7    1540    1728            CO
## 400    2011     1         30         7     845    1015            CO
## 401    2011     1         30         7    1319    1752            CO
## 402    2011     1         30         7    2106    2259            CO
## 403    2011     1         30         7    1053    1411            CO
## 404    2011     1         30         7    1812    2234            CO
## 405    2011     1         30         7    2108    2345            CO
## 406    2011     1         30         7     727    1040            CO
## 407    2011     1         30         7     851    1230            CO
## 408    2011     1         30         7    1603    1820            CO
## 409    2011     1         30         7    1441    1534            CO
## 410    2011     1         30         7    1700    2002            CO
## 411    2011     1         30         7    1304    1642            CO
## 412    2011     1         30         7    2105    2302            CO
## 413    2011     1         30         7     725     839            CO
## 414    2011     1         30         7    1931    2109            CO
## 415    2011     1         30         7    1922    2032            CO
## 416    2011     1         30         7     915    1128            CO
## 417    2011     1         30         7    1904    2305            CO
## 418    2011     1         30         7    2123    2223            CO
## 419    2011     1         30         7    1037    1406            CO
## 420    2011     1         30         7    2050    2227            CO
## 421    2011     1         30         7    1127    1559            CO
## 422    2011     1         30         7    2104    2200            CO
## 423    2011     1         30         7    1924    2357            CO
## 424    2011     1         30         7     927    1113            CO
## 425    2011     1         30         7    1616    1731            CO
## 426    2011     1         30         7    1915    2215            CO
## 427    2011     1         30         7    1805    2019            CO
## 428    2011     1         30         7    1444    1536            CO
## 429    2011     1         30         7    1011    1348            CO
## 430    2011     1         30         7    1755    2034            CO
## 431    2011     1         30         7    1323    1639            CO
## 432    2011     1         30         7    1813    1914            CO
## 433    2011     1         30         7    1402    1707            CO
## 434    2011     1         30         7    1900    2132            CO
## 435    2011     1         30         7     858     950            CO
## 436    2011     1         30         7    1919    2242            CO
## 437    2011     1         30         7    1451    1628            CO
## 438    2011     1         30         7     724    1028            CO
## 439    2011     1         30         7    1757    2206            CO
## 440    2011     1         30         7    1319    1515            CO
## 441    2011     1         30         7    1137    1351            CO
## 442    2011     1         30         7    1418    1538            CO
## 443    2011     1         30         7     839     940            CO
## 444    2011     1         30         7    1235    1431            CO
## 445    2011     1         30         7    1750    2203            CO
## 446    2011     1         30         7    2057    2258            CO
## 447    2011     1         30         7    1029    1251            CO
## 448    2011     1         30         7    1647    1956            CO
## 449    2011     1         30         7    1918    2250            CO
## 450    2011     1         30         7    1747    1904            CO
## 451    2011     1         30         7    1605    2006            CO
## 452    2011     1         30         7     928    1031            CO
## 453    2011     1         30         7    1555    1958            CO
## 454    2011     1         30         7    1802    1955            CO
## 455    2011     1         30         7    1032    1354            CO
## 456    2011     1         30         7    1345    1547            CO
## 457    2011     1         30         7    1752    1907            CO
## 458    2011     1         30         7    1909    2057            CO
## 459    2011     1         30         7    1750    1913            CO
## 460    2011     1         30         7    2234       2            CO
## 461    2011     1         30         7     935    1105            CO
## 462    2011     1         30         7    2057    2140            CO
## 463    2011     1         30         7     722     943            CO
## 464    2011     1         30         7    1944    2324            CO
## 465    2011     1         30         7    1249    1550            CO
## 466    2011     1         30         7     930    1149            CO
## 467    2011     1         30         7    1937      13            CO
## 468    2011     1         30         7    1749    1842            CO
## 469    2011     1         30         7     857    1040            CO
## 470    2011     1         30         7    1704    1805            CO
## 471    2011     1         30         7    1332    1644            CO
## 472    2011     1         30         7    1803    1954            CO
## 473    2011     1         30         7    1453    1632            CO
## 474    2011     1         30         7    1038    1214            CO
## 475    2011     1         30         7    1924    2310            CO
## 476    2011     1         30         7    1146    1629            CO
##        FlightNum TailNum ActualElapsedTime AirTime ArrDelay DepDelay
## 1            731  N614AS               282     255       -4       -1
## 2            731  N627AS               280     257       -7       -2
## 3            731  N627AS               280     260       -3        2
## 4            731  N618AS               287     268       22       20
## 5            731  N607AS               288     273       -1       -4
## 6            731  N624AS               299     278       23        9
## 7            731  N611AS               295     274        8       -2
## 8            731  N607AS               290     269        2       -3
## 9            731  N609AS               290     253       78       73
## 10           731  N626AS               339     315       49       -5
## 11           731  N626AS                NA      NA       NA       -5
## 12           731  N619AS               307     284       19       -3
## 13           731  N627AS               293     273        3       -5
## 14           731  N627AS               296     270        4       -7
## 15           731  N627AS               309     287       21       -3
## 16           731  N627AS               316     291       28       -3
## 17           731  N612AS               331     310       39       -7
## 18           731  N617AS               294     276       20       11
## 19           731  N622AS               282     265       -8       -5
## 20           731  N622AS               313     284       25       -3
## 21           731  N622AS               309     288       26        2
## 22           731  N644AS               284     269      -10       -9
## 23           731  N624AS               286     269       -6       -7
## 24           731  N644AS               285     251       -1       -1
## 25           731  N607AS               275     255       -9        1
## 26           731  N607AS               285     255        5        5
## 27           731  N627AS               278     262        0        7
## 28           731  N627AS               271     256      -18       -4
## 29           731  N627AS               261     246      -28       -4
## 30           731  N627AS               307     264       18       -4
## 31           731  N607AS               284     259        1        2
## 32           620  N324JB               210     181        5       -6
## 33           622  N324JB               211     188       61       54
## 34           620  N324JB               190     172       -6        3
## 35           622  N324JB               216     176       31       19
## 36           620  N229JB               181     166      -19       -1
## 37           622  N206JB               179     165      111      136
## 38           620  N267JB               189     168      -16       -6
## 39           622  N267JB               206     175       25       23
## 40           620  N708JB               183     167      -14        0
## 41           624  N644JB               190     166       -6        9
## 42           624  N641JB               191     175      -17       -3
## 43           620  N641JB               203     172        0       -6
## 44           624  N564JB               194     175       -4        7
## 45           620  N630JB               184     162      -19       -6
## 46           620  N599JB               186     163      -18       -7
## 47           624  N625JB               219     196       57       43
## 48           620  N625JB               186     166      -15       -4
## 49           624  N504JB               187     170        1       19
## 50           620  N504JB               180     161      -24       -7
## 51           624  N537JB                NA      NA       NA       NA
## 52           624  N504JB               201     177       -7       -3
## 53           624  N597JB               196     178      -22      -13
## 54           620  N597JB               201     185       72       68
## 55           624  N729JB               221     189       15       -1
## 56           620  N503JB               194     173       -3        0
## 57           620  N706JB               183     166      -22       -8
## 58           624  N565JB               193     176        4       16
## 59           620  N523JB               185     168       18       30
## 60           624  N779JB               195     173      -14       -4
## 61           620  N779JB               183     162      -15       -1
## 62           624  N729JB               189     164       56       72
## 63           624  N504JB                NA      NA       NA       NA
## 64           624  N760JB               194     161       -8        3
## 65           620  N760JB               188     164      -13       -4
## 66           624  N598JB               190     173       95      110
## 67           620  N527JB               185     161      -11        1
## 68           620  N580JB               180     162      -19       -2
## 69           624  N599JB               178     164      -27        0
## 70           620  N605JB               172     156      -18        7
## 71           624  N536JB               171     156      -37       -3
## 72           620  N589JB               184     162      -15       -2
## 73           624  N621JB               186     167       29       48
## 74           624  N659JB               186     165      -19        0
## 75           624  N569JB                NA      NA       NA       NA
## 76           620  N594JB               192     172      -10       -5
## 77           624  N655JB               215     196       13        3
## 78           620  N508JB               211     180       11       -3
## 79           620  N606JB               195     175      -11       -9
## 80           624  N606JB               199     176       78       84
## 81           620  N661JB               192     172       -6       -1
## 82           624  N629JB               190     169      -18       -3
## 83             1  N69063               529     492       23       -1
## 84             5  N17245                60      42       -9        0
## 85             6  N77520                56      40       -5       -1
## 86            33  N16647                70      42       -2       -3
## 87            35  N35204                59      32        7        1
## 88            47  N76522               227     199        2        6
## 89            52  N67134               229     201        5        2
## 90            59  N57870               144     116       15       28
## 91            60  N68159               205     165       -2        1
## 92            62  N17126               203     163       -9        0
## 93            89  N76529               195     175        2        7
## 94           106  N66051               188     162      -26       -4
## 95           128  N75436                88      49       18       -2
## 96           137  N73283               236     199       14        5
## 97           146  N57862               145     114       64       77
## 98           150  N34282               211     189        6       15
## 99           158  N13750               180     142        7       -3
## 100          170  N35407               241     225      -27        1
## 101          190  N35260               132     107      -12       -1
## 102          197  N75853               209     172        3        0
## 103          199  N14228               169     128        8        1
## 104          206  N39418               115      91      -10       -1
## 105          209  N24715               268     256      -15       -7
## 106          210  N37408               198     166      -15        1
## 107          212  N53441               237     215       -4        9
## 108          220  N33132               206     161       32        7
## 109          226  N19621               181     161        2        0
## 110          232  N33266               200     165      -15       -4
## 111          241  N14629                55      27       -2       -4
## 112          244  N37274               144     121      -16        9
## 113          250  N59630               141     121      -18        0
## 114          258  N77520               173     145       -1       -3
## 115          267  N45440               286     263        7        5
## 116          270  N37420               262     228        1        4
## 117          275  N14242               146     122       16       25
## 118          279  N37274                70      45        4        0
## 119          282  N79279               225     195        4        0
## 120          297  N27421               215     190       13       11
## 121          299  N17244               134     119      -10        8
## 122          309  N33294               283     254        8        4
## 123          310  N77867               193     164       33       49
## 124          320  N39416               192     159       12        1
## 125          323  N36207                61      44      -10       -3
## 126          326  N38257               160     143      -16       -2
## 127          332  N73276               215     177        4       -3
## 128          358  N39728               167     146       -5       -2
## 129          370  N27213               264     229        5        7
## 130          379  N19638                60      39       -2        0
## 131          382  N36272               219     188       -5       -3
## 132          397  N33286               200     182       20       28
## 133          400  N39415               147     109        6        1
## 134          403  N35271               212     194       -1        1
## 135          404  N78501               172     146       -5       -5
## 136          406  N73270               179     143        3       -4
## 137          408  N66056               207     170        1       -1
## 138          410  N73299               155     138      -19       -2
## 139          421  N37298               247     231       80       91
## 140          423  N33266                62      41       -8       -1
## 141          426  N78506               165     143      -12       -1
## 142          432  N16713               198     169        1        4
## 143          442                        NA      NA       NA       NA
## 144          444  N76514               157     117        3        5
## 145          446  N26208               144     117      -16       -6
## 146          458  N17233               168     149       -7       -5
## 147          467  N78285               296     276       58       42
## 148          479  N16217                60      43       -8       -2
## 149          482  N78509               221     190       -3        0
## 150          497  N74856               230     187       23        1
## 151          499  N37267               159     127        2       -2
## 152          500                        NA      NA       NA       NA
## 153          510  N38268               207     183        2        0
## 154          511  N77520                81      60        5        1
## 155          520  N75432               181     161       -2       -2
## 156          532  N76269               225     178       22        2
## 157          534  N79402               150     125      -16       -3
## 158          542  N75436               195     174        2        4
## 159          544  N13624               163     136       -8       -7
## 160          546  N77518               155     116       -1        1
## 161          558  N16709               164     143      -11       -4
## 162          559  N76515               243     202       15        2
## 163          570  N75436               253     236       -4        3
## 164          582  N19621               211     188       -1        6
## 165          586  N17126               132     102       -7       -5
## 166          597  N33203               200     179      -10        0
## 167          599  N57864               159     124        6        3
## 168          601  N26208               183     131       36        9
## 169          606  N77510               113      90      -11        0
## 170          616  N33294               175     139       24       20
## 171          623  N77261                73      44        5       -1
## 172          626  N16647               169     154      -17       -6
## 173          632  N12238               185     166      -25       -2
## 174          644  N37267               137     116       -3       22
## 175          658  N37273               153     128       -6       10
## 176          663  N14115               215     195       33       -5
## 177          667  N57869               266     249        0       12
## 178          682  N78501               202     180      -25        0
## 179          686  N56859               134     105        0       -1
## 180          697  N37293               230     191       20        0
## 181          706  N23708               115      92      -11       -1
## 182          709  N37409               263     245      -13        2
## 183          723  N77510                63      44       -8       -5
## 184          732  N33262               189     157       44       50
## 185          738  N38403               210     194       -3       -1
## 186          739  N75432               232     193       16        1
## 187          741  N37290                57      32        0       -1
## 188          744  N76254               158     125       -7       -2
## 189          746  N78524               149     114       -8        3
## 190          752  N73278               212     189       10       -2
## 191          755  N11641               114      89      -10       -1
## 192          763  N73291                55      42      -15       -2
## 193          767  N37422               291     255       12        5
## 194          770  N37281               235     224       24       50
## 195          771  N26226               273     237        2       -1
## 196          776  N37252               183     155      -11       -3
## 197          786  N75851               127     105        6       12
## 198          788  N46625               159     132      -12       -4
## 199          795  N76502               226     198        8       10
## 200          799  N57855               165     133        0       -3
## 201          810  N78003               200     168       -4        1
## 202          820  N37255               186     158       19       10
## 203         1006  N18220               105      89       -2       17
## 204         1010  N73259               186     161       -9       15
## 205         1046  N79402               123     106       -4       25
## 206         1048  N73283               135     107       -8        0
## 207         1058  N24702               170     149       -7       -2
## 208         1070  N73406               254     231       -8       -2
## 209         1079  N14230                71      40       10        1
## 210         1086  N57855               122     100       97      114
## 211         1088  N14219               167     127        3        4
## 212         1095  N73270               220     201        7       12
## 213         1097  N14231               224     192       14       -3
## 214         1099  N75858               144     121       -9       -1
## 215         1411  N14604                53      31       -9       -5
## 216         1416  N33262               255     238       15       19
## 217         1417  N46625               145     126      -32       -2
## 218         1423  N62631                74      42        4       -4
## 219         1427  N11641               131     113      -15        0
## 220         1448  N75429               136     108      -16       -5
## 221         1459  N87513               222     201        2        3
## 222         1462  N16617               126      98      -25       -8
## 223         1476  N76503               191     158       -1        0
## 224         1479  N33264                52      37       -7        1
## 225         1488  N16701               149     121      -24       -2
## 226         1495  N77867               236     195        5       -5
## 227         1497  N75425               203     181      -10       -1
## 228         1499  N77295               157     138      -13        0
## 229         1506  N35407               102      89      -24        0
## 230         1511  N14704               226     203       -9       -3
## 231         1533  N72405                62      30       20       13
## 232         1541  N16646                65      30       15        4
## 233         1544  N14613               147     128        5       24
## 234         1546  N37253               137     114      -17        3
## 235         1548  N32404               123     106      -24       -3
## 236         1562  N76516               124     101       27       33
## 237         1568  N17627               113      87      -16       -3
## 238         1583  N36207                66      32       10        0
## 239         1586  N75428               122     103       -9        6
## 240         1589  N34222               224     189       21       12
## 241         1590  N27213               133     106      -12       -2
## 242         1603  N77525                50      29       -8       -2
## 243         1605  N37255               240     207       18        3
## 244         1620  N75433               191     163       11        4
## 245         1621  N16701                78      58        1        3
## 246         1623  N38727                59      42       -9        0
## 247         1629  N39726               220     198      -11       -4
## 248         1632  N24702               178     161      -19        0
## 249         1639  N18622                74      55       -4        0
## 250         1644  N76504               232     217      -13       10
## 251         1646  N37409               142     116      -12       -1
## 252         1648  N37252               126     106      -21       -1
## 253         1662  N17229               122      97       -9        0
## 254         1674  N16646               137     109       12        8
## 255         1676  N36280               188     159       -1        3
## 256         1679  N14219                75      39       -2      -12
## 257         1688  N27610               158     128      -17       -2
## 258         1689  N12225               214     192        6       12
## 259         1690  N77295               131     105      -22       -5
## 260         1695  N26210               253     212       32       10
## 261         1705  N16649                81      56       -1       -3
## 262         1711                        NA      NA       NA       NA
## 263         1714  N37273               273     235        8       -4
## 264         1715  N19638               148     120       -4       -2
## 265         1717  N77296               220     194       20       13
## 266         1723  N77296               217     202       -3       -2
## 267         1746  N35204               159     117       32       28
## 268         1748  N75433               129     108      -11        6
## 269         1757  N18622               127      85        0        2
## 270         1767  N87513               293     266       19       10
## 271         1776  N76503               172     142      -10       11
## 272         1779  N37277                53      35       -5        3
## 273         1783  N18223               185     154       11        2
## 274         1787  N18223                61      41        2       13
## 275         1790  N37281               126     105      -17       -3
## 276         1795  N73860               229     200        6        4
## 277         1821  N14731               237     199       14        7
## 278         1823  N16646                69      42       -3       -3
## 279         1830  N39423               127     103      -18       -3
## 280         1832  N78285               192     172      -13        0
## 281         1836  N73278               185     153       -9        2
## 282         1844  N24706               165     128       -4       -3
## 283         1850  N19623               143     121       -4       10
## 284         1858  N26226               130     104       -6       -1
## 285         1873  N14242               133     101      -11       -6
## 286         1882  N17620               160     140      -13        9
## 287         1889  N21723               250     228        6       17
## 288            1  N76064               525     493       20        0
## 289            5  N35271                61      43       -4        4
## 290            6  N17627                61      38       -4       -5
## 291           33  N17620                61      43       -8        0
## 292           35  N16649                61      32        5       -3
## 293           47  N77520               251     203       23        3
## 294           52  N13113               239     201       22        9
## 295           59  N57862               157     120       21       21
## 296           60  N76156               197     171      -11        0
## 297           62  N19130               188     164       -6       18
## 298           89  N26215               194     171        2        0
## 299          106  N67058               209     167       13        6
## 300          128  N54711                67      40        5        6
## 301          137  N18223               209     185       -5       13
## 302          146  N57855               172     119        7       -7
## 303          150  N37281               204     188       15       31
## 304          158  N33714               168     147       -1        1
## 305          170  N57439               268     230       49       45
## 306          190  N37267               136     107       -7        0
## 307          197  N57863               206     162       10        5
## 308          199  N14250               138     119      -20       -1
## 309          206  N37434               121      93        2        5
## 310          209  N15710               259     244       20       37
## 311          210  N79402               206     169        9       17
## 312          212  N53441               233     212       -5        7
## 313          220  N29124               181     153        0       -5
## 314          226  N14613               185     153       15        4
## 315          232  N77510               196     172       -7        3
## 316          241  N14645                64      31       10       -1
## 317          244  N16647               168     136        9       10
## 318          250  N73259               156     126       -1       -2
## 319          267  N27205               264     241      -19        1
## 320          270  N75428               256     227       14       18
## 321          275  N37252               142     121      -13        0
## 322          279  N38257                64      39        2       -1
## 323          297  N75426               193     175      -15        0
## 324          299  N12225               169     119       35       18
## 325          309  N77520               256     239      -20       -2
## 326          310  N57869               220     161       36       25
## 327          320  N78438               169     152       -9        3
## 328          323  N33262                70      43        2        0
## 329          326  N12225               177     144       18       15
## 330          352  N23721               176     127       14       -5
## 331          358  N37274               175     139        6       -4
## 332          370  N14231               256     233       24       34
## 333          379  N14604                69      36        3       -4
## 334          382  N76269               212     190       -8       -4
## 335          397  N37287               219     179       10       -1
## 336          400  N19638               144     103       -1        0
## 337          403  N14230               212     190       -1       -4
## 338          404  N37252               152     135      -28       -8
## 339          406  N18243               190     144       15       -3
## 340          408  N76062               204     180        2       -5
## 341          410  N73270               164     145       -5        3
## 342          421  N36280               273     231       48       33
## 343          423  N16632                84      40       54       39
## 344          426  N17245               196     151       29        9
## 345          432  N13750               206     171        8       -2
## 346          442  N16646               109      64       22        0
## 347          444  N27421               180     142       31       10
## 348          458  N33284               169     144       -1        0
## 349          467  N75428               269     249       15       26
## 350          479  N73276                80      37       16        2
## 351          482  N77525               232     185       22       14
## 352          497  N75858               196     170       -1        6
## 353          499  N12221               160     114       11        1
## 354          500  N79521               164     113       28        9
## 355          510  N75425               204     172        7        0
## 356          511  N54711                66      53        0       11
## 357          520  N47414               186     159       13        8
## 358          532  N35260               179     163        4       30
## 359          534  N37409               175     143       14        2
## 360          542  N79279               179     155      -17       -4
## 361          544  N18622               159     135      -10      -10
## 362          546  N11206               182     127       27       -3
## 363          558  N21723               172     146       -5       -6
## 364          570  N35407               262     232        6        4
## 365          582  N16642               254     198       50       14
## 366          586  N19130               119      99        5       15
## 367          597  N36444               209     178        1        2
## 368          599  N74856               140     118      -20       -4
## 369          601  N76529               159     118       11        8
## 370          606  N76523               113      93      -12       -1
## 371          616  N18220               185     145       14        0
## 372          623  N36272                65      42       -4       -2
## 373          632  N76522               190     169      -15        3
## 374          644  N12221               180     131       44       26
## 375          658  N37274               172     144        6        3
## 376          663  N13110               172     147       -1       -1
## 377          667  N75851               264     239        5       19
## 378          670  N76504               268     228       41       41
## 379          682  N26215               217     194       -7        3
## 380          686  N75851               142     101       13       -1
## 381          697  N38403               198     177        0       12
## 382          709  N32404               303     255       26        1
## 383          723  N78524                61      43       -3       -3
## 384          732  N36272               200     170       19       14
## 385          738  N76515               209     190       -4       -1
## 386          739  N47414               207     185       -5        0
## 387          741  N76523                70      30       15       -4
## 388          744  N16709               172     128       19       10
## 389          746  N87527               152     120       22       30
## 390          752  N37298               191     167      -13       -4
## 391          755  N17620               129      90       61       55
## 392          756  N76519               220     197      -14       -9
## 393          763  N37281                64      43       -6       -2
## 394          767  N75432               265     247        2       21
## 395          770  N37293               260     231        9       10
## 396          771  N32404               247     229      -22       -1
## 397          786  N75853               126     107        0        7
## 398          788  N39728               161     138        0       -3
## 399          795  N26226               228     204        0        0
## 400          799  N77867               150     121       -7        0
## 401          810  N74007               213     175       17        9
## 402          820  N37409               173     150        7       11
## 403         1006  N73299               138      93       22        3
## 404         1010  N14653               202     171        8       22
## 405         1046  N75853               157     126       18       13
## 406         1048  N87527               133     111       -3        2
## 407         1058  N39726               159     145      -13       -2
## 408         1070  N73406               257     224        0        3
## 409         1079  N79521                53      39      -13       -4
## 410         1086  N77867               122     100       43       60
## 411         1088  N54711               158     128      -11       -1
## 412         1095  N18243               237     203       22       10
## 413         1097  N76522               194     176      -13       -5
## 414         1099  N77510               158     122       37       31
## 415         1411  N38268                70      30       30       17
## 416         1416  N73276               253     234       -1        0
## 417         1417  N59630               181     138        5       -1
## 418         1423  N53441                60      43       12       18
## 419         1448  N17719               149     111        4       -3
## 420         1459  N76516               217     201       -6        0
## 421         1476  N16632               212     187       82       63
## 422         1479  N33284                56      34       -4        0
## 423         1488  N23721               213     141       46        4
## 424         1495  N39418               226     194        7        2
## 425         1497  N78501               195     174       -1       16
## 426         1506  N77430               120      89        9       15
## 427         1511  N14731               254     204       27        5
## 428         1541  N14653                52      31       12       14
## 429         1544  N32626               157     134       -6       -4
## 430         1546  N79279               159     125       29       27
## 431         1548  N37408               136     109        0        8
## 432         1558  N77295                61      30       23       18
## 433         1562  N76516               125     106        7       12
## 434         1568  N14613               152      96       36       10
## 435         1583  N38417                52      31       -1       -2
## 436         1586  N37420               143     101       30       24
## 437         1589  N76254               217     195       11        9
## 438         1590  N21723               124     107      -20       -1
## 439         1603  N73299               189     151       21        2
## 440         1605  N38417               236     198       51       40
## 441         1620  N37420               194     153       17        2
## 442         1621  N16646                80      55       -2       -2
## 443         1623  N37409                61      42       -8       -6
## 444         1629  N15710               236     218       19       10
## 445         1632  N39726               193     172        3        7
## 446         1644  N73283               241     220       -7        7
## 447         1646  N35407               142     115       -7       -1
## 448         1648  N38257               129     112      -15        2
## 449         1662  N34222               152      99       29        8
## 450         1674  N11641               137     108       -2       -6
## 451         1676  N75433               181     154        9       20
## 452         1679  N76288                63      40        1       -2
## 453         1688  N16617               183     155        5       -5
## 454         1689  N14237               233     201       18        5
## 455         1690  N37255               142     109       -4       -3
## 456         1695  N76505               242     211       26       15
## 457         1705  N76503                75      55       -5       -1
## 458         1711  N16649               108      59       28        8
## 459         1715  N19621               143     124        8       15
## 460         1717  N38417               208     195       89       94
## 461         1723  N35271               210     193       -8       -1
## 462         1728  N37408                43      27      -15       -3
## 463         1746  N38403               141     115      -12       -3
## 464         1748  N57439               160     107       53       39
## 465         1757  N16642               121      88       -9       -1
## 466         1767  N37293               259     237      -20        0
## 467         1776  N14219               216     156       45       22
## 468         1779  N33262                53      34        2       10
## 469         1783  N17229               163     138      -11       -3
## 470         1787  N17614                61      38       58       69
## 471         1790  N73283               132     109        4       12
## 472         1795  N57852               231     203       22       18
## 473         1821  N24715               219     200        2       13
## 474         1823  N14653                96      44       35        3
## 475         1830  N30401               166     105       23       -1
## 476         1832  N33266               223     173       24        1
##        Origin Dest Distance TaxiIn TaxiOut Cancelled CancellationCode
## 1         IAH  SEA     1874      7      20         0                 
## 2         IAH  SEA     1874      7      16         0                 
## 3         IAH  SEA     1874      4      16         0                 
## 4         IAH  SEA     1874      8      11         0                 
## 5         IAH  SEA     1874      5      10         0                 
## 6         IAH  SEA     1874      3      18         0                 
## 7         IAH  SEA     1874      7      14         0                 
## 8         IAH  SEA     1874      6      15         0                 
## 9         IAH  SEA     1874      5      32         0                 
## 10        IAH  SEA     1874      4      20         0                 
## 11        IAH  SEA     1874      4      18         0                 
## 12        IAH  SEA     1874      5      18         0                 
## 13        IAH  SEA     1874      5      15         0                 
## 14        IAH  SEA     1874      7      19         0                 
## 15        IAH  SEA     1874      4      18         0                 
## 16        IAH  SEA     1874      5      20         0                 
## 17        IAH  SEA     1874      4      17         0                 
## 18        IAH  SEA     1874      4      14         0                 
## 19        IAH  SEA     1874      7      10         0                 
## 20        IAH  SEA     1874      3      26         0                 
## 21        IAH  SEA     1874      7      14         0                 
## 22        IAH  SEA     1874      4      11         0                 
## 23        IAH  SEA     1874      5      12         0                 
## 24        IAH  SEA     1874      3      31         0                 
## 25        IAH  SEA     1874      4      16         0                 
## 26        IAH  SEA     1874      6      24         0                 
## 27        IAH  SEA     1874      5      11         0                 
## 28        IAH  SEA     1874      3      12         0                 
## 29        IAH  SEA     1874      3      12         0                 
## 30        IAH  SEA     1874      6      37         0                 
## 31        IAH  SEA     1874      6      19         0                 
## 32        HOU  JFK     1428      6      23         0                 
## 33        HOU  JFK     1428     12      11         0                 
## 34        HOU  JFK     1428      6      12         0                 
## 35        HOU  JFK     1428      9      31         0                 
## 36        HOU  JFK     1428      3      12         0                 
## 37        HOU  JFK     1428      5       9         0                 
## 38        HOU  JFK     1428      9      12         0                 
## 39        HOU  JFK     1428      8      23         0                 
## 40        HOU  JFK     1428      4      12         0                 
## 41        HOU  JFK     1428     14      10         0                 
## 42        HOU  JFK     1428      7       9         0                 
## 43        HOU  JFK     1428      6      25         0                 
## 44        HOU  JFK     1428      9      10         0                 
## 45        HOU  JFK     1428      9      13         0                 
## 46        HOU  JFK     1428      3      20         0                 
## 47        HOU  JFK     1428     11      12         0                 
## 48        HOU  JFK     1428      4      16         0                 
## 49        HOU  JFK     1428      7      10         0                 
## 50        HOU  JFK     1428      5      14         0                 
## 51        HOU  JFK     1428     NA      NA         1                B
## 52        HOU  JFK     1428      8      16         0                 
## 53        HOU  JFK     1428      8      10         0                 
## 54        HOU  JFK     1428      7       9         0                 
## 55        HOU  JFK     1428      8      24         0                 
## 56        HOU  JFK     1428      4      17         0                 
## 57        HOU  JFK     1428      4      13         0                 
## 58        HOU  JFK     1428      5      12         0                 
## 59        HOU  JFK     1428      4      13         0                 
## 60        HOU  JFK     1428      7      15         0                 
## 61        HOU  JFK     1428      6      15         0                 
## 62        HOU  JFK     1428      4      21         0                 
## 63        HOU  JFK     1428     NA      NA         1                A
## 64        HOU  JFK     1428     16      17         0                 
## 65        HOU  JFK     1428      5      19         0                 
## 66        HOU  JFK     1428      6      11         0                 
## 67        HOU  JFK     1428      3      21         0                 
## 68        HOU  JFK     1428      6      12         0                 
## 69        HOU  JFK     1428      6       8         0                 
## 70        HOU  JFK     1428      4      12         0                 
## 71        HOU  JFK     1428      4      11         0                 
## 72        HOU  JFK     1428      8      14         0                 
## 73        HOU  JFK     1428      7      12         0                 
## 74        HOU  JFK     1428      6      15         0                 
## 75        HOU  JFK     1428     NA      NA         1                B
## 76        HOU  JFK     1428      4      16         0                 
## 77        HOU  JFK     1428      7      12         0                 
## 78        HOU  JFK     1428      7      24         0                 
## 79        HOU  JFK     1428      8      12         0                 
## 80        HOU  JFK     1428     13      10         0                 
## 81        HOU  JFK     1428      8      12         0                 
## 82        HOU  JFK     1428      9      12         0                 
## 83        IAH  HNL     3904      6      31         0                 
## 84        IAH  MSY      305      3      15         0                 
## 85        IAH  SAT      191      2      14         0                 
## 86        IAH  MSY      305      7      21         0                 
## 87        IAH  AUS      140      7      20         0                 
## 88        IAH  LAX     1379      8      20         0                 
## 89        IAH  LAX     1379     11      17         0                 
## 90        IAH  DEN      862     12      16         0                 
## 91        IAH  EWR     1400     29      11         0                 
## 92        IAH  EWR     1400     16      24         0                 
## 93        IAH  EWR     1400      6      14         0                 
## 94        IAH  EWR     1400      8      18         0                 
## 95        IAH  MSY      305      6      33         0                 
## 96        IAH  LAX     1379     10      27         0                 
## 97        IAH  ORD      925     15      16         0                 
## 98        IAH  ONT     1334      5      17         0                 
## 99        IAH  DCA     1208      4      34         0                 
## 100       IAH  SFO     1635      6      10         0                 
## 101       IAH  MIA      964      5      20         0                 
## 102       IAH  LAS     1222      8      29         0                 
## 103       IAH  DEN      862     12      29         0                 
## 104       IAH  TPA      787      4      20         0                 
## 105       IAH  PDX     1825      4       8         0                 
## 106       IAH  EWR     1400     16      16         0                 
## 107       IAH  SJU     2007      6      16         0                 
## 108       IAH  PHX     1009      8      37         0                 
## 109       IAH  BWI     1235      5      15         0                 
## 110       IAH  LGA     1416      4      31         0                 
## 111       IAH  AUS      140      5      23         0                 
## 112       IAH  CLE     1091      5      18         0                 
## 113       IAH  RDU     1043      5      15         0                 
## 114       IAH  DCA     1208      4      24         0                 
## 115       IAH  SEA     1874      9      14         0                 
## 116       IAH  SFO     1635      7      27         0                 
## 117       IAH  DEN      862      8      16         0                 
## 118       IAH  SAT      191      3      22         0                 
## 119       IAH  BOS     1597      5      25         0                 
## 120       IAH  LAS     1222      7      18         0                 
## 121       IAH  DEN      862      6       9         0                 
## 122       IAH  PDX     1825      5      24         0                 
## 123       IAH  EWR     1400      7      22         0                 
## 124       IAH  PHX     1009      7      26         0                 
## 125       IAH  MSY      305      2      15         0                 
## 126       IAH  BWI     1235      4      13         0                 
## 127       IAH  LGA     1416      7      31         0                 
## 128       IAH  DCA     1208      3      18         0                 
## 129       IAH  SFO     1635      6      29         0                 
## 130       IAH  SAT      191      3      18         0                 
## 131       IAH  BOS     1597     10      21         0                 
## 132       IAH  LAS     1222      7      11         0                 
## 133       IAH  IND      845      5      33         0                 
## 134       IAH  SAN     1303      4      14         0                 
## 135       IAH  IAD     1190      5      21         0                 
## 136       IAH  IAD     1190     13      23         0                 
## 137       IAH  EWR     1400     11      26         0                 
## 138       IAH  IAD     1190      9       8         0                 
## 139       IAH  SJC     1609      2      14         0                 
## 140       IAH  MSY      305      2      19         0                 
## 141       IAH  BWI     1235      4      18         0                 
## 142       IAH  LGA     1416      6      23         0                 
## 143       IAH  TUL      429     NA      NA         1                B
## 144       IAH  ORD      925     18      22         0                 
## 145       IAH  ORD      925     11      16         0                 
## 146       IAH  DCA     1208      4      15         0                 
## 147       IAH  SEA     1874      5      15         0                 
## 148       IAH  SAT      191      3      14         0                 
## 149       IAH  BOS     1597     11      20         0                 
## 150       IAH  LAS     1222      7      36         0                 
## 151       IAH  DEN      862      6      26         0                 
## 152       IAH  IND      845     NA      NA         1                B
## 153       IAH  EWR     1400      7      17         0                 
## 154       IAH  MFE      316      4      17         0                 
## 155       IAH  PHX     1009      8      12         0                 
## 156       IAH  LGA     1416      7      40         0                 
## 157       IAH  PIT     1117      7      18         0                 
## 158       IAH  SLC     1195      4      17         0                 
## 159       IAH  CLE     1091      6      21         0                 
## 160       IAH  ORD      925     10      29         0                 
## 161       IAH  DCA     1208      5      16         0                 
## 162       IAH  SNA     1347      6      35         0                 
## 163       IAH  SFO     1635      7      10         0                 
## 164       IAH  BOS     1597      7      16         0                 
## 165       IAH  MCO      853      9      21         0                 
## 166       IAH  LAS     1222      9      12         0                 
## 167       IAH  DEN      862     10      25         0                 
## 168       IAH  DEN      862     18      34         0                 
## 169       IAH  TPA      787      6      17         0                 
## 170       IAH  MSP     1034     11      25         0                 
## 171       IAH  MSY      305      3      26         0                 
## 172       IAH  BWI     1235      4      11         0                 
## 173       IAH  LGA     1416      5      14         0                 
## 174       IAH  CLE     1091      5      16         0                 
## 175       IAH  DCA     1208      9      16         0                 
## 176       IAH  EGE      935      4      16         0                 
## 177       IAH  SEA     1874      6      11         0                 
## 178       IAH  BOS     1597      9      13         0                 
## 179       IAH  MCO      853      8      21         0                 
## 180       IAH  LAS     1222      7      32         0                 
## 181       IAH  TPA      787      3      20         0                 
## 182       IAH  PDX     1825      7      11         0                 
## 183       IAH  MSY      305      2      17         0                 
## 184       IAH  LGA     1416      5      27         0                 
## 185       IAH  SAN     1303      3      13         0                 
## 186       IAH  SAN     1303      4      35         0                 
## 187       IAH  AUS      140      5      20         0                 
## 188       IAH  CLE     1091      5      28         0                 
## 189       IAH  ORD      925     11      24         0                 
## 190       IAH  SLC     1195      5      18         0                 
## 191       IAH  ATL      689      9      16         0                 
## 192       IAH  MSY      305      3      10         0                 
## 193       IAH  SEA     1874      6      30         0                 
## 194       IAH  SFO     1635      5       6         0                 
## 195       IAH  SFO     1635      7      29         0                 
## 196       IAH  PHL     1324      9      19         0                 
## 197       IAH  MCO      853      6      16         0                 
## 198       IAH  DTW     1076      8      19         0                 
## 199       IAH  LAX     1379     13      15         0                 
## 200       IAH  DEN      862     17      15         0                 
## 201       IAH  EWR     1400     14      18         0                 
## 202       IAH  PHX     1009      6      22         0                 
## 203       IAH  TPA      787      3      13         0                 
## 204       IAH  EWR     1400      9      16         0                 
## 205       IAH  ORD      925      7      10         0                 
## 206       IAH  FLL      965      3      25         0                 
## 207       IAH  DCA     1208      4      17         0                 
## 208       IAH  SFO     1635      5      18         0                 
## 209       IAH  SAT      191      3      28         0                 
## 210       IAH  MCO      853      6      16         0                 
## 211       IAH  DTW     1076      6      34         0                 
## 212       IAH  LAX     1379      7      12         0                 
## 213       IAH  LAS     1222      7      25         0                 
## 214       IAH  DEN      862     12      11         0                 
## 215       IAH  AUS      140      6      16         0                 
## 216       IAH  SJC     1609      3      14         0                 
## 217       IAH  PIT     1117      6      13         0                 
## 218       IAH  MSY      305      6      26         0                 
## 219       IAH  CLT      913      6      12         0                 
## 220       IAH  FLL      965      5      23         0                 
## 221       IAH  SNA     1347      8      13         0                 
## 222       IAH  RSW      861      5      23         0                 
## 223       IAH  PHL     1324     14      19         0                 
## 224       IAH  SAT      191      3      12         0                 
## 225       IAH  DTW     1076      6      22         0                 
## 226       IAH  LAX     1379      8      33         0                 
## 227       IAH  LAS     1222      7      15         0                 
## 228       IAH  DCA     1208      4      15         0                 
## 229       IAH  TPA      787      4       9         0                 
## 230       IAH  SNA     1347      8      15         0                 
## 231       IAH  AUS      140      7      25         0                 
## 232       IAH  AUS      140      5      30         0                 
## 233       IAH  CLE     1091      4      15         0                 
## 234       IAH  ORD      925     13      10         0                 
## 235       IAH  FLL      965      4      13         0                 
## 236       IAH  RSW      861      4      19         0                 
## 237       IAH  MCI      643      7      19         0                 
## 238       IAH  AUS      140      5      29         0                 
## 239       IAH  MCO      853      7      12         0                 
## 240       IAH  SAN     1303      4      31         0                 
## 241       IAH  MIA      964      6      21         0                 
## 242       IAH  AUS      140      5      16         0                 
## 243       IAH  LAX     1379      9      24         0                 
## 244       IAH  PHX     1009      6      22         0                 
## 245       IAH  MFE      316      3      17         0                 
## 246       IAH  MSY      305      3      14         0                 
## 247       IAH  SNA     1347      5      17         0                 
## 248       IAH  LGA     1416      5      12         0                 
## 249       IAH  MFE      316      6      13         0                 
## 250       IAH  SMF     1609      3      12         0                 
## 251       IAH  ORD      925     11      15         0                 
## 252       IAH  FLL      965      5      15         0                 
## 253       IAH  RSW      861      4      21         0                 
## 254       IAH  ELP      667      6      22         0                 
## 255       IAH  PHL     1324     11      18         0                 
## 256       IAH  SAT      191      3      33         0                 
## 257       IAH  DTW     1076      7      23         0                 
## 258       IAH  SAN     1303      4      18         0                 
## 259       IAH  MIA      964      5      21         0                 
## 260       IAH  LAX     1379     11      30         0                 
## 261       IAH  MFE      316      4      21         0                 
## 262       IAH  OKC      395     NA      NA         1                B
## 263       IAH  SMF     1609      5      33         0                 
## 264       IAH  ABQ      744      8      20         0                 
## 265       IAH  SAN     1303      3      23         0                 
## 266       IAH  ONT     1334      4      11         0                 
## 267       IAH  ORD      925     12      30         0                 
## 268       IAH  FLL      965      5      16         0                 
## 269       IAH  ATL      689     17      25         0                 
## 270       IAH  SEA     1874      9      18         0                 
## 271       IAH  PHL     1324      7      23         0                 
## 272       IAH  SAT      191      3      15         0                 
## 273       IAH  TUS      936      7      24         0                 
## 274       IAH  DFW      224      4      16         0                 
## 275       IAH  MIA      964      5      16         0                 
## 276       IAH  LAX     1379     15      14         0                 
## 277       IAH  SNA     1347      7      31         0                 
## 278       IAH  MSY      305      5      22         0                 
## 279       IAH  PBI      956      5      19         0                 
## 280       IAH  LGA     1416      7      13         0                 
## 281       IAH  PHL     1324     21      11         0                 
## 282       IAH  CLE     1091      7      30         0                 
## 283       IAH  RDU     1043      6      16         0                 
## 284       IAH  OMA      781     10      16         0                 
## 285       IAH  MCO      853      6      26         0                 
## 286       IAH  HDN      986      5      15         0                 
## 287       IAH  SMF     1609      5      17         0                 
## 288       IAH  HNL     3904     13      19         0                 
## 289       IAH  MSY      305      3      15         0                 
## 290       IAH  SAT      191      6      17         0                 
## 291       IAH  MSY      305      5      13         0                 
## 292       IAH  AUS      140      9      20         0                 
## 293       IAH  LAX     1379     15      33         0                 
## 294       IAH  LAX     1379      7      31         0                 
## 295       IAH  DEN      862      8      29         0                 
## 296       IAH  EWR     1400     12      14         0                 
## 297       IAH  EWR     1400      9      15         0                 
## 298       IAH  EWR     1400      8      15         0                 
## 299       IAH  EWR     1400     14      28         0                 
## 300       IAH  MSY      305      6      21         0                 
## 301       IAH  LAX     1379     10      14         0                 
## 302       IAH  ORD      925     15      38         0                 
## 303       IAH  ONT     1334      4      12         0                 
## 304       IAH  DCA     1208      4      17         0                 
## 305       IAH  SFO     1635      8      30         0                 
## 306       IAH  MIA      964      4      25         0                 
## 307       IAH  LAS     1222      7      37         0                 
## 308       IAH  DEN      862      5      14         0                 
## 309       IAH  TPA      787      5      23         0                 
## 310       IAH  PDX     1825      5      10         0                 
## 311       IAH  EWR     1400      9      28         0                 
## 312       IAH  SJU     2007      5      16         0                 
## 313       IAH  PHX     1009      9      19         0                 
## 314       IAH  BWI     1235      6      26         0                 
## 315       IAH  LGA     1416      7      17         0                 
## 316       IAH  AUS      140      6      27         0                 
## 317       IAH  CLE     1091      7      25         0                 
## 318       IAH  RDU     1043      9      21         0                 
## 319       IAH  SEA     1874      6      17         0                 
## 320       IAH  SFO     1635      5      24         0                 
## 321       IAH  DEN      862      5      16         0                 
## 322       IAH  SAT      191      3      22         0                 
## 323       IAH  LAS     1222      6      12         0                 
## 324       IAH  DEN      862     24      26         0                 
## 325       IAH  PDX     1825      4      13         0                 
## 326       IAH  EWR     1400      6      53         0                 
## 327       IAH  PHX     1009      7      10         0                 
## 328       IAH  MSY      305      3      24         0                 
## 329       IAH  BWI     1235      5      28         0                 
## 330       IAH  GUC      886      4      45         0                 
## 331       IAH  DCA     1208     20      16         0                 
## 332       IAH  SFO     1635      7      16         0                 
## 333       IAH  SAT      191      4      29         0                 
## 334       IAH  BOS     1597      5      17         0                 
## 335       IAH  LAS     1222      7      33         0                 
## 336       IAH  IND      845      5      36         0                 
## 337       IAH  SAN     1303      3      19         0                 
## 338       IAH  IAD     1190      7      10         0                 
## 339       IAH  IAD     1190      9      37         0                 
## 340       IAH  EWR     1400     11      13         0                 
## 341       IAH  IAD     1190      6      13         0                 
## 342       IAH  SJC     1609      5      37         0                 
## 343       IAH  MSY      305     10      34         0                 
## 344       IAH  BWI     1235      7      38         0                 
## 345       IAH  LGA     1416      5      30         0                 
## 346       IAH  TUL      429      7      38         0                 
## 347       IAH  ORD      925      5      33         0                 
## 348       IAH  DCA     1208      3      22         0                 
## 349       IAH  SEA     1874      6      14         0                 
## 350       IAH  SAT      191      6      37         0                 
## 351       IAH  BOS     1597      8      39         0                 
## 352       IAH  LAS     1222      7      19         0                 
## 353       IAH  DEN      862      5      41         0                 
## 354       IAH  IND      845      9      42         0                 
## 355       IAH  EWR     1400     12      20         0                 
## 356       IAH  MFE      316      4       9         0                 
## 357       IAH  PHX     1009      5      22         0                 
## 358       IAH  LGA     1416      6      10         0                 
## 359       IAH  PIT     1117      6      26         0                 
## 360       IAH  SLC     1195      7      17         0                 
## 361       IAH  CLE     1091      7      17         0                 
## 362       IAH  ORD      925     15      40         0                 
## 363       IAH  DCA     1208      5      21         0                 
## 364       IAH  SFO     1635      8      22         0                 
## 365       IAH  BOS     1597      6      50         0                 
## 366       IAH  MCO      853      6      14         0                 
## 367       IAH  LAS     1222      7      24         0                 
## 368       IAH  DEN      862      6      16         0                 
## 369       IAH  DEN      862     10      31         0                 
## 370       IAH  TPA      787      5      15         0                 
## 371       IAH  MSP     1034      5      35         0                 
## 372       IAH  MSY      305      3      20         0                 
## 373       IAH  LGA     1416      6      15         0                 
## 374       IAH  CLE     1091      5      44         0                 
## 375       IAH  DCA     1208      4      24         0                 
## 376       IAH  EGE      935     11      14         0                 
## 377       IAH  SEA     1874      7      18         0                 
## 378       IAH  SFO     1635      7      33         0                 
## 379       IAH  BOS     1597      5      18         0                 
## 380       IAH  MCO      853      7      34         0                 
## 381       IAH  LAS     1222      5      16         0                 
## 382       IAH  PDX     1825      9      39         0                 
## 383       IAH  MSY      305      3      15         0                 
## 384       IAH  LGA     1416      4      26         0                 
## 385       IAH  SAN     1303      4      15         0                 
## 386       IAH  SAN     1303      3      19         0                 
## 387       IAH  AUS      140      4      36         0                 
## 388       IAH  CLE     1091      4      40         0                 
## 389       IAH  ORD      925     14      18         0                 
## 390       IAH  SLC     1195      9      15         0                 
## 391       IAH  ATL      689     14      25         0                 
## 392       IAH  SNA     1347      7      16         0                 
## 393       IAH  MSY      305      4      17         0                 
## 394       IAH  SEA     1874      7      11         0                 
## 395       IAH  SFO     1635      7      22         0                 
## 396       IAH  SFO     1635      7      11         0                 
## 397       IAH  MCO      853      6      13         0                 
## 398       IAH  DTW     1076      7      16         0                 
## 399       IAH  LAX     1379      7      17         0                 
## 400       IAH  DEN      862     15      14         0                 
## 401       IAH  EWR     1400     16      22         0                 
## 402       IAH  PHX     1009      3      20         0                 
## 403       IAH  TPA      787      4      41         0                 
## 404       IAH  EWR     1400      8      23         0                 
## 405       IAH  ORD      925      6      25         0                 
## 406       IAH  FLL      965      4      18         0                 
## 407       IAH  DCA     1208      3      11         0                 
## 408       IAH  SFO     1635      9      24         0                 
## 409       IAH  SAT      191      3      11         0                 
## 410       IAH  MCO      853      6      16         0                 
## 411       IAH  DTW     1076      7      23         0                 
## 412       IAH  LAX     1379     15      19         0                 
## 413       IAH  LAS     1222      6      12         0                 
## 414       IAH  DEN      862      5      31         0                 
## 415       IAH  AUS      140      6      34         0                 
## 416       IAH  SJC     1609      5      14         0                 
## 417       IAH  PIT     1117      9      34         0                 
## 418       IAH  MSY      305      3      14         0                 
## 419       IAH  FLL      965      4      34         0                 
## 420       IAH  SNA     1347      6      10         0                 
## 421       IAH  PHL     1324      6      19         0                 
## 422       IAH  SAT      191      4      18         0                 
## 423       IAH  DTW     1076      7      65         0                 
## 424       IAH  LAX     1379     13      19         0                 
## 425       IAH  LAS     1222      6      15         0                 
## 426       IAH  TPA      787      5      26         0                 
## 427       IAH  SNA     1347     16      34         0                 
## 428       IAH  AUS      140      5      16         0                 
## 429       IAH  CLE     1091      7      16         0                 
## 430       IAH  ORD      925     11      23         0                 
## 431       IAH  FLL      965      4      23         0                 
## 432       IAH  AUS      140      6      25         0                 
## 433       IAH  RSW      861      5      14         0                 
## 434       IAH  MCI      643      7      49         0                 
## 435       IAH  AUS      140      7      14         0                 
## 436       IAH  MCO      853      6      36         0                 
## 437       IAH  SAN     1303      3      19         0                 
## 438       IAH  MIA      964      5      12         0                 
## 439       IAH  DCA     1208      8      30         0                 
## 440       IAH  LAX     1379      8      30         0                 
## 441       IAH  PHX     1009      6      35         0                 
## 442       IAH  MFE      316      5      20         0                 
## 443       IAH  MSY      305      3      16         0                 
## 444       IAH  SNA     1347      6      12         0                 
## 445       IAH  LGA     1416      5      16         0                 
## 446       IAH  SMF     1609      6      15         0                 
## 447       IAH  ORD      925     10      17         0                 
## 448       IAH  FLL      965      5      12         0                 
## 449       IAH  RSW      861      5      48         0                 
## 450       IAH  ELP      667      4      25         0                 
## 451       IAH  PHL     1324      5      22         0                 
## 452       IAH  SAT      191      3      20         0                 
## 453       IAH  DTW     1076      8      20         0                 
## 454       IAH  SAN     1303      2      30         0                 
## 455       IAH  MIA      964      6      27         0                 
## 456       IAH  LAX     1379      8      23         0                 
## 457       IAH  MFE      316      4      16         0                 
## 458       IAH  OKC      395      6      43         0                 
## 459       IAH  ABQ      744      5      14         0                 
## 460       IAH  SAN     1303      3      10         0                 
## 461       IAH  ONT     1334      3      14         0                 
## 462       IAH  AUS      140      4      12         0                 
## 463       IAH  ORD      925     13      13         0                 
## 464       IAH  FLL      965      4      49         0                 
## 465       IAH  ATL      689     10      23         0                 
## 466       IAH  SEA     1874      5      17         0                 
## 467       IAH  PHL     1324      5      55         0                 
## 468       IAH  SAT      191      3      16         0                 
## 469       IAH  TUS      936      6      19         0                 
## 470       IAH  DFW      224      4      19         0                 
## 471       IAH  MIA      964      7      16         0                 
## 472       IAH  LAX     1379     10      18         0                 
## 473       IAH  SNA     1347      5      14         0                 
## 474       IAH  MSY      305      3      49         0                 
## 475       IAH  PBI      956      4      57         0                 
## 476       IAH  LGA     1416      5      45         0                 
##        Diverted
## 1             0
## 2             0
## 3             0
## 4             0
## 5             0
## 6             0
## 7             0
## 8             0
## 9             0
## 10            0
## 11            1
## 12            0
## 13            0
## 14            0
## 15            0
## 16            0
## 17            0
## 18            0
## 19            0
## 20            0
## 21            0
## 22            0
## 23            0
## 24            0
## 25            0
## 26            0
## 27            0
## 28            0
## 29            0
## 30            0
## 31            0
## 32            0
## 33            0
## 34            0
## 35            0
## 36            0
## 37            0
## 38            0
## 39            0
## 40            0
## 41            0
## 42            0
## 43            0
## 44            0
## 45            0
## 46            0
## 47            0
## 48            0
## 49            0
## 50            0
## 51            0
## 52            0
## 53            0
## 54            0
## 55            0
## 56            0
## 57            0
## 58            0
## 59            0
## 60            0
## 61            0
## 62            0
## 63            0
## 64            0
## 65            0
## 66            0
## 67            0
## 68            0
## 69            0
## 70            0
## 71            0
## 72            0
## 73            0
## 74            0
## 75            0
## 76            0
## 77            0
## 78            0
## 79            0
## 80            0
## 81            0
## 82            0
## 83            0
## 84            0
## 85            0
## 86            0
## 87            0
## 88            0
## 89            0
## 90            0
## 91            0
## 92            0
## 93            0
## 94            0
## 95            0
## 96            0
## 97            0
## 98            0
## 99            0
## 100           0
## 101           0
## 102           0
## 103           0
## 104           0
## 105           0
## 106           0
## 107           0
## 108           0
## 109           0
## 110           0
## 111           0
## 112           0
## 113           0
## 114           0
## 115           0
## 116           0
## 117           0
## 118           0
## 119           0
## 120           0
## 121           0
## 122           0
## 123           0
## 124           0
## 125           0
## 126           0
## 127           0
## 128           0
## 129           0
## 130           0
## 131           0
## 132           0
## 133           0
## 134           0
## 135           0
## 136           0
## 137           0
## 138           0
## 139           0
## 140           0
## 141           0
## 142           0
## 143           0
## 144           0
## 145           0
## 146           0
## 147           0
## 148           0
## 149           0
## 150           0
## 151           0
## 152           0
## 153           0
## 154           0
## 155           0
## 156           0
## 157           0
## 158           0
## 159           0
## 160           0
## 161           0
## 162           0
## 163           0
## 164           0
## 165           0
## 166           0
## 167           0
## 168           0
## 169           0
## 170           0
## 171           0
## 172           0
## 173           0
## 174           0
## 175           0
## 176           0
## 177           0
## 178           0
## 179           0
## 180           0
## 181           0
## 182           0
## 183           0
## 184           0
## 185           0
## 186           0
## 187           0
## 188           0
## 189           0
## 190           0
## 191           0
## 192           0
## 193           0
## 194           0
## 195           0
## 196           0
## 197           0
## 198           0
## 199           0
## 200           0
## 201           0
## 202           0
## 203           0
## 204           0
## 205           0
## 206           0
## 207           0
## 208           0
## 209           0
## 210           0
## 211           0
## 212           0
## 213           0
## 214           0
## 215           0
## 216           0
## 217           0
## 218           0
## 219           0
## 220           0
## 221           0
## 222           0
## 223           0
## 224           0
## 225           0
## 226           0
## 227           0
## 228           0
## 229           0
## 230           0
## 231           0
## 232           0
## 233           0
## 234           0
## 235           0
## 236           0
## 237           0
## 238           0
## 239           0
## 240           0
## 241           0
## 242           0
## 243           0
## 244           0
## 245           0
## 246           0
## 247           0
## 248           0
## 249           0
## 250           0
## 251           0
## 252           0
## 253           0
## 254           0
## 255           0
## 256           0
## 257           0
## 258           0
## 259           0
## 260           0
## 261           0
## 262           0
## 263           0
## 264           0
## 265           0
## 266           0
## 267           0
## 268           0
## 269           0
## 270           0
## 271           0
## 272           0
## 273           0
## 274           0
## 275           0
## 276           0
## 277           0
## 278           0
## 279           0
## 280           0
## 281           0
## 282           0
## 283           0
## 284           0
## 285           0
## 286           0
## 287           0
## 288           0
## 289           0
## 290           0
## 291           0
## 292           0
## 293           0
## 294           0
## 295           0
## 296           0
## 297           0
## 298           0
## 299           0
## 300           0
## 301           0
## 302           0
## 303           0
## 304           0
## 305           0
## 306           0
## 307           0
## 308           0
## 309           0
## 310           0
## 311           0
## 312           0
## 313           0
## 314           0
## 315           0
## 316           0
## 317           0
## 318           0
## 319           0
## 320           0
## 321           0
## 322           0
## 323           0
## 324           0
## 325           0
## 326           0
## 327           0
## 328           0
## 329           0
## 330           0
## 331           0
## 332           0
## 333           0
## 334           0
## 335           0
## 336           0
## 337           0
## 338           0
## 339           0
## 340           0
## 341           0
## 342           0
## 343           0
## 344           0
## 345           0
## 346           0
## 347           0
## 348           0
## 349           0
## 350           0
## 351           0
## 352           0
## 353           0
## 354           0
## 355           0
## 356           0
## 357           0
## 358           0
## 359           0
## 360           0
## 361           0
## 362           0
## 363           0
## 364           0
## 365           0
## 366           0
## 367           0
## 368           0
## 369           0
## 370           0
## 371           0
## 372           0
## 373           0
## 374           0
## 375           0
## 376           0
## 377           0
## 378           0
## 379           0
## 380           0
## 381           0
## 382           0
## 383           0
## 384           0
## 385           0
## 386           0
## 387           0
## 388           0
## 389           0
## 390           0
## 391           0
## 392           0
## 393           0
## 394           0
## 395           0
## 396           0
## 397           0
## 398           0
## 399           0
## 400           0
## 401           0
## 402           0
## 403           0
## 404           0
## 405           0
## 406           0
## 407           0
## 408           0
## 409           0
## 410           0
## 411           0
## 412           0
## 413           0
## 414           0
## 415           0
## 416           0
## 417           0
## 418           0
## 419           0
## 420           0
## 421           0
## 422           0
## 423           0
## 424           0
## 425           0
## 426           0
## 427           0
## 428           0
## 429           0
## 430           0
## 431           0
## 432           0
## 433           0
## 434           0
## 435           0
## 436           0
## 437           0
## 438           0
## 439           0
## 440           0
## 441           0
## 442           0
## 443           0
## 444           0
## 445           0
## 446           0
## 447           0
## 448           0
## 449           0
## 450           0
## 451           0
## 452           0
## 453           0
## 454           0
## 455           0
## 456           0
## 457           0
## 458           0
## 459           0
## 460           0
## 461           0
## 462           0
## 463           0
## 464           0
## 465           0
## 466           0
## 467           0
## 468           0
## 469           0
## 470           0
## 471           0
## 472           0
## 473           0
## 474           0
## 475           0
## 476           0
##  [ reached getOption("max.print") -- omitted 221704 rows ]
{% endhighlight %}



{% highlight r %}
hflights %>% 
  filter(!is.na(UniqueCarrier)) # Bring up non-NAs
{% endhighlight %}



{% highlight text %}
##        Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 1      2011     1          1         6    1400    1500            AA
## 2      2011     1          2         7    1401    1501            AA
## 3      2011     1          3         1    1352    1502            AA
## 4      2011     1          4         2    1403    1513            AA
## 5      2011     1          5         3    1405    1507            AA
## 6      2011     1          6         4    1359    1503            AA
## 7      2011     1          7         5    1359    1509            AA
## 8      2011     1          8         6    1355    1454            AA
## 9      2011     1          9         7    1443    1554            AA
## 10     2011     1         10         1    1443    1553            AA
## 11     2011     1         11         2    1429    1539            AA
## 12     2011     1         12         3    1419    1515            AA
## 13     2011     1         13         4    1358    1501            AA
## 14     2011     1         14         5    1357    1504            AA
## 15     2011     1         15         6    1359    1459            AA
## 16     2011     1         16         7    1359    1509            AA
## 17     2011     1         17         1    1530    1634            AA
## 18     2011     1         18         2    1408    1508            AA
## 19     2011     1         19         3    1356    1503            AA
## 20     2011     1         20         4    1507    1622            AA
## 21     2011     1         21         5    1357    1459            AA
## 22     2011     1         22         6    1355    1456            AA
## 23     2011     1         23         7    1356    1501            AA
## 24     2011     1         24         1    1356    1513            AA
## 25     2011     1         25         2    1352    1452            AA
## 26     2011     1         26         3    1353    1455            AA
## 27     2011     1         27         4    1356    1458            AA
## 28     2011     1         28         5    1359    1505            AA
## 29     2011     1         29         6    1355    1455            AA
## 30     2011     1         30         7    1359    1456            AA
## 31     2011     1         31         1    1441    1553            AA
## 32     2011     1          1         6     728     840            AA
## 33     2011     1          2         7     719     821            AA
## 34     2011     1          3         1     717     834            AA
## 35     2011     1          4         2     714     821            AA
## 36     2011     1          5         3     718     822            AA
## 37     2011     1          6         4     719     821            AA
## 38     2011     1          7         5     711     827            AA
## 39     2011     1          8         6     713     805            AA
## 40     2011     1          9         7     714     829            AA
## 41     2011     1         10         1     715     818            AA
## 42     2011     1         11         2     717     820            AA
## 43     2011     1         12         3     714     814            AA
## 44     2011     1         13         4     722     841            AA
## 45     2011     1         14         5     715     828            AA
## 46     2011     1         15         6     719     833            AA
## 47     2011     1         16         7     743     843            AA
## 48     2011     1         17         1     724     842            AA
## 49     2011     1         18         2     721     827            AA
## 50     2011     1         19         3     714     833            AA
## 51     2011     1         20         4     719     822            AA
## 52     2011     1         21         5     712     811            AA
## 53     2011     1         22         6     717     829            AA
## 54     2011     1         23         7     710     814            AA
## 55     2011     1         24         1     731     904            AA
## 56     2011     1         25         2     719     818            AA
## 57     2011     1         26         3     716     824            AA
## 58     2011     1         27         4     715     825            AA
## 59     2011     1         28         5     741     846            AA
## 60     2011     1         29         6     720     825            AA
## 61     2011     1         30         7     716     820            AA
## 62     2011     1         31         1     718     816            AA
## 63     2011     1          2         7    1959    2106            AA
## 64     2011     1          3         1    1958    2107            AA
## 65     2011     1          4         2    2100    2207            AA
## 66     2011     1          5         3    1958    2106            AA
## 67     2011     1          6         4    1955    2103            AA
## 68     2011     1          7         5    1958    2055            AA
## 69     2011     1          9         7    2045    2155            AA
## 70     2011     1         10         1    2029    2133            AA
## 71     2011     1         11         2    1953    2051            AA
## 72     2011     1         12         3    2015    2113            AA
## 73     2011     1         13         4    2020    2116            AA
## 74     2011     1         14         5    2119    2229            AA
## 75     2011     1         16         7    1956    2119            AA
## 76     2011     1         17         1    2030    2131            AA
## 77     2011     1         18         2    1957    2106            AA
## 78     2011     1         19         3    2029    2123            AA
## 79     2011     1         20         4    2004    2121            AA
## 80     2011     1         21         5    2036    2134            AA
## 81     2011     1         23         7    2001    2057            AA
## 82     2011     1         24         1    2043    2139            AA
## 83     2011     1         25         2    2004    2107            AA
## 84     2011     1         26         3    2009    2103            AA
## 85     2011     1         27         4    2039    2130            AA
## 86     2011     1         28         5    1959    2100            AA
## 87     2011     1         30         7    1959    2132            AA
## 88     2011     1         31         1    1954    2105            AA
## 89     2011     1          1         6    1631    1736            AA
## 90     2011     1          2         7    1636    1759            AA
## 91     2011     1          3         1    1623    1738            AA
## 92     2011     1          4         2    1629    1732            AA
## 93     2011     1          5         3    1629    1740            AA
## 94     2011     1          6         4    1625    1732            AA
## 95     2011     1          7         5    1630    1733            AA
## 96     2011     1          8         6    1627    1736            AA
## 97     2011     1          9         7    1835    1951            AA
## 98     2011     1         10         1    1639    1740            AA
## 99     2011     1         11         2    1752    1855            AA
## 100    2011     1         12         3    1631    1739            AA
## 101    2011     1         13         4    1630    1733            AA
## 102    2011     1         14         5    1629    1734            AA
## 103    2011     1         15         6    1632    1736            AA
## 104    2011     1         16         7    1708    1819            AA
## 105    2011     1         17         1    1632    1744            AA
## 106    2011     1         18         2    1625    1740            AA
## 107    2011     1         19         3    1629    1731            AA
## 108    2011     1         20         4    1641    1752            AA
## 109    2011     1         21         5    1638    1746            AA
## 110    2011     1         22         6    1623    1742            AA
## 111    2011     1         23         7    1622    1738            AA
## 112    2011     1         24         1    1621    1749            AA
## 113    2011     1         25         2    1627    1733            AA
## 114    2011     1         26         3    1634    1745            AA
## 115    2011     1         27         4    1634    1740            AA
## 116    2011     1         28         5    1625    1730            AA
## 117    2011     1         29         6    1630    1731            AA
## 118    2011     1         30         7    1635    1733            AA
## 119    2011     1         31         1    1656    1758            AA
## 120    2011     1          1         6    1756    2112            AA
## 121    2011     1          2         7    1823    2132            AA
## 122    2011     1          3         1    1755    2106            AA
## 123    2011     1          4         2    1757    2122            AA
## 124    2011     1          5         3    1751    2100            AA
## 125    2011     1          6         4    1746    2120            AA
## 126    2011     1          7         5    1757    2108            AA
## 127    2011     1          8         6    1749    2100            AA
## 128    2011     1          9         7    1810    2123            AA
## 129    2011     1         10         1    1934    2235            AA
## 130    2011     1         11         2    1848    2156            AA
## 131    2011     1         12         3    1748    2102            AA
## 132    2011     1         13         4    1748    2127            AA
## 133    2011     1         14         5    1754    2101            AA
## 134    2011     1         15         6    1749    2059            AA
## 135    2011     1         16         7    1807    2137            AA
## 136    2011     1         17         1    1803    2121            AA
## 137    2011     1         18         2    1839    2154            AA
## 138    2011     1         19         3    1751    2103            AA
## 139    2011     1         20         4    1750    2114            AA
## 140    2011     1         21         5    1818    2133            AA
## 141    2011     1         22         6    1750    2055            AA
## 142    2011     1         23         7    1753    2113            AA
## 143    2011     1         24         1    1828    2146            AA
## 144    2011     1         25         2    1750    2118            AA
## 145    2011     1         26         3    1905    2211            AA
## 146    2011     1         27         4    1812    2129            AA
## 147    2011     1         28         5    1750    2108            AA
## 148    2011     1         29         6    1753    2102            AA
## 149    2011     1         30         7    1856    2209            AA
## 150    2011     1         31         1    1757    2101            AA
## 151    2011     1          3         1     907    1013            AA
## 152    2011     1          4         2     930    1030            AA
## 153    2011     1          5         3     916    1019            AA
## 154    2011     1          6         4     907    1015            AA
## 155    2011     1          7         5     904    1012            AA
## 156    2011     1         10         1     941    1113            AA
## 157    2011     1         11         2     901    1005            AA
## 158    2011     1         12         3     909    1009            AA
## 159    2011     1         13         4     907    1022            AA
## 160    2011     1         14         5     903    1012            AA
## 161    2011     1         17         1     930    1040            AA
## 162    2011     1         18         2     923    1030            AA
## 163    2011     1         19         3     916    1028            AA
## 164    2011     1         20         4     907    1018            AA
## 165    2011     1         21         5     918    1037            AA
## 166    2011     1         24         1     912    1017            AA
## 167    2011     1         25         2     901    1007            AA
## 168    2011     1         26         3     910    1018            AA
## 169    2011     1         27         4     908    1011            AA
## 170    2011     1         28         5     907    1012            AA
## 171    2011     1         31         1     941    1054            AA
## 172    2011     1          1         6    1012    1347            AA
## 173    2011     1          2         7    1008    1321            AA
## 174    2011     1          3         1    1018    1323            AA
## 175    2011     1          4         2    1026    1333            AA
## 176    2011     1          5         3    1021    1331            AA
## 177    2011     1          6         4    1020    1322            AA
## 178    2011     1          7         5    1010    1316            AA
## 179    2011     1          8         6    1019    1324            AA
## 180    2011     1          9         7    1029    1338            AA
## 181    2011     1         10         1    1038    1414            AA
## 182    2011     1         11         2    1134    1454            AA
## 183    2011     1         12         3    1019    1327            AA
## 184    2011     1         13         4    1018    1326            AA
## 185    2011     1         14         5    1024    1327            AA
## 186    2011     1         15         6    1022    1340            AA
## 187    2011     1         16         7    1021    1332            AA
## 188    2011     1         17         1    1019    1332            AA
## 189    2011     1         18         2    1017    1332            AA
## 190    2011     1         19         3    1016    1331            AA
## 191    2011     1         20         4    1015    1325            AA
## 192    2011     1         21         5    1017    1325            AA
## 193    2011     1         22         6    1026    1345            AA
## 194    2011     1         23         7    1012    1327            AA
## 195    2011     1         24         1      NA      NA            AA
## 196    2011     1         25         2    1040    1354            AA
## 197    2011     1         26         3    1015    1329            AA
## 198    2011     1         27         4    1017    1335            AA
## 199    2011     1         28         5    1020    1318            AA
## 200    2011     1         29         6    1015    1326            AA
## 201    2011     1         30         7    1019    1324            AA
## 202    2011     1         31         1    1013    1336            AA
## 203    2011     1          1         6    1211    1325            AA
## 204    2011     1          2         7    1200    1303            AA
## 205    2011     1          3         1    1204    1308            AA
## 206    2011     1          4         2    1206    1319            AA
## 207    2011     1          5         3    1205    1311            AA
## 208    2011     1          6         4    1204    1310            AA
## 209    2011     1          7         5    1204    1316            AA
## 210    2011     1          8         6    1202    1308            AA
## 211    2011     1          9         7      NA      NA            AA
## 212    2011     1         10         1    1217    1329            AA
## 213    2011     1         11         2    1205    1310            AA
## 214    2011     1         12         3    1206    1305            AA
## 215    2011     1         13         4    1205    1311            AA
## 216    2011     1         14         5    1205    1315            AA
## 217    2011     1         15         6    1222    1329            AA
## 218    2011     1         16         7    1205    1306            AA
## 219    2011     1         17         1    1205    1322            AA
## 220    2011     1         18         2    1235    1334            AA
## 221    2011     1         19         3    1204    1311            AA
## 222    2011     1         20         4    1214    1324            AA
## 223    2011     1         21         5    1206    1312            AA
## 224    2011     1         22         6    1200    1312            AA
## 225    2011     1         23         7    1217    1308            AA
## 226    2011     1         24         1    1212    1318            AA
## 227    2011     1         25         2    1159    1259            AA
## 228    2011     1         26         3    1159    1314            AA
## 229    2011     1         27         4    1159    1311            AA
## 230    2011     1         28         5    1255    1358            AA
## 231    2011     1         29         6    1156    1302            AA
## 232    2011     1         30         7    1159    1319            AA
## 233    2011     1         31         1    1205    1317            AA
## 234    2011     1          2         7     907    1018            AA
## 235    2011     1          8         6     902    1010            AA
## 236    2011     1          9         7     938    1050            AA
## 237    2011     1         15         6     905    1007            AA
## 238    2011     1         16         7     903    1012            AA
## 239    2011     1         22         6     930    1041            AA
## 240    2011     1         23         7     903    1023            AA
## 241    2011     1         29         6     903    1020            AA
## 242    2011     1         30         7     904    1013            AA
## 243    2011     1          1         6     557     906            AA
## 244    2011     1          2         7     554     912            AA
## 245    2011     1          3         1     555     905            AA
## 246    2011     1          4         2     558     923            AA
## 247    2011     1          5         3     555     914            AA
## 248    2011     1          6         4     600     908            AA
## 249    2011     1          7         5     556     905            AA
## 250    2011     1          8         6     558     910            AA
## 251    2011     1          9         7     558     911            AA
## 252    2011     1         10         1     605     920            AA
## 253    2011     1         11         2     553    1216            AA
## 254    2011     1         12         3     551     903            AA
## 255    2011     1         13         4     633     938            AA
## 256    2011     1         14         5     558     910            AA
## 257    2011     1         15         6     555     905            AA
## 258    2011     1         16         7     605     910            AA
## 259    2011     1         17         1     556     943            AA
## 260    2011     1         18         2     555     911            AA
## 261    2011     1         19         3     554     921            AA
## 262    2011     1         20         4     556     912            AA
## 263    2011     1         21         5     553     907            AA
## 264    2011     1         22         6     550     907            AA
## 265    2011     1         23         7     552     900            AA
## 266    2011     1         24         1     553     906            AA
## 267    2011     1         25         2     558     916            AA
## 268    2011     1         26         3     555     907            AA
## 269    2011     1         27         4     606     915            AA
## 270    2011     1         28         5     554     905            AA
## 271    2011     1         29         6     552     904            AA
## 272    2011     1         30         7     553     910            AA
## 273    2011     1         31         1     556     857            AA
## 274    2011     1          1         6    1824    2106            AS
## 275    2011     1          2         7    1823    2103            AS
## 276    2011     1          3         1    1827    2107            AS
## 277    2011     1          4         2    1845    2132            AS
## 278    2011     1          5         3    1821    2109            AS
## 279    2011     1          6         4    1834    2133            AS
## 280    2011     1          7         5    1823    2118            AS
## 281    2011     1          8         6    1822    2112            AS
## 282    2011     1          9         7    1938    2228            AS
## 283    2011     1         10         1    1820    2159            AS
## 284    2011     1         11         2    1820      12            AS
## 285    2011     1         12         3    1822    2129            AS
## 286    2011     1         13         4    1820    2113            AS
## 287    2011     1         14         5    1818    2114            AS
## 288    2011     1         15         6    1822    2131            AS
## 289    2011     1         16         7    1822    2138            AS
## 290    2011     1         17         1    1818    2149            AS
## 291    2011     1         18         2    1836    2130            AS
## 292    2011     1         19         3    1820    2102            AS
## 293    2011     1         20         4    1822    2135            AS
## 294    2011     1         21         5    1827    2136            AS
## 295    2011     1         22         6    1816    2100            AS
## 296    2011     1         23         7    1818    2104            AS
## 297    2011     1         24         1    1824    2109            AS
## 298    2011     1         25         2    1826    2101            AS
## 299    2011     1         26         3    1830    2115            AS
## 300    2011     1         27         4    1832    2110            AS
## 301    2011     1         28         5    1821    2052            AS
## 302    2011     1         29         6    1821    2042            AS
## 303    2011     1         30         7    1821    2128            AS
## 304    2011     1         31         1    1827    2111            AS
## 305    2011     1          1         6     654    1124            B6
## 306    2011     1          1         6    1639    2110            B6
## 307    2011     1          2         7     703    1113            B6
## 308    2011     1          2         7    1604    2040            B6
## 309    2011     1          3         1     659    1100            B6
## 310    2011     1          3         1    1801    2200            B6
## 311    2011     1          4         2     654    1103            B6
## 312    2011     1          4         2    1608    2034            B6
## 313    2011     1          5         3     700    1103            B6
## 314    2011     1          5         3    1544    1954            B6
## 315    2011     1          6         4    1532    1943            B6
## 316    2011     1          7         5     654    1117            B6
## 317    2011     1          7         5    1542    1956            B6
## 318    2011     1          8         6     654    1058            B6
## 319    2011     1          9         7     653    1059            B6
## 320    2011     1          9         7    1618    2057            B6
## 321    2011     1         10         1     656    1102            B6
## 322    2011     1         10         1    1554    2001            B6
## 323    2011     1         11         2     653    1053            B6
## 324    2011     1         11         2      NA      NA            B6
## 325    2011     1         12         3    1532    1953            B6
## 326    2011     1         13         4    1522    1938            B6
## 327    2011     1         14         5     808    1229            B6
## 328    2011     1         14         5    1534    2015            B6
## 329    2011     1         15         6     700    1114            B6
## 330    2011     1         16         7     652    1055            B6
## 331    2011     1         16         7    1551    2004            B6
## 332    2011     1         17         1     730    1135            B6
## 333    2011     1         17         1    1531    1946            B6
## 334    2011     1         18         2     659    1102            B6
## 335    2011     1         18         2    1647    2056            B6
## 336    2011     1         19         3      NA      NA            B6
## 337    2011     1         20         4    1538    1952            B6
## 338    2011     1         21         5     656    1104            B6
## 339    2011     1         21         5    1725    2135            B6
## 340    2011     1         22         6     701    1106            B6
## 341    2011     1         23         7     658    1058            B6
## 342    2011     1         23         7    1535    1933            B6
## 343    2011     1         24         1     707    1059            B6
## 344    2011     1         24         1    1532    1923            B6
## 345    2011     1         25         2     658    1102            B6
## 346    2011     1         25         2    1623    2029            B6
## 347    2011     1         26         3    1535    1941            B6
## 348    2011     1         27         4      NA      NA            B6
## 349    2011     1         28         5     655    1107            B6
## 350    2011     1         28         5    1538    2013            B6
## 351    2011     1         29         6     657    1128            B6
## 352    2011     1         30         7     651    1106            B6
## 353    2011     1         30         7    1659    2118            B6
## 354    2011     1         31         1     659    1111            B6
## 355    2011     1         31         1    1532    1942            B6
## 356    2011     1         31         1     924    1413            CO
## 357    2011     1         31         1    1825    1925            CO
## 358    2011     1         31         1    1554    1650            CO
## 359    2011     1         31         1    1522    1632            CO
## 360    2011     1         31         1    1536    1635            CO
## 361    2011     1         31         1    1916    2103            CO
## 362    2011     1         31         1     747     936            CO
## 363    2011     1         31         1    1803    1927            CO
## 364    2011     1         31         1    1206    1631            CO
## 365    2011     1         31         1    1425    1848            CO
## 366    2011     1         31         1     607    1022            CO
## 367    2011     1         31         1    1041    1449            CO
## 368    2011     1         31         1     728     856            CO
## 369    2011     1         31         1    1433    1629            CO
## 370    2011     1         31         1    1422    1647            CO
## 371    2011     1         31         1    1750    1921            CO
## 372    2011     1         31         1    1442    1842            CO
## 373    2011     1         31         1     851    1052            CO
## 374    2011     1         31         1    1919    2231            CO
## 375    2011     1         31         1    1155    1324            CO
## 376    2011     1         31         1     726     915            CO
## 377    2011     1         31         1    1259    1554            CO
## 378    2011     1         31         1    2116    2344            CO
## 379    2011     1         31         1    1551    2009            CO
## 380    2011     1         31         1    1024    1621            CO
## 381    2011     1         31         1     912    1138            CO
## 382    2011     1         31         1    1020    1421            CO
## 383    2011     1         31         1     916    1336            CO
## 384    2011     1         31         1    1301    1356            CO
## 385    2011     1         31         1    1554    1918            CO
## 386    2011     1         31         1    1850    2211            CO
## 387    2011     1         31         1     727    1120            CO
## 388    2011     1         31         1    1240    1526            CO
## 389    2011     1         31         1    1129    1351            CO
## 390    2011     1         31         1    1615    1741            CO
## 391    2011     1         31         1    1145    1255            CO
## 392    2011     1         31         1     735    1220            CO
## 393    2011     1         31         1    1046    1221            CO
## 394    2011     1         31         1    2102    2216            CO
## 395    2011     1         31         1     854    1137            CO
## 396    2011     1         31         1    1949       2            CO
## 397    2011     1         31         1    1431    1643            CO
## 398    2011     1         31         1    1312    1413            CO
## 399    2011     1         31         1    1248    1628            CO
## 400    2011     1         31         1     742    1217            CO
## 401    2011     1         31         1    1033    1420            CO
## 402    2011     1         31         1    1432    1656            CO
## 403    2011     1         31         1    1320    1420            CO
## 404    2011     1         31         1    1047    1526            CO
## 405    2011     1         31         1    1902    2022            CO
## 406    2011     1         31         1    1316    1643            CO
## 407    2011     1         31         1    1031    1203            CO
## 408    2011     1         31         1     725    1117            CO
## 409    2011     1         31         1    1156    1555            CO
## 410    2011     1         31         1     749    1216            CO
## 411    2011     1         31         1    1701    2036            CO
## 412    2011     1         31         1    1911    2118            CO
## 413    2011     1         31         1    1924    2026            CO
## 414    2011     1         31         1    1909    2254            CO
## 415    2011     1         31         1    1049    1507            CO
## 416    2011     1         31         1      NA      NA            CO
## 417    2011     1         31         1    1925    2202            CO
## 418    2011     1         31         1     554     818            CO
## 419    2011     1         31         1    1250    1638            CO
## 420    2011     1         31         1    2157      53            CO
## 421    2011     1         31         1    1911    2011            CO
## 422    2011     1         31         1    1305    1746            CO
## 423    2011     1         31         1     906    1056            CO
## 424    2011     1         31         1    1148    1327            CO
## 425    2011     1         31         1      NA      NA            CO
## 426    2011     1         31         1     855    1322            CO
## 427    2011     1         31         1    2056    2217            CO
## 428    2011     1         31         1    1738    1939            CO
## 429    2011     1         31         1    1322    1807            CO
## 430    2011     1         31         1    1257    1627            CO
## 431    2011     1         31         1     934    1149            CO
## 432    2011     1         31         1     638    1021            CO
## 433    2011     1         31         1    1146    1421            CO
## 434    2011     1         31         1    1611    1955            CO
## 435    2011     1         31         1     917    1120            CO
## 436    2011     1         31         1    1748    2001            CO
## 437    2011     1         31         1    1901    2332            CO
## 438    2011     1         31         1     740    1052            CO
## 439    2011     1         31         1    2102    2222            CO
## 440    2011     1         31         1    1429    1608            CO
## 441    2011     1         31         1    1313    1516            CO
## 442    2011     1         31         1    1540    1833            CO
## 443    2011     1         31         1    1930    2225            CO
## 444    2011     1         31         1    1429    1542            CO
## 445    2011     1         31         1     714    1103            CO
## 446    2011     1         31         1    1543    1948            CO
## 447    2011     1         31         1    1917    2234            CO
## 448    2011     1         31         1    1915    2248            CO
## 449    2011     1         31         1    1120    1355            CO
## 450    2011     1         31         1    1737    2003            CO
## 451    2011     1         31         1    1550    2012            CO
## 452    2011     1         31         1    1034    1348            CO
## 453    2011     1         31         1    1440    1630            CO
## 454    2011     1         31         1     749    1044            CO
## 455    2011     1         31         1    1807    2030            CO
## 456    2011     1         31         1    1130    1233            CO
## 457    2011     1         31         1    1940    2349            CO
## 458    2011     1         31         1    1239    1409            CO
## 459    2011     1         31         1     906    1058            CO
## 460    2011     1         31         1    1144    1241            CO
## 461    2011     1         31         1    1308    1646            CO
## 462    2011     1         31         1    1423    1652            CO
## 463    2011     1         31         1    2137       9            CO
## 464    2011     1         31         1    1930    2224            CO
## 465    2011     1         31         1    1653    1748            CO
## 466    2011     1         31         1    1440    1731            CO
## 467    2011     1         31         1    2143    2338            CO
## 468    2011     1         31         1     729    1002            CO
## 469    2011     1         31         1     722    1125            CO
## 470    2011     1         31         1    1347    1654            CO
## 471    2011     1         31         1    1012    1351            CO
## 472    2011     1         31         1    1550    1736            CO
## 473    2011     1         31         1     842    1027            CO
## 474    2011     1         31         1    1311    1731            CO
## 475    2011     1         31         1    2105    2311            CO
## 476    2011     1         31         1    1107    1352            CO
##        FlightNum TailNum ActualElapsedTime AirTime ArrDelay DepDelay
## 1            428  N576AA                60      40      -10        0
## 2            428  N557AA                60      45       -9        1
## 3            428  N541AA                70      48       -8       -8
## 4            428  N403AA                70      39        3        3
## 5            428  N492AA                62      44       -3        5
## 6            428  N262AA                64      45       -7       -1
## 7            428  N493AA                70      43       -1       -1
## 8            428  N477AA                59      40      -16       -5
## 9            428  N476AA                71      41       44       43
## 10           428  N504AA                70      45       43       43
## 11           428  N565AA                70      42       29       29
## 12           428  N577AA                56      41        5       19
## 13           428  N476AA                63      44       -9       -2
## 14           428  N552AA                67      47       -6       -3
## 15           428  N462AA                60      44      -11       -1
## 16           428  N555AA                70      41       -1       -1
## 17           428  N518AA                64      48       84       90
## 18           428  N507AA                60      42       -2        8
## 19           428  N523AA                67      46       -7       -4
## 20           428  N425AA                75      42       72       67
## 21           428  N251AA                62      47      -11       -3
## 22           428  N551AA                61      44      -14       -5
## 23           428  N479AA                65      40       -9       -4
## 24           428  N531AA                77      43        3       -4
## 25           428  N561AA                60      40      -18       -8
## 26           428  N541AA                62      40      -15       -7
## 27           428  N512AA                62      40      -12       -4
## 28           428  N4UBAA                66      46       -5       -1
## 29           428  N491AA                60      46      -15       -5
## 30           428  N561AA                57      39      -14       -1
## 31           428  N505AA                72      39       43       41
## 32           460  N520AA                72      41        5        8
## 33           460  N537AA                62      43      -14       -1
## 34           460  N512AA                77      46       -1       -3
## 35           460  N478AA                67      46      -14       -6
## 36           460  N551AA                64      44      -13       -2
## 37           460  N251AA                62      44      -14       -1
## 38           460  N478AA                76      42       -8       -9
## 39           460  N550AA                52      40      -30       -7
## 40           460  N586AA                75      51       -6       -6
## 41           460  N587AA                63      44      -17       -5
## 42           460  N574AA                63      44      -15       -3
## 43           460  N580AA                60      42      -21       -6
## 44           460  N586AA                79      49        6        2
## 45           460  N468AA                73      47       -7       -5
## 46           460  N251AA                74      49       -2       -1
## 47           460  N546AA                60      45        8       23
## 48           460  N559AA                78      54        7        4
## 49           460  N558AA                66      46       -8        1
## 50           460  N574AA                79      51       -2       -6
## 51           460  N471AA                63      44      -13       -1
## 52           460  N278AA                59      40      -24       -8
## 53           460  N499AA                72      47       -6       -3
## 54           460  N556AA                64      42      -21      -10
## 55           460  N545AA                93      42       29       11
## 56           460  N541AA                59      40      -17       -1
## 57           460  N512AA                68      44      -11       -4
## 58           460  N4UCAA                70      44      -10       -5
## 59           460  N403AA                65      44       11       21
## 60           460  N557AA                65      43      -10        0
## 61           460  N498AA                64      44      -15       -4
## 62           460  N493AA                58      40      -19       -2
## 63           533  N461AA                67      44      -14       -6
## 64           533  N4XGAA                69      48      -13       -7
## 65           533  N4XGAA                67      42       47       55
## 66           533  N546AA                68      44      -14       -7
## 67           533  N485AA                68      41      -17      -10
## 68           533  N555AA                57      44      -25       -7
## 69           533  N4WYAA                70      44       35       40
## 70           533  N577AA                64      43       13       24
## 71           533  N505AA                58      44      -29      -12
## 72           533  N555AA                58      39       -7       10
## 73           533  N4XCAA                56      44       -4       15
## 74           533  N549AA                70      45       69       74
## 75           533  N478AA                83      42       -1       -9
## 76           533  N492AA                61      44       11       25
## 77           533  N514AA                69      44      -14       -8
## 78           533  N550AA                54      44        3       24
## 79           533  N512AA                77      45        1       -1
## 80           533  N505AA                58      45       14       31
## 81           533  N530AA                56      39      -23       -4
## 82           533  N4XJAA                56      41       19       38
## 83           533  N585AA                63      44      -13       -1
## 84           533  N403AA                54      39      -17        4
## 85           533  N506AA                51      40       10       34
## 86           533  N466AA                61      42      -20       -6
## 87           533  N455AA                93      43       12       -6
## 88           533  N477AA                71      38      -15      -11
## 89          1121  N4WVAA                65      37       -9        1
## 90          1121  N579AA                83      46       14        6
## 91          1121  N468AA                75      47       -7       -7
## 92          1121  N4WYAA                63      43      -13       -1
## 93          1121  N481AA                71      43       -5       -1
## 94          1121  N498AA                67      43      -13       -5
## 95          1121  N525AA                63      43      -12        0
## 96          1121  N583AA                69      45       -9       -3
## 97          1121  N574AA                76      50      126      125
## 98          1121  N531AA                61      41       -5        9
## 99          1121  N586AA                63      41       70       82
## 100         1121  N468AA                68      44       -6        1
## 101         1121  N583AA                63      45      -12        0
## 102         1121  N551AA                65      47      -11       -1
## 103         1121  N274AA                64      48       -9        2
## 104         1121  N558AA                71      42       34       38
## 105         1121  N580AA                72      51       -1        2
## 106         1121  N515AA                75      45       -5       -5
## 107         1121  N538AA                62      46      -14       -1
## 108         1121  N586AA                71      41        7       11
## 109         1121  N558AA                68      47        1        8
## 110         1121  N504AA                79      47       -3       -7
## 111         1121  N489AA                76      44       -7       -8
## 112         1121  N484AA                88      43        4       -9
## 113         1121  N4UCAA                66      41      -12       -3
## 114         1121  N556AA                71      41        0        4
## 115         1121  N557AA                66      43       -5        4
## 116         1121  N553AA                65      44      -15       -5
## 117         1121  N584AA                61      47      -14        0
## 118         1121  N403AA                58      39      -12        5
## 119         1121  N455AA                62      41       13       26
## 120         1294  N3DGAA               136     113       -3        1
## 121         1294  N3CCAA               129     112       17       28
## 122         1294  N3ARAA               131     112       -9        0
## 123         1294  N3DFAA               145     108        7        2
## 124         1294  N3BDAA               129     107      -15       -4
## 125         1294  N3CMAA               154     106        5       -9
## 126         1294  N3CYAA               131     107       -7        2
## 127         1294  N3AXAA               131     107      -15       -6
## 128         1294  N3AUAA               133     110        8       15
## 129         1294  N3BXAA               121     107       80       99
## 130         1294  N3CWAA               128     111       41       53
## 131         1294  N3DFAA               134     117      -13       -7
## 132         1294  N3DLAA               159     110       12       -7
## 133         1294  N3CUAA               127     110      -14       -1
## 134         1294  N3AXAA               130     111      -16       -6
## 135         1294  N3CXAA               150     113       22       12
## 136         1294  N3CEAA               138     117        6        8
## 137         1294  N3BLAA               135     114       39       44
## 138         1294  N3CWAA               132     110      -12       -4
## 139         1294  N3CWAA               144     111       -1       -5
## 140         1294  N3BCAA               135     110       18       23
## 141         1294  N3BYAA               125     109      -20       -5
## 142         1294  N3DCAA               140     107       -2       -2
## 143         1294  N3GJAA               138     113       31       33
## 144         1294  N3BFAA               148     129        3       -5
## 145         1294  N3BXAA               126     111       56       70
## 146         1294  N3CFAA               137     106       14       17
## 147         1294  N3BLAA               138     108       -7       -5
## 148         1294  N3BXAA               129     105      -13       -2
## 149         1294  N3CPAA               133     108       54       61
## 150         1294  N3DJAA               124     104      -14        2
## 151         1436  N480AA                66      44      -12       -3
## 152         1436  N497AA                60      43        5       20
## 153         1436  N548AA                63      40       -6        6
## 154         1436  N4WUAA                68      42      -10       -3
## 155         1436  N531AA                68      40      -13       -6
## 156         1436  N591AA                92      45       48       31
## 157         1436  N425AA                64      42      -20       -9
## 158         1436  N499AA                60      41      -16       -1
## 159         1436  N251AA                75      45       -3       -3
## 160         1436  N552AA                69      45      -13       -7
## 161         1436  N545AA                70      49       15       20
## 162         1436  N262AA                67      42        5       13
## 163         1436  N474AA                72      45        3        6
## 164         1436  N4XJAA                71      42       -7       -3
## 165         1436  N538AA                79      50       12        8
## 166         1436  N567AA                65      42       -8        2
## 167         1436  N485AA                66      38      -18       -9
## 168         1436  N486AA                68      44       -7        0
## 169         1436  N499AA                63      46      -14       -2
## 170         1436  N425AA                65      44      -13       -3
## 171         1436  N517AA                73      44       29       31
## 172         1700  N3DAAA               155     117        7       -8
## 173         1700  N3ASAA               133     112      -19      -12
## 174         1700  N3CBAA               125     111      -17       -2
## 175         1700  N3BAAA               127     109       -7        6
## 176         1700  N3CDAA               130     108       -9        1
## 177         1700  N3CUAA               122     105      -18        0
## 178         1700  N3BCAA               126     107      -24      -10
## 179         1700  N3AHAA               125     106      -16       -1
## 180         1700  N3CPAA               129     110       -2        9
## 181         1700  N3AKAA               156     132       34       18
## 182         1700  N3ALAA               140     115       74       74
## 183         1700  N3BJAA               128     113      -13       -1
## 184         1700  N3BCAA               128     108      -14       -2
## 185         1700  N3AUAA               123     110      -13        4
## 186         1700  N3DEAA               138     114        0        2
## 187         1700  N3BJAA               131     118       -8        1
## 188         1700  N3BUAA               133     113       -8       -1
## 189         1700  N3ARAA               135     118       -8       -3
## 190         1700  N3BXAA               135     114       -9       -4
## 191         1700  N3CKAA               130     107      -15       -5
## 192         1700  N3APAA               128     110      -15       -3
## 193         1700  N3CPAA               139     112        5        6
## 194         1700  N3CNAA               135     108      -13       -8
## 195         1700  N3BGAA                NA      NA       NA       NA
## 196         1700  N3BFAA               134     112       14       20
## 197         1700  N3BLAA               134     110      -11       -5
## 198         1700  N3AJAA               138     108       -5       -3
## 199         1700  N3DDAA               118     104      -22        0
## 200         1700  N3FYAA               131     108      -14       -5
## 201         1700  N3DCAA               125     106      -16       -1
## 202         1700  N3FRAA               143     100       -4       -7
## 203         1820  N593AA                74      39       15        6
## 204         1820  N589AA                63      47       -7       -5
## 205         1820  N4XPAA                64      46       -2       -1
## 206         1820  N565AA                73      41        9        1
## 207         1820  N560AA                66      44        1        0
## 208         1820  N563AA                66      41        0       -1
## 209         1820  N4YRAA                72      43        6       -1
## 210         1820  N4YTAA                66      39       -2       -3
## 211         1820  N4XCAA                NA      NA       NA       NA
## 212         1820  N598AA                72      43       19       12
## 213         1820  N563AA                65      42        0        0
## 214         1820  N593AA                59      41       -5        1
## 215         1820  N4WAAA                66      46        1        0
## 216         1820  N566AA                70      49        5        0
## 217         1820  N476AA                67      52       19       17
## 218         1820  N599AA                61      42       -4        0
## 219         1820  N4WXAA                77      49       12        0
## 220         1820  N4WRAA                59      43       24       30
## 221         1820  N4YDAA                67      44        1       -1
## 222         1820  N202AA                70      44       14        9
## 223         1820  N433AA                66      44        2        1
## 224         1820  N546AA                72      50        2       -5
## 225         1820  N436AA                51      39       -2       12
## 226         1820  N434AA                66      43        8        7
## 227         1820  N4WDAA                60      40      -11       -6
## 228         1820  N594AA                75      46        4       -6
## 229         1820  N569AA                72      43        1       -6
## 230         1820  N435AA                63      47       48       50
## 231         1820  N592AA                66      44       -8       -9
## 232         1820  N589AA                80      41        9       -6
## 233         1820  N511AA                72      42        7        0
## 234         1824  N569AA                71      45       -7       -3
## 235         1824  N4YUAA                68      43      -15       -8
## 236         1824  N568AA                72      41       25       28
## 237         1824  N4YAAA                62      41      -18       -5
## 238         1824  N568AA                69      44      -13       -7
## 239         1824  N459AA                71      47       16       20
## 240         1824  N4YDAA                80      45       -2       -7
## 241         1824  N599AA                77      44       -5       -7
## 242         1824  N588AA                69      46      -12       -6
## 243         1994  N3BBAA               129     113       -9       -3
## 244         1994  N3DCAA               138     115       -3       -6
## 245         1994  N3CMAA               130     111      -10       -5
## 246         1994  N3CWAA               145     115        8       -2
## 247         1994  N3DFAA               139     111       -1       -5
## 248         1994  N3AJAA               128     107       -7        0
## 249         1994  N3DDAA               129     108      -10       -4
## 250         1994  N3DAAA               132     105       -5       -2
## 251         1994  N3CYAA               133     111       -4       -2
## 252         1994  N3AUAA               135     111        5        5
## 253         1994  N3DLAA                NA      NA       NA       -7
## 254         1994  N3BDAA               132     112      -12       -9
## 255         1994  N3AGAA               125     109       23       33
## 256         1994  N3DLAA               132     112       -5       -2
## 257         1994  N3DJAA               130     114      -10       -5
## 258         1994  N3AHAA               125     112       -5        5
## 259         1994  N3AXAA               167     143       28       -4
## 260         1994  N3DFAA               136     112       -4       -5
## 261         1994  N3BVAA               147     124        6       -6
## 262         1994  N3FTAA               136     110       -3       -4
## 263         1994  N3CJAA               134     114       -8       -7
## 264         1994  N3BFAA               137     118       -8      -10
## 265         1994  N3BCAA               128     110      -15       -8
## 266         1994  N3CCAA               133     111       -9       -7
## 267         1994  N3AMAA               138     111        1       -2
## 268         1994  N3DJAA               132     112       -8       -5
## 269         1994  N3DEAA               129     112        0        6
## 270         1994  N3FYAA               131     111      -10       -6
## 271         1994  N3AKAA               132     107      -11       -8
## 272         1994  N3ARAA               137     111       -5       -7
## 273         1994  N3BTAA               121     106      -18       -4
## 274          731  N614AS               282     255       -4       -1
## 275          731  N627AS               280     257       -7       -2
## 276          731  N627AS               280     260       -3        2
## 277          731  N618AS               287     268       22       20
## 278          731  N607AS               288     273       -1       -4
## 279          731  N624AS               299     278       23        9
## 280          731  N611AS               295     274        8       -2
## 281          731  N607AS               290     269        2       -3
## 282          731  N609AS               290     253       78       73
## 283          731  N626AS               339     315       49       -5
## 284          731  N626AS                NA      NA       NA       -5
## 285          731  N619AS               307     284       19       -3
## 286          731  N627AS               293     273        3       -5
## 287          731  N627AS               296     270        4       -7
## 288          731  N627AS               309     287       21       -3
## 289          731  N627AS               316     291       28       -3
## 290          731  N612AS               331     310       39       -7
## 291          731  N617AS               294     276       20       11
## 292          731  N622AS               282     265       -8       -5
## 293          731  N622AS               313     284       25       -3
## 294          731  N622AS               309     288       26        2
## 295          731  N644AS               284     269      -10       -9
## 296          731  N624AS               286     269       -6       -7
## 297          731  N644AS               285     251       -1       -1
## 298          731  N607AS               275     255       -9        1
## 299          731  N607AS               285     255        5        5
## 300          731  N627AS               278     262        0        7
## 301          731  N627AS               271     256      -18       -4
## 302          731  N627AS               261     246      -28       -4
## 303          731  N627AS               307     264       18       -4
## 304          731  N607AS               284     259        1        2
## 305          620  N324JB               210     181        5       -6
## 306          622  N324JB               211     188       61       54
## 307          620  N324JB               190     172       -6        3
## 308          622  N324JB               216     176       31       19
## 309          620  N229JB               181     166      -19       -1
## 310          622  N206JB               179     165      111      136
## 311          620  N267JB               189     168      -16       -6
## 312          622  N267JB               206     175       25       23
## 313          620  N708JB               183     167      -14        0
## 314          624  N644JB               190     166       -6        9
## 315          624  N641JB               191     175      -17       -3
## 316          620  N641JB               203     172        0       -6
## 317          624  N564JB               194     175       -4        7
## 318          620  N630JB               184     162      -19       -6
## 319          620  N599JB               186     163      -18       -7
## 320          624  N625JB               219     196       57       43
## 321          620  N625JB               186     166      -15       -4
## 322          624  N504JB               187     170        1       19
## 323          620  N504JB               180     161      -24       -7
## 324          624  N537JB                NA      NA       NA       NA
## 325          624  N504JB               201     177       -7       -3
## 326          624  N597JB               196     178      -22      -13
## 327          620  N597JB               201     185       72       68
## 328          624  N729JB               221     189       15       -1
## 329          620  N503JB               194     173       -3        0
## 330          620  N706JB               183     166      -22       -8
## 331          624  N565JB               193     176        4       16
## 332          620  N523JB               185     168       18       30
## 333          624  N779JB               195     173      -14       -4
## 334          620  N779JB               183     162      -15       -1
## 335          624  N729JB               189     164       56       72
## 336          624  N504JB                NA      NA       NA       NA
## 337          624  N760JB               194     161       -8        3
## 338          620  N760JB               188     164      -13       -4
## 339          624  N598JB               190     173       95      110
## 340          620  N527JB               185     161      -11        1
## 341          620  N580JB               180     162      -19       -2
## 342          624  N599JB               178     164      -27        0
## 343          620  N605JB               172     156      -18        7
## 344          624  N536JB               171     156      -37       -3
## 345          620  N589JB               184     162      -15       -2
## 346          624  N621JB               186     167       29       48
## 347          624  N659JB               186     165      -19        0
## 348          624  N569JB                NA      NA       NA       NA
## 349          620  N594JB               192     172      -10       -5
## 350          624  N655JB               215     196       13        3
## 351          620  N508JB               211     180       11       -3
## 352          620  N606JB               195     175      -11       -9
## 353          624  N606JB               199     176       78       84
## 354          620  N661JB               192     172       -6       -1
## 355          624  N629JB               190     169      -18       -3
## 356            1  N69063               529     492       23       -1
## 357            5  N17245                60      42       -9        0
## 358            6  N77520                56      40       -5       -1
## 359           33  N16647                70      42       -2       -3
## 360           35  N35204                59      32        7        1
## 361           47  N76522               227     199        2        6
## 362           52  N67134               229     201        5        2
## 363           59  N57870               144     116       15       28
## 364           60  N68159               205     165       -2        1
## 365           62  N17126               203     163       -9        0
## 366           89  N76529               195     175        2        7
## 367          106  N66051               188     162      -26       -4
## 368          128  N75436                88      49       18       -2
## 369          137  N73283               236     199       14        5
## 370          146  N57862               145     114       64       77
## 371          150  N34282               211     189        6       15
## 372          158  N13750               180     142        7       -3
## 373          170  N35407               241     225      -27        1
## 374          190  N35260               132     107      -12       -1
## 375          197  N75853               209     172        3        0
## 376          199  N14228               169     128        8        1
## 377          206  N39418               115      91      -10       -1
## 378          209  N24715               268     256      -15       -7
## 379          210  N37408               198     166      -15        1
## 380          212  N53441               237     215       -4        9
## 381          220  N33132               206     161       32        7
## 382          226  N19621               181     161        2        0
## 383          232  N33266               200     165      -15       -4
## 384          241  N14629                55      27       -2       -4
## 385          244  N37274               144     121      -16        9
## 386          250  N59630               141     121      -18        0
## 387          258  N77520               173     145       -1       -3
## 388          267  N45440               286     263        7        5
## 389          270  N37420               262     228        1        4
## 390          275  N14242               146     122       16       25
## 391          279  N37274                70      45        4        0
## 392          282  N79279               225     195        4        0
## 393          297  N27421               215     190       13       11
## 394          299  N17244               134     119      -10        8
## 395          309  N33294               283     254        8        4
## 396          310  N77867               193     164       33       49
## 397          320  N39416               192     159       12        1
## 398          323  N36207                61      44      -10       -3
## 399          326  N38257               160     143      -16       -2
## 400          332  N73276               215     177        4       -3
## 401          358  N39728               167     146       -5       -2
## 402          370  N27213               264     229        5        7
## 403          379  N19638                60      39       -2        0
## 404          382  N36272               219     188       -5       -3
## 405          397  N33286               200     182       20       28
## 406          400  N39415               147     109        6        1
## 407          403  N35271               212     194       -1        1
## 408          404  N78501               172     146       -5       -5
## 409          406  N73270               179     143        3       -4
## 410          408  N66056               207     170        1       -1
## 411          410  N73299               155     138      -19       -2
## 412          421  N37298               247     231       80       91
## 413          423  N33266                62      41       -8       -1
## 414          426  N78506               165     143      -12       -1
## 415          432  N16713               198     169        1        4
## 416          442                        NA      NA       NA       NA
## 417          444  N76514               157     117        3        5
## 418          446  N26208               144     117      -16       -6
## 419          458  N17233               168     149       -7       -5
## 420          467  N78285               296     276       58       42
## 421          479  N16217                60      43       -8       -2
## 422          482  N78509               221     190       -3        0
## 423          497  N74856               230     187       23        1
## 424          499  N37267               159     127        2       -2
## 425          500                        NA      NA       NA       NA
## 426          510  N38268               207     183        2        0
## 427          511  N77520                81      60        5        1
## 428          520  N75432               181     161       -2       -2
## 429          532  N76269               225     178       22        2
## 430          534  N79402               150     125      -16       -3
## 431          542  N75436               195     174        2        4
## 432          544  N13624               163     136       -8       -7
## 433          546  N77518               155     116       -1        1
## 434          558  N16709               164     143      -11       -4
## 435          559  N76515               243     202       15        2
## 436          570  N75436               253     236       -4        3
## 437          582  N19621               211     188       -1        6
## 438          586  N17126               132     102       -7       -5
## 439          597  N33203               200     179      -10        0
## 440          599  N57864               159     124        6        3
## 441          601  N26208               183     131       36        9
## 442          606  N77510               113      90      -11        0
## 443          616  N33294               175     139       24       20
## 444          623  N77261                73      44        5       -1
## 445          626  N16647               169     154      -17       -6
## 446          632  N12238               185     166      -25       -2
## 447          644  N37267               137     116       -3       22
## 448          658  N37273               153     128       -6       10
## 449          663  N14115               215     195       33       -5
## 450          667  N57869               266     249        0       12
## 451          682  N78501               202     180      -25        0
## 452          686  N56859               134     105        0       -1
## 453          697  N37293               230     191       20        0
## 454          706  N23708               115      92      -11       -1
## 455          709  N37409               263     245      -13        2
## 456          723  N77510                63      44       -8       -5
## 457          732  N33262               189     157       44       50
## 458          738  N38403               210     194       -3       -1
## 459          739  N75432               232     193       16        1
## 460          741  N37290                57      32        0       -1
## 461          744  N76254               158     125       -7       -2
## 462          746  N78524               149     114       -8        3
## 463          752  N73278               212     189       10       -2
## 464          755  N11641               114      89      -10       -1
## 465          763  N73291                55      42      -15       -2
## 466          767  N37422               291     255       12        5
## 467          770  N37281               235     224       24       50
## 468          771  N26226               273     237        2       -1
## 469          776  N37252               183     155      -11       -3
## 470          786  N75851               127     105        6       12
## 471          788  N46625               159     132      -12       -4
## 472          795  N76502               226     198        8       10
## 473          799  N57855               165     133        0       -3
## 474          810  N78003               200     168       -4        1
## 475          820  N37255               186     158       19       10
## 476         1006  N18220               105      89       -2       17
##        Origin Dest Distance TaxiIn TaxiOut Cancelled CancellationCode
## 1         IAH  DFW      224      7      13         0                 
## 2         IAH  DFW      224      6       9         0                 
## 3         IAH  DFW      224      5      17         0                 
## 4         IAH  DFW      224      9      22         0                 
## 5         IAH  DFW      224      9       9         0                 
## 6         IAH  DFW      224      6      13         0                 
## 7         IAH  DFW      224     12      15         0                 
## 8         IAH  DFW      224      7      12         0                 
## 9         IAH  DFW      224      8      22         0                 
## 10        IAH  DFW      224      6      19         0                 
## 11        IAH  DFW      224      8      20         0                 
## 12        IAH  DFW      224      4      11         0                 
## 13        IAH  DFW      224      6      13         0                 
## 14        IAH  DFW      224      5      15         0                 
## 15        IAH  DFW      224      6      10         0                 
## 16        IAH  DFW      224     12      17         0                 
## 17        IAH  DFW      224      8       8         0                 
## 18        IAH  DFW      224      7      11         0                 
## 19        IAH  DFW      224     10      11         0                 
## 20        IAH  DFW      224      9      24         0                 
## 21        IAH  DFW      224      6       9         0                 
## 22        IAH  DFW      224      9       8         0                 
## 23        IAH  DFW      224      7      18         0                 
## 24        IAH  DFW      224      6      28         0                 
## 25        IAH  DFW      224      7      13         0                 
## 26        IAH  DFW      224      8      14         0                 
## 27        IAH  DFW      224     12      10         0                 
## 28        IAH  DFW      224      8      12         0                 
## 29        IAH  DFW      224      7       7         0                 
## 30        IAH  DFW      224      7      11         0                 
## 31        IAH  DFW      224      8      25         0                 
## 32        IAH  DFW      224      6      25         0                 
## 33        IAH  DFW      224      9      10         0                 
## 34        IAH  DFW      224     21      10         0                 
## 35        IAH  DFW      224      6      15         0                 
## 36        IAH  DFW      224      7      13         0                 
## 37        IAH  DFW      224      8      10         0                 
## 38        IAH  DFW      224     24      10         0                 
## 39        IAH  DFW      224      3       9         0                 
## 40        IAH  DFW      224     11      13         0                 
## 41        IAH  DFW      224      8      11         0                 
## 42        IAH  DFW      224      7      12         0                 
## 43        IAH  DFW      224     10       8         0                 
## 44        IAH  DFW      224     16      14         0                 
## 45        IAH  DFW      224     15      11         0                 
## 46        IAH  DFW      224     12      13         0                 
## 47        IAH  DFW      224      5      10         0                 
## 48        IAH  DFW      224     12      12         0                 
## 49        IAH  DFW      224      7      13         0                 
## 50        IAH  DFW      224     14      14         0                 
## 51        IAH  DFW      224      8      11         0                 
## 52        IAH  DFW      224     11       8         0                 
## 53        IAH  DFW      224     18       7         0                 
## 54        IAH  DFW      224     11      11         0                 
## 55        IAH  DFW      224     14      37         0                 
## 56        IAH  DFW      224      8      11         0                 
## 57        IAH  DFW      224     10      14         0                 
## 58        IAH  DFW      224     16      10         0                 
## 59        IAH  DFW      224      7      14         0                 
## 60        IAH  DFW      224     12      10         0                 
## 61        IAH  DFW      224     11       9         0                 
## 62        IAH  DFW      224     10       8         0                 
## 63        IAH  DFW      224     12      11         0                 
## 64        IAH  DFW      224      5      16         0                 
## 65        IAH  DFW      224      3      22         0                 
## 66        IAH  DFW      224     13      11         0                 
## 67        IAH  DFW      224     14      13         0                 
## 68        IAH  DFW      224      3      10         0                 
## 69        IAH  DFW      224     11      15         0                 
## 70        IAH  DFW      224     10      11         0                 
## 71        IAH  DFW      224      3      11         0                 
## 72        IAH  DFW      224      9      10         0                 
## 73        IAH  DFW      224      4       8         0                 
## 74        IAH  DFW      224      5      20         0                 
## 75        IAH  DFW      224     18      23         0                 
## 76        IAH  DFW      224      5      12         0                 
## 77        IAH  DFW      224     10      15         0                 
## 78        IAH  DFW      224      4       6         0                 
## 79        IAH  DFW      224      7      25         0                 
## 80        IAH  DFW      224      3      10         0                 
## 81        IAH  DFW      224      9       8         0                 
## 82        IAH  DFW      224      4      11         0                 
## 83        IAH  DFW      224      8      11         0                 
## 84        IAH  DFW      224      9       6         0                 
## 85        IAH  DFW      224      2       9         0                 
## 86        IAH  DFW      224      8      11         0                 
## 87        IAH  DFW      224     10      40         0                 
## 88        IAH  DFW      224     11      22         0                 
## 89        IAH  DFW      224     16      12         0                 
## 90        IAH  DFW      224     24      13         0                 
## 91        IAH  DFW      224     10      18         0                 
## 92        IAH  DFW      224      9      11         0                 
## 93        IAH  DFW      224     16      12         0                 
## 94        IAH  DFW      224     13      11         0                 
## 95        IAH  DFW      224      6      14         0                 
## 96        IAH  DFW      224     13      11         0                 
## 97        IAH  DFW      224      9      17         0                 
## 98        IAH  DFW      224      8      12         0                 
## 99        IAH  DFW      224      8      14         0                 
## 100       IAH  DFW      224      5      19         0                 
## 101       IAH  DFW      224      4      14         0                 
## 102       IAH  DFW      224      8      10         0                 
## 103       IAH  DFW      224      5      11         0                 
## 104       IAH  DFW      224     12      17         0                 
## 105       IAH  DFW      224     10      11         0                 
## 106       IAH  DFW      224     10      20         0                 
## 107       IAH  DFW      224      6      10         0                 
## 108       IAH  DFW      224      5      25         0                 
## 109       IAH  DFW      224      9      12         0                 
## 110       IAH  DFW      224     15      17         0                 
## 111       IAH  DFW      224      7      25         0                 
## 112       IAH  DFW      224     10      35         0                 
## 113       IAH  DFW      224     10      15         0                 
## 114       IAH  DFW      224      7      23         0                 
## 115       IAH  DFW      224     10      13         0                 
## 116       IAH  DFW      224     10      11         0                 
## 117       IAH  DFW      224      5       9         0                 
## 118       IAH  DFW      224      9      10         0                 
## 119       IAH  DFW      224      9      12         0                 
## 120       IAH  MIA      964      9      14         0                 
## 121       IAH  MIA      964      6      11         0                 
## 122       IAH  MIA      964      5      14         0                 
## 123       IAH  MIA      964     26      11         0                 
## 124       IAH  MIA      964     11      11         0                 
## 125       IAH  MIA      964     34      14         0                 
## 126       IAH  MIA      964      9      15         0                 
## 127       IAH  MIA      964     11      13         0                 
## 128       IAH  MIA      964      7      16         0                 
## 129       IAH  MIA      964      3      11         0                 
## 130       IAH  MIA      964      7      10         0                 
## 131       IAH  MIA      964      7      10         0                 
## 132       IAH  MIA      964     36      13         0                 
## 133       IAH  MIA      964      6      11         0                 
## 134       IAH  MIA      964      6      13         0                 
## 135       IAH  MIA      964     15      22         0                 
## 136       IAH  MIA      964     10      11         0                 
## 137       IAH  MIA      964      7      14         0                 
## 138       IAH  MIA      964     11      11         0                 
## 139       IAH  MIA      964     20      13         0                 
## 140       IAH  MIA      964      9      16         0                 
## 141       IAH  MIA      964      6      10         0                 
## 142       IAH  MIA      964     20      13         0                 
## 143       IAH  MIA      964      5      20         0                 
## 144       IAH  MIA      964      6      13         0                 
## 145       IAH  MIA      964      5      10         0                 
## 146       IAH  MIA      964     20      11         0                 
## 147       IAH  MIA      964     20      10         0                 
## 148       IAH  MIA      964     12      12         0                 
## 149       IAH  MIA      964      7      18         0                 
## 150       IAH  MIA      964      4      16         0                 
## 151       IAH  DFW      224      4      18         0                 
## 152       IAH  DFW      224      4      13         0                 
## 153       IAH  DFW      224      4      19         0                 
## 154       IAH  DFW      224      7      19         0                 
## 155       IAH  DFW      224      7      21         0                 
## 156       IAH  DFW      224     27      20         0                 
## 157       IAH  DFW      224      6      16         0                 
## 158       IAH  DFW      224      4      15         0                 
## 159       IAH  DFW      224      7      23         0                 
## 160       IAH  DFW      224      6      18         0                 
## 161       IAH  DFW      224     11      10         0                 
## 162       IAH  DFW      224      5      20         0                 
## 163       IAH  DFW      224      7      20         0                 
## 164       IAH  DFW      224     13      16         0                 
## 165       IAH  DFW      224      8      21         0                 
## 166       IAH  DFW      224      9      14         0                 
## 167       IAH  DFW      224      8      20         0                 
## 168       IAH  DFW      224     10      14         0                 
## 169       IAH  DFW      224     10       7         0                 
## 170       IAH  DFW      224      4      17         0                 
## 171       IAH  DFW      224      5      24         0                 
## 172       IAH  MIA      964     12      26         0                 
## 173       IAH  MIA      964      6      15         0                 
## 174       IAH  MIA      964      6       8         0                 
## 175       IAH  MIA      964      5      13         0                 
## 176       IAH  MIA      964     10      12         0                 
## 177       IAH  MIA      964      7      10         0                 
## 178       IAH  MIA      964     10       9         0                 
## 179       IAH  MIA      964      7      12         0                 
## 180       IAH  MIA      964     10       9         0                 
## 181       IAH  MIA      964      5      19         0                 
## 182       IAH  MIA      964     11      14         0                 
## 183       IAH  MIA      964      6       9         0                 
## 184       IAH  MIA      964      4      16         0                 
## 185       IAH  MIA      964      5       8         0                 
## 186       IAH  MIA      964     13      11         0                 
## 187       IAH  MIA      964      4       9         0                 
## 188       IAH  MIA      964     12       8         0                 
## 189       IAH  MIA      964      5      12         0                 
## 190       IAH  MIA      964      9      12         0                 
## 191       IAH  MIA      964     11      12         0                 
## 192       IAH  MIA      964      7      11         0                 
## 193       IAH  MIA      964     11      16         0                 
## 194       IAH  MIA      964     17      10         0                 
## 195       IAH  MIA      964     NA      NA         1                A
## 196       IAH  MIA      964      4      18         0                 
## 197       IAH  MIA      964     13      11         0                 
## 198       IAH  MIA      964     12      18         0                 
## 199       IAH  MIA      964      5       9         0                 
## 200       IAH  MIA      964      8      15         0                 
## 201       IAH  MIA      964     10       9         0                 
## 202       IAH  MIA      964     26      17         0                 
## 203       IAH  DFW      224      6      29         0                 
## 204       IAH  DFW      224      3      13         0                 
## 205       IAH  DFW      224      5      13         0                 
## 206       IAH  DFW      224     19      13         0                 
## 207       IAH  DFW      224     12      10         0                 
## 208       IAH  DFW      224      8      17         0                 
## 209       IAH  DFW      224      6      23         0                 
## 210       IAH  DFW      224     17      10         0                 
## 211       IAH  DFW      224     NA      NA         1                B
## 212       IAH  DFW      224     12      17         0                 
## 213       IAH  DFW      224      9      14         0                 
## 214       IAH  DFW      224      8      10         0                 
## 215       IAH  DFW      224      4      16         0                 
## 216       IAH  DFW      224      4      17         0                 
## 217       IAH  DFW      224      6       9         0                 
## 218       IAH  DFW      224      8      11         0                 
## 219       IAH  DFW      224      4      24         0                 
## 220       IAH  DFW      224      8       8         0                 
## 221       IAH  DFW      224      6      17         0                 
## 222       IAH  DFW      224      5      21         0                 
## 223       IAH  DFW      224      5      17         0                 
## 224       IAH  DFW      224     11      11         0                 
## 225       IAH  DFW      224      5       7         0                 
## 226       IAH  DFW      224      5      18         0                 
## 227       IAH  DFW      224      3      17         0                 
## 228       IAH  DFW      224     11      18         0                 
## 229       IAH  DFW      224     13      16         0                 
## 230       IAH  DFW      224      5      11         0                 
## 231       IAH  DFW      224      8      14         0                 
## 232       IAH  DFW      224      3      36         0                 
## 233       IAH  DFW      224      8      22         0                 
## 234       IAH  DFW      224      6      20         0                 
## 235       IAH  DFW      224      9      16         0                 
## 236       IAH  DFW      224     10      21         0                 
## 237       IAH  DFW      224      9      12         0                 
## 238       IAH  DFW      224      8      17         0                 
## 239       IAH  DFW      224      5      19         0                 
## 240       IAH  DFW      224     22      13         0                 
## 241       IAH  DFW      224     15      18         0                 
## 242       IAH  DFW      224      6      17         0                 
## 243       IAH  MIA      964      5      11         0                 
## 244       IAH  MIA      964      5      18         0                 
## 245       IAH  MIA      964      6      13         0                 
## 246       IAH  MIA      964     18      12         0                 
## 247       IAH  MIA      964      7      21         0                 
## 248       IAH  MIA      964      7      14         0                 
## 249       IAH  MIA      964      6      15         0                 
## 250       IAH  MIA      964     11      16         0                 
## 251       IAH  MIA      964      8      14         0                 
## 252       IAH  MIA      964      7      17         0                 
## 253       IAH  MIA      964     12      18         0                 
## 254       IAH  MIA      964      6      14         0                 
## 255       IAH  MIA      964      7       9         0                 
## 256       IAH  MIA      964      7      13         0                 
## 257       IAH  MIA      964      4      12         0                 
## 258       IAH  MIA      964      4       9         0                 
## 259       IAH  MIA      964      9      15         0                 
## 260       IAH  MIA      964     15       9         0                 
## 261       IAH  MIA      964      5      18         0                 
## 262       IAH  MIA      964      7      19         0                 
## 263       IAH  MIA      964      8      12         0                 
## 264       IAH  MIA      964      5      14         0                 
## 265       IAH  MIA      964      6      12         0                 
## 266       IAH  MIA      964      8      14         0                 
## 267       IAH  MIA      964     12      15         0                 
## 268       IAH  MIA      964      6      14         0                 
## 269       IAH  MIA      964      4      13         0                 
## 270       IAH  MIA      964      5      15         0                 
## 271       IAH  MIA      964      8      17         0                 
## 272       IAH  MIA      964     11      15         0                 
## 273       IAH  MIA      964      4      11         0                 
## 274       IAH  SEA     1874      7      20         0                 
## 275       IAH  SEA     1874      7      16         0                 
## 276       IAH  SEA     1874      4      16         0                 
## 277       IAH  SEA     1874      8      11         0                 
## 278       IAH  SEA     1874      5      10         0                 
## 279       IAH  SEA     1874      3      18         0                 
## 280       IAH  SEA     1874      7      14         0                 
## 281       IAH  SEA     1874      6      15         0                 
## 282       IAH  SEA     1874      5      32         0                 
## 283       IAH  SEA     1874      4      20         0                 
## 284       IAH  SEA     1874      4      18         0                 
## 285       IAH  SEA     1874      5      18         0                 
## 286       IAH  SEA     1874      5      15         0                 
## 287       IAH  SEA     1874      7      19         0                 
## 288       IAH  SEA     1874      4      18         0                 
## 289       IAH  SEA     1874      5      20         0                 
## 290       IAH  SEA     1874      4      17         0                 
## 291       IAH  SEA     1874      4      14         0                 
## 292       IAH  SEA     1874      7      10         0                 
## 293       IAH  SEA     1874      3      26         0                 
## 294       IAH  SEA     1874      7      14         0                 
## 295       IAH  SEA     1874      4      11         0                 
## 296       IAH  SEA     1874      5      12         0                 
## 297       IAH  SEA     1874      3      31         0                 
## 298       IAH  SEA     1874      4      16         0                 
## 299       IAH  SEA     1874      6      24         0                 
## 300       IAH  SEA     1874      5      11         0                 
## 301       IAH  SEA     1874      3      12         0                 
## 302       IAH  SEA     1874      3      12         0                 
## 303       IAH  SEA     1874      6      37         0                 
## 304       IAH  SEA     1874      6      19         0                 
## 305       HOU  JFK     1428      6      23         0                 
## 306       HOU  JFK     1428     12      11         0                 
## 307       HOU  JFK     1428      6      12         0                 
## 308       HOU  JFK     1428      9      31         0                 
## 309       HOU  JFK     1428      3      12         0                 
## 310       HOU  JFK     1428      5       9         0                 
## 311       HOU  JFK     1428      9      12         0                 
## 312       HOU  JFK     1428      8      23         0                 
## 313       HOU  JFK     1428      4      12         0                 
## 314       HOU  JFK     1428     14      10         0                 
## 315       HOU  JFK     1428      7       9         0                 
## 316       HOU  JFK     1428      6      25         0                 
## 317       HOU  JFK     1428      9      10         0                 
## 318       HOU  JFK     1428      9      13         0                 
## 319       HOU  JFK     1428      3      20         0                 
## 320       HOU  JFK     1428     11      12         0                 
## 321       HOU  JFK     1428      4      16         0                 
## 322       HOU  JFK     1428      7      10         0                 
## 323       HOU  JFK     1428      5      14         0                 
## 324       HOU  JFK     1428     NA      NA         1                B
## 325       HOU  JFK     1428      8      16         0                 
## 326       HOU  JFK     1428      8      10         0                 
## 327       HOU  JFK     1428      7       9         0                 
## 328       HOU  JFK     1428      8      24         0                 
## 329       HOU  JFK     1428      4      17         0                 
## 330       HOU  JFK     1428      4      13         0                 
## 331       HOU  JFK     1428      5      12         0                 
## 332       HOU  JFK     1428      4      13         0                 
## 333       HOU  JFK     1428      7      15         0                 
## 334       HOU  JFK     1428      6      15         0                 
## 335       HOU  JFK     1428      4      21         0                 
## 336       HOU  JFK     1428     NA      NA         1                A
## 337       HOU  JFK     1428     16      17         0                 
## 338       HOU  JFK     1428      5      19         0                 
## 339       HOU  JFK     1428      6      11         0                 
## 340       HOU  JFK     1428      3      21         0                 
## 341       HOU  JFK     1428      6      12         0                 
## 342       HOU  JFK     1428      6       8         0                 
## 343       HOU  JFK     1428      4      12         0                 
## 344       HOU  JFK     1428      4      11         0                 
## 345       HOU  JFK     1428      8      14         0                 
## 346       HOU  JFK     1428      7      12         0                 
## 347       HOU  JFK     1428      6      15         0                 
## 348       HOU  JFK     1428     NA      NA         1                B
## 349       HOU  JFK     1428      4      16         0                 
## 350       HOU  JFK     1428      7      12         0                 
## 351       HOU  JFK     1428      7      24         0                 
## 352       HOU  JFK     1428      8      12         0                 
## 353       HOU  JFK     1428     13      10         0                 
## 354       HOU  JFK     1428      8      12         0                 
## 355       HOU  JFK     1428      9      12         0                 
## 356       IAH  HNL     3904      6      31         0                 
## 357       IAH  MSY      305      3      15         0                 
## 358       IAH  SAT      191      2      14         0                 
## 359       IAH  MSY      305      7      21         0                 
## 360       IAH  AUS      140      7      20         0                 
## 361       IAH  LAX     1379      8      20         0                 
## 362       IAH  LAX     1379     11      17         0                 
## 363       IAH  DEN      862     12      16         0                 
## 364       IAH  EWR     1400     29      11         0                 
## 365       IAH  EWR     1400     16      24         0                 
## 366       IAH  EWR     1400      6      14         0                 
## 367       IAH  EWR     1400      8      18         0                 
## 368       IAH  MSY      305      6      33         0                 
## 369       IAH  LAX     1379     10      27         0                 
## 370       IAH  ORD      925     15      16         0                 
## 371       IAH  ONT     1334      5      17         0                 
## 372       IAH  DCA     1208      4      34         0                 
## 373       IAH  SFO     1635      6      10         0                 
## 374       IAH  MIA      964      5      20         0                 
## 375       IAH  LAS     1222      8      29         0                 
## 376       IAH  DEN      862     12      29         0                 
## 377       IAH  TPA      787      4      20         0                 
## 378       IAH  PDX     1825      4       8         0                 
## 379       IAH  EWR     1400     16      16         0                 
## 380       IAH  SJU     2007      6      16         0                 
## 381       IAH  PHX     1009      8      37         0                 
## 382       IAH  BWI     1235      5      15         0                 
## 383       IAH  LGA     1416      4      31         0                 
## 384       IAH  AUS      140      5      23         0                 
## 385       IAH  CLE     1091      5      18         0                 
## 386       IAH  RDU     1043      5      15         0                 
## 387       IAH  DCA     1208      4      24         0                 
## 388       IAH  SEA     1874      9      14         0                 
## 389       IAH  SFO     1635      7      27         0                 
## 390       IAH  DEN      862      8      16         0                 
## 391       IAH  SAT      191      3      22         0                 
## 392       IAH  BOS     1597      5      25         0                 
## 393       IAH  LAS     1222      7      18         0                 
## 394       IAH  DEN      862      6       9         0                 
## 395       IAH  PDX     1825      5      24         0                 
## 396       IAH  EWR     1400      7      22         0                 
## 397       IAH  PHX     1009      7      26         0                 
## 398       IAH  MSY      305      2      15         0                 
## 399       IAH  BWI     1235      4      13         0                 
## 400       IAH  LGA     1416      7      31         0                 
## 401       IAH  DCA     1208      3      18         0                 
## 402       IAH  SFO     1635      6      29         0                 
## 403       IAH  SAT      191      3      18         0                 
## 404       IAH  BOS     1597     10      21         0                 
## 405       IAH  LAS     1222      7      11         0                 
## 406       IAH  IND      845      5      33         0                 
## 407       IAH  SAN     1303      4      14         0                 
## 408       IAH  IAD     1190      5      21         0                 
## 409       IAH  IAD     1190     13      23         0                 
## 410       IAH  EWR     1400     11      26         0                 
## 411       IAH  IAD     1190      9       8         0                 
## 412       IAH  SJC     1609      2      14         0                 
## 413       IAH  MSY      305      2      19         0                 
## 414       IAH  BWI     1235      4      18         0                 
## 415       IAH  LGA     1416      6      23         0                 
## 416       IAH  TUL      429     NA      NA         1                B
## 417       IAH  ORD      925     18      22         0                 
## 418       IAH  ORD      925     11      16         0                 
## 419       IAH  DCA     1208      4      15         0                 
## 420       IAH  SEA     1874      5      15         0                 
## 421       IAH  SAT      191      3      14         0                 
## 422       IAH  BOS     1597     11      20         0                 
## 423       IAH  LAS     1222      7      36         0                 
## 424       IAH  DEN      862      6      26         0                 
## 425       IAH  IND      845     NA      NA         1                B
## 426       IAH  EWR     1400      7      17         0                 
## 427       IAH  MFE      316      4      17         0                 
## 428       IAH  PHX     1009      8      12         0                 
## 429       IAH  LGA     1416      7      40         0                 
## 430       IAH  PIT     1117      7      18         0                 
## 431       IAH  SLC     1195      4      17         0                 
## 432       IAH  CLE     1091      6      21         0                 
## 433       IAH  ORD      925     10      29         0                 
## 434       IAH  DCA     1208      5      16         0                 
## 435       IAH  SNA     1347      6      35         0                 
## 436       IAH  SFO     1635      7      10         0                 
## 437       IAH  BOS     1597      7      16         0                 
## 438       IAH  MCO      853      9      21         0                 
## 439       IAH  LAS     1222      9      12         0                 
## 440       IAH  DEN      862     10      25         0                 
## 441       IAH  DEN      862     18      34         0                 
## 442       IAH  TPA      787      6      17         0                 
## 443       IAH  MSP     1034     11      25         0                 
## 444       IAH  MSY      305      3      26         0                 
## 445       IAH  BWI     1235      4      11         0                 
## 446       IAH  LGA     1416      5      14         0                 
## 447       IAH  CLE     1091      5      16         0                 
## 448       IAH  DCA     1208      9      16         0                 
## 449       IAH  EGE      935      4      16         0                 
## 450       IAH  SEA     1874      6      11         0                 
## 451       IAH  BOS     1597      9      13         0                 
## 452       IAH  MCO      853      8      21         0                 
## 453       IAH  LAS     1222      7      32         0                 
## 454       IAH  TPA      787      3      20         0                 
## 455       IAH  PDX     1825      7      11         0                 
## 456       IAH  MSY      305      2      17         0                 
## 457       IAH  LGA     1416      5      27         0                 
## 458       IAH  SAN     1303      3      13         0                 
## 459       IAH  SAN     1303      4      35         0                 
## 460       IAH  AUS      140      5      20         0                 
## 461       IAH  CLE     1091      5      28         0                 
## 462       IAH  ORD      925     11      24         0                 
## 463       IAH  SLC     1195      5      18         0                 
## 464       IAH  ATL      689      9      16         0                 
## 465       IAH  MSY      305      3      10         0                 
## 466       IAH  SEA     1874      6      30         0                 
## 467       IAH  SFO     1635      5       6         0                 
## 468       IAH  SFO     1635      7      29         0                 
## 469       IAH  PHL     1324      9      19         0                 
## 470       IAH  MCO      853      6      16         0                 
## 471       IAH  DTW     1076      8      19         0                 
## 472       IAH  LAX     1379     13      15         0                 
## 473       IAH  DEN      862     17      15         0                 
## 474       IAH  EWR     1400     14      18         0                 
## 475       IAH  PHX     1009      6      22         0                 
## 476       IAH  TPA      787      3      13         0                 
##        Diverted
## 1             0
## 2             0
## 3             0
## 4             0
## 5             0
## 6             0
## 7             0
## 8             0
## 9             0
## 10            0
## 11            0
## 12            0
## 13            0
## 14            0
## 15            0
## 16            0
## 17            0
## 18            0
## 19            0
## 20            0
## 21            0
## 22            0
## 23            0
## 24            0
## 25            0
## 26            0
## 27            0
## 28            0
## 29            0
## 30            0
## 31            0
## 32            0
## 33            0
## 34            0
## 35            0
## 36            0
## 37            0
## 38            0
## 39            0
## 40            0
## 41            0
## 42            0
## 43            0
## 44            0
## 45            0
## 46            0
## 47            0
## 48            0
## 49            0
## 50            0
## 51            0
## 52            0
## 53            0
## 54            0
## 55            0
## 56            0
## 57            0
## 58            0
## 59            0
## 60            0
## 61            0
## 62            0
## 63            0
## 64            0
## 65            0
## 66            0
## 67            0
## 68            0
## 69            0
## 70            0
## 71            0
## 72            0
## 73            0
## 74            0
## 75            0
## 76            0
## 77            0
## 78            0
## 79            0
## 80            0
## 81            0
## 82            0
## 83            0
## 84            0
## 85            0
## 86            0
## 87            0
## 88            0
## 89            0
## 90            0
## 91            0
## 92            0
## 93            0
## 94            0
## 95            0
## 96            0
## 97            0
## 98            0
## 99            0
## 100           0
## 101           0
## 102           0
## 103           0
## 104           0
## 105           0
## 106           0
## 107           0
## 108           0
## 109           0
## 110           0
## 111           0
## 112           0
## 113           0
## 114           0
## 115           0
## 116           0
## 117           0
## 118           0
## 119           0
## 120           0
## 121           0
## 122           0
## 123           0
## 124           0
## 125           0
## 126           0
## 127           0
## 128           0
## 129           0
## 130           0
## 131           0
## 132           0
## 133           0
## 134           0
## 135           0
## 136           0
## 137           0
## 138           0
## 139           0
## 140           0
## 141           0
## 142           0
## 143           0
## 144           0
## 145           0
## 146           0
## 147           0
## 148           0
## 149           0
## 150           0
## 151           0
## 152           0
## 153           0
## 154           0
## 155           0
## 156           0
## 157           0
## 158           0
## 159           0
## 160           0
## 161           0
## 162           0
## 163           0
## 164           0
## 165           0
## 166           0
## 167           0
## 168           0
## 169           0
## 170           0
## 171           0
## 172           0
## 173           0
## 174           0
## 175           0
## 176           0
## 177           0
## 178           0
## 179           0
## 180           0
## 181           0
## 182           0
## 183           0
## 184           0
## 185           0
## 186           0
## 187           0
## 188           0
## 189           0
## 190           0
## 191           0
## 192           0
## 193           0
## 194           0
## 195           0
## 196           0
## 197           0
## 198           0
## 199           0
## 200           0
## 201           0
## 202           0
## 203           0
## 204           0
## 205           0
## 206           0
## 207           0
## 208           0
## 209           0
## 210           0
## 211           0
## 212           0
## 213           0
## 214           0
## 215           0
## 216           0
## 217           0
## 218           0
## 219           0
## 220           0
## 221           0
## 222           0
## 223           0
## 224           0
## 225           0
## 226           0
## 227           0
## 228           0
## 229           0
## 230           0
## 231           0
## 232           0
## 233           0
## 234           0
## 235           0
## 236           0
## 237           0
## 238           0
## 239           0
## 240           0
## 241           0
## 242           0
## 243           0
## 244           0
## 245           0
## 246           0
## 247           0
## 248           0
## 249           0
## 250           0
## 251           0
## 252           0
## 253           1
## 254           0
## 255           0
## 256           0
## 257           0
## 258           0
## 259           0
## 260           0
## 261           0
## 262           0
## 263           0
## 264           0
## 265           0
## 266           0
## 267           0
## 268           0
## 269           0
## 270           0
## 271           0
## 272           0
## 273           0
## 274           0
## 275           0
## 276           0
## 277           0
## 278           0
## 279           0
## 280           0
## 281           0
## 282           0
## 283           0
## 284           1
## 285           0
## 286           0
## 287           0
## 288           0
## 289           0
## 290           0
## 291           0
## 292           0
## 293           0
## 294           0
## 295           0
## 296           0
## 297           0
## 298           0
## 299           0
## 300           0
## 301           0
## 302           0
## 303           0
## 304           0
## 305           0
## 306           0
## 307           0
## 308           0
## 309           0
## 310           0
## 311           0
## 312           0
## 313           0
## 314           0
## 315           0
## 316           0
## 317           0
## 318           0
## 319           0
## 320           0
## 321           0
## 322           0
## 323           0
## 324           0
## 325           0
## 326           0
## 327           0
## 328           0
## 329           0
## 330           0
## 331           0
## 332           0
## 333           0
## 334           0
## 335           0
## 336           0
## 337           0
## 338           0
## 339           0
## 340           0
## 341           0
## 342           0
## 343           0
## 344           0
## 345           0
## 346           0
## 347           0
## 348           0
## 349           0
## 350           0
## 351           0
## 352           0
## 353           0
## 354           0
## 355           0
## 356           0
## 357           0
## 358           0
## 359           0
## 360           0
## 361           0
## 362           0
## 363           0
## 364           0
## 365           0
## 366           0
## 367           0
## 368           0
## 369           0
## 370           0
## 371           0
## 372           0
## 373           0
## 374           0
## 375           0
## 376           0
## 377           0
## 378           0
## 379           0
## 380           0
## 381           0
## 382           0
## 383           0
## 384           0
## 385           0
## 386           0
## 387           0
## 388           0
## 389           0
## 390           0
## 391           0
## 392           0
## 393           0
## 394           0
## 395           0
## 396           0
## 397           0
## 398           0
## 399           0
## 400           0
## 401           0
## 402           0
## 403           0
## 404           0
## 405           0
## 406           0
## 407           0
## 408           0
## 409           0
## 410           0
## 411           0
## 412           0
## 413           0
## 414           0
## 415           0
## 416           0
## 417           0
## 418           0
## 419           0
## 420           0
## 421           0
## 422           0
## 423           0
## 424           0
## 425           0
## 426           0
## 427           0
## 428           0
## 429           0
## 430           0
## 431           0
## 432           0
## 433           0
## 434           0
## 435           0
## 436           0
## 437           0
## 438           0
## 439           0
## 440           0
## 441           0
## 442           0
## 443           0
## 444           0
## 445           0
## 446           0
## 447           0
## 448           0
## 449           0
## 450           0
## 451           0
## 452           0
## 453           0
## 454           0
## 455           0
## 456           0
## 457           0
## 458           0
## 459           0
## 460           0
## 461           0
## 462           0
## 463           0
## 464           0
## 465           0
## 466           0
## 467           0
## 468           0
## 469           0
## 470           0
## 471           0
## 472           0
## 473           0
## 474           0
## 475           0
## 476           0
##  [ reached getOption("max.print") -- omitted 227020 rows ]
{% endhighlight %}


#### select()

Now we can start using `dplyr` to select certain columns using the `select()` function.  



{% highlight r %}
head(hflights)  # look at the data
{% endhighlight %}



{% highlight text %}
##      Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 5424 2011     1          1         6    1400    1500            AA
## 5425 2011     1          2         7    1401    1501            AA
## 5426 2011     1          3         1    1352    1502            AA
## 5427 2011     1          4         2    1403    1513            AA
## 5428 2011     1          5         3    1405    1507            AA
## 5429 2011     1          6         4    1359    1503            AA
##      FlightNum TailNum ActualElapsedTime AirTime ArrDelay DepDelay Origin
## 5424       428  N576AA                60      40      -10        0    IAH
## 5425       428  N557AA                60      45       -9        1    IAH
## 5426       428  N541AA                70      48       -8       -8    IAH
## 5427       428  N403AA                70      39        3        3    IAH
## 5428       428  N492AA                62      44       -3        5    IAH
## 5429       428  N262AA                64      45       -7       -1    IAH
##      Dest Distance TaxiIn TaxiOut Cancelled CancellationCode Diverted
## 5424  DFW      224      7      13         0                         0
## 5425  DFW      224      6       9         0                         0
## 5426  DFW      224      5      17         0                         0
## 5427  DFW      224      9      22         0                         0
## 5428  DFW      224      9       9         0                         0
## 5429  DFW      224      6      13         0                         0
{% endhighlight %}



{% highlight r %}
hflights %>% 
  select(-CancellationCode) %>% head()  # select everything except CancellationCode
{% endhighlight %}



{% highlight text %}
##      Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 5424 2011     1          1         6    1400    1500            AA
## 5425 2011     1          2         7    1401    1501            AA
## 5426 2011     1          3         1    1352    1502            AA
## 5427 2011     1          4         2    1403    1513            AA
## 5428 2011     1          5         3    1405    1507            AA
## 5429 2011     1          6         4    1359    1503            AA
##      FlightNum TailNum ActualElapsedTime AirTime ArrDelay DepDelay Origin
## 5424       428  N576AA                60      40      -10        0    IAH
## 5425       428  N557AA                60      45       -9        1    IAH
## 5426       428  N541AA                70      48       -8       -8    IAH
## 5427       428  N403AA                70      39        3        3    IAH
## 5428       428  N492AA                62      44       -3        5    IAH
## 5429       428  N262AA                64      45       -7       -1    IAH
##      Dest Distance TaxiIn TaxiOut Cancelled Diverted
## 5424  DFW      224      7      13         0        0
## 5425  DFW      224      6       9         0        0
## 5426  DFW      224      5      17         0        0
## 5427  DFW      224      9      22         0        0
## 5428  DFW      224      9       9         0        0
## 5429  DFW      224      6      13         0        0
{% endhighlight %}



{% highlight r %}
hflights %>% 
  select(Month, UniqueCarrier, FlightNum) %>% head() # select specific columns, seperated by a','
{% endhighlight %}



{% highlight text %}
##      Month UniqueCarrier FlightNum
## 5424     1            AA       428
## 5425     1            AA       428
## 5426     1            AA       428
## 5427     1            AA       428
## 5428     1            AA       428
## 5429     1            AA       428
{% endhighlight %}



{% highlight r %}
#  You can also use 'helper functions'
hflights %>% 
  select(starts_with("A")) %>% head() #selects only columns begining with "A"
{% endhighlight %}



{% highlight text %}
##      ArrTime ActualElapsedTime AirTime ArrDelay
## 5424    1500                60      40      -10
## 5425    1501                60      45       -9
## 5426    1502                70      48       -8
## 5427    1513                70      39        3
## 5428    1507                62      44       -3
## 5429    1503                64      45       -7
{% endhighlight %}



{% highlight r %}
hflights %>% 
  select(matches("Taxi")) %>% head()  #  Find columns that match "Taxi"
{% endhighlight %}



{% highlight text %}
##      TaxiIn TaxiOut
## 5424      7      13
## 5425      6       9
## 5426      5      17
## 5427      9      22
## 5428      9       9
## 5429      6      13
{% endhighlight %}



{% highlight r %}
hflights %>% 
  select(contains("Taxi")) %>% head()  #Similar to match, find columns that contain "Taxi"
{% endhighlight %}



{% highlight text %}
##      TaxiIn TaxiOut
## 5424      7      13
## 5425      6       9
## 5426      5      17
## 5427      9      22
## 5428      9       9
## 5429      6      13
{% endhighlight %}



{% highlight r %}
hflights %>% 
  select(everything()) %>% head()  #  Not sure what this actually does, might as well not use select()
{% endhighlight %}



{% highlight text %}
##      Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 5424 2011     1          1         6    1400    1500            AA
## 5425 2011     1          2         7    1401    1501            AA
## 5426 2011     1          3         1    1352    1502            AA
## 5427 2011     1          4         2    1403    1513            AA
## 5428 2011     1          5         3    1405    1507            AA
## 5429 2011     1          6         4    1359    1503            AA
##      FlightNum TailNum ActualElapsedTime AirTime ArrDelay DepDelay Origin
## 5424       428  N576AA                60      40      -10        0    IAH
## 5425       428  N557AA                60      45       -9        1    IAH
## 5426       428  N541AA                70      48       -8       -8    IAH
## 5427       428  N403AA                70      39        3        3    IAH
## 5428       428  N492AA                62      44       -3        5    IAH
## 5429       428  N262AA                64      45       -7       -1    IAH
##      Dest Distance TaxiIn TaxiOut Cancelled CancellationCode Diverted
## 5424  DFW      224      7      13         0                         0
## 5425  DFW      224      6       9         0                         0
## 5426  DFW      224      5      17         0                         0
## 5427  DFW      224      9      22         0                         0
## 5428  DFW      224      9       9         0                         0
## 5429  DFW      224      6      13         0                         0
{% endhighlight %}



{% highlight r %}
hflights %>% 
  select(Year:FlightNum) %>% head()  # you can specifiy a sequence of column headers
{% endhighlight %}



{% highlight text %}
##      Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 5424 2011     1          1         6    1400    1500            AA
## 5425 2011     1          2         7    1401    1501            AA
## 5426 2011     1          3         1    1352    1502            AA
## 5427 2011     1          4         2    1403    1513            AA
## 5428 2011     1          5         3    1405    1507            AA
## 5429 2011     1          6         4    1359    1503            AA
##      FlightNum
## 5424       428
## 5425       428
## 5426       428
## 5427       428
## 5428       428
## 5429       428
{% endhighlight %}



{% highlight r %}
hflights %>% 
  select(1:8) %>% head() # or specify the column numbers
{% endhighlight %}



{% highlight text %}
##      Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 5424 2011     1          1         6    1400    1500            AA
## 5425 2011     1          2         7    1401    1501            AA
## 5426 2011     1          3         1    1352    1502            AA
## 5427 2011     1          4         2    1403    1513            AA
## 5428 2011     1          5         3    1405    1507            AA
## 5429 2011     1          6         4    1359    1503            AA
##      FlightNum
## 5424       428
## 5425       428
## 5426       428
## 5427       428
## 5428       428
## 5429       428
{% endhighlight %}

#### arrange()

There are many times that it helps to arrange the data in the fashion that you would like to manipulate it.  This is no more required than when you have time series data that the actual order of the data is important.  This used to be done using the `order()` function but dplyr has made this easier with `arrange()`.

`arrange()` requirements

  1. data, if you are chaining (i.e., using pipes this is not required
  2. columns to be arranged
    * default is assending but can be flipped with the `desc()` function
    

{% highlight r %}
hflights %>% 
  arrange(UniqueCarrier,Year,Month, DayofMonth) %>% head()
{% endhighlight %}



{% highlight text %}
##   Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier FlightNum
## 1 2011     1          1         6    1400    1500            AA       428
## 2 2011     1          1         6     728     840            AA       460
## 3 2011     1          1         6    1631    1736            AA      1121
## 4 2011     1          1         6    1756    2112            AA      1294
## 5 2011     1          1         6    1012    1347            AA      1700
## 6 2011     1          1         6    1211    1325            AA      1820
##   TailNum ActualElapsedTime AirTime ArrDelay DepDelay Origin Dest Distance
## 1  N576AA                60      40      -10        0    IAH  DFW      224
## 2  N520AA                72      41        5        8    IAH  DFW      224
## 3  N4WVAA                65      37       -9        1    IAH  DFW      224
## 4  N3DGAA               136     113       -3        1    IAH  MIA      964
## 5  N3DAAA               155     117        7       -8    IAH  MIA      964
## 6  N593AA                74      39       15        6    IAH  DFW      224
##   TaxiIn TaxiOut Cancelled CancellationCode Diverted
## 1      7      13         0                         0
## 2      6      25         0                         0
## 3     16      12         0                         0
## 4      9      14         0                         0
## 5     12      26         0                         0
## 6      6      29         0                         0
{% endhighlight %}



{% highlight r %}
# Using desc()
hflights %>% 
  arrange(desc(UniqueCarrier),desc(Year),Month, DayofMonth) %>% head()
{% endhighlight %}



{% highlight text %}
##   Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier FlightNum
## 1 2011     2         19         6    1004    1355            YV      7290
## 2 2011     2         26         6    1001    1335            YV      7290
## 3 2011     3          5         6    1002    1358            YV      7231
## 4 2011     3         12         6    1009    1357            YV      7240
## 5 2011     3         19         6    1008    1350            YV      7240
## 6 2011     3         19         6    1453    1541            YV      2699
##   TailNum ActualElapsedTime AirTime ArrDelay DepDelay Origin Dest Distance
## 1  N508MJ               171     144      -12       -6    IAH  IAD     1190
## 2  N521LR               154     134      -32       -9    IAH  IAD     1190
## 3  N501MJ               176     142       -9       -8    IAH  IAD     1190
## 4  N521LR               168     148      -10       -1    IAH  IAD     1190
## 5  N518LR               162     141      -17       -2    IAH  IAD     1190
## 6  N907FJ               168     150      -13       -7    IAH  PHX     1009
##   TaxiIn TaxiOut Cancelled CancellationCode Diverted
## 1     14      13         0                         0
## 2      4      16         0                         0
## 3      4      30         0                         0
## 4      4      16         0                         0
## 5      6      15         0                         0
## 6      9       9         0                         0
{% endhighlight %}

#### mutate()

`mutate()` can be used to create new columns, usually based on existing columns. 

`arrange()` requirements

  1. data, if you are chaining (i.e., using pipes this is not required
  2. new column name preceeded by equals symbol '='.  multiple new columns can be separated by ',' 
    
    
    # Note that we can work with columns created in subsequent order
    

{% highlight r %}
hflights %>% 
  select(UniqueCarrier,DepTime,ArrTime) %>%
  mutate(TravTime = (ArrTime-DepTime), 
         TravTime2 = TravTime/60)  # create a new column called 'TravTime' that is the difference between arrival time and departure time.  NOTE: yes i do know that dividing by travel time by 60 makes no sense, this is just illustrative
{% endhighlight %}



{% highlight text %}
##        UniqueCarrier DepTime ArrTime TravTime    TravTime2
## 1                 AA    1400    1500      100   1.66666667
## 2                 AA    1401    1501      100   1.66666667
## 3                 AA    1352    1502      150   2.50000000
## 4                 AA    1403    1513      110   1.83333333
## 5                 AA    1405    1507      102   1.70000000
## 6                 AA    1359    1503      144   2.40000000
## 7                 AA    1359    1509      150   2.50000000
## 8                 AA    1355    1454       99   1.65000000
## 9                 AA    1443    1554      111   1.85000000
## 10                AA    1443    1553      110   1.83333333
## 11                AA    1429    1539      110   1.83333333
## 12                AA    1419    1515       96   1.60000000
## 13                AA    1358    1501      143   2.38333333
## 14                AA    1357    1504      147   2.45000000
## 15                AA    1359    1459      100   1.66666667
## 16                AA    1359    1509      150   2.50000000
## 17                AA    1530    1634      104   1.73333333
## 18                AA    1408    1508      100   1.66666667
## 19                AA    1356    1503      147   2.45000000
## 20                AA    1507    1622      115   1.91666667
## 21                AA    1357    1459      102   1.70000000
## 22                AA    1355    1456      101   1.68333333
## 23                AA    1356    1501      145   2.41666667
## 24                AA    1356    1513      157   2.61666667
## 25                AA    1352    1452      100   1.66666667
## 26                AA    1353    1455      102   1.70000000
## 27                AA    1356    1458      102   1.70000000
## 28                AA    1359    1505      146   2.43333333
## 29                AA    1355    1455      100   1.66666667
## 30                AA    1359    1456       97   1.61666667
## 31                AA    1441    1553      112   1.86666667
## 32                AA     728     840      112   1.86666667
## 33                AA     719     821      102   1.70000000
## 34                AA     717     834      117   1.95000000
## 35                AA     714     821      107   1.78333333
## 36                AA     718     822      104   1.73333333
## 37                AA     719     821      102   1.70000000
## 38                AA     711     827      116   1.93333333
## 39                AA     713     805       92   1.53333333
## 40                AA     714     829      115   1.91666667
## 41                AA     715     818      103   1.71666667
## 42                AA     717     820      103   1.71666667
## 43                AA     714     814      100   1.66666667
## 44                AA     722     841      119   1.98333333
## 45                AA     715     828      113   1.88333333
## 46                AA     719     833      114   1.90000000
## 47                AA     743     843      100   1.66666667
## 48                AA     724     842      118   1.96666667
## 49                AA     721     827      106   1.76666667
## 50                AA     714     833      119   1.98333333
## 51                AA     719     822      103   1.71666667
## 52                AA     712     811       99   1.65000000
## 53                AA     717     829      112   1.86666667
## 54                AA     710     814      104   1.73333333
## 55                AA     731     904      173   2.88333333
## 56                AA     719     818       99   1.65000000
## 57                AA     716     824      108   1.80000000
## 58                AA     715     825      110   1.83333333
## 59                AA     741     846      105   1.75000000
## 60                AA     720     825      105   1.75000000
## 61                AA     716     820      104   1.73333333
## 62                AA     718     816       98   1.63333333
## 63                AA    1959    2106      147   2.45000000
## 64                AA    1958    2107      149   2.48333333
## 65                AA    2100    2207      107   1.78333333
## 66                AA    1958    2106      148   2.46666667
## 67                AA    1955    2103      148   2.46666667
## 68                AA    1958    2055       97   1.61666667
## 69                AA    2045    2155      110   1.83333333
## 70                AA    2029    2133      104   1.73333333
## 71                AA    1953    2051       98   1.63333333
## 72                AA    2015    2113       98   1.63333333
## 73                AA    2020    2116       96   1.60000000
## 74                AA    2119    2229      110   1.83333333
## 75                AA    1956    2119      163   2.71666667
## 76                AA    2030    2131      101   1.68333333
## 77                AA    1957    2106      149   2.48333333
## 78                AA    2029    2123       94   1.56666667
## 79                AA    2004    2121      117   1.95000000
## 80                AA    2036    2134       98   1.63333333
## 81                AA    2001    2057       56   0.93333333
## 82                AA    2043    2139       96   1.60000000
## 83                AA    2004    2107      103   1.71666667
## 84                AA    2009    2103       94   1.56666667
## 85                AA    2039    2130       91   1.51666667
## 86                AA    1959    2100      141   2.35000000
## 87                AA    1959    2132      173   2.88333333
## 88                AA    1954    2105      151   2.51666667
## 89                AA    1631    1736      105   1.75000000
## 90                AA    1636    1759      123   2.05000000
## 91                AA    1623    1738      115   1.91666667
## 92                AA    1629    1732      103   1.71666667
## 93                AA    1629    1740      111   1.85000000
## 94                AA    1625    1732      107   1.78333333
## 95                AA    1630    1733      103   1.71666667
## 96                AA    1627    1736      109   1.81666667
## 97                AA    1835    1951      116   1.93333333
## 98                AA    1639    1740      101   1.68333333
## 99                AA    1752    1855      103   1.71666667
## 100               AA    1631    1739      108   1.80000000
## 101               AA    1630    1733      103   1.71666667
## 102               AA    1629    1734      105   1.75000000
## 103               AA    1632    1736      104   1.73333333
## 104               AA    1708    1819      111   1.85000000
## 105               AA    1632    1744      112   1.86666667
## 106               AA    1625    1740      115   1.91666667
## 107               AA    1629    1731      102   1.70000000
## 108               AA    1641    1752      111   1.85000000
## 109               AA    1638    1746      108   1.80000000
## 110               AA    1623    1742      119   1.98333333
## 111               AA    1622    1738      116   1.93333333
## 112               AA    1621    1749      128   2.13333333
## 113               AA    1627    1733      106   1.76666667
## 114               AA    1634    1745      111   1.85000000
## 115               AA    1634    1740      106   1.76666667
## 116               AA    1625    1730      105   1.75000000
## 117               AA    1630    1731      101   1.68333333
## 118               AA    1635    1733       98   1.63333333
## 119               AA    1656    1758      102   1.70000000
## 120               AA    1756    2112      356   5.93333333
## 121               AA    1823    2132      309   5.15000000
## 122               AA    1755    2106      351   5.85000000
## 123               AA    1757    2122      365   6.08333333
## 124               AA    1751    2100      349   5.81666667
## 125               AA    1746    2120      374   6.23333333
## 126               AA    1757    2108      351   5.85000000
## 127               AA    1749    2100      351   5.85000000
## 128               AA    1810    2123      313   5.21666667
## 129               AA    1934    2235      301   5.01666667
## 130               AA    1848    2156      308   5.13333333
## 131               AA    1748    2102      354   5.90000000
## 132               AA    1748    2127      379   6.31666667
## 133               AA    1754    2101      347   5.78333333
## 134               AA    1749    2059      310   5.16666667
## 135               AA    1807    2137      330   5.50000000
## 136               AA    1803    2121      318   5.30000000
## 137               AA    1839    2154      315   5.25000000
## 138               AA    1751    2103      352   5.86666667
## 139               AA    1750    2114      364   6.06666667
## 140               AA    1818    2133      315   5.25000000
## 141               AA    1750    2055      305   5.08333333
## 142               AA    1753    2113      360   6.00000000
## 143               AA    1828    2146      318   5.30000000
## 144               AA    1750    2118      368   6.13333333
## 145               AA    1905    2211      306   5.10000000
## 146               AA    1812    2129      317   5.28333333
## 147               AA    1750    2108      358   5.96666667
## 148               AA    1753    2102      349   5.81666667
## 149               AA    1856    2209      353   5.88333333
## 150               AA    1757    2101      344   5.73333333
## 151               AA     907    1013      106   1.76666667
## 152               AA     930    1030      100   1.66666667
## 153               AA     916    1019      103   1.71666667
## 154               AA     907    1015      108   1.80000000
## 155               AA     904    1012      108   1.80000000
## 156               AA     941    1113      172   2.86666667
## 157               AA     901    1005      104   1.73333333
## 158               AA     909    1009      100   1.66666667
## 159               AA     907    1022      115   1.91666667
## 160               AA     903    1012      109   1.81666667
## 161               AA     930    1040      110   1.83333333
## 162               AA     923    1030      107   1.78333333
## 163               AA     916    1028      112   1.86666667
## 164               AA     907    1018      111   1.85000000
## 165               AA     918    1037      119   1.98333333
## 166               AA     912    1017      105   1.75000000
## 167               AA     901    1007      106   1.76666667
## 168               AA     910    1018      108   1.80000000
## 169               AA     908    1011      103   1.71666667
## 170               AA     907    1012      105   1.75000000
## 171               AA     941    1054      113   1.88333333
## 172               AA    1012    1347      335   5.58333333
## 173               AA    1008    1321      313   5.21666667
## 174               AA    1018    1323      305   5.08333333
## 175               AA    1026    1333      307   5.11666667
## 176               AA    1021    1331      310   5.16666667
## 177               AA    1020    1322      302   5.03333333
## 178               AA    1010    1316      306   5.10000000
## 179               AA    1019    1324      305   5.08333333
## 180               AA    1029    1338      309   5.15000000
## 181               AA    1038    1414      376   6.26666667
## 182               AA    1134    1454      320   5.33333333
## 183               AA    1019    1327      308   5.13333333
## 184               AA    1018    1326      308   5.13333333
## 185               AA    1024    1327      303   5.05000000
## 186               AA    1022    1340      318   5.30000000
## 187               AA    1021    1332      311   5.18333333
## 188               AA    1019    1332      313   5.21666667
## 189               AA    1017    1332      315   5.25000000
## 190               AA    1016    1331      315   5.25000000
## 191               AA    1015    1325      310   5.16666667
## 192               AA    1017    1325      308   5.13333333
## 193               AA    1026    1345      319   5.31666667
## 194               AA    1012    1327      315   5.25000000
## 195               AA      NA      NA       NA           NA
## 196               AA    1040    1354      314   5.23333333
## 197               AA    1015    1329      314   5.23333333
## 198               AA    1017    1335      318   5.30000000
## 199               AA    1020    1318      298   4.96666667
## 200               AA    1015    1326      311   5.18333333
## 201               AA    1019    1324      305   5.08333333
## 202               AA    1013    1336      323   5.38333333
## 203               AA    1211    1325      114   1.90000000
## 204               AA    1200    1303      103   1.71666667
## 205               AA    1204    1308      104   1.73333333
## 206               AA    1206    1319      113   1.88333333
## 207               AA    1205    1311      106   1.76666667
## 208               AA    1204    1310      106   1.76666667
## 209               AA    1204    1316      112   1.86666667
## 210               AA    1202    1308      106   1.76666667
## 211               AA      NA      NA       NA           NA
## 212               AA    1217    1329      112   1.86666667
## 213               AA    1205    1310      105   1.75000000
## 214               AA    1206    1305       99   1.65000000
## 215               AA    1205    1311      106   1.76666667
## 216               AA    1205    1315      110   1.83333333
## 217               AA    1222    1329      107   1.78333333
## 218               AA    1205    1306      101   1.68333333
## 219               AA    1205    1322      117   1.95000000
## 220               AA    1235    1334       99   1.65000000
## 221               AA    1204    1311      107   1.78333333
## 222               AA    1214    1324      110   1.83333333
## 223               AA    1206    1312      106   1.76666667
## 224               AA    1200    1312      112   1.86666667
## 225               AA    1217    1308       91   1.51666667
## 226               AA    1212    1318      106   1.76666667
## 227               AA    1159    1259      100   1.66666667
## 228               AA    1159    1314      155   2.58333333
## 229               AA    1159    1311      152   2.53333333
## 230               AA    1255    1358      103   1.71666667
## 231               AA    1156    1302      146   2.43333333
## 232               AA    1159    1319      160   2.66666667
## 233               AA    1205    1317      112   1.86666667
## 234               AA     907    1018      111   1.85000000
## 235               AA     902    1010      108   1.80000000
## 236               AA     938    1050      112   1.86666667
## 237               AA     905    1007      102   1.70000000
## 238               AA     903    1012      109   1.81666667
## 239               AA     930    1041      111   1.85000000
## 240               AA     903    1023      120   2.00000000
## 241               AA     903    1020      117   1.95000000
## 242               AA     904    1013      109   1.81666667
## 243               AA     557     906      349   5.81666667
## 244               AA     554     912      358   5.96666667
## 245               AA     555     905      350   5.83333333
## 246               AA     558     923      365   6.08333333
## 247               AA     555     914      359   5.98333333
## 248               AA     600     908      308   5.13333333
## 249               AA     556     905      349   5.81666667
## 250               AA     558     910      352   5.86666667
## 251               AA     558     911      353   5.88333333
## 252               AA     605     920      315   5.25000000
## 253               AA     553    1216      663  11.05000000
## 254               AA     551     903      352   5.86666667
## 255               AA     633     938      305   5.08333333
## 256               AA     558     910      352   5.86666667
## 257               AA     555     905      350   5.83333333
## 258               AA     605     910      305   5.08333333
## 259               AA     556     943      387   6.45000000
## 260               AA     555     911      356   5.93333333
## 261               AA     554     921      367   6.11666667
## 262               AA     556     912      356   5.93333333
## 263               AA     553     907      354   5.90000000
## 264               AA     550     907      357   5.95000000
## 265               AA     552     900      348   5.80000000
## 266               AA     553     906      353   5.88333333
## 267               AA     558     916      358   5.96666667
## 268               AA     555     907      352   5.86666667
## 269               AA     606     915      309   5.15000000
## 270               AA     554     905      351   5.85000000
## 271               AA     552     904      352   5.86666667
## 272               AA     553     910      357   5.95000000
## 273               AA     556     857      301   5.01666667
## 274               AS    1824    2106      282   4.70000000
## 275               AS    1823    2103      280   4.66666667
## 276               AS    1827    2107      280   4.66666667
## 277               AS    1845    2132      287   4.78333333
## 278               AS    1821    2109      288   4.80000000
## 279               AS    1834    2133      299   4.98333333
## 280               AS    1823    2118      295   4.91666667
## 281               AS    1822    2112      290   4.83333333
## 282               AS    1938    2228      290   4.83333333
## 283               AS    1820    2159      339   5.65000000
## 284               AS    1820      12    -1808 -30.13333333
## 285               AS    1822    2129      307   5.11666667
## 286               AS    1820    2113      293   4.88333333
## 287               AS    1818    2114      296   4.93333333
## 288               AS    1822    2131      309   5.15000000
## 289               AS    1822    2138      316   5.26666667
## 290               AS    1818    2149      331   5.51666667
## 291               AS    1836    2130      294   4.90000000
## 292               AS    1820    2102      282   4.70000000
## 293               AS    1822    2135      313   5.21666667
## 294               AS    1827    2136      309   5.15000000
## 295               AS    1816    2100      284   4.73333333
## 296               AS    1818    2104      286   4.76666667
## 297               AS    1824    2109      285   4.75000000
## 298               AS    1826    2101      275   4.58333333
## 299               AS    1830    2115      285   4.75000000
## 300               AS    1832    2110      278   4.63333333
## 301               AS    1821    2052      231   3.85000000
## 302               AS    1821    2042      221   3.68333333
## 303               AS    1821    2128      307   5.11666667
## 304               AS    1827    2111      284   4.73333333
## 305               B6     654    1124      470   7.83333333
## 306               B6    1639    2110      471   7.85000000
## 307               B6     703    1113      410   6.83333333
## 308               B6    1604    2040      436   7.26666667
## 309               B6     659    1100      441   7.35000000
## 310               B6    1801    2200      399   6.65000000
## 311               B6     654    1103      449   7.48333333
## 312               B6    1608    2034      426   7.10000000
## 313               B6     700    1103      403   6.71666667
## 314               B6    1544    1954      410   6.83333333
## 315               B6    1532    1943      411   6.85000000
## 316               B6     654    1117      463   7.71666667
## 317               B6    1542    1956      414   6.90000000
## 318               B6     654    1058      404   6.73333333
## 319               B6     653    1059      406   6.76666667
## 320               B6    1618    2057      439   7.31666667
## 321               B6     656    1102      446   7.43333333
## 322               B6    1554    2001      447   7.45000000
## 323               B6     653    1053      400   6.66666667
## 324               B6      NA      NA       NA           NA
## 325               B6    1532    1953      421   7.01666667
## 326               B6    1522    1938      416   6.93333333
## 327               B6     808    1229      421   7.01666667
## 328               B6    1534    2015      481   8.01666667
## 329               B6     700    1114      414   6.90000000
## 330               B6     652    1055      403   6.71666667
## 331               B6    1551    2004      453   7.55000000
## 332               B6     730    1135      405   6.75000000
## 333               B6    1531    1946      415   6.91666667
## 334               B6     659    1102      443   7.38333333
## 335               B6    1647    2056      409   6.81666667
## 336               B6      NA      NA       NA           NA
## 337               B6    1538    1952      414   6.90000000
## 338               B6     656    1104      448   7.46666667
## 339               B6    1725    2135      410   6.83333333
## 340               B6     701    1106      405   6.75000000
## 341               B6     658    1058      400   6.66666667
## 342               B6    1535    1933      398   6.63333333
## 343               B6     707    1059      352   5.86666667
## 344               B6    1532    1923      391   6.51666667
## 345               B6     658    1102      444   7.40000000
## 346               B6    1623    2029      406   6.76666667
## 347               B6    1535    1941      406   6.76666667
## 348               B6      NA      NA       NA           NA
## 349               B6     655    1107      452   7.53333333
## 350               B6    1538    2013      475   7.91666667
## 351               B6     657    1128      471   7.85000000
## 352               B6     651    1106      455   7.58333333
## 353               B6    1659    2118      459   7.65000000
## 354               B6     659    1111      452   7.53333333
## 355               B6    1532    1942      410   6.83333333
## 356               CO     924    1413      489   8.15000000
## 357               CO    1825    1925      100   1.66666667
## 358               CO    1554    1650       96   1.60000000
## 359               CO    1522    1632      110   1.83333333
## 360               CO    1536    1635       99   1.65000000
## 361               CO    1916    2103      187   3.11666667
## 362               CO     747     936      189   3.15000000
## 363               CO    1803    1927      124   2.06666667
## 364               CO    1206    1631      425   7.08333333
## 365               CO    1425    1848      423   7.05000000
## 366               CO     607    1022      415   6.91666667
## 367               CO    1041    1449      408   6.80000000
## 368               CO     728     856      128   2.13333333
## 369               CO    1433    1629      196   3.26666667
## 370               CO    1422    1647      225   3.75000000
## 371               CO    1750    1921      171   2.85000000
## 372               CO    1442    1842      400   6.66666667
## 373               CO     851    1052      201   3.35000000
## 374               CO    1919    2231      312   5.20000000
## 375               CO    1155    1324      169   2.81666667
## 376               CO     726     915      189   3.15000000
## 377               CO    1259    1554      295   4.91666667
## 378               CO    2116    2344      228   3.80000000
## 379               CO    1551    2009      458   7.63333333
## 380               CO    1024    1621      597   9.95000000
## 381               CO     912    1138      226   3.76666667
## 382               CO    1020    1421      401   6.68333333
## 383               CO     916    1336      420   7.00000000
## 384               CO    1301    1356       55   0.91666667
## 385               CO    1554    1918      364   6.06666667
## 386               CO    1850    2211      361   6.01666667
## 387               CO     727    1120      393   6.55000000
## 388               CO    1240    1526      286   4.76666667
## 389               CO    1129    1351      222   3.70000000
## 390               CO    1615    1741      126   2.10000000
## 391               CO    1145    1255      110   1.83333333
## 392               CO     735    1220      485   8.08333333
## 393               CO    1046    1221      175   2.91666667
## 394               CO    2102    2216      114   1.90000000
## 395               CO     854    1137      283   4.71666667
## 396               CO    1949       2    -1947 -32.45000000
## 397               CO    1431    1643      212   3.53333333
## 398               CO    1312    1413      101   1.68333333
## 399               CO    1248    1628      380   6.33333333
## 400               CO     742    1217      475   7.91666667
## 401               CO    1033    1420      387   6.45000000
## 402               CO    1432    1656      224   3.73333333
## 403               CO    1320    1420      100   1.66666667
## 404               CO    1047    1526      479   7.98333333
## 405               CO    1902    2022      120   2.00000000
## 406               CO    1316    1643      327   5.45000000
## 407               CO    1031    1203      172   2.86666667
## 408               CO     725    1117      392   6.53333333
## 409               CO    1156    1555      399   6.65000000
## 410               CO     749    1216      467   7.78333333
## 411               CO    1701    2036      335   5.58333333
## 412               CO    1911    2118      207   3.45000000
## 413               CO    1924    2026      102   1.70000000
## 414               CO    1909    2254      345   5.75000000
## 415               CO    1049    1507      458   7.63333333
## 416               CO      NA      NA       NA           NA
## 417               CO    1925    2202      277   4.61666667
## 418               CO     554     818      264   4.40000000
## 419               CO    1250    1638      388   6.46666667
## 420               CO    2157      53    -2104 -35.06666667
## 421               CO    1911    2011      100   1.66666667
## 422               CO    1305    1746      441   7.35000000
## 423               CO     906    1056      150   2.50000000
## 424               CO    1148    1327      179   2.98333333
## 425               CO      NA      NA       NA           NA
## 426               CO     855    1322      467   7.78333333
## 427               CO    2056    2217      161   2.68333333
## 428               CO    1738    1939      201   3.35000000
## 429               CO    1322    1807      485   8.08333333
## 430               CO    1257    1627      370   6.16666667
## 431               CO     934    1149      215   3.58333333
## 432               CO     638    1021      383   6.38333333
## 433               CO    1146    1421      275   4.58333333
## 434               CO    1611    1955      344   5.73333333
## 435               CO     917    1120      203   3.38333333
## 436               CO    1748    2001      253   4.21666667
## 437               CO    1901    2332      431   7.18333333
## 438               CO     740    1052      312   5.20000000
## 439               CO    2102    2222      120   2.00000000
## 440               CO    1429    1608      179   2.98333333
## 441               CO    1313    1516      203   3.38333333
## 442               CO    1540    1833      293   4.88333333
## 443               CO    1930    2225      295   4.91666667
## 444               CO    1429    1542      113   1.88333333
## 445               CO     714    1103      389   6.48333333
## 446               CO    1543    1948      405   6.75000000
## 447               CO    1917    2234      317   5.28333333
## 448               CO    1915    2248      333   5.55000000
## 449               CO    1120    1355      235   3.91666667
## 450               CO    1737    2003      266   4.43333333
## 451               CO    1550    2012      462   7.70000000
## 452               CO    1034    1348      314   5.23333333
## 453               CO    1440    1630      190   3.16666667
## 454               CO     749    1044      295   4.91666667
## 455               CO    1807    2030      223   3.71666667
## 456               CO    1130    1233      103   1.71666667
## 457               CO    1940    2349      409   6.81666667
## 458               CO    1239    1409      170   2.83333333
## 459               CO     906    1058      152   2.53333333
## 460               CO    1144    1241       97   1.61666667
## 461               CO    1308    1646      338   5.63333333
## 462               CO    1423    1652      229   3.81666667
## 463               CO    2137       9    -2128 -35.46666667
## 464               CO    1930    2224      294   4.90000000
## 465               CO    1653    1748       95   1.58333333
## 466               CO    1440    1731      291   4.85000000
## 467               CO    2143    2338      195   3.25000000
## 468               CO     729    1002      273   4.55000000
## 469               CO     722    1125      403   6.71666667
## 470               CO    1347    1654      307   5.11666667
## 471               CO    1012    1351      339   5.65000000
## 472               CO    1550    1736      186   3.10000000
## 473               CO     842    1027      185   3.08333333
## 474               CO    1311    1731      420   7.00000000
## 475               CO    2105    2311      206   3.43333333
## 476               CO    1107    1352      245   4.08333333
## 477               CO    1805    2211      406   6.76666667
## 478               CO    2120    2323      203   3.38333333
## 479               CO     725    1040      315   5.25000000
## 480               CO     851    1241      390   6.50000000
## 481               CO    1558    1812      254   4.23333333
## 482               CO    1446    1557      111   1.85000000
## 483               CO    1754    2056      302   5.03333333
## 484               CO    1309    1656      347   5.78333333
## 485               CO    2107    2247      140   2.33333333
## 486               CO     727     911      184   3.06666667
## 487               CO    1859    2023      164   2.73333333
## 488               CO    1900    1953       53   0.88333333
## 489               CO     934    1149      215   3.58333333
## 490               CO    1903    2228      325   5.41666667
## 491               CO    2101    2215      114   1.90000000
## 492               CO    1229    1540      311   5.18333333
## 493               CO    1035    1351      316   5.26666667
## 494               CO    2053    2235      182   3.03333333
## 495               CO    1048    1354      306   5.10000000
## 496               CO    1022    1433      411   6.85000000
## 497               CO    2105    2157       52   0.86666667
## 498               CO    1918    2247      329   5.48333333
## 499               CO     920    1116      196   3.26666667
## 500               CO    1559    1722      163   2.71666667
## 501               CO    1756    2133      377   6.28333333
## 502               CO    1900    2142      242   4.03333333
## 503               CO    1757    1943      186   3.10000000
## 504               CO    2113    2215      102   1.70000000
## 505               CO    1434    1539      105   1.75000000
## 506               CO    1039    1406      367   6.11666667
## 507               CO    1731    1948      217   3.61666667
## 508               CO    1312    1615      303   5.05000000
## 509               CO    1358    1702      344   5.73333333
## 510               CO    1847    2040      193   3.21666667
## 511               CO     900    1006      106   1.76666667
## 512               CO    1901    2203      302   5.03333333
## 513               CO    1454    1638      184   3.06666667
## 514               CO     723    1036      313   5.21666667
## 515               CO    1753    1843       90   1.50000000
## 516               CO    1153    1353      200   3.33333333
## 517               CO    1139    1350      211   3.51666667
## 518               CO    1423    1541      118   1.96666667
## 519               CO     845     944       99   1.65000000
## 520               CO    1216    1356      140   2.33333333
## 521               CO    1743    2141      398   6.63333333
## 522               CO     850    1004      154   2.56666667
## 523               CO    2100    2252      152   2.53333333
## 524               CO    1029    1251      222   3.70000000
## 525               CO    1604    1910      306   5.10000000
## 526               CO    1910    2212      302   5.03333333
## 527               CO    1801    1918      117   1.95000000
## 528               CO    1548    1956      408   6.80000000
## 529               CO     913    1028      115   1.91666667
## 530               CO    1558    1936      378   6.30000000
## 531               CO    1809    1943      134   2.23333333
## 532               CO    1030    1341      311   5.18333333
## 533               CO    1325    1538      213   3.55000000
## 534               CO    1732    1853      121   2.01666667
## 535               CO      NA      NA       NA           NA
## 536               CO     911    1144      233   3.88333333
## 537               CO    1733    1901      168   2.80000000
## 538               CO    2113    2253      140   2.33333333
## 539               CO    1008    1145      137   2.28333333
## 540               CO     753    1032      279   4.65000000
## 541               CO    1911    2220      309   5.15000000
## 542               CO    1252    1559      307   5.11666667
## 543               CO     940    1233      293   4.88333333
## 544               CO    1926    2318      392   6.53333333
## 545               CO    1742    1835       93   1.55000000
## 546               CO     902    1107      205   3.41666667
## 547               CO    1608    1709      101   1.68333333
## 548               CO    1317    1623      306   5.10000000
## 549               CO    1749    1938      189   3.15000000
## 550               CO    1447    1644      197   3.28333333
## 551               CO    1027    1136      109   1.81666667
## 552               CO    1922    2229      307   5.11666667
## 553               CO    1145    1557      412   6.86666667
## 554               CO    1232    1637      405   6.75000000
## 555               CO    1432    1817      385   6.41666667
## 556               CO    1305    1628      323   5.38333333
## 557               CO    1737    1947      210   3.50000000
## 558               CO     904    1217      313   5.21666667
## 559               CO    1139    1319      180   3.00000000
## 560               CO    1757    2007      250   4.16666667
## 561               CO     925    1410      485   8.08333333
## 562               CO    1829    1930      101   1.68333333
## 563               CO    1550    1651      101   1.68333333
## 564               CO    1525    1626      101   1.68333333
## 565               CO    1532    1633      101   1.68333333
## 566               CO    1914    2125      211   3.51666667
## 567               CO     754     953      199   3.31666667
## 568               CO    1756    1933      177   2.95000000
## 569               CO    1205    1622      417   6.95000000
## 570               CO    1443    1851      408   6.80000000
## 571               CO     600    1014      414   6.90000000
## 572               CO    1051    1520      469   7.81666667
## 573               CO     736     843      107   1.78333333
## 574               CO    1441    1610      169   2.81666667
## 575               CO    1258    1550      292   4.86666667
## 576               CO    2128    2252      124   2.06666667
## 577               CO    1446    1834      388   6.46666667
## 578               CO     935    1203      268   4.46666667
## 579               CO    1920    2236      316   5.26666667
## 580               CO    1200    1326      126   2.10000000
## 581               CO     559     717      158   2.63333333
## 582               CO    1305    1606      301   5.01666667
## 583               CO    2200      19    -2181 -36.35000000
## 584               CO    1607    2033      426   7.10000000
## 585               CO    1022    1615      593   9.88333333
## 586               CO     900    1101      201   3.35000000
## 587               CO    1024    1429      405   6.75000000
## 588               CO     923    1339      416   6.93333333
## 589               CO    1304    1408      104   1.73333333
## 590               CO    1555    1943      388   6.46666667
## 591               CO    1848    2224      376   6.26666667
## 592               CO    1236    1500      264   4.40000000
## 593               CO    1143    1359      216   3.60000000
## 594               CO    1550    1712      162   2.70000000
## 595               CO    1144    1248      104   1.73333333
## 596               CO    1047    1200      153   2.55000000
## 597               CO    2112    2301      189   3.15000000
## 598               CO     848    1104      256   4.26666667
## 599               CO    1925       5    -1920 -32.00000000
## 600               CO    1433    1622      189   3.15000000
## 601               CO    1315    1425      110   1.83333333
## 602               CO    1305    1702      397   6.61666667
## 603               CO    1130    1326      196   3.26666667
## 604               CO    1031    1426      395   6.58333333
## 605               CO    1459    1715      256   4.26666667
## 606               CO    1316    1425      109   1.81666667
## 607               CO    1046    1518      472   7.86666667
## 608               CO    1801    1940      139   2.31666667
## 609               CO    1315    1639      324   5.40000000
## 610               CO    1026    1158      132   2.20000000
## 611               CO     722    1054      332   5.53333333
## 612               CO    1157    1607      450   7.50000000
## 613               CO     745    1209      464   7.73333333
## 614               CO    1706    2050      344   5.73333333
## 615               CO    1813    2046      233   3.88333333
## 616               CO    2004    2128      124   2.06666667
## 617               CO    1919    2335      416   6.93333333
## 618               CO    1043    1509      466   7.76666667
## 619               CO    1855    2044      189   3.15000000
## 620               CO    1930    2230      300   5.00000000
## 621               CO    1255    1644      389   6.48333333
## 622               CO    2141      10    -2131 -35.51666667
## 623               CO    1912    2032      120   2.00000000
## 624               CO    1319    1811      492   8.20000000
## 625               CO     916    1032      116   1.93333333
## 626               CO    1151    1331      180   3.00000000
## 627               CO    1934    2318      384   6.40000000
## 628               CO     855    1319      464   7.73333333
## 629               CO    2106    2212      106   1.76666667
## 630               CO    1748    1954      206   3.43333333
## 631               CO    1350    1749      399   6.65000000
## 632               CO    1302    1657      355   5.91666667
## 633               CO     926    1125      199   3.31666667
## 634               CO     735    1114      379   6.31666667
## 635               CO    1142    1444      302   5.03333333
## 636               CO    1609    2001      392   6.53333333
## 637               CO    1749    2011      262   4.36666667
## 638               CO    1909      23    -1886 -31.43333333
## 639               CO     800    1059      259   4.31666667
## 640               CO    2100    2229      129   2.15000000
## 641               CO    1420    1540      120   2.00000000
## 642               CO    1312    1451      139   2.31666667
## 643               CO    1539    1832      293   4.88333333
## 644               CO    1910    2215      305   5.08333333
## 645               CO    1428    1533      105   1.75000000
## 646               CO    1548    1958      410   6.83333333
## 647               CO    1921    2321      400   6.66666667
## 648               CO    1908    2300      392   6.53333333
## 649               CO    1124    1316      192   3.20000000
## 650               CO    1744    2008      264   4.40000000
## 651               CO    1931    2159      228   3.80000000
## 652               CO    1553    2030      477   7.95000000
## 653               CO    1034    1356      322   5.36666667
## 654               CO    1452    1610      158   2.63333333
## 655               CO    1806    2109      303   5.05000000
## 656               CO    1132    1233      101   1.68333333
## 657               CO    1904    2324      420   7.00000000
## 658               CO    1239    1408      169   2.81666667
## 659               CO     905    1032      127   2.11666667
## 660               CO    1141    1251      110   1.83333333
## 661               CO    1320    1712      392   6.53333333
## 662               CO    1455    1727      272   4.53333333
## 663               CO    2135    2346      211   3.51666667
## 664               CO    2026    2335      309   5.15000000
## 665               CO     906    1046      140   2.33333333
## 666               CO    1653    1757      104   1.73333333
## 667               CO    1516    1741      225   3.75000000
## 668               CO    2100    2320      220   3.66666667
## 669               CO     729     936      207   3.45000000
## 670               CO    1342    1648      306   5.10000000
## 671               CO    1102    1443      341   5.68333333
## 672               CO    1540    1728      188   3.13333333
## 673               CO     845    1015      170   2.83333333
## 674               CO    1319    1752      433   7.21666667
## 675               CO    2106    2259      153   2.55000000
## 676               CO    1053    1411      358   5.96666667
## 677               CO    1812    2234      422   7.03333333
## 678               CO    2108    2345      237   3.95000000
## 679               CO     727    1040      313   5.21666667
## 680               CO     851    1230      379   6.31666667
## 681               CO    1603    1820      217   3.61666667
## 682               CO    1441    1534       93   1.55000000
## 683               CO    1700    2002      302   5.03333333
## 684               CO    1304    1642      338   5.63333333
## 685               CO    2105    2302      197   3.28333333
## 686               CO     725     839      114   1.90000000
## 687               CO    1931    2109      178   2.96666667
## 688               CO    1922    2032      110   1.83333333
## 689               CO     915    1128      213   3.55000000
## 690               CO    1904    2305      401   6.68333333
## 691               CO    2123    2223      100   1.66666667
## 692               CO    1037    1406      369   6.15000000
## 693               CO    2050    2227      177   2.95000000
## 694               CO    1127    1559      432   7.20000000
## 695               CO    2104    2200       96   1.60000000
## 696               CO    1924    2357      433   7.21666667
## 697               CO     927    1113      186   3.10000000
## 698               CO    1616    1731      115   1.91666667
## 699               CO    1915    2215      300   5.00000000
## 700               CO    1805    2019      214   3.56666667
## 701               CO    1444    1536       92   1.53333333
## 702               CO    1011    1348      337   5.61666667
## 703               CO    1755    2034      279   4.65000000
## 704               CO    1323    1639      316   5.26666667
## 705               CO    1813    1914      101   1.68333333
## 706               CO    1402    1707      305   5.08333333
## 707               CO    1900    2132      232   3.86666667
## 708               CO     858     950       92   1.53333333
## 709               CO    1919    2242      323   5.38333333
## 710               CO    1451    1628      177   2.95000000
## 711               CO     724    1028      304   5.06666667
## 712               CO    1757    2206      449   7.48333333
## 713               CO    1319    1515      196   3.26666667
## 714               CO    1137    1351      214   3.56666667
## 715               CO    1418    1538      120   2.00000000
## 716               CO     839     940      101   1.68333333
## 717               CO    1235    1431      196   3.26666667
## 718               CO    1750    2203      453   7.55000000
## 719               CO    2057    2258      201   3.35000000
## 720               CO    1029    1251      222   3.70000000
## 721               CO    1647    1956      309   5.15000000
## 722               CO    1918    2250      332   5.53333333
## 723               CO    1747    1904      157   2.61666667
## 724               CO    1605    2006      401   6.68333333
## 725               CO     928    1031      103   1.71666667
## 726               CO    1555    1958      403   6.71666667
## 727               CO    1802    1955      153   2.55000000
## 728               CO    1032    1354      322   5.36666667
## 729               CO    1345    1547      202   3.36666667
## 730               CO    1752    1907      155   2.58333333
## 731               CO    1909    2057      148   2.46666667
## 732               CO    1750    1913      163   2.71666667
## 733               CO    2234       2    -2232 -37.20000000
## 734               CO     935    1105      170   2.83333333
## 735               CO    2057    2140       83   1.38333333
## 736               CO     722     943      221   3.68333333
## 737               CO    1944    2324      380   6.33333333
## 738               CO    1249    1550      301   5.01666667
## 739               CO     930    1149      219   3.65000000
## 740               CO    1937      13    -1924 -32.06666667
## 741               CO    1749    1842       93   1.55000000
## 742               CO     857    1040      183   3.05000000
## 743               CO    1704    1805      101   1.68333333
## 744               CO    1332    1644      312   5.20000000
## 745               CO    1803    1954      151   2.51666667
## 746               CO    1453    1632      179   2.98333333
## 747               CO    1038    1214      176   2.93333333
## 748               CO    1924    2310      386   6.43333333
## 749               CO    1146    1629      483   8.05000000
## 750               CO    1233    1644      411   6.85000000
## 751               CO    1442    1805      363   6.05000000
## 752               CO    1253    1625      372   6.20000000
## 753               CO    1758    2023      265   4.41666667
## 754               CO     905    1222      317   5.28333333
## 755               CO    1131    1321      190   3.16666667
## 756               CO    1739    1945      206   3.43333333
## 757               CO    1045    1445      400   6.66666667
## 758               CO    1826    1920       94   1.56666667
## 759               CO    1437    1543      106   1.76666667
## 760               CO    1535    1628       93   1.55000000
## 761               CO     744     921      177   2.95000000
## 762               CO    1738    1901      163   2.71666667
## 763               CO    1211    1629      418   6.96666667
## 764               CO    1433    1846      413   6.88333333
## 765               CO     559    1017      458   7.63333333
## 766               CO    1050    1516      466   7.76666667
## 767               CO    1443    1632      189   3.15000000
## 768               CO    1302    1532      230   3.83333333
## 769               CO    1732    1909      177   2.95000000
## 770               CO     852    1126      274   4.56666667
## 771               CO    1920    2227      307   5.11666667
## 772               CO    1235    1347      112   1.86666667
## 773               CO     556     717      161   2.68333333
## 774               CO    1310    1558      248   4.13333333
## 775               CO    2122    2348      226   3.76666667
## 776               CO    1546    2024      478   7.96666667
## 777               CO    1022    1618      596   9.93333333
## 778               CO    1010    1202      192   3.20000000
## 779               CO    1018    1416      398   6.63333333
## 780               CO    1403    1452       49   0.81666667
## 781               CO    1541    1916      375   6.25000000
## 782               CO    1852    2218      366   6.10000000
## 783               CO     726    1121      395   6.58333333
## 784               CO    1258    1519      261   4.35000000
## 785               CO    1133    1355      222   3.70000000
## 786               CO    1530    1705      175   2.91666667
## 787               CO    1140    1248      108   1.80000000
## 788               CO     740    1227      487   8.11666667
## 789               CO    1037    1143      106   1.76666667
## 790               CO    2052    2215      163   2.71666667
## 791               CO     942    1157      215   3.58333333
## 792               CO    1924    2333      409   6.81666667
## 793               CO    1458    1647      189   3.15000000
## 794               CO    1309    1412      103   1.71666667
## 795               CO    1314    1716      402   6.70000000
## 796               CO     747    1157      410   6.83333333
## 797               CO    1215    1338      123   2.05000000
## 798               CO    1104    1440      336   5.60000000
## 799               CO    1442    1655      213   3.55000000
## 800               CO    1317    1421      104   1.73333333
## 801               CO    1051    1531      480   8.00000000
## 802               CO    1809    1932      123   2.05000000
## 803               CO    1158    1551      393   6.55000000
## 804               CO      NA      NA       NA           NA
## 805               CO    1702    2047      345   5.75000000
## 806               CO    1744    2000      256   4.26666667
## 807               CO    1918    2020      102   1.70000000
## 808               CO    2010    2346      336   5.60000000
## 809               CO    1104    1515      411   6.85000000
## 810               CO    1941    2151      210   3.50000000
## 811               CO     606     827      221   3.68333333
## 812               CO    1250    1640      390   6.50000000
## 813               CO    2127    2348      221   3.68333333
## 814               CO    1907    2000       93   1.55000000
## 815               CO    1300    1747      447   7.45000000
## 816               CO     912    1016      104   1.73333333
## 817               CO    1204    1320      116   1.93333333
## 818               CO    1919    2242      323   5.38333333
## 819               CO     858    1317      459   7.65000000
## 820               CO    2056    2214      158   2.63333333
## 821               CO    1745    1940      195   3.25000000
## 822               CO    1324    1742      418   6.96666667
## 823               CO    1308    1643      335   5.58333333
## 824               CO     933    1132      199   3.31666667
## 825               CO     741    1116      375   6.25000000
## 826               CO    1141    1409      268   4.46666667
## 827               CO    1611    1943      332   5.53333333
## 828               CO     920    1048      128   2.13333333
## 829               CO    1809    2021      212   3.53333333
## 830               CO    1920    2340      420   7.00000000
## 831               CO     740    1039      299   4.98333333
## 832               CO    2055    2213      158   2.63333333
## 833               CO    1426    1543      117   1.95000000
## 834               CO    1306    1424      118   1.96666667
## 835               CO    1554    1850      296   4.93333333
## 836               CO    1916    2201      285   4.75000000
## 837               CO     711    1109      398   6.63333333
## 838               CO    1541    1959      418   6.96666667
## 839               CO    1907    2240      333   5.55000000
## 840               CO    1921    2309      388   6.46666667
## 841               CO    1124    1306      182   3.03333333
## 842               CO    1743    2005      262   4.36666667
## 843               CO    1544    2012      468   7.80000000
## 844               CO    1047    1349      302   5.03333333
## 845               CO    1437    1547      110   1.83333333
## 846               CO     723    1012      289   4.81666667
## 847               CO    1933    2151      218   3.63333333
## 848               CO    1132    1234      102   1.70000000
## 849               CO    1856    2314      458   7.63333333
## 850               CO    1302    1421      119   1.98333333
## 851               CO     911    1030      119   1.98333333
## 852               CO    1144    1235       91   1.51666667
## 853               CO    1309    1650      341   5.68333333
## 854               CO    1422    1644      222   3.70000000
## 855               CO    2141    2347      206   3.43333333
## 856               CO    1922    2209      287   4.78333333
## 857               CO    1656    1805      149   2.48333333
## 858               CO    1500    1730      230   3.83333333
## 859               CO    2101    2312      211   3.51666667
## 860               CO     734     945      211   3.51666667
## 861               CO    1335    1637      302   5.03333333
## 862               CO    1029    1407      378   6.30000000
## 863               CO    1548    1724      176   2.93333333
## 864               CO     841    1017      176   2.93333333
## 865               CO    1316    1728      412   6.86666667
## 866               CO    1148    1433      285   4.75000000
## 867               CO    1800    2223      423   7.05000000
## 868               CO     726    1044      318   5.30000000
## 869               CO    1605    1819      214   3.56666667
## 870               CO    1446    1540       94   1.56666667
## 871               CO    1601    1908      307   5.11666667
## 872               CO    1257    1643      386   6.43333333
## 873               CO    2102    2239      137   2.28333333
## 874               CO     724     827      103   1.71666667
## 875               CO    1905    1957       52   0.86666667
## 876               CO     917    1131      214   3.56666667
## 877               CO    1900    2236      336   5.60000000
## 878               CO    2101    2205      104   1.73333333
## 879               CO    1226    1542      316   5.26666667
## 880               CO    1039    1351      312   5.20000000
## 881               CO    1052    1355      303   5.05000000
## 882               CO    1043    1448      405   6.75000000
## 883               CO    2110    2217      107   1.78333333
## 884               CO     928    1102      174   2.90000000
## 885               CO    1903    2155      252   4.20000000
## 886               CO    1434    1730      296   4.93333333
## 887               CO    1007    1338      331   5.51666667
## 888               CO    1731    1946      215   3.58333333
## 889               CO    1321    1630      309   5.15000000
## 890               CO    1321    1634      313   5.21666667
## 891               CO    1856    2048      192   3.20000000
## 892               CO     855     946       91   1.51666667
## 893               CO    1913    2213      300   5.00000000
## 894               CO    1440    1605      165   2.75000000
## 895               CO     734    1041      307   5.11666667
## 896               CO    1802    1902      100   1.66666667
## 897               CO    1243    1415      172   2.86666667
## 898               CO    1220    1353      133   2.21666667
## 899               CO    1420    1546      126   2.10000000
## 900               CO     844     949      105   1.75000000
## 901               CO    2046    2240      194   3.23333333
## 902               CO    1032    1258      226   3.76666667
## 903               CO    2104    2202       98   1.63333333
## 904               CO    1602    1908      306   5.10000000
## 905               CO    1911    2215      304   5.06666667
## 906               CO    1749    1902      153   2.55000000
## 907               CO     919    1021      102   1.70000000
## 908               CO    1801    1929      128   2.13333333
## 909               CO    1034    1354      320   5.33333333
## 910               CO    1332    1510      178   2.96666667
## 911               CO    1736    1848      112   1.86666667
## 912               CO    1854    2005      151   2.51666667
## 913               CO     915    1117      202   3.36666667
## 914               CO    1732    1837      105   1.75000000
## 915               CO    2056    2219      163   2.71666667
## 916               CO    1554    1654      100   1.66666667
## 917               CO    1230    1352      122   2.03333333
## 918               CO     929    1054      125   2.08333333
## 919               CO     732    1008      276   4.60000000
## 920               CO    1918    2224      306   5.10000000
## 921               CO    1002    1220      218   3.63333333
## 922               CO    1914    2310      396   6.60000000
## 923               CO    1800    1903      103   1.71666667
## 924               CO     857    1033      176   2.93333333
## 925               CO    1555    1707      152   2.53333333
## 926               CO    1317    1627      310   5.16666667
## 927               CO    1753    1932      179   2.98333333
## 928               CO    1452    1622      170   2.83333333
## 929               CO    1023    1141      118   1.96666667
## 930               CO    1920    2223      303   5.05000000
## 931               CO    1226    1634      408   6.80000000
## 932               CO    1258    1618      360   6.00000000
## 933               CO    1743    1956      213   3.55000000
## 934               CO     932    1228      296   4.93333333
## 935               CO    1131    1308      177   2.95000000
## 936               CO    1740    1939      199   3.31666667
## 937               CO    1516    1916      400   6.66666667
## 938               CO    1831    1934      103   1.71666667
## 939               CO    1555    1652       97   1.61666667
## 940               CO    1522    1627      105   1.75000000
## 941               CO    1544    1641       97   1.61666667
## 942               CO    1919    2117      198   3.30000000
## 943               CO     750     920      170   2.83333333
## 944               CO    1753    1915      162   2.70000000
## 945               CO    1207    1643      436   7.26666667
## 946               CO    1614    2034      420   7.00000000
## 947               CO     600    1028      428   7.13333333
## 948               CO    1049    1521      472   7.86666667
## 949               CO    1454    1615      161   2.68333333
## 950               CO    1304    1544      240   4.00000000
## 951               CO    2058    2224      166   2.76666667
## 952               CO      NA      NA       NA           NA
## 953               CO     852    1105      253   4.21666667
## 954               CO    1922    2243      321   5.35000000
## 955               CO    1153    1259      106   1.76666667
## 956               CO     724     851      127   2.11666667
## 957               CO    1317    1608      291   4.85000000
## 958               CO    2117    2344      227   3.78333333
## 959               CO    1557    2056      499   8.31666667
## 960               CO    1019    1622      603  10.05000000
## 961               CO     937    1119      182   3.03333333
## 962               CO    1016    1421      405   6.75000000
## 963               CO     916    1342      426   7.10000000
## 964               CO    1258    1351       93   1.55000000
## 965               CO    1544    1944      400   6.66666667
## 966               CO    1856    2232      376   6.26666667
## 967               CO     728    1122      394   6.56666667
## 968               CO    1307    1534      227   3.78333333
## 969               CO    1130    1340      210   3.50000000
## 970               CO    1553    1716      163   2.71666667
## 971               CO    1145    1243       98   1.63333333
## 972               CO     729    1215      486   8.10000000
## 973               CO    1031    1139      108   1.80000000
## 974               CO    2053    2208      155   2.58333333
## 975               CO     850    1128      278   4.63333333
## 976               CO    1912    2341      429   7.15000000
## 977               CO    1453    1636      183   3.05000000
## 978               CO    1312    1417      105   1.75000000
## 979               CO    1256    1649      393   6.55000000
## 980               CO     741    1205      464   7.73333333
## 981               CO    1033    1429      396   6.60000000
## 982               CO    1429    1640      211   3.51666667
## 983               CO    1333    1422       89   1.48333333
## 984               CO    1046    1530      484   8.06666667
## 985               CO    1807    1922      115   1.91666667
## 986               CO    1317    1636      319   5.31666667
## 987               CO    1033    1148      115   1.91666667
## 988               CO     727    1122      395   6.58333333
## 989               CO    1159    1602      443   7.38333333
## 990               CO     750    1221      471   7.85000000
## 991               CO    1704    2101      397   6.61666667
## 992               CO    1746    1949      203   3.38333333
## 993               CO    1922    2044      122   2.03333333
## 994               CO    2022      10    -2012 -33.53333333
## 995               CO    1046    1518      472   7.86666667
## 996               CO    1852    2016      164   2.73333333
## 997               CO    1919    2151      232   3.86666667
## 998               CO     601     841      240   4.00000000
## 999               CO    1255    1645      390   6.50000000
## 1000              CO    2115    2349      234   3.90000000
## 1001              CO    1910    2004       94   1.56666667
## 1002              CO    1304    1808      504   8.40000000
## 1003              CO     906    1017      111   1.85000000
## 1004              CO    1152    1316      164   2.73333333
## 1005              CO    2034    2351      317   5.28333333
## 1006              CO     903    1337      434   7.23333333
## 1007              CO    2049    2206      157   2.61666667
## 1008              CO    1743    1929      186   3.10000000
## 1009              CO    1321    1744      423   7.05000000
## 1010              CO    1300    1702      402   6.70000000
## 1011              CO     944    1132      188   3.13333333
## 1012              CO     648    1037      389   6.48333333
## 1013              CO    1143    1412      269   4.48333333
## 1014              CO      NA      NA       NA           NA
## 1015              CO    1742    2022      280   4.66666667
## 1016              CO    1857    2351      494   8.23333333
## 1017              CO     800    1054      254   4.23333333
## 1018              CO    2101    2219      118   1.96666667
## 1019              CO    1456    1611      155   2.58333333
## 1020              CO    1309    1435      126   2.10000000
## 1021              CO    1546    1844      298   4.96666667
## 1022              CO    1913    2157      244   4.06666667
## 1023              CO    1427    1530      103   1.71666667
## 1024              CO     714    1102      388   6.46666667
## 1025              CO    1543    2016      473   7.88333333
## 1026              CO    1856    2235      379   6.31666667
## 1027              CO    1907    2255      348   5.80000000
## 1028              CO    1123    1259      136   2.26666667
## 1029              CO    1736    2007      271   4.51666667
## 1030              CO    2100    2301      201   3.35000000
## 1031              CO    1553    2035      482   8.03333333
## 1032              CO    1037    1338      301   5.01666667
## 1033              CO    1437    1539      102   1.70000000
## 1034              CO     753    1043      290   4.83333333
## 1035              CO    1806    2036      230   3.83333333
## 1036              CO    1133    1241      108   1.80000000
## 1037              CO    1903    2337      434   7.23333333
## 1038              CO    1325    1427      102   1.70000000
## 1039              CO     905    1017      112   1.86666667
## 1040              CO    1217    1306       89   1.48333333
## 1041              CO    1308    1702      394   6.56666667
## 1042              CO    1502    1729      227   3.78333333
## 1043              CO    2132    2327      195   3.25000000
## 1044              CO    1948    2252      304   5.06666667
## 1045              CO     919    1038      119   1.98333333
## 1046              CO    1659    1802      143   2.38333333
## 1047              CO    1451    1732      281   4.68333333
## 1048              CO    2154      31    -2123 -35.38333333
## 1049              CO     734     943      209   3.48333333
## 1050              CO     725    1140      415   6.91666667
## 1051              CO    1332    1635      303   5.05000000
## 1052              CO    1010    1433      423   7.05000000
## 1053              CO    1709    1833      124   2.06666667
## 1054              CO     846    1008      162   2.70000000
## 1055              CO    1315    1820      505   8.41666667
## 1056              CO    2055    2243      188   3.13333333
## 1057              CO    1050    1355      305   5.08333333
## 1058              CO    1755    2245      490   8.16666667
## 1059              CO    2054    2322      268   4.46666667
## 1060              CO     722    1032      310   5.16666667
## 1061              CO     947    1323      376   6.26666667
## 1062              CO    1604    1830      226   3.76666667
## 1063              CO    1442    1548      106   1.76666667
## 1064              CO    1557    1905      348   5.80000000
## 1065              CO    1304    1659      355   5.91666667
## 1066              CO    2058    2258      200   3.33333333
## 1067              CO     731     825       94   1.56666667
## 1068              CO    1901    2037      136   2.26666667
## 1069              CO    1902    1949       47   0.78333333
## 1070              CO     920    1121      201   3.35000000
## 1071              CO    1859    2302      443   7.38333333
## 1072              CO    2101    2159       58   0.96666667
## 1073              CO    1227    1548      321   5.35000000
## 1074              CO    1039    1401      362   6.03333333
## 1075              CO    2109    2229      120   2.00000000
## 1076              CO    1049    1401      352   5.86666667
## 1077              CO    1059    1522      463   7.71666667
## 1078              CO    2105    2210      105   1.75000000
## 1079              CO    1928    2326      398   6.63333333
## 1080              CO     934    1055      121   2.01666667
## 1081              CO    1601    1705      104   1.73333333
## 1082              CO    1918    2211      293   4.88333333
## 1083              CO    1826    1950      124   2.06666667
## 1084              CO    2140    2224       84   1.40000000
## 1085              CO    1428    1522       94   1.56666667
## 1086              CO    1023    1417      394   6.56666667
## 1087              CO    1735    2016      281   4.68333333
## 1088              CO    1400    1710      310   5.16666667
## 1089              CO    1758    2155      397   6.61666667
## 1090              CO    1322    1626      304   5.06666667
## 1091              CO    1853    2050      197   3.28333333
## 1092              CO     902     953       51   0.85000000
## 1093              CO    1911    2219      308   5.13333333
## 1094              CO    1511    1629      118   1.96666667
## 1095              CO     726    1042      316   5.26666667
## 1096              CO    1802    1852       50   0.83333333
## 1097              CO    1201    1326      125   2.08333333
## 1098              CO    1135    1323      188   3.13333333
## 1099              CO    1421    1535      114   1.90000000
## 1100              CO     843     953      110   1.83333333
## 1101              CO    1218    1337      119   1.98333333
## 1102              CO    1733    2222      489   8.15000000
## 1103              CO     843     958      115   1.91666667
## 1104              CO    2057    2300      243   4.05000000
## 1105              CO    1027    1300      273   4.55000000
## 1106              CO    1620    1936      316   5.26666667
## 1107              CO    1925    2239      314   5.23333333
## 1108              CO    1748    1901      153   2.55000000
## 1109              CO    1637    2051      414   6.90000000
## 1110              CO     927    1027      100   1.66666667
## 1111              CO    1600    1955      355   5.91666667
## 1112              CO    1805    1921      116   1.93333333
## 1113              CO    1039    1355      316   5.26666667
## 1114              CO    1504    1622      118   1.96666667
## 1115              CO    1735    1848      113   1.88333333
## 1116              CO    1916    2051      135   2.25000000
## 1117              CO     914    1113      199   3.31666667
## 1118              CO    1733    1848      115   1.91666667
## 1119              CO    2129    2239      110   1.83333333
## 1120              CO     955    1106      151   2.51666667
## 1121              CO     721     958      237   3.95000000
## 1122              CO    1925    2252      327   5.45000000
## 1123              CO    1250    1553      303   5.05000000
## 1124              CO     931    1210      279   4.65000000
## 1125              CO    1933    2353      420   7.00000000
## 1126              CO    1738    1834       96   1.60000000
## 1127              CO     858    1034      176   2.93333333
## 1128              CO    1552    1708      156   2.60000000
## 1129              CO    1346    1659      313   5.21666667
## 1130              CO    1752    1930      178   2.96666667
## 1131              CO    1439    1610      171   2.85000000
## 1132              CO    1027    1130      103   1.71666667
## 1133              CO    1925    2248      323   5.38333333
## 1134              CO    1140    1602      462   7.70000000
## 1135              CO    1229    1706      477   7.95000000
## 1136              CO    1440    1831      391   6.51666667
## 1137              CO    1251    1631      380   6.33333333
## 1138              CO    1736    1942      206   3.43333333
## 1139              CO     905    1214      309   5.15000000
## 1140              CO    1126    1308      182   3.03333333
## 1141              CO    1738    1932      194   3.23333333
## 1142              CO     950    1344      394   6.56666667
## 1143              CO    1854    1957      103   1.71666667
## 1144              CO    1740    1833       93   1.55000000
## 1145              CO    1522    1633      111   1.85000000
## 1146              CO    1547    1634       87   1.45000000
## 1147              CO    1918    2054      136   2.26666667
## 1148              CO     746     915      169   2.81666667
## 1149              CO    2017    2135      118   1.96666667
## 1150              CO    1231    1635      404   6.73333333
## 1151              CO    1458    1921      463   7.71666667
## 1152              CO      NA      NA       NA           NA
## 1153              CO    1107    1650      543   9.05000000
## 1154              CO     729     845      116   1.93333333
## 1155              CO    1822    1945      123   2.05000000
## 1156              CO    1305    1547      242   4.03333333
## 1157              CO    2137    2254      117   1.95000000
## 1158              CO    1443    1822      379   6.31666667
## 1159              CO     857    1053      196   3.26666667
## 1160              CO    1927    2236      309   5.15000000
## 1161              CO    1156    1318      162   2.70000000
## 1162              CO     723     849      126   2.10000000
## 1163              CO    1328    1620      292   4.86666667
## 1164              CO      11     216      205   3.41666667
## 1165              CO    1633    2048      415   6.91666667
## 1166              CO    1025    1625      600  10.00000000
## 1167              CO     910    1122      212   3.53333333
## 1168              CO    1017    1408      391   6.51666667
## 1169              CO     919    1338      419   6.98333333
## 1170              CO    1303    1358       55   0.91666667
## 1171              CO    1537    1948      411   6.85000000
## 1172              CO    2237     153    -2084 -34.73333333
## 1173              CO      NA      NA       NA           NA
## 1174              CO    1336    1604      268   4.46666667
## 1175              CO    1138    1335      197   3.28333333
## 1176              CO    1553    1728      175   2.91666667
## 1177              CO    1145    1242       97   1.61666667
## 1178              CO     737    1214      477   7.95000000
## 1179              CO    1034    1206      172   2.86666667
## 1180              CO    2140    2308      168   2.80000000
## 1181              CO     852    1111      259   4.31666667
## 1182              CO    1954      20    -1934 -32.23333333
## 1183              CO    1430    1619      189   3.15000000
## 1184              CO    1423    1524      101   1.68333333
## 1185              CO    1251    1639      388   6.46666667
## 1186              CO     746    1158      412   6.86666667
## 1187              CO    1128    1254      126   2.10000000
## 1188              CO    1032    1417      385   6.41666667
## 1189              CO    1500    1645      145   2.41666667
## 1190              CO    1317    1420      103   1.71666667
## 1191              CO    1044    1507      463   7.71666667
## 1192              CO    1809    1919      110   1.83333333
## 1193              CO    1310    1628      318   5.30000000
## 1194              CO    1040    1152      112   1.86666667
## 1195              CO     727    1156      429   7.15000000
## 1196              CO    1245    1627      382   6.36666667
## 1197              CO      NA      NA       NA           NA
## 1198              CO    1703    2040      337   5.61666667
## 1199              CO    1802    1946      144   2.40000000
## 1200              CO    1923    2023      100   1.66666667
## 1201              CO    1920    2305      385   6.41666667
## 1202              CO    1048    1449      401   6.68333333
## 1203              CO    1848    2024      176   2.93333333
## 1204              CO    1938    2210      272   4.53333333
## 1205              CO     610     842      232   3.86666667
## 1206              CO    1255    1632      377   6.28333333
## 1207              CO    2116    2357      241   4.01666667
## 1208              CO    1907    2008      101   1.68333333
## 1209              CO    1313    1751      438   7.30000000
## 1210              CO     907    1027      120   2.00000000
## 1211              CO    1150    1321      171   2.85000000
## 1212              CO    1921    2251      330   5.50000000
## 1213              CO    1102    1621      519   8.65000000
## 1214              CO    2059    2207      148   2.46666667
## 1215              CO    1945    2135      190   3.16666667
## 1216              CO    1419    1842      423   7.05000000
## 1217              CO    1450    1827      377   6.28333333
## 1218              CO     928    1139      211   3.51666667
## 1219              CO     642    1022      380   6.33333333
## 1220              CO    1146    1423      277   4.61666667
## 1221              CO    1614    1958      344   5.73333333
## 1222              CO    1849    2036      187   3.11666667
## 1223              CO    1856    2325      469   7.81666667
## 1224              CO     741    1045      304   5.06666667
## 1225              CO    2109    2205       96   1.60000000
## 1226              CO    1437    1600      163   2.71666667
## 1227              CO    1308    1438      130   2.16666667
## 1228              CO    1617    1909      292   4.86666667
## 1229              CO    1919    2219      300   5.00000000
## 1230              CO    1430    1538      108   1.80000000
## 1231              CO     723    1109      386   6.43333333
## 1232              CO    1730    2203      473   7.88333333
## 1233              CO    1904    2253      349   5.81666667
## 1234              CO    1905    2240      335   5.58333333
## 1235              CO    1125    1312      187   3.11666667
## 1236              CO    1734    2010      276   4.60000000
## 1237              CO    2008    2153      145   2.41666667
## 1238              CO    1554    2026      472   7.86666667
## 1239              CO    1033    1343      310   5.16666667
## 1240              CO    1528    1637      109   1.81666667
## 1241              CO     747    1046      299   4.98333333
## 1242              CO    1806    2028      222   3.70000000
## 1243              CO    1133    1241      108   1.80000000
## 1244              CO    2039      39    -2000 -33.33333333
## 1245              CO    1240    1342      102   1.70000000
## 1246              CO     907    1023      116   1.93333333
## 1247              CO    1143    1237       94   1.56666667
## 1248              CO    1311    1658      347   5.78333333
## 1249              CO    1435    1713      278   4.63333333
## 1250              CO    2142    2343      201   3.35000000
## 1251              CO    1932    2233      301   5.01666667
## 1252              CO     914    1055      141   2.35000000
## 1253              CO    1650    1758      108   1.80000000
## 1254              CO    1437    1705      268   4.46666667
## 1255              CO    2056    2247      191   3.18333333
## 1256              CO     730     932      202   3.36666667
## 1257              CO     727    1118      391   6.51666667
## 1258              CO    1348    1648      300   5.00000000
## 1259              CO    1013    1401      388   6.46666667
## 1260              CO    1602    1725      123   2.05000000
## 1261              CO     844    1010      166   2.76666667
## 1262              CO    1527    2202      675  11.25000000
## 1263              CO    2104    2248      144   2.40000000
## 1264              CO    1121    1415      294   4.90000000
## 1265              CO    1902    2325      423   7.05000000
## 1266              CO    2057    2335      278   4.63333333
## 1267              CO     724    1039      315   5.25000000
## 1268              CO     904    1246      342   5.70000000
## 1269              CO    1602    1752      150   2.50000000
## 1270              CO    1505    1600       95   1.58333333
## 1271              CO    1612    1906      294   4.90000000
## 1272              CO    1305    1700      395   6.58333333
## 1273              CO    2134    2253      119   1.98333333
## 1274              CO     725     838      113   1.88333333
## 1275              CO    1921    2051      130   2.16666667
## 1276              CO    2133    2216       83   1.38333333
## 1277              CO     913    1119      206   3.43333333
## 1278              CO    1902    2249      347   5.78333333
## 1279              CO    2111    2213      102   1.70000000
## 1280              CO    1224    1532      308   5.13333333
## 1281              CO    1040    1359      319   5.31666667
## 1282              CO    2049    2207      158   2.63333333
## 1283              CO    1053    1356      303   5.05000000
## 1284              CO    1203    1607      404   6.73333333
## 1285              CO    2111    2208       97   1.61666667
## 1286              CO    1918    2314      396   6.60000000
## 1287              CO     932    1110      178   2.96666667
## 1288              CO    1604    1717      113   1.88333333
## 1289              CO    1757    2137      380   6.33333333
## 1290              CO    1908    2159      251   4.18333333
## 1291              CO    1813    1942      129   2.15000000
## 1292              CO    2102    2155       53   0.88333333
## 1293              CO    1429    1524       95   1.58333333
## 1294              CO    1012    1350      338   5.63333333
## 1295              CO    1734    2034      300   5.00000000
## 1296              CO    1316    1649      333   5.55000000
## 1297              CO    1324    1631      307   5.11666667
## 1298              CO    1849    2059      210   3.50000000
## 1299              CO     855     945       90   1.50000000
## 1300              CO    1915    2211      296   4.93333333
## 1301              CO    1445    1602      157   2.61666667
## 1302              CO     730    1045      315   5.25000000
## 1303              CO    1759    1853       94   1.56666667
## 1304              CO    1215    1346      131   2.18333333
## 1305              CO    1140    1336      196   3.26666667
## 1306              CO    1418    1534      116   1.93333333
## 1307              CO     846     947      101   1.68333333
## 1308              CO    1237    1400      163   2.71666667
## 1309              CO    2128     136    -1992 -33.20000000
## 1310              CO     847    1006      159   2.65000000
## 1311              CO    2050    2240      190   3.16666667
## 1312              CO    1057    1334      277   4.61666667
## 1313              CO    1609    1925      316   5.26666667
## 1314              CO    1910    2208      298   4.96666667
## 1315              CO    1749    1847       98   1.63333333
## 1316              CO    1603    2039      436   7.26666667
## 1317              CO     930    1035      105   1.75000000
## 1318              CO    1642    2038      396   6.60000000
## 1319              CO    1802    1924      122   2.03333333
## 1320              CO    1052    1409      357   5.95000000
## 1321              CO    1318    1451      133   2.21666667
## 1322              CO    1748    1904      156   2.60000000
## 1323              CO    1846    2012      166   2.76666667
## 1324              CO     911    1125      214   3.56666667
## 1325              CO    1741    1854      113   1.88333333
## 1326              CO    2206    2313      107   1.78333333
## 1327              CO     935    1104      169   2.81666667
## 1328              CO     733    1009      276   4.60000000
## 1329              CO    1913    2231      318   5.30000000
## 1330              CO    1256    1600      344   5.73333333
## 1331              CO     933    1216      283   4.71666667
## 1332              CO    1936    2336      400   6.66666667
## 1333              CO    1751    1848       97   1.61666667
## 1334              CO     856    1049      193   3.21666667
## 1335              CO    1607    1717      110   1.83333333
## 1336              CO    1322    1646      324   5.40000000
## 1337              CO    1759    1925      166   2.76666667
## 1338              CO    1543    1711      168   2.80000000
## 1339              CO    1024    1127      103   1.71666667
## 1340              CO    1930    2237      307   5.11666667
## 1341              CO    1152    1548      396   6.60000000
## 1342              CO    1302    1722      420   7.00000000
## 1343              CO    1446    1815      369   6.15000000
## 1344              CO    1257    1623      366   6.10000000
## 1345              CO    1739    1957      218   3.63333333
## 1346              CO     905    1207      302   5.03333333
## 1347              CO    1127    1323      196   3.26666667
## 1348              CO    1828    2015      187   3.11666667
## 1349              CO     944    1350      406   6.76666667
## 1350              CO    1837    1933       96   1.60000000
## 1351              CO    1554    1657      103   1.71666667
## 1352              CO    1526    1627      101   1.68333333
## 1353              CO    1533    1629       96   1.60000000
## 1354              CO    1908    2044      136   2.26666667
## 1355              CO     744     915      171   2.85000000
## 1356              CO    1737    1923      186   3.10000000
## 1357              CO      NA      NA       NA           NA
## 1358              CO    1531    1944      413   6.88333333
## 1359              CO     557    1032      475   7.91666667
## 1360              CO    1325    1816      491   8.18333333
## 1361              CO     732     844      112   1.86666667
## 1362              CO    1430    1608      178   2.96666667
## 1363              CO    1313    1557      244   4.06666667
## 1364              CO    1739    1922      183   3.05000000
## 1365              CO      NA      NA       NA           NA
## 1366              CO     851    1055      204   3.40000000
## 1367              CO    1918    2227      309   5.15000000
## 1368              CO     736     911      175   2.91666667
## 1369              CO    1300    1601      301   5.01666667
## 1370              CO    2122    2346      224   3.73333333
## 1371              CO      NA      NA       NA           NA
## 1372              CO    1012    1632      620  10.33333333
## 1373              CO     907    1109      202   3.36666667
## 1374              CO     946    1406      460   7.66666667
## 1375              CO    1303    1353       50   0.83333333
## 1376              CO    1540    1921      381   6.35000000
## 1377              CO    1848    2221      373   6.21666667
## 1378              CO     740    1122      382   6.36666667
## 1379              CO    1558    1722      164   2.73333333
## 1380              CO     748    1225      477   7.95000000
## 1381              CO    2047    2216      169   2.81666667
## 1382              CO     846    1119      273   4.55000000
## 1383              CO    1926      NA       NA           NA
## 1384              CO    1451    1643      192   3.20000000
## 1385              CO    1313    1416      103   1.71666667
## 1386              CO    1251    1647      396   6.60000000
## 1387              CO     753    1234      481   8.01666667
## 1388              CO    1031    1412      381   6.35000000
## 1389              CO    1427    1630      203   3.38333333
## 1390              CO    1321    1422      101   1.68333333
## 1391              CO    1824    1945      121   2.01666667
## 1392              CO    1315    1625      310   5.16666667
## 1393              CO     727    1117      390   6.50000000
## 1394              CO    1158    1612      454   7.56666667
## 1395              CO     744    1225      481   8.01666667
## 1396              CO    1703      NA       NA           NA
## 1397              CO    1743    1940      197   3.28333333
## 1398              CO    1922    2031      109   1.81666667
## 1399              CO      NA      NA       NA           NA
## 1400              CO    1130    1550      420   7.00000000
## 1401              CO    1846    2004      158   2.63333333
## 1402              CO    1911    2152      241   4.01666667
## 1403              CO     600     834      234   3.90000000
## 1404              CO    1253    1656      403   6.71666667
## 1405              CO    2114    2345      231   3.85000000
## 1406              CO    1914    2016      102   1.70000000
## 1407              CO    1306    1755      449   7.48333333
## 1408              CO     906    1032      126   2.10000000
## 1409              CO    1913    2235      322   5.36666667
## 1410              CO    1146    1633      487   8.11666667
## 1411              CO    2054    2205      151   2.51666667
## 1412              CO    1736    1925      189   3.15000000
## 1413              CO    1443    1909      466   7.76666667
## 1414              CO    1302    1644      342   5.70000000
## 1415              CO     933    1139      206   3.43333333
## 1416              CO     740    1125      385   6.41666667
## 1417              CO    1141    1412      271   4.51666667
## 1418              CO      NA      NA       NA           NA
## 1419              CO     910    1051      141   2.35000000
## 1420              CO    1754    1957      203   3.38333333
## 1421              CO    1847    2319      472   7.86666667
## 1422              CO     744    1137      393   6.55000000
## 1423              CO    2102    2226      124   2.06666667
## 1424              CO    1437    1609      172   2.86666667
## 1425              CO    1307    1431      124   2.06666667
## 1426              CO    1540    1834      294   4.90000000
## 1427              CO    1916    2212      296   4.93333333
## 1428              CO    1429    1541      112   1.86666667
## 1429              CO     717    1114      397   6.61666667
## 1430              CO      NA      NA       NA           NA
## 1431              CO    1850    2234      384   6.40000000
## 1432              CO      NA      NA       NA           NA
## 1433              CO    1004    1145      141   2.35000000
## 1434              CO    1725    2008      283   4.71666667
## 1435              CO    1857    2108      251   4.18333333
## 1436              CO    1547    2031      484   8.06666667
## 1437              CO    1441    1609      168   2.80000000
## 1438              CO     745    1048      303   5.05000000
## 1439              CO    1802    2035      233   3.88333333
## 1440              CO      NA      NA       NA           NA
## 1441              CO     906    1030      124   2.06666667
## 1442              CO    1308    1647      339   5.65000000
## 1443              CO    1427    1711      284   4.73333333
## 1444              CO    2151    2345      194   3.23333333
## 1445              CO    1923    2221      298   4.96666667
## 1446              CO    1652    1759      107   1.78333333
## 1447              CO    1444    1724      280   4.66666667
## 1448              CO    2049    2257      208   3.46666667
## 1449              CO     733     940      207   3.45000000
## 1450              CO     949    1436      487   8.11666667
## 1451              CO    1336    1638      302   5.03333333
## 1452              CO    1550    1732      182   3.03333333
## 1453              CO     849    1021      172   2.86666667
## 1454              CO    1341    1820      479   7.98333333
## 1455              CO    2111    2305      194   3.23333333
## 1456              CO      NA      NA       NA           NA
## 1457              CO    2115    2330      215   3.58333333
## 1458              CO     723    1036      313   5.21666667
## 1459              CO      NA      NA       NA           NA
## 1460              CO    1607    1816      209   3.48333333
## 1461              CO    1450    1548       98   1.63333333
## 1462              CO    1606    1917      311   5.18333333
## 1463              CO    1304    1647      343   5.71666667
## 1464              CO    2049    2210      161   2.68333333
## 1465              CO     728     850      122   2.03333333
## 1466              CO    1859    2041      182   3.03333333
## 1467              CO    1910    2012      102   1.70000000
## 1468              CO     913    1106      193   3.21666667
## 1469              CO    1900    2247      347   5.78333333
## 1470              CO    2103    2205      102   1.70000000
## 1471              CO    1226    1543      317   5.28333333
## 1472              CO    2055    2237      182   3.03333333
## 1473              CO    2238    2332       94   1.56666667
## 1474              CO    1912    2256      344   5.73333333
## 1475              CO     925    1106      181   3.01666667
## 1476              CO    1601    1729      128   2.13333333
## 1477              CO    1903    2156      253   4.21666667
## 1478              CO    1807    1940      133   2.21666667
## 1479              CO    2100    2156       56   0.93333333
## 1480              CO    1431    1524       93   1.55000000
## 1481              CO    1005    1339      334   5.56666667
## 1482              CO    1727    2002      275   4.58333333
## 1483              CO    1431    1746      315   5.25000000
## 1484              CO    1757    1854       97   1.61666667
## 1485              CO    1328    1636      308   5.13333333
## 1486              CO    1850    2051      201   3.35000000
## 1487              CO     857     944       87   1.45000000
## 1488              CO    1855    2155      300   5.00000000
## 1489              CO    1440    1611      171   2.85000000
## 1490              CO     733    1050      317   5.28333333
## 1491              CO      NA      NA       NA           NA
## 1492              CO    1416    1537      121   2.01666667
## 1493              CO     843     946      103   1.71666667
## 1494              CO    1221    1342      121   2.01666667
## 1495              CO      NA      NA       NA           NA
## 1496              CO    2048    2257      209   3.48333333
## 1497              CO    1023    1247      224   3.73333333
## 1498              CO    1603    1923      320   5.33333333
## 1499              CO    1930    2229      299   4.98333333
## 1500              CO    1754    1905      151   2.51666667
## 1501              CO    1546    1956      410   6.83333333
## 1502              CO     922    1015       93   1.55000000
## 1503              CO    1554    1948      394   6.56666667
## 1504              CO    1757    1921      164   2.73333333
## 1505              CO    1319    1459      140   2.33333333
## 1506              CO    1747    1905      158   2.63333333
## 1507              CO    1847    2013      166   2.76666667
## 1508              CO     912    1105      193   3.21666667
## 1509              CO    1732    1853      121   2.01666667
## 1510              CO    2101    2225      124   2.06666667
## 1511              CO     932    1059      127   2.11666667
## 1512              CO     726    1001      275   4.58333333
## 1513              CO    1917    2241      324   5.40000000
## 1514              CO    1248    1559      311   5.18333333
## 1515              CO     937    1209      272   4.53333333
## 1516              CO      NA      NA       NA           NA
## 1517              CO    1736    1835       99   1.65000000
## 1518              CO    1550    1704      154   2.56666667
## 1519              CO    1330    1648      318   5.30000000
## 1520              CO    1751    1928      177   2.95000000
## 1521              CO    1440    1620      180   3.00000000
## 1522              CO    1933    2246      313   5.21666667
## 1523              CO      NA      NA       NA           NA
## 1524              CO    1502    1906      404   6.73333333
## 1525              CO    1436    1802      366   6.10000000
## 1526              CO    1249    1624      375   6.25000000
## 1527              CO    1734    1939      205   3.41666667
## 1528              CO     917    1225      308   5.13333333
## 1529              CO    1006    1206      200   3.33333333
## 1530              CO    1740    1936      196   3.26666667
## 1531              CO     924    1337      413   6.88333333
## 1532              CO    1823    1930      107   1.78333333
## 1533              CO    1553    1704      151   2.51666667
## 1534              CO    1519    1632      113   1.88333333
## 1535              CO    1706    1802       96   1.60000000
## 1536              CO     745     940      195   3.25000000
## 1537              CO    1930    2058      128   2.13333333
## 1538              CO    1205    1612      407   6.78333333
## 1539              CO    1429    1833      404   6.73333333
## 1540              CO     600    1010      410   6.83333333
## 1541              CO    1045    1455      410   6.83333333
## 1542              CO     730     834      104   1.73333333
## 1543              CO    1431    1616      185   3.08333333
## 1544              CO    1307    1547      240   4.00000000
## 1545              CO    1743    1913      170   2.83333333
## 1546              CO    1438    1815      377   6.28333333
## 1547              CO     851    1056      205   3.41666667
## 1548              CO    1918    2234      316   5.26666667
## 1549              CO     724     844      120   2.00000000
## 1550              CO    1256    1606      350   5.83333333
## 1551              CO    2122    2356      234   3.90000000
## 1552              CO    1552    2010      458   7.63333333
## 1553              CO    1011    1642      631  10.51666667
## 1554              CO     905    1052      147   2.45000000
## 1555              CO     916    1322      406   6.76666667
## 1556              CO    1259    1401      142   2.36666667
## 1557              CO    1537    1918      381   6.35000000
## 1558              CO    1847    2212      365   6.08333333
## 1559              CO     816    1138      322   5.36666667
## 1560              CO    1551    1722      171   2.85000000
## 1561              CO     732    1224      492   8.20000000
## 1562              CO    2050    2212      162   2.70000000
## 1563              CO     938    1157      219   3.65000000
## 1564              CO    1909    2318      409   6.81666667
## 1565              CO    1454    1643      189   3.15000000
## 1566              CO    1315    1434      119   1.98333333
## 1567              CO    1250    1626      376   6.26666667
## 1568              CO     742    1212      470   7.83333333
## 1569              CO    1130    1259      129   2.15000000
## 1570              CO    1426    1650      224   3.73333333
## 1571              CO    1315    1422      107   1.78333333
## 1572              CO    1755    1918      163   2.71666667
## 1573              CO    1307    1612      305   5.08333333
## 1574              CO     734    1117      383   6.38333333
## 1575              CO    1159    1536      377   6.28333333
## 1576              CO     754    1216      462   7.70000000
## 1577              CO    1703    2042      339   5.65000000
## 1578              CO    1808    2015      207   3.45000000
## 1579              CO    1922    2031      109   1.81666667
## 1580              CO    1909    2253      344   5.73333333
## 1581              CO    1848    2022      174   2.90000000
## 1582              CO    1922    2148      226   3.76666667
## 1583              CO     603     829      226   3.76666667
## 1584              CO    1247    1619      372   6.20000000
## 1585              CO    2115    2350      235   3.91666667
## 1586              CO    1912    2012      100   1.66666667
## 1587              CO    1304    1737      433   7.21666667
## 1588              CO     902    1026      124   2.06666667
## 1589              CO    1920    2231      311   5.18333333
## 1590              CO     854    1324      470   7.83333333
## 1591              CO    2052    2200      148   2.46666667
## 1592              CO    1737    1925      188   3.13333333
## 1593              CO    1318    1735      417   6.95000000
## 1594              CO    1256    1635      379   6.31666667
## 1595              CO     931    1141      210   3.50000000
## 1596              CO     741    1129      388   6.46666667
## 1597              CO    1146    1418      272   4.53333333
## 1598              CO    1613    1945      332   5.53333333
## 1599              CO    1805    2018      213   3.55000000
## 1600              CO    1900    2318      418   6.96666667
## 1601              CO     744    1055      311   5.18333333
## 1602              CO    2059    2230      171   2.85000000
## 1603              CO    1441    1614      173   2.88333333
## 1604              CO    1305    1437      132   2.20000000
## 1605              CO    1536    1903      367   6.11666667
## 1606              CO    2002    2244      242   4.03333333
## 1607              CO    1430    1542      112   1.86666667
## 1608              CO     713    1100      387   6.45000000
## 1609              CO    1542    2004      462   7.70000000
## 1610              CO    1856    2220      364   6.06666667
## 1611              CO    1857    2234      377   6.28333333
## 1612              CO    1001    1151      150   2.50000000
## 1613              CO    1728    2003      275   4.58333333
## 1614              CO    1712    2129      417   6.95000000
## 1615              CO    1440    1602      162   2.70000000
## 1616              CO     748    1049      301   5.01666667
## 1617              CO    1855    2115      260   4.33333333
## 1618              CO    1853    2249      396   6.60000000
## 1619              CO     909    1027      118   1.96666667
## 1620              CO    1302    1634      332   5.53333333
## 1621              CO    1419    1716      297   4.95000000
## 1622              CO    2131    2338      207   3.45000000
## 1623              CO    1926    2235      309   5.15000000
## 1624              CO     912    1033      121   2.01666667
## 1625              CO    1655    1811      156   2.60000000
## 1626              CO    1455    1721      266   4.43333333
## 1627              CO    2056    2302      246   4.10000000
## 1628              CO     727     941      214   3.56666667
## 1629              CO     722    1120      398   6.63333333
## 1630              CO    1337    1714      377   6.28333333
## 1631              CO    1543    1725      182   3.03333333
## 1632              CO     843     955      112   1.86666667
## 1633              CO    1317    1739      422   7.03333333
## 1634              CO    2056    2241      185   3.08333333
## 1635              CO    1754    2202      448   7.46666667
## 1636              CO    2055    2315      260   4.33333333
## 1637              CO     724    1036      312   5.20000000
## 1638              CO     848    1218      370   6.16666667
## 1639              CO    1558    1814      256   4.26666667
## 1640              CO    1447    1549      102   1.70000000
## 1641              CO    1604    1933      329   5.48333333
## 1642              CO    1305    1654      349   5.81666667
## 1643              CO    2104    2239      135   2.25000000
## 1644              CO     726     851      125   2.08333333
## 1645              CO    1914    2051      137   2.28333333
## 1646              CO    1906    1957       51   0.85000000
## 1647              CO     911    1109      198   3.30000000
## 1648              CO    1857    2233      376   6.26666667
## 1649              CO    2102    2218      116   1.93333333
## 1650              CO    1231    1550      319   5.31666667
## 1651              CO    2048    2204      156   2.60000000
## 1652              CO    2103    2202       99   1.65000000
## 1653              CO    2112      43    -2069 -34.48333333
## 1654              CO     922    1103      181   3.01666667
## 1655              CO    1901    2207      306   5.10000000
## 1656              CO    1802    1936      134   2.23333333
## 1657              CO    2101    2158       57   0.95000000
## 1658              CO    1427    1530      103   1.71666667
## 1659              CO    1010    1337      327   5.45000000
## 1660              CO    1740    2030      290   4.83333333
## 1661              CO    1317    1656      339   5.65000000
## 1662              CO    1909    2053      144   2.40000000
## 1663              CO    1753    2135      382   6.36666667
## 1664              CO    1320    1644      324   5.40000000
## 1665              CO    1846    2055      209   3.48333333
## 1666              CO     925    1019       94   1.56666667
## 1667              CO    1930    2238      308   5.13333333
## 1668              CO    1444    1611      167   2.78333333
## 1669              CO     728    1046      318   5.30000000
## 1670              CO    1752    1846       94   1.56666667
## 1671              CO    1419    1537      118   1.96666667
## 1672              CO     843     945      102   1.70000000
## 1673              CO    1334    1507      173   2.88333333
## 1674              CO    1747    2148      401   6.68333333
## 1675              CO    2053    2247      194   3.23333333
## 1676              CO    1023    1239      216   3.60000000
## 1677              CO    1601    1924      323   5.38333333
## 1678              CO    1909    2212      303   5.05000000
## 1679              CO    1748    1908      160   2.66666667
## 1680              CO    1546    1952      406   6.76666667
## 1681              CO     924    1029      105   1.75000000
## 1682              CO    1553    1937      384   6.40000000
## 1683              CO    1804    1927      123   2.05000000
## 1684              CO    1315    1459      144   2.40000000
## 1685              CO    1730    1844      114   1.90000000
## 1686              CO    1846    2026      180   3.00000000
## 1687              CO     910    1109      199   3.31666667
## 1688              CO    1729    1858      129   2.15000000
## 1689              CO    2058    2218      160   2.66666667
## 1690              CO    1011    1139      128   2.13333333
## 1691              CO     723     952      229   3.81666667
## 1692              CO    1934    2257      323   5.38333333
## 1693              CO    1251    1608      357   5.95000000
## 1694              CO     933    1211      278   4.63333333
## 1695              CO    1917    2322      405   6.75000000
## 1696              CO    1742    1842      100   1.66666667
## 1697              CO    1553    1708      155   2.58333333
## 1698              CO    1340    1704      364   6.06666667
## 1699              CO    1823    1950      127   2.11666667
## 1700              CO    1453    1623      170   2.83333333
## 1701              CO    1923    2333      410   6.83333333
## 1702              CO    1139    1548      409   6.81666667
## 1703              CO    1230    1635      405   6.75000000
## 1704              CO    1432    1809      377   6.28333333
## 1705              CO    1252    1639      387   6.45000000
## 1706              CO    1732    1943      211   3.51666667
## 1707              CO     907    1228      321   5.35000000
## 1708              CO    1001    1147      146   2.43333333
## 1709              CO    1741    1950      209   3.48333333
## 1710              CO    1144    1605      461   7.68333333
## 1711              CO    1826    1946      120   2.00000000
## 1712              CO    1555    1654       99   1.65000000
## 1713              CO    1539    1650      111   1.85000000
## 1714              CO    1536    1628       92   1.53333333
## 1715              CO    1925    2107      182   3.03333333
## 1716              CO     744     919      175   2.91666667
## 1717              CO    1744    1917      173   2.88333333
## 1718              CO    1206    1616      410   6.83333333
## 1719              CO    1505    1915      410   6.83333333
## 1720              CO     559     959      400   6.66666667
## 1721              CO    1047    1503      456   7.60000000
## 1722              CO     725     824       99   1.65000000
## 1723              CO    1451    1628      177   2.95000000
## 1724              CO    1303    1605      302   5.03333333
## 1725              CO    1812    1947      135   2.25000000
## 1726              CO    1446    1827      381   6.35000000
## 1727              CO     854    1115      261   4.35000000
## 1728              CO    1920    2245      325   5.41666667
## 1729              CO    1157    1321      164   2.73333333
## 1730              CO     724     859      135   2.25000000
## 1731              CO    1309    1611      302   5.03333333
## 1732              CO    2122    2353      231   3.85000000
## 1733              CO    1548    2000      452   7.53333333
## 1734              CO    1023    1622      599   9.98333333
## 1735              CO     911    1115      204   3.40000000
## 1736              CO    1015    1355      340   5.66666667
## 1737              CO     919    1329      410   6.83333333
## 1738              CO    1322    1428      106   1.76666667
## 1739              CO    1542    1923      381   6.35000000
## 1740              CO    1931    2325      394   6.56666667
## 1741              CO     731    1125      394   6.56666667
## 1742              CO    1240    1517      277   4.61666667
## 1743              CO    1146    1349      203   3.38333333
## 1744              CO    1558    1743      185   3.08333333
## 1745              CO    1147    1259      112   1.86666667
## 1746              CO     735    1223      488   8.13333333
## 1747              CO    1036    1204      168   2.80000000
## 1748              CO    2109    2226      117   1.95000000
## 1749              CO     853    1123      270   4.50000000
## 1750              CO    1907    2315      408   6.80000000
## 1751              CO    1451    1642      191   3.18333333
## 1752              CO    1312    1433      121   2.01666667
## 1753              CO    1256    1631      375   6.25000000
## 1754              CO     742    1202      460   7.66666667
## 1755              CO    1042    1433      391   6.51666667
## 1756              CO    1439    1653      214   3.56666667
## 1757              CO    1317    1421      104   1.73333333
## 1758              CO    1053    1530      477   7.95000000
## 1759              CO    1833    1954      121   2.01666667
## 1760              CO    1421    1720      299   4.98333333
## 1761              CO    1029    1155      126   2.10000000
## 1762              CO     725    1115      390   6.50000000
## 1763              CO    1159    1541      382   6.36666667
## 1764              CO     750    1224      474   7.90000000
## 1765              CO    1702    2039      337   5.61666667
## 1766              CO    1748    2005      257   4.28333333
## 1767              CO    1924    2050      126   2.10000000
## 1768              CO    1940    2347      407   6.78333333
## 1769              CO    1050    1511      461   7.68333333
## 1770              CO    1854    2016      162   2.70000000
## 1771              CO    1930    2159      229   3.81666667
## 1772              CO     628     903      275   4.58333333
## 1773              CO    1257    1636      379   6.31666667
## 1774              CO    2121    2344      223   3.71666667
## 1775              CO    1919    2021      102   1.70000000
## 1776              CO    1309    1740      431   7.18333333
## 1777              CO     904    1024      120   2.00000000
## 1778              CO    1149    1313      164   2.73333333
## 1779              CO    1937    2322      385   6.41666667
## 1780              CO     855    1316      461   7.68333333
## 1781              CO    2057    2210      153   2.55000000
## 1782              CO    1748    1933      185   3.08333333
## 1783              CO    1318    1801      483   8.05000000
## 1784              CO    1304    1640      336   5.60000000
## 1785              CO     936    1151      215   3.58333333
## 1786              CO     641    1008      367   6.11666667
## 1787              CO    1152    1422      270   4.50000000
## 1788              CO    1615    2009      394   6.56666667
## 1789              CO     936    1128      192   3.20000000
## 1790              CO    1837    2103      266   4.43333333
## 1791              CO    1856    2320      464   7.73333333
## 1792              CO     822    1128      306   5.10000000
## 1793              CO    2128    2233      105   1.75000000
## 1794              CO    1429    1555      126   2.10000000
## 1795              CO    1307    1454      147   2.45000000
## 1796              CO    1556    1906      350   5.83333333
## 1797              CO    1930    2214      284   4.73333333
## 1798              CO    1430    1542      112   1.86666667
## 1799              CO     716    1103      387   6.45000000
## 1800              CO    1550    2020      470   7.83333333
## 1801              CO    1900    2226      326   5.43333333
## 1802              CO    1943    2345      402   6.70000000
## 1803              CO    1121    1305      184   3.06666667
## 1804              CO    1807    2051      244   4.06666667
## 1805              CO    1546    2042      496   8.26666667
## 1806              CO    1040    1404      364   6.06666667
## 1807              CO    1524    1636      112   1.86666667
## 1808              CO     746    1107      361   6.01666667
## 1809              CO    1911    2157      246   4.10000000
## 1810              CO    1137    1236       99   1.65000000
## 1811              CO    1927    2342      415   6.91666667
## 1812              CO    1247    1403      156   2.60000000
## 1813              CO     917    1051      134   2.23333333
## 1814              CO    1153    1253      100   1.66666667
## 1815              CO    1309    1703      394   6.56666667
## 1816              CO    1417    1650      233   3.88333333
## 1817              CO    2142    2340      198   3.30000000
## 1818              CO    1926    2230      304   5.06666667
## 1819              CO    1657    1805      148   2.46666667
## 1820              CO    1445    1714      269   4.48333333
## 1821              CO    2111    2310      199   3.31666667
## 1822              CO     727     950      223   3.71666667
## 1823              CO     728    1147      419   6.98333333
## 1824              CO    1333    1652      319   5.31666667
## 1825              CO    1013    1354      341   5.68333333
## 1826              CO    1602    1748      146   2.43333333
## 1827              CO     847    1008      161   2.68333333
## 1828              CO    1313    1759      446   7.43333333
## 1829              CO    2106    2250      144   2.40000000
## 1830              CO    1047    1357      310   5.16666667
## 1831              CO    1807    2224      417   6.95000000
## 1832              CO    2100    2305      205   3.41666667
## 1833              CO     720    1035      315   5.25000000
## 1834              CO     936    1316      380   6.33333333
## 1835              CO    1627    1856      229   3.81666667
## 1836              CO    1448    1546       98   1.63333333
## 1837              CO    1620    1941      321   5.35000000
## 1838              CO    1301    1657      356   5.93333333
## 1839              CO    2105    2242      137   2.28333333
## 1840              CO     730     916      186   3.10000000
## 1841              CO    1903    2038      135   2.25000000
## 1842              CO    1939    2059      120   2.00000000
## 1843              CO     915    1137      222   3.70000000
## 1844              CO    1902    2247      345   5.75000000
## 1845              CO    2109    2217      108   1.80000000
## 1846              CO    1227    1533      306   5.10000000
## 1847              CO    1038    1412      374   6.23333333
## 1848              CO    2100    2226      126   2.10000000
## 1849              CO    1105    1417      312   5.20000000
## 1850              CO    1024    1415      391   6.51666667
## 1851              CO    2106    2202       96   1.60000000
## 1852              CO    1936    2335      399   6.65000000
## 1853              CO     927    1117      190   3.16666667
## 1854              CO    1606    1752      146   2.43333333
## 1855              CO    1805    2218      413   6.88333333
## 1856              CO    1912    2206      294   4.90000000
## 1857              CO    1802    1938      136   2.26666667
## 1858              CO    2107    2200       93   1.55000000
## 1859              CO    1429    1531      102   1.70000000
## 1860              CO    1012    1345      333   5.55000000
## 1861              CO    1753    2028      275   4.58333333
## 1862              CO    1314    1630      316   5.26666667
## 1863              CO    1333    1653      320   5.33333333
## 1864              CO    1912    2117      205   3.41666667
## 1865              CO     930    1044      114   1.90000000
## 1866              CO    1858    2205      347   5.78333333
## 1867              CO    1512    1630      118   1.96666667
## 1868              CO     729    1056      327   5.45000000
## 1869              CO    1759    1857       98   1.63333333
## 1870              CO    1154    1333      179   2.98333333
## 1871              CO    1137    1342      205   3.41666667
## 1872              CO    1426    1546      120   2.00000000
## 1873              CO     845     942       97   1.61666667
## 1874              CO    1223    1348      125   2.08333333
## 1875              CO    1743    2148      405   6.75000000
## 1876              CO     915    1102      187   3.11666667
## 1877              CO    2102    2256      154   2.56666667
## 1878              CO    1102    1352      250   4.16666667
## 1879              CO    1625    1943      318   5.30000000
## 1880              CO    1931    2246      315   5.25000000
## 1881              CO    1813    1933      120   2.00000000
## 1882              CO    1600    2006      406   6.76666667
## 1883              CO     921    1044      123   2.05000000
## 1884              CO    1600    2009      409   6.81666667
## 1885              CO    1804    1950      146   2.43333333
## 1886              CO    1034    1359      325   5.41666667
## 1887              CO    1318    1456      138   2.30000000
## 1888              CO    1835    1952      117   1.95000000
## 1889              CO    1858    2018      160   2.66666667
## 1890              CO     916    1124      208   3.46666667
## 1891              CO    1734    1845      111   1.85000000
## 1892              CO    2115    2228      113   1.88333333
## 1893              CO    1010    1131      121   2.01666667
## 1894              CO     734    1024      290   4.83333333
## 1895              CO    1923    2303      380   6.33333333
## 1896              CO    1252    1554      302   5.03333333
## 1897              CO     928    1227      299   4.98333333
## 1898              CO    1923    2337      414   6.90000000
## 1899              CO    1750    1854      104   1.73333333
## 1900              CO     915    1111      196   3.26666667
## 1901              CO    1557    1714      157   2.61666667
## 1902              CO    1318    1646      328   5.46666667
## 1903              CO    1808    1945      137   2.28333333
## 1904              CO    1438    1615      177   2.95000000
## 1905              CO    1027    1138      111   1.85000000
## 1906              CO    1926    2251      325   5.41666667
## 1907              CO    1142    1549      407   6.78333333
## 1908              CO    1244    1647      403   6.71666667
## 1909              CO    1444    1814      370   6.16666667
## 1910              CO    1320    1704      384   6.40000000
## 1911              CO    1742    1957      215   3.58333333
## 1912              CO     917    1226      309   5.15000000
## 1913              CO    1128    1312      184   3.06666667
## 1914              CO    1803    2006      203   3.38333333
## 1915              CO     926    1335      409   6.81666667
## 1916              CO    1925    2025      100   1.66666667
## 1917              CO    1550    1656      106   1.76666667
## 1918              CO    1522    1620       98   1.63333333
## 1919              CO    1530    1619       89   1.48333333
## 1920              CO    1916    2105      189   3.15000000
## 1921              CO     743     937      194   3.23333333
## 1922              CO    1743    1906      163   2.71666667
## 1923              CO    1206    1609      403   6.71666667
## 1924              CO    1444    1901      457   7.61666667
## 1925              CO     601    1015      414   6.90000000
## 1926              CO    1046    1454      408   6.80000000
## 1927              CO     730     845      115   1.91666667
## 1928              CO    1444    1617      173   2.88333333
## 1929              CO    1304    1521      217   3.61666667
## 1930              CO    2056    2210      154   2.56666667
## 1931              CO    1452    1826      374   6.23333333
## 1932              CO     850    1047      197   3.28333333
## 1933              CO    1926    2244      318   5.30000000
## 1934              CO    1158    1311      153   2.55000000
## 1935              CO     552     712      160   2.66666667
## 1936              CO    1256    1556      300   5.00000000
## 1937              CO    2142      28    -2114 -35.23333333
## 1938              CO    1551    2002      451   7.51666667
## 1939              CO    1036    1633      597   9.95000000
## 1940              CO     903    1053      150   2.50000000
## 1941              CO    1017    1404      387   6.45000000
## 1942              CO     917    1321      404   6.73333333
## 1943              CO    1301    1409      108   1.80000000
## 1944              CO    1543    1919      376   6.26666667
## 1945              CO    1853    2215      362   6.03333333
## 1946              CO    1246    1522      276   4.60000000
## 1947              CO    1126    1350      224   3.73333333
## 1948              CO    1551    1723      172   2.86666667
## 1949              CO    1144    1246      102   1.70000000
## 1950              CO    1101    1217      116   1.93333333
## 1951              CO    2108    2230      122   2.03333333
## 1952              CO     848    1121      273   4.55000000
## 1953              CO    1903    2300      397   6.61666667
## 1954              CO    1429    1617      188   3.13333333
## 1955              CO    1309    1417      108   1.80000000
## 1956              CO    1255    1631      376   6.26666667
## 1957              CO    1129    1310      181   3.01666667
## 1958              CO    1030    1406      376   6.26666667
## 1959              CO    1432    1646      214   3.56666667
## 1960              CO    1314    1429      115   1.91666667
## 1961              CO    1052    1509      457   7.61666667
## 1962              CO    1805    1930      125   2.08333333
## 1963              CO    1314    1624      310   5.16666667
## 1964              CO    1034    1158      124   2.06666667
## 1965              CO     731    1106      375   6.25000000
## 1966              CO    1202    1543      341   5.68333333
## 1967              CO     805    1209      404   6.73333333
## 1968              CO    1702    2044      342   5.70000000
## 1969              CO    1749    2000      251   4.18333333
## 1970              CO    1923    2042      119   1.98333333
## 1971              CO    1921    2303      382   6.36666667
## 1972              CO    1041    1439      398   6.63333333
## 1973              CO    1904    2034      130   2.16666667
## 1974              CO    1922    2150      228   3.80000000
## 1975              CO    1305    1640      335   5.58333333
## 1976              CO    2126    2357      231   3.85000000
## 1977              CO    1911    2005       94   1.56666667
## 1978              CO    1304    1735      431   7.18333333
## 1979              CO     912    1022      110   1.83333333
## 1980              CO    1152    1314      162   2.70000000
## 1981              CO    1921    2235      314   5.23333333
## 1982              CO     856    1301      445   7.41666667
## 1983              CO    2109    2225      116   1.93333333
## 1984              CO    1743    1940      197   3.28333333
## 1985              CO    1324    1738      414   6.90000000
## 1986              CO    1310    1643      333   5.55000000
## 1987              CO     930    1142      212   3.53333333
## 1988              CO     738    1104      366   6.10000000
## 1989              CO    1145    1411      266   4.43333333
## 1990              CO    1612    1959      347   5.78333333
## 1991              CO    1754    1958      204   3.40000000
## 1992              CO    1855    2314      459   7.65000000
## 1993              CO     748    1051      303   5.05000000
## 1994              CO    2120    2231      111   1.85000000
## 1995              CO    1421    1548      127   2.11666667
## 1996              CO    1303    1429      126   2.10000000
## 1997              CO    1536    1834      298   4.96666667
## 1998              CO    1927    2209      282   4.70000000
## 1999              CO    1431    1536      105   1.75000000
## 2000              CO    1545    2004      459   7.65000000
##  [ reached getOption("max.print") -- omitted 225496 rows ]
{% endhighlight %}

#### summarize()

`summarize()` collapses your dataset based on your `group_by` statements.  Note unlike `mutate()` you will loose columns not specified in `group_by()` and you will not be able to subsequentley build on columns created within `summarize()` that you could do in `mutate()`.  




{% highlight r %}
  hflights %>% 
    filter(Month %in% c(1:4)) %>% 
    group_by(UniqueCarrier) %>% 
    mutate(TravelTime = ArrTime - DepTime) %>% 
    summarize(MeanTravel = mean(TravelTime,na.rm =T),
              SDTravel = sd(TravelTime,na.rm =T)) %>%
    mutate(CVTravel = SDTravel/MeanTravel)
{% endhighlight %}



{% highlight text %}
## # A tibble: 15 × 4
##    UniqueCarrier MeanTravel  SDTravel  CVTravel
##            <chr>      <dbl>     <dbl>     <dbl>
## 1             AA   182.5295 149.95498 0.8215384
## 2             AS   245.5167 289.86360 1.1806270
## 3             B6   418.2167 273.96645 0.6550824
## 4             CO   212.0426 349.57368 1.6486009
## 5             DL   302.4732  31.70383 0.1048153
## 6             EV   277.4028 152.97204 0.5514438
## 7             F9   143.2479  21.36778 0.1491665
## 8             FL   269.6241 187.57866 0.6957043
## 9             MQ   160.0611 129.11954 0.8066889
## 10            OO   192.3847 239.30470 1.2438861
## 11            UA   248.9249 115.98536 0.4659452
## 12            US   257.6196  98.54704 0.3825292
## 13            WN   130.1616 208.34976 1.6007001
## 14            XE   176.5255 209.43191 1.1864116
## 15            YV   335.0000  42.82325 0.1278306
{% endhighlight %}

### Lets work with some real data

Here is what I would like you to do:

1. Load the `FAO_GlobalProduction.csv` from our github repository
2. Convert from **wide** to **long** format, with variables `year` and `prod`
3. Rename the columns.  
  * all columns to lowercase
  * 'Country (Country)' to country
  * 'Species (ASFIS species)' to common_name
  * 'Production area (FAO major fishing area)' to prod_area
  * 'Production source (Detailed production source)' to prod_source
  * 'Measure (Measure)' to measure
4. In prod, change '...' to NA
5. Only rows with `Capture production`, `Quantity (tonnes)`, and without `NA` in prod 
6. Create a new column called `inland` which is a binary value of whether the region is inland or not
7. Arrange by country, common_name, and year
8.  Create a new column called log_catch that is the log of prod
9. Generate a unique ID for each fishery
10. Calculate the mean log lifetime catch of each fishery
11. Calculate the coefficient of variation of each fishery
12. Filter out fisheries with short time series (< 10 yrs)
13.  If you are feeling up to it, display CVs among the fisheries (select a specific country or fishery).

[Click here for answers](https://chrischizinski.github.io/SNR_R_Group/answers/answer1.html)
