options(stringsAsFactors = FALSE)
.libPaths("P:/RLibrary")

library(tidyverse)

set.seed(9302016)

rand_data <- data.frame(obs = 1:999, concentration = rnorm(999, 113, 16))
head(rand_data)

min(rand_data$concentration)
max(rand_data$concentration)\

ggplot() +
  geom_histogram(data = rand_data, aes(x = concentration), bins = 50, fill = "dodgerblue", colour = "black") +
  theme_bw()

ggplot() +
  geom_histogram(data = rand_data, aes(x = concentration), binwidth = 5, fill = "firebrick", colour = "black") +
  theme_bw()

summ_data <- rand_data %>% 
             mutate(bin = cut(concentration, breaks =seq(50,175,by=5), labels = seq(50,170,by=5))) %>%
             group_by(bin) %>% 
             summarise(N = n()) %>% 
             ungroup() %>% 
             mutate(bin = as.numeric(as.character(bin)))

ggplot() +
  geom_bar(data = summ_data, aes(x = bin, y = N), stat = "identity", fill = "blue", colour = "black", width = 5) +
  labs(x = "Concentration", y = "Frequency", title = "Histogram") +
  theme_bw()
  
  
cut(rand_data$concentration, seq(50,175))

# L-estimator
# mean

sum(rand_data$concentration)/length(rand_data$concentration)
mean(rand_data$concentration)

# median
conc_order<- rand_data$concentration[order(rand_data$concentration)]
conc_order[500]
median(rand_data$concentration)


# trimmed mean
concentration <- c(2,4,6,7,11,21,81,90,105,121)
concentration <- concentration[order(concentration)]

length(concentration) * 0.10

concentration[-c(1,10)]
mean(concentration[-c(1,10)])

mean(concentration, trim = 0.1)

install.packages('psych')
library(psych)

winsor.mean(concentration, trim = 0.1)

install.packages("MASS")
library(MASS)

data(chem)
chem

chem_data <- data.frame(ind = 1:length(chem), chem = chem)

ggplot() + 
  geom_point(data = chem_data, aes(x = ind, y = chem), size = 2, colour="red") +
  theme_bw()

mean(chem)

huber(chem)

# hodges lehman estimator
fake_data <- rpois(20 , 10)

# all possible combination
all_combos <- expand.grid(x = fake_data, y = fake_data)
all_combos$mean <- apply(all_combos, 1, mean)

median(all_combos$mean)

wilcox.test(fake_data, conf.int=TRUE)$estimate
median(fake_data)


# Spread in data
range(rand_data$concentration)

# variance 
sum_squares <- sum((rand_data$concentration - mean(rand_data$concentration))^2)
  
sum_squares / (length(rand_data$concentration) - 1)
var(rand_data$concentration)

# standard deviation
sqrt(var(rand_data$concentration))
sd(rand_data$concentration)

# Coefficient of variation
sd(rand_data$concentration)/mean(rand_data$concentration)

#median absolute deviation
abs_deviation <- abs(rand_data$concentration - median(rand_data$concentration))
median(abs_deviation) * 1.4826
sd(rand_data$concentration)

mad(rand_data$concentration)

# interquartile range 
quantz <-  quantile(rand_data$concentration, c(0.75, 0.25))
quantz[1] - quantz[2]

IQR(rand_data$concentration)


# standard error
se <- sd(rand_data$concentration)/ sqrt(length(rand_data$concentration))
se


abs(qt(0.005, 10000)) # 99% confidence interval
abs(qt(0.025, 10000)) # 95% confidence interval
abs(qt(0.050, 10000)) # 90% confidence interval
abs(qt(0.10, 10000))  # 80% confidence interval

## Graphing SE vs SD

set.seed(12345)
x_data<- data.frame(obs= 1:100, val = rnorm(100))
head(x_data)

mean_conc<- mean(x_data$val)
sd_conc<- sd(x_data$val)
se_conc<- sd(x_data$val)/sqrt(length(x_data$val))


ggplot() +
  geom_histogram(data = x_data, aes(x = val), 
                 bins = 30, fill = "firebrick", colour = "black", alpha = 0.5) +
  geom_errorbarh(aes(xmin = mean_conc - 1.96*se_conc,xmax = mean_conc + 1.96*se_conc, y = 11, x =mean_conc), colour = "black") + 
  geom_point(aes(x = mean_conc, y=11), size = 2, colour = "black") +
  geom_errorbarh(aes(xmin = mean_conc - 1.96*sd_conc,xmax = mean_conc + 1.96*sd_conc, y = 7, x =mean_conc), colour = "red") + 
  geom_point(aes(x = mean_conc, y=7), size = 2, colour = "red") +
  annotate("text", x = c(0.5,2), y = c(11,7), label = c("SE", "SD")) +
  coord_cartesian(ylim = c(0,15), expand = FALSE) +
  theme_bw()

## Resampling techniques
# Jackknifing
set.seed(4321)

rand_data <- data.frame(x = 1:75, val = rnorm(75, mean= 10, sd = 3))
head(rand_data)

stor_vals <- data.frame(iter = 1:nrow(rand_data), j_mean = NA)
head(stor_vals)

for( i in 1:nrow(rand_data)){
  print(i)
  sub_rand <- rand_data[-i,]
  mean_val<-mean(sub_rand$val)
  stor_vals$j_mean[i] <- mean_val
  
}

mean(stor_vals$j_mean)
mean(rand_data$val)
