---
title: "Simple regression"
output: html_document
---



The RMarkdown file for this lesson can be found [here](https://raw.githubusercontent.com/chrischizinski/SNR_R_Group/master/Rmd/2016-10-28-SimpleRegression.Rmd).

This lesson will follow Chapter 5 in Quinn and Keough (2002).

Load the packages we will be using in this lesson


{% highlight r %}
library(MASS)
library(car)
library(RCurl)
library(mgcv)
library(tidyverse)
library(broom)
library(Rfit)
library(mgcv)
library(gtable)
library(lmodel2)
{% endhighlight %}


## Linear regression analysis

Statistical models that assume a linear relationship between a single, continuous (usually) predictor value are *simple linear regression* models.  

These models have three primary purposes:

- describe a linear relationship between \\( Y \\) and \\( X \\)
- determine the amount of variation (explained) in \\( Y \\) with \\( X \\) and the amount of variation unexplained
- predict values of \\( Y \\) from \\( X \\)

### Simple bivariate linear regression

#### Linear model for regression

Consider you have a set of observations (\\( i = 1 :n \\) ), where the each observation was chosen based on its  \\( X \\) value and its \\( Y \\) value for each observation is sampled from a population of possible \\( Y \\) values.

This model can be represented as:

$$ y_i = \beta_0 + \beta_1 x_i + \epsilon_i  $$  

- \\( y_i \\) is the value of  \\( Y \\) for the *i*th observation when the predictor  \\( X = x_i \\)
- \\( \beta_0 \\) is the population intercept (i.e., mean value of the probability distribution) when \\( x_i = 0\\)
- \\( \beta_1 \\) is the population slope and measures the change in \\( Y \\) with a change in \\( X \\)
- \\( \epsilon_i \\) is the random or unexplained error associated with the *i*th observation

In this model, the response variable \\( Y \\) is a random variable and \\( X \\) represents fixed values choed by the researcher.  Thus repeated sampling, you would have the same values of \\( X \\) while \\( Y \\) would vary.  

#### Estimating model parameters

The main goal in regression analysis is estimating \\( \beta_0 \\),  \\( \beta_1 \\), and \\( \sigma_\epsilon^2 \\).

We discussed solving for \\( \beta_0 \\) and \\( \beta_1 \\) using   OLS in an [earlier lesson](https://chrischizinski.github.io/SNR_R_Group/2016-10-07-REstimation2)

##### Regression slope

The most informative of the parameters in a regression equation is \\( \beta_{1} \\), because this describes the relationship between \\( Y \\) and \\( X \\).

##### Intercept

The OLS regression line must pass through  \\( \bar{x} \\) and \\( \bar{y} \\).  We can then estimate \\( \beta_{0} \\) by substituting in \\( \beta_{1} \\), \\( \bar{x} \\) and \\( \bar{y} \\).

Often the intercept does not contain a lot of usable information because rarely do we have situations where \\( X = 0 \\).

Lets begin to explore this with the coarse woody debris data in lakes.  `christ` data in `Chap 5` on github.  


{% highlight r %}
cwd_data <- read_csv(getURL('https://raw.githubusercontent.com/chrischizinski/SNR_R_Group/master/data/ExperimentalDesignData/chpt5/christ.csv'))

glimpse(cwd_data)
{% endhighlight %}



{% highlight text %}
## Observations: 0
## Variables: 1
## $ 404: Not Found <chr>
{% endhighlight %}



{% highlight r %}
ggplot(data = cwd_data) + 
  geom_point(aes(x = RIP.DENS, y = CWD.DENS), size = 2) +
  labs(x = "Riparian tree density", y ="Coarse woody debris density") +
  theme_bw()
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'RIP.DENS' not found
{% endhighlight %}

![plot of chunk unnamed-chunk-2](/SNR_R_Group/figs/2016-10-28-SimpleRegression/unnamed-chunk-2-1.png)

`lm()' is the function in R to conduct simple linear regression.


{% highlight r %}
mod_cwd <- lm(CWD.DENS ~  RIP.DENS, data = cwd_data)
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'CWD.DENS' not found
{% endhighlight %}



{% highlight r %}
mod_cwd # displays the coefficients
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'mod_cwd' not found
{% endhighlight %}



{% highlight r %}
summary(mod_cwd) # displays a bunch more information
{% endhighlight %}



{% highlight text %}
## Error in summary(mod_cwd): object 'mod_cwd' not found
{% endhighlight %}

There is a lot of information stored in our object `mod_cwd`.


{% highlight r %}
names(mod_cwd)
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'mod_cwd' not found
{% endhighlight %}

We can call on these directly from our `mod_cwd` or use several 'helper' functions.


{% highlight r %}
# Coefficients
mod_cwd$coefficients
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'mod_cwd' not found
{% endhighlight %}



{% highlight r %}
#or
coef(mod_cwd)
{% endhighlight %}



{% highlight text %}
## Error in coef(mod_cwd): object 'mod_cwd' not found
{% endhighlight %}



{% highlight r %}
# Residuals
mod_cwd$residuals[1:10]  # display the first 10 residuals
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'mod_cwd' not found
{% endhighlight %}



{% highlight r %}
#or
resid(mod_cwd)[1:10]
{% endhighlight %}



{% highlight text %}
## Error in resid(mod_cwd): object 'mod_cwd' not found
{% endhighlight %}



{% highlight r %}
mod_cwd$model
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'mod_cwd' not found
{% endhighlight %}

The `broom` package makes inspection of the models a bit easier (although they are not too difficult) in base R.  The biggest plus for broom, is that the outputs of the models are returned in a tidy format. 


{% highlight r %}
# tidy will give you a data.frame representation
tidy(mod_cwd)
{% endhighlight %}



{% highlight text %}
## Error in tidy(mod_cwd): object 'mod_cwd' not found
{% endhighlight %}



{% highlight r %}
# augment will give fitted values and residuals for each of the original points in the regression

head(augment(mod_cwd))
{% endhighlight %}



{% highlight text %}
## Error in augment(mod_cwd): object 'mod_cwd' not found
{% endhighlight %}



{% highlight r %}
#glance will let you see the statistics associated with the model
glance(mod_cwd)
{% endhighlight %}



{% highlight text %}
## Error in glance(mod_cwd): object 'mod_cwd' not found
{% endhighlight %}

##### Confidence intervals

Confidence intervals for \\( \beta_{1} \\) are calculated in the usual manner when we know the standard error of a statistic and use the t distribution.

This can be represented as a confidence band (e.g. 95%) for the regression line.  The 95% confidence band is a band that will contain the true population regression line 95% of the time. 

We can display our confidence intervals using `geom_smooth` in ggplot.  


{% highlight r %}
ggplot(data = cwd_data) + 
  geom_point(aes(x = RIP.DENS, y = CWD.DENS), size = 2) +
  geom_smooth(aes(x = RIP.DENS, y = CWD.DENS), method = 'lm', alpha = 0.35) +
  labs(x = "Riparian tree density", y ="Coarse woody debris density", title = "Linear model fit") +
  theme_bw()
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'RIP.DENS' not found
{% endhighlight %}

![plot of chunk unnamed-chunk-7](/SNR_R_Group/figs/2016-10-28-SimpleRegression/unnamed-chunk-7-1.png)

We can also use `geom_smooth` to explore other non-linear relationships between \\( X \\) and \\( Y \\).


{% highlight r %}
ggplot(data = cwd_data) + 
  geom_point(aes(x = RIP.DENS, y = CWD.DENS), size = 2) +
  geom_smooth(aes(x = RIP.DENS, y = CWD.DENS), method = 'loess', alpha = 0.35) +
  labs(x = "Riparian tree density", y ="Coarse woody debris density", title = "Loess fit") +
  theme_bw()
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'RIP.DENS' not found
{% endhighlight %}



{% highlight r %}
# or via a GAM

ggplot(data = cwd_data) + 
  geom_point(aes(x = RIP.DENS, y = CWD.DENS), size = 2) +
  geom_smooth(aes(x = RIP.DENS, y = CWD.DENS), method = 'gam', alpha = 0.35) +
  labs(x = "Riparian tree density", y ="Coarse woody debris density", title = "GAM fit") +
  theme_bw()
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'RIP.DENS' not found
{% endhighlight %}

![plot of chunk unnamed-chunk-8](/SNR_R_Group/figs/2016-10-28-SimpleRegression/unnamed-chunk-8-1.png)

While using `geom_smooth` makes nice visuals, I think you have a lot more flexibility when you build your own predictions.  The `predict()` function is one of my favorite functions in R.  

##### Predicted values 

Prediction from the OLS regression equation is straightforward by substituting an X-value into the regression equation and calculating the predicted Y-value. Do not predict from X-values outside the range of your data.

If we run the `predict()` with just the model, we get results the same as in the `fitted.values`.  


{% highlight r %}
pred_values <- predict(mod_cwd)
{% endhighlight %}



{% highlight text %}
## Error in predict(mod_cwd): object 'mod_cwd' not found
{% endhighlight %}



{% highlight r %}
head(pred_values)
{% endhighlight %}



{% highlight text %}
## Error in head(pred_values): object 'pred_values' not found
{% endhighlight %}



{% highlight r %}
# pulling out the values using augment
head(augment(mod_cwd)$.fitted)
{% endhighlight %}



{% highlight text %}
## Error in augment(mod_cwd): object 'mod_cwd' not found
{% endhighlight %}

It helps to bind, your predictions (and the standard error) with those from your original data.  **NOTE**:  that augment already does this for you.  


{% highlight r %}
fitted_vals <- cbind(cwd_data[,c("RIP.DENS","CWD.DENS")],predict(mod_cwd, se.fit = TRUE))
{% endhighlight %}



{% highlight text %}
## Error: Unknown columns 'RIP.DENS', 'CWD.DENS'
{% endhighlight %}



{% highlight r %}
ggplot(data = fitted_vals) + 
  geom_point(aes(x = RIP.DENS, y = CWD.DENS), size = 2) +
  geom_ribbon(aes(x = RIP.DENS, ymax = fit + 1.96*se.fit, ymin = fit - 1.96*se.fit), fill="#0E3386", alpha = 0.5) +
  geom_line(aes(x = RIP.DENS, y = fit), color = "#D12325", size = 1, linetype = "dashed") +
  coord_cartesian(ylim = c(0, 1000), expand = FALSE)  +
  scale_y_continuous(breaks = seq(0,1000, by = 250)) +
  labs(x = "Riparian tree density", y ="Coarse woody debris density") +
  theme_bw()
{% endhighlight %}



{% highlight text %}
## Error in ggplot(data = fitted_vals): object 'fitted_vals' not found
{% endhighlight %}

While these values are helpful in displaying the basic model fit, there are often times (especially when doing multiple linear regression) when you want to look at predictions based off specific values.  We can do this by using the `newdata` in `predict()`.  **NOTE** that the column header names need to reflect the independent values in your model.  


{% highlight r %}
nd <- data.frame(RIP.DENS = 800:2100)

fitted_vals <- cbind(nd,predict(mod_cwd,newdata = nd, se.fit = TRUE))
{% endhighlight %}



{% highlight text %}
## Error in predict(mod_cwd, newdata = nd, se.fit = TRUE): object 'mod_cwd' not found
{% endhighlight %}



{% highlight r %}
head(fitted_vals)
{% endhighlight %}



{% highlight text %}
## Error in head(fitted_vals): object 'fitted_vals' not found
{% endhighlight %}



{% highlight r %}
ggplot(data = fitted_vals) + 
  geom_ribbon(aes(x = RIP.DENS, ymax = fit + 1.96*se.fit, ymin = fit - 1.96*se.fit), fill="#ED174C", alpha = 0.5) +
  geom_line(aes(x = RIP.DENS, y = fit), color = "#002B5C", size = 1, linetype = "dashed") +
  coord_cartesian(ylim = c(0, 1000), expand = FALSE)  +
  scale_y_continuous(breaks = seq(0,1000, by = 250)) +
  labs(x = "Riparian tree density", y ="Coarse woody debris density") +
  theme_bw()
{% endhighlight %}



{% highlight text %}
## Error in ggplot(data = fitted_vals): object 'fitted_vals' not found
{% endhighlight %}


##### Residuals

This difference between each observed  \\( y_{i} \\) and each predicted \\( \hat{y_i} \\) is called a residual \\( e_{i} \\):

$$ e_i = y_i - \hat{y_i} $$


{% highlight r %}
fitted_vals <- cbind(cwd_data[,c("RIP.DENS","CWD.DENS")],predict(mod_cwd, se.fit = TRUE))
{% endhighlight %}



{% highlight text %}
## Error: Unknown columns 'RIP.DENS', 'CWD.DENS'
{% endhighlight %}



{% highlight r %}
ggplot(data = fitted_vals) +
    geom_segment(aes(x = RIP.DENS, xend = RIP.DENS,  y = CWD.DENS, yend = fit), linetype = 'dotted', alpha = 0.5) +
  geom_point(aes(x = RIP.DENS, y = CWD.DENS), size = 1, colour ="black") + 
  geom_point(aes(x = RIP.DENS, y = fit), size = 1, colour ="red") + 
  labs(x = "Riparian tree density", y ="Coarse woody debris density") +
  theme_bw()
{% endhighlight %}



{% highlight text %}
## Error in ggplot(data = fitted_vals): object 'fitted_vals' not found
{% endhighlight %}

#### Analysis of variance

In biological sciences we often want to partition the total variation in \\( Y \\) in part to \\( X \\) and the other part to the unexplained variation.   The partitioned variance is often presented as an analysis of variance (ANOVA) table.

- Total variation in  \\( Y \\)  is the sum of squared deviations of each observation from the sample mean
- \\( SS_{total} \\) has n-1 df and can be partitioned into two additive components

1. Variation in \\( Y \\) explained by  \\( X \\) (difference between \\( \hat{y_i} \\)  and \\( \bar{y} \\).  The number of degrees of freedom associated with a linear model is usually the number of parameters minus one. 

2. Variation in \\( Y \\) *not* explained by \\( X \\) (difference between each observed Y-value and \\( \hat{y_i} \\). Residual (or error) variation.  The \\( df_{residual} \\) is n-2, because we have already estimated \\( \beta_0 \\) and \\( \beta_1 \\) to determine the \\( \hat{y_i} \\).

- The SS and df are additive 



{% highlight r %}
ggplot(data = fitted_vals) +
    geom_segment(data = fitted_vals[fitted_vals$RIP.DENS==1400,],
                 aes(x = RIP.DENS, xend = RIP.DENS,  y = CWD.DENS, yend = fit), linetype = 'dotted') +
  geom_segment(data = fitted_vals[fitted_vals$RIP.DENS==1800,],
                 aes(x = RIP.DENS, xend = RIP.DENS,  y = mean(fitted_vals$CWD.DENS), yend = fit), linetype = 'dotted') +
  geom_point(aes(x = RIP.DENS, y = CWD.DENS), size = 1, colour ="black") + 
  geom_point(aes(x = RIP.DENS, y = fit), size = 1, colour ="red") + 
  labs(x = "Riparian tree density", y ="Coarse woody debris density") +
  annotate("text", x = 1800, y = mean(fitted_vals$CWD.DENS), label = ' hat(y)[1800]~-~bar(y)', parse =TRUE) +
  annotate("text", x = 1400, y = fitted_vals$CWD.DENS[fitted_vals$RIP.DENS==1400], label = ' hat(y)[1400]~-~Y[1400]', parse =TRUE) +
  theme_bw()
{% endhighlight %}



{% highlight text %}
## Error in ggplot(data = fitted_vals): object 'fitted_vals' not found
{% endhighlight %}

- The \\( SS_{total} \\) increases with sample size.  The Mean SS is a measure of variability that does not depend on sample size.  MS is calculated by dividing SS by their df and thus, are not additive.  

- The \\( MS_{Residual} \\) estimates the common variance of the error terms \\( e_{i} \\), and therefore of the Y-values at each \\( x_i \\).  **NOTE** a key assumption is homogeneity of variances. 

We can calculate the ANOVA table from our linear model in R by using the `anova()` statment. 


{% highlight r %}
tidy(anova(mod_cwd))
{% endhighlight %}



{% highlight text %}
## Error in anova(mod_cwd): object 'mod_cwd' not found
{% endhighlight %}

#### Variance explaned ( \\(r^2\\) or \\( R^2 \\))

- descriptive measure of association between Y and X (also termed coefficient of variation). the proportion of the total variation in Y that is explained by its linear relationship with X. 

- \\( 1 = \frac{SS_{residual}}{SS_{total}} \\)

####  Scatterplot with marginal boxplots


{% highlight r %}
## Create the base scatterplot

p1 <- ggplot(data = cwd_data) + 
   geom_point(aes(x = RIP.DENS, y = CWD.DENS)) + 
   scale_x_continuous(expand = c(0, 0)) + 
   scale_y_continuous(expand = c(0, 0)) +
   coord_cartesian(xlim = c(700,2300), ylim = c(0,1000)) +
   theme_bw() +
   theme(plot.margin = unit(c(0.2, 0.2, 0.5, 0.5), "lines"))

# horizontal marginal boxplots

p2 <- ggplot(data = cwd_data) + 
   geom_boxplot(aes(x = factor(1),y = RIP.DENS), outlier.colour = "red") + 
   geom_jitter(aes(x = factor(1),y = RIP.DENS),position = position_jitter(width = 0.05)) + 
   scale_y_continuous(expand = c(0, 0))  +
   coord_flip(ylim = c(700,2300)) + 
   theme_void() +
   theme(axis.text = element_blank(), 
         axis.title = element_blank(), 
         axis.ticks = element_blank(), 
         plot.margin = unit(c(1, 0.2, -0.5, 0.5), "lines"))

# vertical marginal boxplots

p3 <- ggplot(data = cwd_data) + 
   geom_boxplot(aes(x = factor(1),y = CWD.DENS), outlier.colour = "red") + 
   geom_jitter(aes(x = factor(1),y = CWD.DENS),position = position_jitter(width = 0.05)) + 
   scale_y_continuous(expand = c(0, 0)) +
  coord_cartesian( ylim = c(0,1000)) +
  theme_void() +
   theme(axis.text = element_blank(), 
         axis.title = element_blank(), 
         axis.ticks = element_blank(), 
         plot.margin = unit(c(0.2, 1, 0.5, -0.5), "lines"))
{% endhighlight %}


{% highlight r %}
gt1 <- ggplot_gtable(ggplot_build(p1))
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'RIP.DENS' not found
{% endhighlight %}



{% highlight r %}
gt2 <- ggplot_gtable(ggplot_build(p2))
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'RIP.DENS' not found
{% endhighlight %}



{% highlight r %}
gt3 <- ggplot_gtable(ggplot_build(p3))
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'CWD.DENS' not found
{% endhighlight %}



{% highlight r %}
# Get maximum widths and heights
maxWidth <- unit.pmax(gt1$widths[2:3], gt2$widths[2:3])
{% endhighlight %}



{% highlight text %}
## Error in unit.pmax(gt1$widths[2:3], gt2$widths[2:3]): object 'gt1' not found
{% endhighlight %}



{% highlight r %}
maxHeight <- unit.pmax(gt1$heights[4:5], gt3$heights[4:5])
{% endhighlight %}



{% highlight text %}
## Error in unit.pmax(gt1$heights[4:5], gt3$heights[4:5]): object 'gt1' not found
{% endhighlight %}



{% highlight r %}
# Set the maximums in the gtables for gt1, gt2 and gt3
gt1$widths[2:3] <- as.list(maxWidth)
{% endhighlight %}



{% highlight text %}
## Error in as.list(maxWidth): object 'maxWidth' not found
{% endhighlight %}



{% highlight r %}
gt2$widths[2:3] <- as.list(maxWidth)
{% endhighlight %}



{% highlight text %}
## Error in as.list(maxWidth): object 'maxWidth' not found
{% endhighlight %}



{% highlight r %}
gt1$heights[4:5] <- as.list(maxHeight)
{% endhighlight %}



{% highlight text %}
## Error in as.list(maxHeight): object 'maxHeight' not found
{% endhighlight %}



{% highlight r %}
gt3$heights[4:5] <- as.list(maxHeight)
{% endhighlight %}



{% highlight text %}
## Error in as.list(maxHeight): object 'maxHeight' not found
{% endhighlight %}


{% highlight r %}
# Create a new gtable
gt <- gtable(widths = unit(c(7, 1), "null"), height = unit(c(1, 7), "null"))

# Insert gt1, gt2 and gt3 into the new gtable
gt <- gtable_add_grob(gt, gt1, 2, 1)
{% endhighlight %}



{% highlight text %}
## Error in is.grob(grobs): object 'gt1' not found
{% endhighlight %}



{% highlight r %}
gt <- gtable_add_grob(gt, gt2, 1, 1)
{% endhighlight %}



{% highlight text %}
## Error in is.grob(grobs): object 'gt2' not found
{% endhighlight %}



{% highlight r %}
gt <- gtable_add_grob(gt, gt3, 2, 2)
{% endhighlight %}



{% highlight text %}
## Error in is.grob(grobs): object 'gt3' not found
{% endhighlight %}



{% highlight r %}
# And render the plot
grid.newpage()
grid.draw(gt)
{% endhighlight %}



{% highlight text %}
## Error in mapply(child_vp, vp_name = vpname(x$layout), t = x$layout$t, : zero-length inputs cannot be mixed with those of non-zero length
{% endhighlight %}



{% highlight r %}
# grid.rect(x = 0.5, y = 0.5, height = 0.995, width = 0.995, default.units = "npc", 
#     gp = gpar(col = "black", fill = NA, lwd = 1))
{% endhighlight %}

#### Assumptions of a regression model

1. Normality (except GLMs)
2. Homogeneity of variance
3. Independence
4. Fixed X

#### Regression diagnostics  

- A proper interpretation of a linear regression analysis should also include checks of how well the model fits the observed data

1. Is a straight line appropriate?
2. Influence of outliers?
  - See-saw, balanced on the mean of X
  
##### Leverage 

- Leverage is a measure of how extreme an observation is for the \\(X \\)-variable

- Generally concerned when a value is 2 or 3 times greater than the mean value


{% highlight r %}
fitted_vals2 <- cbind(cwd_data[,c("RIP.DENS","CWD.DENS")],predict(mod_cwd, se.fit = TRUE))
{% endhighlight %}



{% highlight text %}
## Error: Unknown columns 'RIP.DENS', 'CWD.DENS'
{% endhighlight %}



{% highlight r %}
mod_hat<-hatvalues(mod_cwd)
{% endhighlight %}



{% highlight text %}
## Error in hatvalues(mod_cwd): object 'mod_cwd' not found
{% endhighlight %}



{% highlight r %}
mean_hat <- mean(mod_hat)
{% endhighlight %}



{% highlight text %}
## Error in mean(mod_hat): object 'mod_hat' not found
{% endhighlight %}



{% highlight r %}
fitted_vals2$resid.out <- 0
{% endhighlight %}



{% highlight text %}
## Error in fitted_vals2$resid.out <- 0: object 'fitted_vals2' not found
{% endhighlight %}



{% highlight r %}
fitted_vals2$resid.out[which(mod_hat > 2*mean_hat)] <- 1
{% endhighlight %}



{% highlight text %}
## Error in fitted_vals2$resid.out[which(mod_hat > 2 * mean_hat)] <- 1: object 'fitted_vals2' not found
{% endhighlight %}



{% highlight r %}
fitted_vals2$resid.out <- as.factor(fitted_vals2$resid.out )
{% endhighlight %}



{% highlight text %}
## Error in is.factor(x): object 'fitted_vals2' not found
{% endhighlight %}



{% highlight r %}
ggplot(data = fitted_vals2)  +
  geom_point(aes(x = RIP.DENS, y = CWD.DENS, colour = resid.out), size = 2) + 
  geom_line(aes(x = RIP.DENS, y = fit), color = "#002B5C", size = 1, linetype = "dashed") +
  coord_cartesian(ylim = c(0, 1000), xlim = c(750, 2200), expand = FALSE)  +
  scale_y_continuous(breaks = seq(0,1000, by = 250)) +
  labs(x = "Riparian tree density", y ="Coarse woody debris density") +
  scale_colour_manual(values = c("0" = "red", "1" = "blue")) +
  theme_bw() + 
  theme(legend.position = c(0.90, 0.25))
{% endhighlight %}



{% highlight text %}
## Error in ggplot(data = fitted_vals2): object 'fitted_vals2' not found
{% endhighlight %}


##### Residuals 

- Residuals are an important way of checking regression assumptions

- Studentized residuals do have constant variance so different studentized residuals can be compared



{% highlight r %}
std_res <- studres(mod_cwd)
{% endhighlight %}



{% highlight text %}
## Error in lmwork(object): object 'mod_cwd' not found
{% endhighlight %}



{% highlight r %}
fitted_vals2$resid.std <- std_res
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'std_res' not found
{% endhighlight %}



{% highlight r %}
ggplot(data = fitted_vals2)  +
  geom_point(aes(x = RIP.DENS, y = resid.std), size = 2) + 
  coord_cartesian(ylim = c(-4, 4), xlim = c(750, 2200), expand = FALSE)  +
  scale_y_continuous(breaks = seq(-4,4, by = 1)) +
  labs(x = "Riparian tree density", y ="Coarse woody debris density") +
  scale_colour_manual(values = c("0" = "red", "1" = "blue")) +
  theme_bw()
{% endhighlight %}



{% highlight text %}
## Error in ggplot(data = fitted_vals2): object 'fitted_vals2' not found
{% endhighlight %}



{% highlight r %}
#outlier.test in car package
outlierTest(mod_cwd)
{% endhighlight %}



{% highlight text %}
## Error in outlierTest(mod_cwd): object 'mod_cwd' not found
{% endhighlight %}


##### Influence

- Cook’s distance statistic, \\( D_i \\), is the measure of the influence each observation has on the fitted regression line and the estimates of the regression parameters.

- A large \\( D_i \\) indicates that removal of that observation would change the estimates of the regression parameters considerably


{% highlight r %}
fitted_vals3<-augment(mod_cwd)
{% endhighlight %}



{% highlight text %}
## Error in augment(mod_cwd): object 'mod_cwd' not found
{% endhighlight %}



{% highlight r %}
ggplot(data = fitted_vals3)  +
  geom_point(aes(x = RIP.DENS, y = CWD.DENS, colour = .cooksd ), size = 2) + 
  coord_cartesian(ylim = c(0, 1000), xlim = c(750, 2200), expand = FALSE)  +
  scale_y_continuous(breaks = seq(0,1000, by = 250)) +
  labs(x = "Riparian tree density", y ="Coarse woody debris density") +
  scale_colour_continuous(low = "black", high = "red") +
  theme_bw()
{% endhighlight %}



{% highlight text %}
## Error in ggplot(data = fitted_vals3): object 'fitted_vals3' not found
{% endhighlight %}


#### Weighted least squares

- Responses are averages with known sample sizes
- Responses are estimates and SEs are available
  - \\( w_i = \frac{1}{se(Y_i)^2} \\)
- Variance is proportional to X
  -  \\( w_i = \frac{1}{X_i} \\) or \\( w_i = \frac{1}{X_i^2} \\)


{% highlight r %}
set.seed(12345)

x = rnorm(100,0,3)
y = 3-2*x + rnorm(100,0,sapply(x,function(x){1+0.5*x^2}))

fake_data1 <- data.frame(x = x, y = y)

mod_1 <- lm(y ~ x, data = fake_data1)
summary(mod_1)
{% endhighlight %}



{% highlight text %}
## 
## Call:
## lm(formula = y ~ x, data = fake_data1)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -29.1365  -1.9392   0.4543   3.2609  27.8710 
## 
## Coefficients:
##             Estimate Std. Error t value    Pr(>|t|)    
## (Intercept)   2.5684     0.8601   2.986     0.00357 ** 
## x            -1.3402     0.2524  -5.310 0.000000685 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 8.398 on 98 degrees of freedom
## Multiple R-squared:  0.2234,	Adjusted R-squared:  0.2155 
## F-statistic: 28.19 on 1 and 98 DF,  p-value: 0.000000685
{% endhighlight %}



{% highlight r %}
fake_pred<-cbind(fake_data1, predict(mod_1, se.fit = TRUE))

ggplot(data = fake_pred) +
  geom_point(aes(x = x, y = y), size = 2, colour = "red") +
  geom_line(aes(x = x, y = fit), linetype = 'dashed') +
  theme_bw()
{% endhighlight %}

![plot of chunk unnamed-chunk-22](/SNR_R_Group/figs/2016-10-28-SimpleRegression/unnamed-chunk-22-1.png)

{% highlight r %}
mod_2 <- lm(y ~ x, weights= 1/(x^2), data = fake_data1)
summary(mod_2)
{% endhighlight %}



{% highlight text %}
## 
## Call:
## lm(formula = y ~ x, data = fake_data1, weights = 1/(x^2))
## 
## Weighted Residuals:
##     Min      1Q  Median      3Q     Max 
## -4.4230 -1.0989  0.1181  1.4912  4.4567 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   2.7659     0.1213  22.794  < 2e-16 ***
## x            -1.6554     0.2092  -7.911 3.92e-12 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.07 on 98 degrees of freedom
## Multiple R-squared:  0.3898,	Adjusted R-squared:  0.3835 
## F-statistic: 62.59 on 1 and 98 DF,  p-value: 3.918e-12
{% endhighlight %}



{% highlight r %}
summary(mod_1)
{% endhighlight %}



{% highlight text %}
## 
## Call:
## lm(formula = y ~ x, data = fake_data1)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -29.1365  -1.9392   0.4543   3.2609  27.8710 
## 
## Coefficients:
##             Estimate Std. Error t value    Pr(>|t|)    
## (Intercept)   2.5684     0.8601   2.986     0.00357 ** 
## x            -1.3402     0.2524  -5.310 0.000000685 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 8.398 on 98 degrees of freedom
## Multiple R-squared:  0.2234,	Adjusted R-squared:  0.2155 
## F-statistic: 28.19 on 1 and 98 DF,  p-value: 0.000000685
{% endhighlight %}



{% highlight r %}
fake_pred2<-cbind(fake_data1, predict(mod_2, se.fit = TRUE))

ggplot(data = fake_pred) +
  geom_point(aes(x = x, y = y), size = 2, colour = "red") +
  geom_line(aes(x = x, y = fit), linetype = 'dashed') +
  geom_line(data =fake_pred2, aes(x = x, y = fit), linetype = 'solid') +
  theme_bw()
{% endhighlight %}

![plot of chunk unnamed-chunk-22](/SNR_R_Group/figs/2016-10-28-SimpleRegression/unnamed-chunk-22-2.png)


#### Random X (Model II Regression)

- Both \\(X \\) and  \\(Y \\) chosen haphazardly or at random
- Model II Regression and the approach is controversial
- If the purpose of regression is **prediction**, then OLS 
- If the purpose of regression is **mechanisms**, then **not** OLS (?)
  - error variability associated with both Y \\( \sigma_{\epsilon}^2 \\) and X \\( \sigma_{\gamma}^2 \\) and the OLS estimate of \\( \beta_1 \\) is biased towards zero 
- Major axis (MA) regression fits line minimizing the sum of squared perpendicular distances from each observation to the fitted line
  - \\( \sigma_{\epsilon}^2 \\) = \\( \sigma_{\gamma}^2 \\)
- Reduced major axis (RMA) regression or standard major axis (SMA) regression is fitted by minimizing the sum of areas of the triangles formed by vertical and horizontal lines from each observation to the fitted line
 - \\( \sigma_{\epsilon}^2 \propto \sigma_x^2 \\) and \\( \sigma_{\gamma}^2 \propto \sigma_y^2\\)
 
 


{% highlight r %}
 # install.packages('lmodel2')
 
 data(mod2ex2)
 
Ex2.res <- lmodel2(Prey ~ Predators, data=mod2ex2, "relative", "relative", 99)
Ex2.res
{% endhighlight %}



{% highlight text %}
## 
## Model II regression
## 
## Call: lmodel2(formula = Prey ~ Predators, data = mod2ex2, range.y
## = "relative", range.x = "relative", nperm = 99)
## 
## n = 20   r = 0.8600787   r-square = 0.7397354 
## Parametric P-values:   2-tailed = 0.000001161748    1-tailed = 0.0000005808741 
## Angle between the two OLS regression lines = 5.106227 degrees
## 
## Permutation tests of OLS, MA, RMA slopes: 1-tailed, tail corresponding to sign
## A permutation test of r is equivalent to a permutation test of the OLS slope
## P-perm for SMA = NA because the SMA slope cannot be tested
## 
## Regression results
##   Method Intercept    Slope Angle (degrees) P-perm (1-tailed)
## 1    OLS  20.02675 2.631527        69.19283              0.01
## 2     MA  13.05968 3.465907        73.90584              0.01
## 3    SMA  16.45205 3.059635        71.90073                NA
## 4    RMA  17.25651 2.963292        71.35239              0.01
## 
## Confidence intervals
##   Method 2.5%-Intercept 97.5%-Intercept 2.5%-Slope 97.5%-Slope
## 1    OLS      12.490993        27.56251   1.858578    3.404476
## 2     MA       1.347422        19.76310   2.663101    4.868572
## 3    SMA       9.195287        22.10353   2.382810    3.928708
## 4    RMA       8.962997        23.84493   2.174260    3.956527
## 
## Eigenvalues: 269.8212 6.418234 
## 
## H statistic used for computing C.I. of MA: 0.006120651
{% endhighlight %}

- Simulated comparisons of  OLS, MA and RMA regression analyses when X is random indicated:
1. RMA estimate of \\( /beta_1 )\\ is less biased than the MA estimate
2. If the error variability in X is more than ~ a third of the error variability in Y, then RMA is the preferred method; otherwise OLS is acceptable

#### Robust regression 

- Limitation of OLS is that the estimates of model parameters, and therefore subsequent hypothesis tests, can be sensitive to distributional assumptions and affected by outlying observations

##### Least absolute deviance (LAD)

-  Minimize the sum of absolute values of the residuals rather than the sum of squared residuals 
    - not squaring the residuals, extreme observations have less influence on the fitted model
    
##### M-estimator

- M-estimators involve minimizing the sum of some function of \\( e_i \\)
- Huber M-estimators, [described earlier](https://chrischizinski.github.io/SNR_R_Group/2016-10-07-REstimation), weight the observations differently depending how far they are from the central tendency


{% highlight r %}
crime_data <- read_csv(getURL("https://raw.githubusercontent.com/chrischizinski/SNR_R_Group/master/data/crime_data.csv"))
head(crime_data)
{% endhighlight %}



{% highlight text %}
## # A tibble: 6 × 9
##     sid state crime murder pctmetro pctwhite pcths poverty single
##   <dbl> <chr> <int>  <dbl>    <dbl>    <dbl> <dbl>   <dbl>  <dbl>
## 1     1    ak   761    9.0     41.8     75.2  86.6     9.1   14.3
## 2     2    al   780   11.6     67.4     73.5  66.9    17.4   11.5
## 3     3    ar   593   10.2     44.7     82.9  66.3    20.0   10.7
## 4     4    az   715    8.6     84.7     88.6  78.7    15.4   12.1
## 5     5    ca  1078   13.1     96.7     79.3  76.2    18.2   12.5
## 6     6    co   567    5.8     81.8     92.5  84.4     9.9   12.1
{% endhighlight %}



{% highlight r %}
crime_mod <- lm(crime ~ single, data = crime_data)
summary(crime_mod)
{% endhighlight %}



{% highlight text %}
## 
## Call:
## lm(formula = crime ~ single, data = crime_data)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -767.42 -116.82  -20.58  125.28  719.70 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -1362.53     186.23  -7.316 2.15e-09 ***
## single        174.42      16.17  10.788 1.53e-14 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 242.5 on 49 degrees of freedom
## Multiple R-squared:  0.7037,	Adjusted R-squared:  0.6977 
## F-statistic: 116.4 on 1 and 49 DF,  p-value: 1.529e-14
{% endhighlight %}



{% highlight r %}
crime_fit <- data.frame(state = crime_data$state, augment(crime_mod))
{% endhighlight %}


{% highlight r %}
ggplot(data = crime_fit) +
  geom_line(aes(x = single,  y = .fitted), color = "red") +
  geom_point(aes(x = single,  y = crime, colour = .std.resid ), size = 2) +
  geom_text(aes(x = single,  y = crime, label = state ), hjust = 0, vjust = 1) +
  scale_colour_continuous(low = "red", high = "blue") +
  theme_bw()
{% endhighlight %}

![plot of chunk unnamed-chunk-25](/SNR_R_Group/figs/2016-10-28-SimpleRegression/unnamed-chunk-25-1.png)


{% highlight r %}
mod_huber <- rlm(crime ~ single, data = crime_data)
summary(mod_huber)
{% endhighlight %}



{% highlight text %}
## 
## Call: rlm(formula = crime ~ single, data = crime_data)
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -797.489 -130.956   -9.108  127.019  716.664 
## 
## Coefficients:
##             Value      Std. Error t value   
## (Intercept) -1429.3999   164.1623    -8.7072
## single        181.0128    14.2519    12.7010
## 
## Residual standard error: 192.9 on 49 degrees of freedom
{% endhighlight %}



{% highlight r %}
huber_dat<-data.frame(state = crime_data$state, augment(mod_huber), weight = mod_huber$w)
{% endhighlight %}



{% highlight r %}
ggplot(data = huber_dat) +
  geom_line(aes(x = single,  y = .fitted), color = "red") +
  geom_point(aes(x = single,  y = crime, colour = weight ), size = 2) +
  geom_text(aes(x = single,  y = crime, label = state ), hjust = 0, vjust = 1) +
  scale_colour_continuous(low = "red", high = "blue") +
  theme_bw()
{% endhighlight %}

![plot of chunk unnamed-chunk-27](/SNR_R_Group/figs/2016-10-28-SimpleRegression/unnamed-chunk-27-1.png)

#### Rank-based regression

- Does not assume any specific distribution of the error terms but still fits the usual linear regression model
    - Transformations are either ineffective or misrepresent the underlying biological process


{% highlight r %}
# install.packages("Rfit")

mod_rank <- rfit(crime ~ single, data = crime_data)
summary(mod_rank)
{% endhighlight %}



{% highlight text %}
## Call:
## rfit.default(formula = crime ~ single, data = crime_data)
## 
## Coefficients:
##              Estimate Std. Error t.value   p.value    
## (Intercept) -1400.923    182.905 -7.6593 6.362e-10 ***
## single        176.538     15.861 11.1305 5.109e-15 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## Overall Wald Test: 123.8871 p-value: 0
{% endhighlight %}

### Relationship between regression and correlation

- Simple correlation analysis is used when we seek to  measure the strength of the linear relationship (the correlation coefficient) between the two variables 
- Regression analysis is used when we  can biologically distinguish a response \\(( Y \\) to a predictor variable \\( X \\) 
    - We can construct a model relating \\(( Y \\) to \\( X \\) and this to predict \\(( Y \\) from \\( X \\)
