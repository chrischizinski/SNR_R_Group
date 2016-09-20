---
title: "Inputing data"
output: html_document
tags: [R, Data input, tidyverse]
---



All the data that we use (and will be used in this course) are available from [here](https://qkstats.com/data-files/).  I have also placed a copy of this data in our [repository](https://github.com/chrischizinski/SNR_R_Group/tree/master/data).


## Getting data into R

There are a lot of ways of getting data into R and this can add to a lot of confusion for R newbies trying to get started in R.  We have already shown that there are ways to manually enter data in the previous lesson.  R does have its own data format called `.Rdata`.

### `.RData` - R's internal data format

You can read and write your data to an `.RData` format in a couple of ways.  To illustrate, we will use the iris dataset. 


{% highlight r %}
data(iris)  # load the internal data set

head(iris)  # take a look at it
{% endhighlight %}



{% highlight text %}
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
{% endhighlight %}



{% highlight r %}
newiris<- iris # create a new object called newiris

# To save this as an .Rdata set we need to specify the data.frame and then the path to save it
save(newiris, file = "/Users/cchizinski2/Documents/SNR_R_Group/master/data/newiris.RData")

# First lets remove newiris from the environment
rm(newiris, iris)
ls()
{% endhighlight %}



{% highlight text %}
## [1] "KnitPost"               "theme_map"             
## [3] "theme_map_presentation" "theme_mine"            
## [5] "theme_presentation"     "theme_transparent"
{% endhighlight %}



{% highlight r %}
# To load an .Rdata file you
load(file = "/Users/cchizinski2/Documents/SNR_R_Group/master/data/newiris.RData")
head(newiris)
{% endhighlight %}



{% highlight text %}
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
{% endhighlight %}

### Other formats

Whether you are trying to scrape a webpage, load from SPSS or SAS, or csv there is a package trying to help you get it into R.  Hadley has been behind a cohesive effort and philosophy of data and R programming called the `tidyverse`.  Within these collection of packages are the abilities to load most kinds of data.  NOTE:  these packages will load data in the form of a [`tibble`](https://github.com/hadley/tibble)

To install these packages, you will first need to install the package `devtools` and then install from Hadley's [github repository](https://github.com/hadley/tidyverse).

Please note that I am only going to cover the files that you are most likely going to encounter.  There are a ton of different files out there and if you need alternate file types, check out the [`foreign` package](https://cran.r-project.org/web/packages/foreign/foreign.pdf), [`rio`](https://cloud.r-project.org/web/packages/rio/index.html), or [Hadley's page](http://r4ds.had.co.nz/data-import.html).


{% highlight r %}
install.packages("devtools")
{% endhighlight %}


{% highlight r %}
library(devtools) 

install_github("hadley/tidyverse", force = TRUE)

library(tidyverse)
{% endhighlight %}


{% highlight text %}
## Loading tidyverse: tibble
## Loading tidyverse: tidyr
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


### CSV and TSV

One of the most basic types of files (and those that I use most frequently) are flat files like csv (comma seperated values or text files (space or tab seperated files).  The best (in my unqualified opinion) is the [`readr` package](https://cran.r-project.org/web/packages/readr/readr.pdf). 

To look at the requirements and default options pull up the help menu 


{% highlight r %}
#library(readr) # if you have not loaded tidyverse
?read_csv  # note this is different from read.csv in base R
{% endhighlight %}

There is a couple of things that are nice with this package over the base:
- comment:  a string to identify comments
- strip white space:  removes leading and trailing white space (THE BANE OF MANY STRINGS)


To open a csv file, indicate the path to the file. Again NOTE that this will be loaded as a `tibble` and not a traditional `data.frame.`


{% highlight r %}
#Land crabs on Christmas Island, relationship to burrow density
land_crabs<-read_csv("/Users/cchizinski2/Documents/SNR_R_Group/master/data/ExperimentalDesignData/chpt5/green.csv")
{% endhighlight %}



{% highlight text %}
## Parsed with column specification:
## cols(
##   SITE = col_character(),
##   QUADNUM = col_integer(),
##   TOTMASS = col_double(),
##   BURROWS = col_integer()
## )
{% endhighlight %}



{% highlight r %}
head(land_crabs)
{% endhighlight %}



{% highlight text %}
## # A tibble: 6 × 4
##    SITE QUADNUM TOTMASS BURROWS
##   <chr>   <int>   <dbl>   <int>
## 1    DS       1    2.15      39
## 2    DS       2    2.27      38
## 3    DS       3    4.31      61
## 4    DS       4    2.58      79
## 5    DS       5    3.23      35
## 6    DS       6    1.83      39
{% endhighlight %}



{% highlight r %}
# to convert to a data.frame use
land_crabs.df<-as.data.frame(land_crabs)
head(land_crabs.df)
{% endhighlight %}



{% highlight text %}
##   SITE QUADNUM TOTMASS BURROWS
## 1   DS       1    2.15      39
## 2   DS       2    2.27      38
## 3   DS       3    4.31      61
## 4   DS       4    2.58      79
## 5   DS       5    3.23      35
## 6   DS       6    1.83      39
{% endhighlight %}



{% highlight r %}
#library(readr) # if you have not loaded tidyverse
?read_tsv  # note this is different from read.csv in base R
{% endhighlight %}

To open a tsv file, indicate the path to the file. Again NOTE that this will be loaded as a `tibble` and not a traditional `data.frame.`


{% highlight r %}
#Land crabs on Christmas Island, relationship to burrow density
land_crabs<-read_tsv("/Users/cchizinski2/Documents/SNR_R_Group/master/data/ExperimentalDesignData/chpt5/green_txt.txt")
{% endhighlight %}



{% highlight text %}
## Warning: Missing column names filled in: 'X5' [5]
{% endhighlight %}



{% highlight text %}
## Parsed with column specification:
## cols(
##   SITE = col_character(),
##   QUADNUM = col_integer(),
##   TOTMASS = col_double(),
##   BURROWS = col_integer(),
##   X5 = col_character()
## )
{% endhighlight %}



{% highlight r %}
head(land_crabs)
{% endhighlight %}



{% highlight text %}
## # A tibble: 6 × 5
##    SITE QUADNUM TOTMASS BURROWS    X5
##   <chr>   <int>   <dbl>   <int> <chr>
## 1    DS       1    2.15      39  <NA>
## 2    DS       2    2.27      38  <NA>
## 3    DS       3    4.31      61  <NA>
## 4    DS       4    2.58      79  <NA>
## 5    DS       5    3.23      35  <NA>
## 6    DS       6    1.83      39  <NA>
{% endhighlight %}



{% highlight r %}
# to convert to a data.frame use
land_crabs.df<-as.data.frame(land_crabs)
head(land_crabs.df)
{% endhighlight %}



{% highlight text %}
##   SITE QUADNUM TOTMASS BURROWS   X5
## 1   DS       1    2.15      39 <NA>
## 2   DS       2    2.27      38 <NA>
## 3   DS       3    4.31      61 <NA>
## 4   DS       4    2.58      79 <NA>
## 5   DS       5    3.23      35 <NA>
## 6   DS       6    1.83      39 <NA>
{% endhighlight %}

### xls or xlsx

Unfortunately, people like to store data in excel files, despite many problems like those pointed out in this [study](http://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-1044-7). However, there is the [`readxl` package](https://cran.r-project.org/web/packages/readxl/readxl.pdf). 

To look at the requirements and default options pull up the help menu 


{% highlight r %}
library(readxl) # if you have not loaded tidyverse
?read_excel  
{% endhighlight %}

To open a excel file, indicate the path to the file. Again NOTE that this will be loaded as a `tibble` and not a traditional `data.frame.`


{% highlight r %}
#Land crabs on Christmas Island, relationship to burrow density
land_crabs<-read_excel("/Users/cchizinski2/Documents/SNR_R_Group/master/data/ExperimentalDesignData/chpt5/green.xls")

head(land_crabs)
{% endhighlight %}



{% highlight text %}
## # A tibble: 6 × 4
##    SITE QUADNUM TOTMASS BURROWS
##   <chr>   <dbl>   <dbl>   <dbl>
## 1    DS       1    2.15      39
## 2    DS       2    2.27      38
## 3    DS       3    4.31      61
## 4    DS       4    2.58      79
## 5    DS       5    3.23      35
## 6    DS       6    1.83      39
{% endhighlight %}



{% highlight r %}
# You can also specify the sheet you would like to input
land_crabs2<-read_excel("/Users/cchizinski2/Documents/SNR_R_Group/master/data/ExperimentalDesignData/chpt5/green.xls", sheet = "Sheet2")

# or 
land_crabs2<-read_excel("/Users/cchizinski2/Documents/SNR_R_Group/master/data/ExperimentalDesignData/chpt5/green.xls", sheet = 2)

# and specify NAs for something different than blank cells
land_crabs2<-read_excel("/Users/cchizinski2/Documents/SNR_R_Group/master/data/ExperimentalDesignData/chpt5/green.xls", sheet = "Sheet2", na = "NA")

land_crabs2
{% endhighlight %}



{% highlight text %}
## # A tibble: 18 × 4
##     SITE QUADNUM TOTMASS BURROWS
##    <chr>   <dbl>   <dbl>   <dbl>
## 1     DS       1    2.15      39
## 2     DS       2    2.27      38
## 3     DS       3    4.31      61
## 4     DS       4    2.58      79
## 5     DS       5    3.23      35
## 6     DS       6    1.83      39
## 7     DS       7    1.54      NA
## 8     DS       8    2.00      28
## 9     LS       1    4.36      38
## 10    LS       2    4.01      37
## 11    LS       3    3.33      NA
## 12    LS       4    2.63      18
## 13    LS       5    4.46      41
## 14    LS       6    3.96      33
## 15    LS       7    4.18      40
## 16    LS       8    4.21      29
## 17    LS       9    2.54      25
## 18    LS      10    4.29      38
{% endhighlight %}

### SAS, SPSS, or Stata

There is always the chance that you get handed data from one of the 'other' stat programs and need to load it into R. In addition, it can write data in these formats as well.   Luckily there is the [`haven` package](https://github.com/hadley/haven). 

To look at the requirements and default options pull up the help menu 


{% highlight r %}
library(haven) # if you have not loaded tidyverse
?read_sas #SAS
?read_sav #SPSS
?read_dta #Stata
{% endhighlight %}


#### SAS files

To open a SAS file (SAS7BDAT + SAS7BCAT formats), indicate the path to the file. Again NOTE that this will be loaded as a `tibble` and not a traditional `data.frame.`


{% highlight r %}
# Iris data set
iris_sas<-read_sas("/Users/cchizinski2/Documents/SNR_R_Group/master/data/iris.sas7bdat")

head(iris_sas)
{% endhighlight %}



{% highlight text %}
## # A tibble: 6 × 5
##   Sepal_Length Sepal_Width Petal_Length Petal_Width Species
##          <dbl>       <dbl>        <dbl>       <dbl>   <chr>
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
{% endhighlight %}

#### SPSS files

To open a SPSS file (`.sav`), indicate the path to the file. Again NOTE that this will be loaded as a `tibble` and not a traditional `data.frame.`


{% highlight r %}
# Iris data set
iris_spss<-read_sav("/Users/cchizinski2/Documents/SNR_R_Group/master/data/iris.sav")

head(iris_spss)
{% endhighlight %}



{% highlight text %}
## # A tibble: 6 × 5
##   Sepal.Length Sepal.Width Petal.Length Petal.Width        Species
##          <dbl>       <dbl>        <dbl>       <dbl> <S3: labelled>
## 1          5.1         3.5          1.4         0.2              1
## 2          4.9         3.0          1.4         0.2              1
## 3          4.7         3.2          1.3         0.2              1
## 4          4.6         3.1          1.5         0.2              1
## 5          5.0         3.6          1.4         0.2              1
## 6          5.4         3.9          1.7         0.4              1
{% endhighlight %}

#### Stata files

To open a Stata file (Stata 13 and 14), indicate the path to the file. Again NOTE that this will be loaded as a `tibble` and not a traditional `data.frame.`


{% highlight r %}
# Iris data set
iris_stata<-read_stata("/Users/cchizinski2/Documents/SNR_R_Group/master/data/iris.dta")

head(iris_stata)
{% endhighlight %}



{% highlight text %}
## # A tibble: 6 × 5
##   Sepal.Length Sepal.Width Petal.Length Petal.Width        Species
##          <dbl>       <dbl>        <dbl>       <dbl> <S3: labelled>
## 1          5.1         3.5          1.4         0.2              1
## 2          4.9         3.0          1.4         0.2              1
## 3          4.7         3.2          1.3         0.2              1
## 4          4.6         3.1          1.5         0.2              1
## 5          5.0         3.6          1.4         0.2              1
## 6          5.4         3.9          1.7         0.4              1
{% endhighlight %}


### Reading data from a github repository

#### Text files (csv, tab)

To load text files from a git repository you will need the [`RCurl` package](https://cran.r-project.org/web/packages/RCurl/RCurl.pdf).  Note this is not part of the `tidyverse`)

On the github repository that you would like to download data from
, find the button marked "Raw" and click on it.  This is the raw text file and you will need to copy the URL to past this following the code below.  


{% highlight r %}
library(RCurl)
{% endhighlight %}



{% highlight text %}
## Loading required package: bitops
{% endhighlight %}



{% highlight text %}
## 
## Attaching package: 'RCurl'
{% endhighlight %}



{% highlight text %}
## The following object is masked from 'package:tidyr':
## 
##     complete
{% endhighlight %}



{% highlight r %}
library(readr)

land_crabs<-read_csv(getURL("https://raw.githubusercontent.com/chrischizinski/SNR_R_Group/master/data/ExperimentalDesignData/chpt5/green.csv"))

head(land_crabs)
{% endhighlight %}



{% highlight text %}
## # A tibble: 6 × 4
##    SITE QUADNUM TOTMASS BURROWS
##   <chr>   <int>   <dbl>   <int>
## 1    DS       1    2.15      39
## 2    DS       2    2.27      38
## 3    DS       3    4.31      61
## 4    DS       4    2.58      79
## 5    DS       5    3.23      35
## 6    DS       6    1.83      39
{% endhighlight %}

#### RData files

To load `.RData` files from a git repository, you will need the  [`repmis package`](https://cran.r-project.org/web/packages/repmis/repmis.pdf).  Note that `repmis` is not part of the `tidyverse` and contains some other miscellaneous functions that could be helpful. 

On the github repository that you would like to download data from, find the button marked "Raw" and right-click on it, and copy link.  If you click it, it will download the file.     

{% highlight r %}
library(repmis)

source_data("https://github.com/chrischizinski/SNR_R_Group/blob/master/data/iris_from_git.RData?raw=true")
{% endhighlight %}



{% highlight text %}
## Downloading data from: https://github.com/chrischizinski/SNR_R_Group/blob/master/data/iris_from_git.RData?raw=true
{% endhighlight %}



{% highlight text %}
## SHA-1 hash of the downloaded data file is:
## fe14b424cf7065a4574f5657153db5d25c6e2057
{% endhighlight %}



{% highlight text %}
## [1] "iris_from_git"
{% endhighlight %}



{% highlight r %}
head(iris_from_git)
{% endhighlight %}



{% highlight text %}
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
{% endhighlight %}
