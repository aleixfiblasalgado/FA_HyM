# Comparing Price Return and Total Return
## This computation could be useful for estimating which percentage of total returns is based on price returns
## and, on the contrary which one is based on dividends.

## Import the Data
source("PriceReturns_HyM.R")
source("TotalReturns_HyM.R")
HyM.Ret <- cbind(HyM.prc.ret, HyM.tot.ret)
names(HyM.Ret) <- c("prc.ret", "tot.ret")
library(xts)
library(quantmod)

## Set first returns to zero
HyM.Ret$prc.ret[1] <- 0
HyM.Ret$tot.ret[1] <- 0

## Calculate the Gross Return
HyM.Ret$gross.prc <- 1+HyM.Ret$prc.ret
HyM.Ret$gross.tot <- 1+HyM.Ret$tot.ret

## Cumulate the Gross Return
HyM.Ret$cum.prc <- cumprod(HyM.Ret$gross.prc)
HyM.Ret$cum.tot <- cumprod(HyM.Ret$gross.tot)

## Plot the Two Return Series
y.range <- range(HyM.Ret[ ,5:6])
plot(HyM.Ret$cum.tot, 
     type = "l", 
     xlab = "Date", 
     ylab = "Value of Investment (SEK)", 
     ylim = y.range, 
     main = "H&M Stock Performance Based on Total Returns and Price Returns
     December 31, 2010 - December 31, 2013")
lines(HyM.Ret$cum.tot, col = "darkgreen", lwd = 2)
lines(HyM.Ret$cum.prc, 
      type = "l", 
      lty = 3)
abline(h = 1, col = "black")
legend("topleft", col = c("darkgreen", "black"), 
       lty = c(1, 3), lwd = c(2, 1),
       c("Value based on Total Return", 
         "Value Based on Price Return"))
