# R estimation part 2
# October 7, 2016

.libPaths("P:/RLibrary")
library(ggplot2)

set.seed(123456)

rand_values <- data.frame(x = 1:75, val = rnorm(75, mean = 10, sd = 3))
head(rand_values)

iter <- 1000

stor_vals <- data.frame(iter = 1:iter, bs_mean = NA)
head(stor_vals) 

for(i in 1:iter){
  print(i)
  sub_rand_values <- rand_values[sample(1:nrow(rand_values),nrow(rand_values), replace = TRUE),]
  
  mean_val <- mean(sub_rand_values$val)
  
  stor_vals$bs_mean[i] <- mean_val
  
}

ggplot() +
  geom_histogram(data = rand_values, aes(x = val), bins = 25, colour = "black", fill = "dodgerblue") + 
  geom_vline(aes(xintercept = mean(rand_values$val)), color = "red", linetype = "dashed") + 
  geom_vline(aes(xintercept = mean(stor_vals$bs_mean)), color = "black", linetype = "dotted") +
  labs(x = "Value", y = "Frequency") + 
  coord_cartesian(ylim = c(0,10), expand = F) + 
  theme_bw()

stor_vals2 <- data.frame(iter = 1:iter, bs_mean = NA)
head(stor_vals2) 

for(i in 1:iter){
  print(i)
  sub_rand_values <- rand_values[sample(1:nrow(rand_values),floor(nrow(rand_values)/2), replace = FALSE),]
  
  mean_val <- mean(sub_rand_values$val)
  
  stor_vals2$bs_mean[i] <- mean_val
  
}

ggplot() +
  geom_histogram(data = rand_values, aes(x = val), bins = 25, colour = "black", fill = "firebrick") + 
  geom_vline(aes(xintercept = mean(rand_values$val)), color = "red", linetype = "dashed") + 
  geom_vline(aes(xintercept = mean(stor_vals2$bs_mean)), color = "black", linetype = "dotted") +
  labs(x = "Value", y = "Frequency") + 
  coord_cartesian(ylim = c(0,10), expand = F) + 
  theme_bw()

library(tidyverse)
library(RCurl)

lovett <- read_csv(getURL("https://raw.githubusercontent.com/chrischizinski/SNR_R_Group/master/data/ExperimentalDesignData/chpt2/lovett.csv"))

head(lovett)

lovett_sum<-lovett %>% 
      summarise(Mean_SO4 = mean(SO4),
                Mean_SO4mod = mean(SO4MOD),
                Mean_CL = mean(CL),
                Median_SO4 = median(SO4),
                Median_SO4mod = median(SO4MOD),
                Median_CL = median(CL),
                TrimMean_SO4 = mean(SO4,trim=0.05),
                TrimMean_SO4mod = mean(SO4MOD,trim=0.05),
                TrimMean_CL = mean(CL,trim=0.05),
                SD_SO4 = sd(SO4),
                SD_SO4mod = sd(SO4MOD),
                SD_CL = sd(CL),
                IQR_SO4 = IQR(SO4),
                IQR_SO4mod = IQR(SO4MOD),
                IQR_CL = IQR(CL),
                MAD_SO4 = mad(SO4),
                MAD_SO4mod = mad(SO4MOD),
                MAD_CL = mad(CL),
                SE_SO4 = sd(SO4)/sqrt(length(SO4)),
                SE_SO4mod = sd(SO4MOD)/sqrt(length(SO4MOD)),
                SE_CL = sd(CL)/sqrt(length(CL))) %>% 
      mutate(CILO_SO4 = Mean_SO4 - 1.96*SE_SO4,
             CIHI_SO4 = Mean_SO4 + 1.96*SE_SO4,
             CILO_SO4mod = Mean_SO4mod - 1.96*SE_SO4mod,
             CIHI_SO4mod = Mean_SO4mod + 1.96*SE_SO4mod,
             CILO_CL = Mean_CL - 1.96*SE_CL,
             CIHI_CL = Mean_CL + 1.96*SE_CL) %>% 
      gather(Mean, value, Mean_SO4:CIHI_CL) %>% 
      separate(Mean, c("Type", "Class"), sep ="_") %>% 
      spread(Class, value)

library(MASS)
names(lovett)
hub_vals<-apply(lovett[,c("SO4","SO4MOD","CL")], 2, function(x) huber(x)$mu)

names(hub_vals)<- c("SO4","SO4mod","CL")

hub_vals2<-data.frame(Type = "Huber", rbind(hub_vals))

lovett_sum <- rbind(lovett_sum, hub_vals2)