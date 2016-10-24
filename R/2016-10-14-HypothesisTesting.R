# Estimation of parameters
# 10-14-2016

.libPaths("P:/RLibrary")

library(tidyverse)
library(RCurl)

# Sum of squares (Ordinary Least Squares[OLS])
  # Simple, no assumptions about uncertainty
  # Long history of use in science
  # Computers make this easy to calculate

set.seed(12345)

fake_data <- data.frame(x = rpois(30,5))
fake_data$y <- fake_data$x *2 + rnorm(30, sd = 2)


ggplot(data = fake_data) +
  geom_point(aes(x = x, y = y), size = 2, color = "blue") +
  theme_bw()

start.val <- -2
max.val <- 6

poss.vals<- seq(start.val, max.val, by=0.01)

length(poss.vals)

SS_stor <- data.frame(poss.vals = poss.vals, SS = NA)
head(SS_stor)

for(i in 1:length(poss.vals)){
  pred.vals <-fake_data$x * poss.vals[i]
  
  SS_stor$SS[i] <- sum((pred.vals - fake_data$y)^2)
  
}

beta_val<- SS_stor[which(SS_stor$SS==min(SS_stor$SS)),]

ggplot(data = SS_stor) +
  geom_line(aes(x = poss.vals, y = SS), size = 1, colour = "red") + 
  geom_vline(aes(xintercept = beta_val$poss.vals), linetype = "dashed") + 
  annotate("text", x = 2.01, y=10000, label = paste("beta value is =",beta_val$poss.vals, sep = " ")) +
  theme_bw()

# Challenge 1

set.seed(456789)

fake_data2<-data.frame(x1 = rpois(50,5), x2 = rpois(50,2))
fake_data2$y <- fake_data2$x1 *2 + rnorm(50, sd = 2) + fake_data2$x2 *-4 + rnorm(50, sd = 2)

start.val1<- -4
max.val1 <- 6
  
start.val2<- -8
max.val2<- 8

poss.vals.x1 <- seq(start.val1,max.val1, by = 0.5)
poss.vals.x2 <- seq(start.val2,max.val2, by = 0.5)

SS_stor2 <- expand.grid(x1 =poss.vals.x1, x2 = poss.vals.x2, SS = NA )

for(i in 1:nrow(SS_stor2)){
  print(i)
  pred.vals2 <- fake_data2$x1 *SS_stor2$x1[i] +  fake_data2$x2 *SS_stor2$x2[i]
  
  SS_stor2$SS[i] <- sum((fake_data2$y - pred.vals2)^2)
}

beta_vals2<- SS_stor2[which(SS_stor2$SS==min(SS_stor2$SS)),]

height_data<- data.frame(ind = 1:10, height = c(171,168,180,190,169,172,162,181,181,177))

m <- seq(160,200, by = 0.25)

data_stor<- data.frame(m = m, ll = NA)

for(i in 1:length(m)){
  ll <- length(height_data$height)*(log(10) + 1/2* log(2*pi)) + sum((height_data$height - m[i])^2/200)

  data_stor$ll[i] <- ll
  
  }

# Hyptothsis tests for a single population

set.seed(12345)

data_of_pop <- data.frame(ind = 1:1000, height = rnorm(1000,mean = 65, sd = 3.5))

head(data_of_pop)

rand_sample <- data_of_pop[sample(1:nrow(data_of_pop),100, replace = F),]

mean_height = mean(rand_sample$height)
sd_height = sd(rand_sample$height)
se_height = sd_height/sqrt(length(rand_sample$height))

t = (mean_height - 58)/se_height

qt(0.975, df = 100-1)

t.test(rand_sample$height, mu = 58)

set.seed(4321)
test.group <- rbind(data.frame(grp = "A", value = rnorm(15,mean=22, sd = 3)),
                    data.frame(grp = "B", value = rnorm(20,mean=30, sd = 3)))

# independent 2-group test
t.test(test.group$value ~ test.group$grp, var.equal = TRUE)
t.test(test.group$value ~ test.group$grp, var.equal = FALSE)

t.test(test.group$value[test.group$grp=="A"], test.group$value[test.group$grp=="B"], var.equal = FALSE)

# paired t test

library(MASS)

head(immer)

t.test(immer$Y1, immer$Y2, paired=TRUE)

## resampling

install.packages("boot")
library(boot)


org_counts <- data.frame(grp1 = rpois(30, lambda = 15),
                         grp2 = rpois(30, lambda = 20))

diff.means <- function(x, w){
  m1 = mean(x$grp1[w])
  m2 = mean(x$grp2[w])
  
  diff_means = m1 - m2
  return(diff_means)
  }

boot_result <- boot(org_counts, diff.means, R = 5000)
boot_result

names(boot_result)

boot_result$t0
head(boot_result$t)

data2<- data.frame(values =boot_result$t )

ggplot(data = data2) + 
  geom_histogram(aes(x = values), bins = 50, fill="dodgerblue") + 
  geom_vline(aes(xintercept = boot_result$t0), colour = "red") + 
  theme_bw()

sum(boot_result$t >= 0)/length(boot_result$t)
