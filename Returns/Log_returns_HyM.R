# Logarithmic Total Returns
## The Delt command are called arithmetic returns. On the other hand, logarithmic returns are used extensively
## in derivatives pricing, among other areas of finance. Furthermore, calculating cumulative returns is 
## relatively easy using logarithmic returns

## rt = lnPt - ln(Pt -1)

## Import Adjusted Closing Price Data
source("../Importer.R")
HyM.log.ret <- data.HyM[ ,6]

## Calculate Log Returns
HyM.log.ret$HyM.log.ret <- diff(log(HyM.log.ret$HyM.Adjusted))

## Clean up the data
options(digits = 5)
HyM.log.ret <- HyM.log.ret[ ,2]
