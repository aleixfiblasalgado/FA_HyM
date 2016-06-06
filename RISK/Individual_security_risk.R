# Individual Securirty Risk
## We consider the varianceof an asset, or its positive square root (sd) as a measure of risk

## The formula basically tells us about the variance as a measure of volatility that captures deviations from the average
## From the perspective of variance, both positive and negative deviations from the mean are considered "risk".

## Import the data
library(quantmod)
library(xts)
data.HyM <- read.csv("H&M.csv", header = TRUE)
date <- as.Date(data.HyM$Date, format = "%Y-%m-%d")
data.HyM <- cbind(date, data.HyM[ ,-1])
data.HyM <- data.HyM[order(data.HyM$date), ]
data.HyM <- xts(data.HyM[ ,2:7], order.by = data.HyM[ ,1])
names(data.HyM) <- paste(c("HyM.Open", "HyM.High", "HyM.Low", "HyM.Close", "HyM.Volume", "HyM.Adjusted"))

## Calculate Returns
HyM.ret <- data.HyM[,6]
HyM.ret$Return = Delt(HyM.ret$HyM.Adjusted)
HyM.ret <- HyM.ret[-1, 2]

## Calculate full period variance and standard deviation
HyM.var.full <- var(HyM.ret$Return)
HyM.sd.full <- sd(HyM.ret$Return)

# Subset some periods of interes
## Ex: var and sd for 2011
HyM.2011 <- subset(HyM.ret, 
                   index(HyM.ret) >= "2011-01-01" &
                     index(HyM.ret) <= "2011-12-31")
HyM.var.2011 <- var(HyM.2011)
HyM.sd.2011 <- sd(HyM.2011)

## Ex: var and sd for 2012
HyM.2012 <- subset(HyM.ret, 
                   index(HyM.ret) >= "2012-01-01" &
                     index(HyM.ret) <= "2012-12-31")
HyM.var.2012 <- var(HyM.2012)
HyM.sd.2012 <- sd(HyM.2012)

## Ex: var and sd for 2013
HyM.2013 <- subset(HyM.ret, 
                   index(HyM.ret) >= "2013-01-01" &
                     index(HyM.ret) <= "2013-12-31")
HyM.var.2013 <- var(HyM.2013)
HyM.sd.2013 <- sd(HyM.2013)

## Ex: var and sd for 2014
HyM.2014 <- subset(HyM.ret, 
                   index(HyM.ret) >= "2014-01-01" &
                     index(HyM.ret) <= "2014-12-31")
HyM.var.2014 <- var(HyM.2014)
HyM.sd.2014 <- sd(HyM.2014)

## Ex: var and sd for 2015
HyM.2015 <- subset(HyM.ret, 
                   index(HyM.ret) >= "2015-01-01" &
                     index(HyM.ret) <= "2015-12-31")
HyM.var.2015 <- var(HyM.2015)
HyM.sd.2015 <- sd(HyM.2015)

## Calculate Average Return for the Full Period and each subperiods
mean.ret.full <- mean(HyM.ret)
mean.ret.2011 <- mean(HyM.2011)
mean.ret.2012 <- mean(HyM.2012)
mean.ret.2013 <- mean(HyM.2013)
mean.ret.2014 <- mean(HyM.2014)
mean.ret.2015 <- mean(HyM.2015)

## Combine all data
HyM.risk <- rbind(
  cbind(HyM.var.full, HyM.var.2011, HyM.var.2012, HyM.var.2013, HyM.var.2014, HyM.var.2015), 
  cbind(HyM.sd.full, HyM.sd.2011, HyM.sd.2012, HyM.sd.2013, HyM.sd.2014, HyM.sd.2015), 
  cbind(mean.ret.full, mean.ret.2011, mean.ret.2012, mean.ret.2013, mean.ret.2014, mean.ret.2015))

## Clean up Data
options(digits = 3)
rownames(HyM.risk) <- c("Variance", "Std Dev", "Mean")
colnames(HyM.risk) <- c("2011-2015", "2011", "2012", "2013", "2014", "2015")
options(digits = 7)

## Based on daily returns, we can see that for the whole period H&M average return is 0,14% but its standard deviation is
## around 5,06%. Assuming a normal distribution, 68% of H&M returns lie within one sd from the mean and 95% with two sd.
## This means that 68% of returns are between (-4,9% , 5,2%) and 95% H&M's daily returns are between (-9,98% , 10,2%)

## Notice these are daily volatility estimates. As such, the volatility would be different for weekly and monthly returns
## Sd of returns based on different frequencies are not comparable. We have to convert such volatility measures to an annualized
## number to make comparisons. For var, we multiply it by 252, which represent the approximate number of trading days in a year.
## For standard deviation, we multiply the daily sd by the square root of 252. For the mean, we multiply the daily mean by 252.
options(digits = 3)
annual.vol <- HyM.risk
annual.vol[1,] <- annual.vol[1,]*252
annual.vol[2,] <- annual.vol[2,]*sqrt(252)
annual.vol[3,] <- annual.vol[3,]*252
options(digits = 7)

