Convergence Statistics
================
Karl Hornlund
August 14, 2018

Introduction
------------

The following is an analysis of samples sizes required to estimate a binary variable using a *95% Confidence Interval*. In particular:

*How does the width of a 95% confidence interval narrow as the number of trials increases?*

The goal is to inform decisions choosing a number of trials *N*, such that *N* is not *unnecessarily large*, while large enough to give appropriate *confidence* in estimates resulting from the trials.

Results
-------

### General Trends

The following shows the expected width of a 95% Confidence Interval, given the probability of a binary outcome *p*, and the number of trials performed *N*.

![](convergence_files/figure-markdown_github/plot01-1.png)

### Intersection with *w**i**d**t**h* = 0.05

The following shows the number of trials (*N*) required to narrow the Confidence Interval width to below 0.05, for a given probability *p*. In other words, it shows how the lines in the plot above intersect with *y* = 0.05.

![](convergence_files/figure-markdown_github/plot02-1.png)

Appendix
--------

### Monte Carlo Results

    ## # A tibble: 10 x 8
    ##        P `100` `200` `300` `400` `500` `600` `700`
    ##    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
    ##  1  0.5  0.196 0.139 0.113 0.098 0.088 0.08  0.074
    ##  2  0.55 0.195 0.138 0.113 0.098 0.087 0.08  0.074
    ##  3  0.6  0.192 0.136 0.111 0.096 0.086 0.078 0.073
    ##  4  0.65 0.187 0.132 0.108 0.094 0.084 0.076 0.071
    ##  5  0.7  0.179 0.127 0.104 0.09  0.08  0.073 0.068
    ##  6  0.75 0.169 0.12  0.098 0.085 0.076 0.069 0.064
    ##  7  0.8  0.156 0.111 0.09  0.078 0.07  0.064 0.059
    ##  8  0.85 0.139 0.099 0.081 0.07  0.063 0.057 0.053
    ##  9  0.9  0.117 0.083 0.068 0.059 0.053 0.048 0.044
    ## 10  0.95 0.085 0.06  0.05  0.043 0.038 0.035 0.032
