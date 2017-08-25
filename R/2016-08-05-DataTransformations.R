#  Data transformations and standardizations
rawdata<-matrix(c(1,1,1,3,3,1,
                2,2,4,6,6,0,
                10,10,20,30, 30,0,
                3,3,2,1,1,0,
                0,0,0,0,1,0,
                0,0,0,0,20,0), 6, byrow =T)

# row sums
apply(rawdata, 1, sum)  

# column sums
apply(rawdata, 2, sum)

## Transformations are applied to each element of the data matrix, independent of the other elements

## Standardizations adjust matrix elements by a row or column standard (e.g., max, sum, mean)

## Monotonic transformations
### log 10 transformation
logdata<-apply(rawdata,c(1,2), function(x) log10(x+1))

#### compress high values and spreads low values by expressing as orders of magnitude
#### useful when you have a lot of variation

setwd("/Users/cchizinski2/Desktop/AppliedMultivariate")
source("/Users/cchizinski2/Desktop/AppliedMultivariate/biostats.R")

dat<-read.csv("plants_native_cover.csv", header=TRUE)
head(dat)

library(gridExtra)

a<-ggplot(data=dat) +
  geom_histogram(aes(x=Tsuga.canadensis), bins=30, fill="red", color="black") + 
  coord_cartesian(xlim = c(0,80)) +
  theme_bw()

b<-ggplot(data=dat) +
   geom_histogram(aes(x=log10(Tsuga.canadensis+1)), bins =30, fill="blue", color="black") + 
   # coord_cartesian(xlim = c(0,80)) +
   theme_bw()

grid.arrange(a,b, ncol=1)


##power transformation
# x >0

pwr_trans<-function(x, trans){
  x<- ifelse(x>0,x^(1/trans),0)
  return(x)
}

dat.x<-data.frame(x=c(1:100))

library(dplyr)
library(tidyr)

data.x<-dat.x %>%
        mutate(b2=pwr_trans(x,2),
               b3=pwr_trans(x,3),
               b4=pwr_trans(x,4),
               b5=pwr_trans(x,5),
               b10=pwr_trans(x,10)) %>%
        gather(trans,value, b2:b10)

ggplot(data.x) + 
  geom_line(aes(x = x, y = value, colour = trans )) + 
  theme_bw()

## sqrt trans (trans = 2) most often used for Poisson data
#  greater the value, greater the compression
# flexible for a wide range of data


### pres/absence transformations
pa_trans<-function(x){
  x<-ifelse(x>0,1,0)
  return(x)
  }

apply(rawdata,c(1,2), function(x) pa_trans(x))

#### Quantitative to nonquantitative
#### applicable to species data
#### most useful when there is not a lot of quantitative info present
#### severe transformation:  loose a lot of info

### arc sine 
popdata<-rawdata %*% diag(1 / apply(rawdata, 2, sum))

acsin_trans<-function(x){
  x<- 2/pi *asin(sqrt(x))
  return(x)
  }

apply(popdata, c(1,2), function(x) acsin_trans(x))

data.x<-data.frame(x=c(1:100)/100)
data.x$b<-acsin_trans(data.x$x)

ggplot(data.x) + 
  geom_line(aes(x = x, y = x)) +
  geom_line(aes(x = x, y = b), colour="red") + 
  theme_bw()
#### Spreads end of scale while compressing the middle
#### useful for proportion data with a positive skew


### Standardizations or relativizations

#All standardizations can be applied to either rows or columns or both
rawdata

## Column Z score standaridization
# acceptable domain:  all
# range of f(x):  all 

mvals<-apply(rawdata, 2, mean)
sdvals<-apply(rawdata, 2, sd)

std_data<-(rawdata - mvals_r) %*% diag(1 /sdvals_r)
apply(std_data, 2, sum)

#### Converts values to z scores (mean = 0, variance = 1)
#### Commonly used to put variables on equal footing
#### important to use when you variables that are at different scales or units of measurement



## Column total standardization
# acceptable domain:  >= 0
# range of f(x):  0 - 1

tvals<-apply(rawdata, 2, sum)

std_data<-(rawdata ) %*% diag(1 /tvals)
std_data
apply(std_data, 2, sum)

#### used for species data to adjust for unequal abundances
#### equalizes AUC of species profiles
#### relative abundance


## Column max standardization
# acceptable domain:  >= 0
# range of f(x):  0 - 1

mxvals<-apply(rawdata, 2, max)

std_data<-(rawdata) %*% diag(1 /mxvals)
std_data
apply(std_data, 2, sum)

#### used for species data to adjust for unequal abundances
#### equalizes AUC of species profiles
#### relative abundance

spdat<-data.frame(spp= rep(c("sp.a","sp.b"), each = 100), N = c(rpois(100, 1),rpois(100, 5)))

spdata.summ<-spdat %>%
              group_by(spp, N) %>%
              summarise(ttl=n()) %>%
              ungroup() %>%
              complete(N, nesting(spp),fill=list(ttl = 0))

a<-ggplot(data=spdata.summ) + 
  geom_bar(aes(x =N, y = ttl, fill=spp), position="dodge", stat="identity", colour="black", width = 1) + 
  labs(y = "Frequency", x = "Count", title="Raw") +
  theme_bw()

spdata.summ2<- spdata.summ %>%
                group_by(spp) %>%
                mutate(MaxN= max(ttl),
                       TTL = sum(ttl))

b<-ggplot(data=spdata.summ2) + 
  geom_bar(aes(x =N, y = ttl/TTL, fill=spp), position="dodge", stat="identity", colour="black", width = 1) + 
  labs(y = "Frequency", x = "Count", title="Column Total Standardization") +
  theme_bw()

c<-ggplot(data=spdata.summ2) + 
  geom_bar(aes(x =N, y = ttl/MaxN, fill=spp), position="dodge", stat="identity", colour="black", width = 1) + 
  labs(y = "Frequency", x = "Count", title="Column Max Standardization") +
  theme_bw()

grid.arrange(a,b,c, ncol=1)

## Row total standardization
# acceptable domain:  >= 0
# range of f(x):  0 - 1

tvals<-apply(rawdata, 1, sum)

std_data<-(rawdata ) / tvals
std_data

#### adjust for unequal abundances
#### equalized AUC
###
