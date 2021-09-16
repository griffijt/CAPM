# Calculating Portfolio Returns

# Adapted from:
# 1. https://rviews.rstudio.com/2017/10/11/from-asset-to-portfolio-returns/
# 2. https://rviews.rstudio.com/2017/11/09/introduction-to-visualizing-asset-returns/
# Original Author: Jonathan Regenstein

# Purpose: Download and visualize asset and portfolio returns

# Portfolio contains:
# - ACWX (global equities excluding US) at 25%
# - BLOK (blockchain themed ETF) at 20%
# - ICLN (renewable energy themed ETF) at 10%
# - IJS (small-cap US equity) at 15%
# - VOO (S&P 500) at 30%

# load libraries
library(dplyr)
library(highcharter)
library(quantmod)
library(tibbletime)
library(tidyverse)
library(tidyquant)
library(timetk)

# define vector of ticker symbols
tickers <- c("ACWX", "BLOK", "ICLN", "IJS", "VOO")

# define weight vector
w <- c(0.25, 0.2, 0.1, 0.15, 0.3)

# get adjusted price data from yahoo and store
prices <- 
  getSymbols(tickers, src = "yahoo", from = "2018-08-31",
             auto.assign = TRUE, warnings = TRUE) %>% # download prices
  map(~Ad(get(.))) %>% # select adjusted prices only
  reduce(merge) %>% # merge data into one xts object
  `colnames<-`(tickers) # set column names to ticker symbols

# xts method

#convert prices to monthly log returns
prices_monthly <- to.monthly(prices, indexAt = "last", OHLC = FALSE)
returns_xts <- na.omit(Return.calculate(prices_monthly, method="log"))

# calculate quarterly rebalanced returns
returns_xts_rebal_quarterly <- 
  Return.portfolio(returns_xts, weights = w, rebalance_on = "quarters") %>%
  `colnames<-`("returns")

# tidyverse method (data in long form)

# convert prices to monthly log returns
returns_long <- 
  prices %>%
  to.monthly(indexAt = "last", OHLC = FALSE) %>% # convert data to monthly based on EOM
  tk_tbl(preserve_index = TRUE, rename_index = "date") %>% # convert to tibble object
  gather(asset, returns, -date) %>% 
  group_by(asset) %>% # group data by asset (ticker)
  mutate(returns = log(returns/lag(returns))) # calculate log returns

# calculate quarterly rebalanced returned
returns_long_rebal_quarterly <- 
  returns_long %>%
  tq_portfolio(assets_col = asset,
               returns_col = returns,
               weights = w,
               col_rename = "returns",
               rebalance_on = "quarters")

# plot the time series of returns vs. S&P 500 using highcharter library
highchart(type = "stock") %>%
  hc_title(text = "Portfolio Monthly Log Returns") %>%
  hc_add_series(returns_xts_rebal_quarterly,
                name = "Portfolio") %>%
  hc_add_series(returns_xts$VOO,
                name = "S&P500") %>%
  hc_add_theme(hc_theme_bloom()) # apply Bloomberg theme lol

# plot histotram/density of individual asset returns using tidyverse
returns_long %>%
  ggplot(aes(x = returns, colour = asset, fill = asset)) +
  geom_histogram(alpha = 0.25, binwidth = .01) +
  stat_density(geom = "line", alpha = 1) +
  facet_wrap(~asset) +
  ggtitle("Monthly Returns since August 2018") +
  xlab("Monthly Returns") +
  ylab("Distribution")
