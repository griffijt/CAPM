# Portfolio Analysis
The purpose of this repository is to:
1. Expand my experience with R
2. Apply concepts learned in my undergrad and CFA studies
3. See if I add any value to my portfolio

## CAPM
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
