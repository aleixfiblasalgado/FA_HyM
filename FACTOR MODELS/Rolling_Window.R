# Rolling window regressions
## Run a regression over a rolling window to estimate beta. This section is used to analyse variations in the
## alphas and betas over multiple periods

library(zoo)
library(quantmod)
## Import data from H&M and OMX 30 index data
data.OMX <- read.csv("OMX30.csv")
date <- as.Date(data.OMX$Date, format = "%Y-%m-%d")
data.OMX <- cbind(date, data.OMX[ ,-1])
data.OMX <- data.OMX[order(data.OMX$date), ]
data.mkt <- xts(data.OMX[ ,2:7], order.by = data.OMX[ ,1])
names(data.mkt)[1:6] <- paste(c("OMX.Open", "OMX.High", "OMX.Low", 
                                "OMX.Close", "OMX.Volume", "OMX.Adjusted"))

data.HyM <- read.csv("H&M.csv", header = TRUE)
date <- as.Date(data.HyM$Date, format = "%Y-%m-%d")
data.HyM <- cbind(date, data.HyM[ ,-1])
data.HyM <- data.HyM[order(data.HyM$date), ]
data.HyM <- xts(data.HyM[ ,2:7], order.by = data.HyM[ ,1])
names(data.HyM) <- paste(c("HyM.Open", "HyM.High", "HyM.Low", "HyM.Close", "HyM.Volume", "HyM.Adjusted"))

## Calculate H&M returns and market returns
rets <- diff(log(data.HyM$HyM.Adjusted))
rets$OMX30 <- diff(log(data.mkt$OMX.Adjusted))
names(rets)[1] <- "HYM"
rets <- rets[-1, ]


## Create the Rolling Window Regression function
require(zoo)
coeffs <- rollapply(rets, 
                    width = 252,
                    FUN = function(X)
                      {
                      roll.reg = lm(HYM~OMX30, 
                                    data = as.data.frame(X))
                      return(roll.reg$coef)
                    },
                    by.column = FALSE)

## Remove NAs from the data. The first 251 coefficients will be NA because the we need first 252 observations to
## generate the first regression
coeffs <- na.omit(coeffs)

## Clean-up Data
names(coeffs) <- c("Alpha", "Beta")
options(digits = 3)

## Plot the Data
par(oma = c(0, 0, 4, 0))
par(mfrow = c(2, 1))
plot(x = index(coeffs),
     xlab = "Date", 
     y = coeffs$Alpha,
     ylab = "alpha",
     type = "l", 
     col = "gold",
     lwd = 2)
plot(x = index(coeffs),
     xlab = "Date",
     y = coeffs$Beta,
     ylab = "beta",
     type = "l", 
     col = "dodgerblue3",
     lwd = 2)
title(main = "H&M Alpha and Beta
      Using Rolling 252-Day Windows and
      Daily Returns from 2010 to 2015", outer = TRUE)
par(mfrow = c(1, 1))


