#CAPM Model on Personal Portfolios

#Load CSV file into R
return_data = read.table("return_data.csv",header=TRUE,sep=",")

# Extract returns
RRSP <- return_data[,2]
TFSA <- return_data[,3]
rf <- return_data[,4]
TSX <- return_data[,5]
SP500 <- return_data[,6]

# Calculate excess returns
RRSPxs <- RRSP - rf
TFSAxs <- TFSA - rf

# Regress portfolio excess returns on SP500 returns
RRSPmodel <- lm(RRSPxs ~ SP500)
TFSAmodel <- lm(TFSAxs ~ SP500)

# Print summary of RRSP regression results
summary(RRSPmodel)

# Basic residual analysis to test model assumptions
par(mfrow=c(2,2))
plot(RRSPmodel)

# Wait for user to review RRSP results
readline(prompt="Press [enter] to review TFSA results")

# Review model output and assumptions for TFSA
summary(TFSAmodel)
plot(TFSAmodel)
