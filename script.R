library(tidyverse)
library(ggthemes)

probs <- seq(0.50, 0.99, 0.01)
N     <- seq(50, 1000, 1)
runs  <- seq(200, 800, 100)

width_func <- function(p, N) {
  std_dev <- sqrt(p * (1-p))
  z <- qnorm(.975) # 95% CI
  width <- 2 * z * std_dev/sqrt(N)
  return(width)
}

df <- expand.grid(N, probs)
names(df) <- c("N", "P")

df <- df %>%
  mutate(width = width_func(.$P, .$N))

df %>%
  filter(N %in% runs) %>%
  ggplot(aes(x = P, y = width, color = factor(N))) +
  geom_line() +
  scale_color_gdocs() +
  theme_gdocs() +
  labs(
    title = "Confidence Interval Widths for Bernoulli Trials",
    x = "Probability of Bernoulli Trial Success (p)",
    y = "E[ Width of 95% Confidence Interval ]",
    color = "Trials (N)"
  )


min.df <- df %>%
  filter(width <= 0.05) %>%
  group_by(P) %>%
  summarise(min_runs = min(N))

min.df %>%
  ggplot(aes(x = P, y = min_runs)) +
  geom_line() +
  scale_color_gdocs() +
  theme_gdocs() +
  scale_x_continuous(breaks = seq(0.8, 1, 0.02)) +
  labs(
    title = "Trials required for 0.05 Confidence Interval Width",
    x = "Probability of Bernoulli Trial Success (p)",
    y = "E[ Trials ]"
  )




