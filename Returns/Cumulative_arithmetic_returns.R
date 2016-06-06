# Cumulating Arithmetic Returns
## To string together multiple days of arithmetic returns, we have to take the product of the daily gross returns

## Ex: (1+R1) x (1+R2) x (1+R3)... Where T-days is an specific investment horizon

## Import data
source("../Importer.R")
source("TotalReturns_HyM.R")
HyM.acum <- HyM.tot.ret

## Set first day Total Return Value to 0
HyM.acum[1, 1] <- 0

## Calculate gross daily returns
HyM.acum$GrossRet <- 1 + HyM.acum$HyM.tot.ret

## Calculate cumulative Gross Returns
HyM.acum$Grosscum <- cumprod(HyM.acum$GrossRet)

## Convert to Net Returns
HyM.acum$NetCum <- HyM.acum$Grosscum - 1
