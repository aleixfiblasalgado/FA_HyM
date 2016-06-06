# Price Returns
## The percentage change in the closing price of a security is its price return.
## The price return is measured over some investment horizon. However, the results should
## be consistent such that accumulating daily returns will provide the yeraly return.

## Daily return:
## PRet = (Pt/Pt - 1) - 1

library(quantmod)
library(xts)

## Import the data
source("../Importer.R")
HyM.prc.ret <- data.HyM[,4]

## Calculate the Price Return
HyM.prc.ret$HyM.prc.ret <- Delt(HyM.prc.ret$HyM.Close)
options(digits = 5)
HyM.prc.ret <- HyM.prc.ret[-1, 2]

## Note that the closing price is not adjusted for neither dividend payments nor stock splits
## Consequently looking at the closing price alone may not be sufficient to properly make inferences
## from the data.

