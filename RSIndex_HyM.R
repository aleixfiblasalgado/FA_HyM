# Momentum: Relative Strength Index
## Momentum measures the rate of the rise or fall in stock prices. From the standpoint of
## trending, momentum is a very useful indicator of strength or weakness in the issue's price.

## A common technical analysis momentum indicator is the RSI. Typical calculation is to use a 14-day
## period. The RSI is computed as following:

## RSI = 100 - (100/(1 + RS))

## Where RS is equal to the up average divided by the down average with the averages calculated using the
## Wilder Exponential Moving Average.

## Obtain adjusted closing prices for H&M
source("Importer.R")
HyM.RSI <- data.HyM[ ,6]
HyM.RSI$delta <- diff(HyM.RSI$HyM.Adjusted)

## Create dummy variables to indicate whether the prices went up or down
HyM.RSI$up <- ifelse(HyM.RSI$delta>0,1,0)
HyM.RSI$down <- ifelse(HyM.RSI$delta<0,1,0)

## Calculate Prices for Up Days and Prices for Down Days
HyM.RSI$up.val <- HyM.RSI$delta*HyM.RSI$up
HyM.RSI$down.val <-- HyM.RSI$delta*HyM.RSI$down

## Calculate Initial Up and Down 14-Day Averages
HyM.RSI$up.first.avg <- rollapply(HyM.RSI$up.val, width = 14, FUN = mean, fill = NA, na.rm = TRUE)
HyM.RSI$down.first.avg <- rollapply(HyM.RSI$down.val, width = 14, FUN = mean, fill = NA, na.rm = TRUE)

## Calculate the Wilder Exponential Moving Average to calculate final up and down 14-Day Averages
up.val <- as.numeric(HyM.RSI$up.val)
down.val <- as.numeric(HyM.RSI$down.val)

HyM.RSI$up.avg <- HyM.RSI$up.first.avg
for(i in 15:nrow(HyM.RSI)){
  HyM.RSI$up.avg[i] <- ((HyM.RSI$up.avg[i-1]*13 + up.val[i])/14)
}

HyM.RSI$down.avg <- HyM.RSI$down.first.avg
for(i in 15:nrow(HyM.RSI)){
  HyM.RSI$down.avg[i] <- ((HyM.RSI$down.avg[i-1]*13 + down.val[i])/14)
}

## Compute the RSI
HyM.RSI$RS <- HyM.RSI$up.avg/HyM.RSI$down.avg
HyM.RSI$RSI <- 100 - (100/(1+HyM.RSI$RS))

## Plot the Data
title1 <- "H&M - Relative Strength Index"
title2 <- "January 2010 - December 2015"
plot(x = index(HyM.RSI), 
     xlab = "Date", 
     y = HyM.RSI$RSI, 
     ylab = "RSI (14-Day Moving Average)", 
     ylim = c(0, 100), 
     type = "l", 
     col = "gold", 
     main = paste(title1,"\n", title2))
abline(h = c(30, 70), lty = 2)

## Notice that a buy indicator have been made as the RSI was above 70 and crossed below 70 during those periods
## In contrast a sell signal could be identified when the RSI was below 30 and crossed above 30 during a specific 
## period.
