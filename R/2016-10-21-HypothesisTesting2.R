.libPaths("P:/RLibrary")

library(RCurl)
library(tidyverse)
library(MASS)

#Hypothesis test part 2

head(mtcars)

wilcox.test(mpg ~ am, data = mtcars)

head(immer)

wilcox.test(immer$Y1, immer$Y2, paired = TRUE)

## Putting it into practice

ward <- read_csv(getURL("https://raw.githubusercontent.com/chrischizinski/SNR_R_Group/master/data/ExperimentalDesignData/chpt3/ward.csv"))


head(ward)
unique(ward$ZONE)
