---
output: html_document
---




{% highlight r %}
library(RCurl)
library(tidyverse)

fao_data<-read_csv(getURL("https://raw.githubusercontent.com/chrischizinski/SNR_R_Group/master/data/FAO_GlobalProduction.csv"))

names(fao_data)
{% endhighlight %}



{% highlight text %}
##  [1] "Country (Country)"                             
##  [2] "Species (ASFIS species)"                       
##  [3] "Production area (FAO major fishing area)"      
##  [4] "Production source (Detailed production source)"
##  [5] "Measure (Measure)"                             
##  [6] "1950"                                          
##  [7] "1951"                                          
##  [8] "1952"                                          
##  [9] "1953"                                          
## [10] "1954"                                          
## [11] "1955"                                          
## [12] "1956"                                          
## [13] "1957"                                          
## [14] "1958"                                          
## [15] "1959"                                          
## [16] "1960"                                          
## [17] "1961"                                          
## [18] "1962"                                          
## [19] "1963"                                          
## [20] "1964"                                          
## [21] "1965"                                          
## [22] "1966"                                          
## [23] "1967"                                          
## [24] "1968"                                          
## [25] "1969"                                          
## [26] "1970"                                          
## [27] "1971"                                          
## [28] "1972"                                          
## [29] "1973"                                          
## [30] "1974"                                          
## [31] "1975"                                          
## [32] "1976"                                          
## [33] "1977"                                          
## [34] "1978"                                          
## [35] "1979"                                          
## [36] "1980"                                          
## [37] "1981"                                          
## [38] "1982"                                          
## [39] "1983"                                          
## [40] "1984"                                          
## [41] "1985"                                          
## [42] "1986"                                          
## [43] "1987"                                          
## [44] "1988"                                          
## [45] "1989"                                          
## [46] "1990"                                          
## [47] "1991"                                          
## [48] "1992"                                          
## [49] "1993"                                          
## [50] "1994"                                          
## [51] "1995"                                          
## [52] "1996"                                          
## [53] "1997"                                          
## [54] "1998"                                          
## [55] "1999"                                          
## [56] "2000"                                          
## [57] "2001"                                          
## [58] "2002"                                          
## [59] "2003"                                          
## [60] "2004"                                          
## [61] "2005"                                          
## [62] "2006"                                          
## [63] "2007"                                          
## [64] "2008"                                          
## [65] "2009"                                          
## [66] "2010"                                          
## [67] "2011"                                          
## [68] "2012"                                          
## [69] "2013"                                          
## [70] "2014"
{% endhighlight %}



{% highlight r %}
fao_summary<-fao_data %>%
      gather(year, prod, -(1:5)) %>% 
      rename(country = `Country (Country)`,
             commonname = `Species (ASFIS species)`,
             prod_area = `Production area (FAO major fishing area)`,
             prod_source = `Production source (Detailed production source)`,
             measure = `Measure (Measure)`) %>% 
      mutate(prod = ifelse(prod == '...', NA, prod),
             prod = ifelse(prod == '0 0', 0, prod),
             prod = as.numeric(prod)) %>% 
      filter(prod_source == "Capture production",
             measure == "Quantity (tonnes)",
             !is.na(prod)) %>% 
      mutate(inland = ifelse(grepl("Inland",prod_area),1,0),
             log_prod = log(prod+1)) %>% 
      arrange(country, commonname, year) %>% 
      unite(uniq_fishery, country, commonname, remove=FALSE) %>%
      group_by(country,uniq_fishery) %>% 
      summarise(mean_log = mean(log_prod),
                CV_prod = sd(prod)/mean(prod),
                n_years = n()) %>% 
      filter(n_years> 10) 

head(fao_summary)
{% endhighlight %}



{% highlight text %}
## Source: local data frame [6 x 5]
## Groups: country [2]
## 
##       country                         uniq_fishery mean_log   CV_prod
##         <chr>                                <chr>    <dbl>     <dbl>
## 1 Afghanistan    Afghanistan_Freshwater fishes nei 6.327915 0.5401854
## 2     Albania Albania_Angelsharks, sand devils nei 2.786145 0.9581526
## 3     Albania              Albania_Atlantic bonito 2.348561 0.7635166
## 4     Albania                        Albania_Bleak 5.512833 0.5219357
## 5     Albania                        Albania_Bogue 5.174876 0.8579373
## 6     Albania               Albania_Caramote prawn 3.928849 1.1270006
## # ... with 1 more variables: n_years <int>
{% endhighlight %}

