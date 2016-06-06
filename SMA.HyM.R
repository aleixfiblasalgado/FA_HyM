# Trend: Simple Moving Average Crossover
## The SMA crossover is a common trend indicator while implementing technical analysis.
## We will use two SMA lines (short and long term) and make trading decisions when the lines cross.

## Obtain adjusted closing prices for H&M
source("Importer.R")
HyM.sma <- data.HyM[ ,6]

## Compute the Rolling 50-Day and 200-Day Average Price

HyM.sma$sma50 <- rollmeanr(HyM.sma$HyM.Adjusted, k = 50) ## first 50 rows will be NA
HyM.sma$sma200 <- rollmeanr(HyM.sma$HyM.Adjusted, k = 200) ## first 200 rows will be NA

## Plot the SMA

y.range <- range(HyM.sma, na.rm = TRUE)
par(mfrow = c(1, 1))
plot(x = index(HyM.sma),
     xlab = "Date", 
     y = HyM.sma$HyM.Adjusted,
     ylim = y.range,
     ylab = "Price (SEK)",
     type = "l", 
     col = "magenta", 
     lty = 1,
     lwd = 2,
     main = "H&M - Simple Moving Average
     January 1, 2010 - December 31, 2015")
lines(x = index(HyM.sma), y = HyM.sma$sma50)
lines(x = index(HyM.sma), y = HyM.sma$sma200, lty = 2)
legend("topleft", c("H&M Price", "50-Day Moving Average", "200-Day Moving Average"), col = c("magenta", "black", "black"),
       lty = c(1, 1, 2))

## If the 50-day moving average cross above the 200-day moving average, which is called a bullish crossover, 
## this may be taken as an indicator to buy the stock. Conversely, if the 50-day moving average crosses 
## below the 200-day moving average, which is known as a bearish crossover, this may be taken as an indicator 
## to sell the stock