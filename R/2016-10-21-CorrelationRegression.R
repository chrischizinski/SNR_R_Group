.libPaths("P:/RLibrary")

library(RCurl)
library(tidyverse)
library(MASS)


set.seed(123456)

mean.x <- 70
sd.x <- 3

mean.y <- 162
sd.y <- 14

r = 0.55

z1 <-rnorm(100)
z2 <-rnorm(100)

x1 <- sqrt(1-r^2)*sd.x*z1 + r*sd.x*z2 + mean.x
y1 <- sd.y*z2 + mean.y


r = 0.9
x2 <- sqrt(1-r^2)*sd.x*z1 + r*sd.x*z2 + mean.x
y2 <- sd.y*z2 + mean.y

data_for_plot<- rbind(data.frame(x = x1, y = y1, r = 0.55),
                      data.frame(x = x2, y = y2, r = 0.90))

data_for_plot %>% 
  gather(var, val, x:y) %>% 
  ggplot() + 
  geom_density(aes(x = val, fill = var), alpha = 0.5) +
  facet_wrap(~r, ncol = 1, labeller = label_both) + 
  theme_bw()


ggplot(data=data_for_plot)  +
  geom_point(aes(x = x, y = y), size = 1) +
  facet_wrap(~r, ncol = 1, labeller = label_both) + 
  theme_bw()


### Covariance 
dev.x <- x1 - mean(x1)
dev.y <- y1 - mean(y1)

sum(dev.x * dev.y)/ (length(x1) -1)

cov(x1,y1)

cov(x1*100,y1*100)


### Pearson correlation
sum(dev.x * dev.y) / sqrt(sum(dev.x^2)*sum(dev.y^2))

cor(x1,y1,method = "pearson")
cor.test(x1,y1,method = "pearson")

## Spearman

r_x1 <- rank(x1)
r_y1 <- rank(y1)

cor(r_x1, r_y1)
cor(x1,y1, method ="spearman")

cor(x1,y1, method = "kendall")

