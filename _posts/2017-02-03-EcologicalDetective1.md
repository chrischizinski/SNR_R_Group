---
title: "Ecological Detective - Introduction"
output: html_document
---



## Ecological Detective

### Preface:  Beyond the Null hypothesis


### Tools of an Ecological Detective

### Classic Hypothesis Testing

- M~1~:  Boom and bust (complete extinction between colonizations) hypothesis
- M~2~:  Constant prevalance of population but only is detected when certain conditions arise 

- H~0~:  Model M1 is true
- H~A~:  Some other model is true 

Outcome: 

1. M~2~ is rejected but M~1~ is not
2. M~1~ is rejected but M~2~ is not
3. M~1~ and M~2~ are rejected
4. M~1~ and M~2~ are not rejected

What if 1 and 2 happen? 

- then you can move forward

What if 3 or 4 happen?  

- new hypothesis
- collect more data
- cry 

### Likelihood approach

- You can begin directly comparing models together

1. construct a measure of the probability of the observed data, given the model is true

    - $Pr\{data\|M_i\}$
    
2.  Likelihood is a measure of the chance that the model is true given the data 

    - $L_i\{M_i\|data\}$
    
3. Directly compare the likelihoods among competing models

    - $L_i\{M_1\|data\} \gg L_i\{M_2\|data\}$ . Model 1 is better supported than Model 2  
    - $L_i\{M_2\|data\} \gg L_i\{M_1\|data\}$ . Model 2 is better supported than Model 1
    - $L_i\{M_2\|data\} \approx L_i\{M_1\|data\}$ . Models are equally supported or not supported given the data 
    
### Bayesian approach 

- Allows for the incorporation of prior knowledge into your models 
    - "prior probability that M~i~ is true"
          - $p_i$
    - 'You are not so smart' podcast 073: Bayes Theorom
  
## Tools for Ecological Detection

1. Hypotheses:  possible explanation of mechanics underlying your observations 
2. Data:  your analyses and predictions are only as good as the data you collect
3. Goodness of fit (gof):  How well does your model predict the data.  Comparison of models does not necessarily mean that they fit the data well
4. Numerical procedures:  Need to assess gof rapidly and efficiently 


# Chapter 2:  The Scientific Method and Modelling

What are some attributes of ecological data, that make classical hypothesis testing difficult?

- Non-normal:  data comes from different distributions
- Adequate sample size is difficult to collect 
- Hard to replicate
- Hard to control the environment.  Environment changes.  
- Long time scales:  ecology and evolution operate at larger time frames 

## Distinguish between models and hypotheses 

- Hypothesis: "an unproved theory, proposition, supposition tentatively accepted  to explain certain facts or to provide the basis for further investigation"
- Theory: "a systematic statement of principles involved" or "a formulation of apparent relationships of certain observed phenomena"
- Model: "a stylized representation or a general description used in analyzing or explaining something"

Hypothesis that birds forage more efficiently in flocks than individually

- Model A:  Consumption is proportional to flock size $C = \alpha S$
- Model B:  Consumption saturates as flock size increases $$
- Model C:  Consumption increases and then decreases with increasing flock size $$






