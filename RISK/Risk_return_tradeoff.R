# Risk Return Trade-Off
## The main trade-off we have to consider when making investments is between risk and return. The only way to get
## a higher return from a security is assuming more risk. To see that assumption in practise let's take a look at 
## how stocks and bonds have performed over the last 50 years.

library(quantmod)
library(xts)

## Import Fama-French Data
FF.raw <- read.fwf(file = "F-F_Research_Data_Factors.txt", widths = c(6, 8, 8, 8, 8), skip = 4)

## Clean up Data
FF.raw <- FF.raw[-1051:-1171, ]
names(FF.raw) <- paste(c("text.date", "RmxRf", "SMB", "HML", "Rf"))

## Although the data looks like it is workable, the variables are all Factor variables. We need to convert them to 
## numeric variables
FF.raw <- FF.raw[ ,c(-1, -3, -4)]
FF.raw$RmxRf <- as.numeric(as.character(FF.raw$RmxRf))/100
FF.raw$Rf <- as.numeric(as.character(FF.raw$Rf))/100
FF.raw$date <- seq(as.Date("1926-07-01"), as.Date("2013-12-31"), by = "months")
FF.raw$date <- as.yearmon(FF.raw$date, "%Y - %m - %d")

## Compute Raw Market return variable
FF.raw$Rm <- FF.raw$RmxRf + FF.raw$Rf

## Subset Data from December 1963 to December 2013
FF <- subset(FF.raw, FF.raw$date >= "1963-12-01" & FF.raw$date <= "2013-12-31")

## Calculate Gross Returns for the market and Risk-free Rate
## We set the return for Dec, 1963 to zero because we assume we are at the end of the month
FF$Gross.Rm <- 1 + FF$Rm
FF$Gross.Rm[1] <- 1
FF$Gross.Rf <- 1 + FF$Rf
FF$Gross.Rf[1] <- 1

## Compute the cumulative returns for Market and Risk-free rates
FF$cum.Rm <- cumprod(FF$Gross.Rm)
FF$cum.Rf <- cumprod(FF$Gross.Rf)

## Plot the Data
y.range <- range(FF$cum.Rm, FF$cum.Rf)
title1 <- "Stock vs. Bond Returns"
title2 <- "1964 to 2013"
plot(x = FF$date, 
     FF$cum.Rm, 
     type = "l",
     xlab = "Date", 
     ylab = "Value of $1 Investment ($)", 
     ylim = y.range, 
     col = "slateblue3",
     lwd = 3,
     main = paste(title1, "\n", title2))
lines(x = FF$date, y = FF$cum.Rf, lty = 2, col = "springgreen3", lwd = 2)
legend("topleft", c("Stocks (2013 Ending Value: $124.89)", 
                    "Bonds (2013 Ending Value: $12.1)"), 
       col = c("slateblue3", "springgreen3"), 
       lty = c(1, 2),
       lwd = c(3, 2))

## Plot the Returns
y.range_bis <- range(FF$Rm, FF$Rf)
title1 <- "Volatility of Stock vs.Bond Returns"
title2 <- "1964 to 2013"
plot(x = FF$date, 
     FF$Rm, 
     type = "l",
     xlab = "Date", 
     ylab = "Returns (%)", 
     ylim = y.range_bis, 
     col = "gray50",
     lwd = 1,
     main = paste(title1, "\n", title2))
lines(x = FF$date, y = FF$Rf, lty = 1, col = "black", lwd = 1)
legend("topleft", c("Stocks, Bonds "), 
       col = c("gray50", "black"), 
       lty = c(1, 1),
       lwd = c(1, 1))