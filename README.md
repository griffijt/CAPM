# Portfolio Analysis
The purpose of this repository is to:
1. Expand my experience with R
2. Apply concepts learned in my undergrad and CFA studies
3. See if I add any value to my portfolio

Portfolio return (input) data is saved in the repository under return_data.csv

## CAPM Model
This R scrypt performs CAPM regression analysis on my two portfolios: my retirement account (RRSP) and my stock picking account (TFSA).

The model is:

> Excess Return = Alpha + Beta*(Market Return - Risk Free Rate)

where,

> Excess Return = Portfolio Return - Risk Free Rate

### Data
All returns are downloaded from my bank's website and expressed in Canadian dollars.

- Portfolio Returns = Retirement (RRSP) or Stock Picking (TFSA)
- Risk Free = 3-month US T-Bills (in CAD)
- Market = S&P 500 (in CAD)

### Notes
- N is small. I started investing in January 2020, so the data is not too robust.

### Analysis
Based on returns up to August 2021 both models are signficant based on an F-test at the 5% significance level.

RRSP:
- This portfolio contains the following five ETFs:
  - VOO (S&P 500)
  - ACWX (All Country World Index excluding US stocks)
  - IJS (US small-cap value)
  - ICLN (thematic ETF holding renewable energy and related companies)
  - BLOK (thematic ETF holding blockchain and related companies)
- Based on the residual plots, the model assumptions do not appear to be violated, namely:
  - Considering the low amount of data (N=20), the residuals do not appear to be related to the fitted values of the model
  - The normal QQ plot shows a tight linear relation, suggesting no violations of the normality assumptions
- The CAPM beta=1.22 suggests the portfolio is slightly more volatile than the S&P500, which makes sense considering the more risky thematic portfolio holdings
- The CAPM alpha value is insignificant, which is to say we cannot distinguish it from zero. This means I have not been able to add value to the portfolio in a statistically significant way

TFSA:
- This portfolio consists of approximately 15 stocks that I believe will provide long-term capital appreciation
- Based on the residual plots, the model assumptions do not appear to be violated, namely:
  - Considering the low amount of data (N=20), the residuals do not appear to be related to the fitted values of the model
  - The normal QQ plot shows a tight linear relation, suggesting no violations of the normality assumptions
  - However, there is a high leverage point (i=11) that has significant weight on the model. This point occured in November 2020, when one of the holdings tripled in value over the course of the month.
- The statistically significant CAPM beta=1.60 suggests the portfolio is about 60% more volatile than the S&P500, which makes sense considering the concentrated and high conviction bets being made in the portfolio
- The CAPM alpha value is insignificant, which is to say we cannot distinguish it from zero. This means I have not been able to add value to the portfolio in a statistically significant way (thank goodness, since the alpha is negative, suggesting I have been losing value relative to the S&P500, opposed to creating it)
