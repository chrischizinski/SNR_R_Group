---
title       : Multivariate Stats
subtitle    : 
author      : Christopher Chizinski
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Multivariate data

> - Data (biological or sociological) we collect is often complex
    - 5 species = 10 potential correlation
    - 25 species = 300 potential correlations

> - Multivariate techniques were developed to:
    - Reduce dimensionality of data
    - Explore how multiple variables respond to explanatory variables *simultaneously*

---

## Structure of multivariate data

- Array (matrix)
    - columns = measured variables
    - rows = observations
    
- Data can be binary, quantitative, qualitative, rank-ordered, or a mixture

- Many multivariate techniques exist to meet the many types of data and the needs of the researcher

--- &vcenter
## Lots of options

<img src="assets/img/multibox.png" width="800px" />

---

## Data transformations

>- Non-categorical data can often benefit from transformations
    - Ecological and statistical reasons
    
>- The type of transformation should reflect the science behind the data as well as the method that will be used 

>- Data transformations should:
    - be used to the statistical assumptions of the chosen sampling distribution (e.g., normality, linearity, homogeneity of variances) 
    - make units comparable when the observations are measured on different scales

---

## Data standardizations

most common types of standardizations:
- relativized (dividing by row or column totals or maximums)
- z-score (subtract the mean of the row or column and dividing by the standard deviation)
- Hellinger (for zero-inflated presence-absence data)
- chord (weights data by rarity)

---

## Distances

- is important to represent measurement (i.e. rows) and observations (i.e. columns) in your data set in terms of  resemblance 

>- *Similarity*  ranges from 1 (complete similarity) to 0 (no similarity), is the most common measure of resemblance and considers the number of measurements observations have in common, divided by the total number of measurements taken

>- *Dissimilarity* is the complement to Similarity (dissimilarity = 1 – similarity)

>- *Distance* between measurements can also quantify ecological resemblance

---

## Distance (cont)

>- Most common distance measure is Euclidean distance, which uses the Pythagorean Theorem to measure between two points in multidimensional space (rather than geographic space) and is applicable to data of any scale

>- Some multivariate techniques are limited to a single distance measure (i.e., principal component analysis, correspondence analysis) based on the type of data collected, but other techniques are more flexible (i.e., principal coordinate analysis, non-metric multidimensional analysis)

>- Each distance measure has its own strengths and weaknesses that must be considered before choosing an analysis technique 






 
 






