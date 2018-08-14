library(tidyverse)
library(ggthemes)

#------------------------------------------------------------------
# Functions
#------------------------------------------------------------------

# get N samples of binary outcomes with probability p
get_samples <- function(N, p) {
  samples <- sample(x = c(1, 0), size = N, replace = TRUE, prob = c(p, 1-p))
  return(samples)
}

# given a set of sample lists, subset the first N
# samples of each list and compute the average
# confidence interval size
get_width_for_N <- function(N, samples) {
  sample_subset <- data.frame(samples[1:N, ])
  stats <- map_dfr(sample_subset, compute_stats)
  return(mean(stats$size))
}

compute_stats <- function(x) {
  q  <- qnorm(.975) # 95% confidence interval
  N  <- length(x)
  s  <- sd(x)
  mu <- mean(x)
  
  lower <- mu - q * s / sqrt(N)
  upper <- mu + q * s / sqrt(N)
  size <- upper - lower
  
  stats <- list(
    "mu" = mu,
    "sd" = s,
    "N"  = N,
    "lower" = lower,
    "upper" = upper,
    "size" = size
  )
  
  return(stats)
}

get_widths <- function(p, B, runs) {
  samples <- replicate(B, get_samples(max(runs), p))
  sizes <- map(runs, get_width_for_N, samples = samples)
  names(sizes) <- runs
  
  return(sizes)
}

#------------------------------------------------------------------
# Execution
#------------------------------------------------------------------

B <- 1000 # repeats
probs <- seq(0.50, 0.99, 0.01)
runs <- seq(100, 700, 100)

results.df <- cbind(probs, map_dfr(probs, get_widths, B = B, runs = runs))
names(results.df)[1] <- "P"

widths.df <- results.df %>%
  gather(key = N, value = Width, -P) %>%
  arrange(desc(P))
  
intercepts <- widths.df %>%
  filter(Width < 0.05) %>%
  group_by(N) %>%
  summarise(Intercept = min(P))
#------------------------------------------------------------------
# Plotting
#------------------------------------------------------------------

widths.df %>%
  ggplot(aes(x = P, y = Width, color = N)) +
  geom_line() +
  scale_color_gdocs() +
  theme_gdocs() +
  labs(
    title = "Width of 95% Confidence Interval",
    x = "Probability of Binary Outcome",
    y = "Width of 95% Confidence Interval",
    color = "Runs"
  )

intercepts %>%
  ggplot(aes(x = as.numeric(N), y = Intercept)) +
  geom_point() +
  geom_line() +
  theme_gdocs() +
  labs(
    title = "Convergence to 0.05 Confidence Interval Width",
    x = "Runs",
    y = "Probability at which Confidence Interval width is 0.05"
  )

print.df <- results.df[seq(1, nrow(results.df), by = 5), ]
print(map_dfr(print.df, round, digits = 3))








