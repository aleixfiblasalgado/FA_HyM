## Estimating the cost of equity using CAPM

source("CAPM.R")
beta <- summary(CAPM)$coefficients[2]

## For the ERP (rm - rf) we could take the arithmetic average of our data
ERP <- mean(combo$exmkt)

## For the return on risk-free assets we coul take our last value available or also the mean
rf_assets <- combo$rf[71]

## Compute the cost of equity
Cost_of_equity <- rf_assets + (beta*ERP)
Cost_of_equity <- Cost_of_equity*100 
cat("The cost of equity for H&M would be", Cost_of_equity, "%")