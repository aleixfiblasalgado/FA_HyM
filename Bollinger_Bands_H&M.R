# Volatitly: Bollinger Bands
## Bollinger Bnds is a frequently used tool to analize volatility. It has three components:
## 1- A 20-day simple moving average
## 2- An upper band which is two standard deviations above the 20-day SMA
## 3- A lower band which is two standard deviations below the 20-day SMA

## Obtain adjusted closing prices for H&M
source("Importer.R")
HyM.bb <- data.HyM[ ,6]

## Calculate Rolling 20-day Mean and Standard Deviation
HyM.bb$avg <- rollmeanr(HyM.bb$HyM.Adjusted, k = 20)
HyM.bb$sd <- rollapply(HyM.bb$HyM.Adjusted, width = 20, FUN = sd, fill = NA)

## Compute the Bollinger Bands
HyM.bb$sd2up <- HyM.bb$avg + 2*HyM.bb$sd
HyM.bb$sd2down <- HyM.bb$avg - 2*HyM.bb$sd

## Plot the data
y.range <- range(HyM.bb[ ,-3], na.rm = TRUE)
plot(x = index(HyM.bb), 
     xlab = "Date", 
     y = HyM.bb$HyM.Adjusted, 
     ylim = y.range, 
     ylab = "Price (SEK)", 
     type = "l", 
     lwd = 3,
     col = "orange",
     main = "H&M - Bollinger Bands (20 days, 2 deviations)
     January 1,2010 - December 31, 2015")
lines(x = index(HyM.bb), y = HyM.bb$avg, lty = 2)
lines(x = index(HyM.bb), y = HyM.bb$sd2up, col = "gray40")
lines(x = index(HyM.bb), y = HyM.bb$sd2down, col = "gray40")
legend("topleft", 
       c("HyM Price", "20-Day Moving Average", "Upper Band", "Lower Band"),
       lty = c(1, 2, 1, 1), 
       lwd = c(3, 1, 1, 1), 
       col = c("orange", "black", "gray40", "gray40"))

