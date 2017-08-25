---
title: "Joins"
output: html_document
tags: [R, dplyr, joins]
---



Very often when we are working with datasets, particularly databases, we often want to combine multiple datasets.  Traditionally, in R, this was done with the function `merge()`.  Since the development of the `tidyverse` there has been improvements on the types and speed of joins.  The joins available in the `dplyr()` package follow those in SQL type joins.  

We will explore these types of joins using datasets from the our [github repository](https://github.com/chrischizinski/OFWIM_2016/tree/master/data)


{% highlight r %}
library(RCurl)
library(tidyverse)

publishers <- read_csv(getURL("https://raw.githubusercontent.com/chrischizinski/OFWIM_2016/master/data/publisher.csv"))

publishers
{% endhighlight %}



{% highlight text %}
## # A tibble: 3 × 2
##   publisher yr_founded
##       <chr>      <int>
## 1        DC       1934
## 2    Marvel       1939
## 3     Image       1992
{% endhighlight %}



{% highlight r %}
superheroes <- read_csv(getURL("https://raw.githubusercontent.com/chrischizinski/OFWIM_2016/master/data/superheroes.csv"))

superheroes
{% endhighlight %}



{% highlight text %}
## # A tibble: 7 × 4
##       name alignment gender         publisher
##      <chr>     <chr>  <chr>             <chr>
## 1  Magneto       bad   male            Marvel
## 2    Storm      good female            Marvel
## 3 Mystique       bad female            Marvel
## 4   Batman      good   male                DC
## 5    Joker       bad   male                DC
## 6 Catwoman       bad female                DC
## 7  Hellboy      good   male Dark Horse Comics
{% endhighlight %}

## Inner join

**Mutating join**

> inner_join(x, y): Return all rows from x where there are matching values in y, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned.

An inner join of `superheroes` with `publisher` would return a dataset of `superheros` that match those in `publisher`


{% highlight r %}
super_ij <- inner_join(superheroes, publishers, by = "publisher")
super_ij
{% endhighlight %}



{% highlight text %}
## # A tibble: 6 × 5
##       name alignment gender publisher yr_founded
##      <chr>     <chr>  <chr>     <chr>      <int>
## 1  Magneto       bad   male    Marvel       1939
## 2    Storm      good female    Marvel       1939
## 3 Mystique       bad female    Marvel       1939
## 4   Batman      good   male        DC       1934
## 5    Joker       bad   male        DC       1934
## 6 Catwoman       bad female        DC       1934
{% endhighlight %}
## Semi join

**Filtering join**

> semi_join(x, y): Return all rows from x where there are matching values in y, keeping just columns from x. 

A semi join differs from an inner join because an inner join will return one row of x for each matching row of y, where a semi join will never duplicate rows of x. 


{% highlight r %}
super_sj <- semi_join(superheroes, publishers, by = "publisher")
super_sj
{% endhighlight %}



{% highlight text %}
## # A tibble: 6 × 4
##       name alignment gender publisher
##      <chr>     <chr>  <chr>     <chr>
## 1   Batman      good   male        DC
## 2    Joker       bad   male        DC
## 3 Catwoman       bad female        DC
## 4  Magneto       bad   male    Marvel
## 5    Storm      good female    Marvel
## 6 Mystique       bad female    Marvel
{% endhighlight %}

Notice that we loose 'Hellboy' because publisher was 'Dark Horse Comics' that did not exist in publisher.  This differs from the inner join because it only retains the columns in superheroes, which is why it is a filtering join.   

## Left join

**Mutating join**

> left_join(x, y): Return all rows from x, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned.  


The left join keeps all the data from the first specified dataset (x) and the columns from the second dataset (y).  Where there are no matches an `NA` will be returned.   


{% highlight r %}
super_lj <- left_join(superheroes, publishers, by = "publisher")
super_lj
{% endhighlight %}



{% highlight text %}
## # A tibble: 7 × 5
##       name alignment gender         publisher yr_founded
##      <chr>     <chr>  <chr>             <chr>      <int>
## 1  Magneto       bad   male            Marvel       1939
## 2    Storm      good female            Marvel       1939
## 3 Mystique       bad female            Marvel       1939
## 4   Batman      good   male                DC       1934
## 5    Joker       bad   male                DC       1934
## 6 Catwoman       bad female                DC       1934
## 7  Hellboy      good   male Dark Horse Comics         NA
{% endhighlight %}

Notice that we loose 'Hellboy' because publisher was 'Dark Horse Comics' that did not exist in publisher.  This differs from the inner join because it only retains the columns in superheroes, which is why it is a filtering join. 

## Right join

**Mutating join**

> right_join(x, y): Returns all observations in y. It’s equivalent to left_join(y, x), but the columns will be ordered differently.  


The right join keeps all the data from the first specified dataset (x) and the columns from the second dataset (y).  Where there are no matches an `NA` will be returned.   


{% highlight r %}
super_rj <- right_join(superheroes, publishers, by = "publisher")
super_rj
{% endhighlight %}



{% highlight text %}
## # A tibble: 7 × 5
##       name alignment gender publisher yr_founded
##      <chr>     <chr>  <chr>     <chr>      <int>
## 1   Batman      good   male        DC       1934
## 2    Joker       bad   male        DC       1934
## 3 Catwoman       bad female        DC       1934
## 4  Magneto       bad   male    Marvel       1939
## 5    Storm      good female    Marvel       1939
## 6 Mystique       bad female    Marvel       1939
## 7     <NA>      <NA>   <NA>     Image       1992
{% endhighlight %}

## Anti join

**Filtering join**

> anti_join(x, y): Returns all rows in x that do not have a match in y.  

Returns only the rows that do not have matches.    


{% highlight r %}
super_aj <- anti_join(superheroes, publishers, by = "publisher")
super_aj
{% endhighlight %}



{% highlight text %}
## # A tibble: 1 × 4
##      name alignment gender         publisher
##     <chr>     <chr>  <chr>             <chr>
## 1 Hellboy      good   male Dark Horse Comics
{% endhighlight %}

## Full join

**Mutating join**

> full_join(x, y): Returns all observations in x and y.   

The full join keeps all the data from the first specified dataset (x) and  the second dataset (y).  Where there are no matches an `NA` will be returned.   


{% highlight r %}
super_fj <- full_join(superheroes, publishers, by = "publisher")
super_fj
{% endhighlight %}



{% highlight text %}
## # A tibble: 8 × 5
##       name alignment gender         publisher yr_founded
##      <chr>     <chr>  <chr>             <chr>      <int>
## 1  Magneto       bad   male            Marvel       1939
## 2    Storm      good female            Marvel       1939
## 3 Mystique       bad female            Marvel       1939
## 4   Batman      good   male                DC       1934
## 5    Joker       bad   male                DC       1934
## 6 Catwoman       bad female                DC       1934
## 7  Hellboy      good   male Dark Horse Comics         NA
## 8     <NA>      <NA>   <NA>             Image       1992
{% endhighlight %}
