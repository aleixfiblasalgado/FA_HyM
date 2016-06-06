# Total Returns
## Total returns a shareholder can receive includes both change in the price of shares as well as any income
## generated from dividends and the reinvestment of those dividends.

## Rt = (Pt/(Pt-1))-1  + (CFt / (Pt - 1))

library(quantmod)

## The first term corresponds to the capital appreciation and the second one the CF yield resulting from dividends payment
## CFt is the cash flow (Ex:dividend) payment on day t

## Import adjusted close prices
source("../Importer.R")
HyM.tot.ret <- data.HyM[ ,6]

## Calculate total Return
HyM.tot.ret$HyM.tot.ret = Delt(HyM.tot.ret$HyM.Adjusted)

## Clean up the data
options(digits = 5)
HyM.tot.ret <- HyM.tot.ret[ ,2]

## Note that the total returns gets part of the price returns plus the reinvestment of cash received form dividends
