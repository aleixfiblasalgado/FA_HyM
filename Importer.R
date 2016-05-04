# Gathering stock data
library(zoo)
library(xts)

## Importing data into R
data.HyM <- read.csv("H&M.csv", header = TRUE)

## Convert the variable data from a Factor to a Date
date <- as.Date(data.HyM$Date, format = "%Y-%m-%d")

## Combine date and data.HyM
data.HyM <- cbind(date, data.HyM[ ,-1])

## Sort the data in Chronological Order
data.HyM <- data.HyM[order(data.HyM$date), ]

## Convert from data.frame Object to xts object
data.HyM <- xts(data.HyM[ ,2:7], order.by = data.HyM[ ,1])

## Rename Variables (columns)
names(data.HyM) <- paste(c("HyM.Open", "HyM.High", "HyM.Low", "HyM.Close", "HyM.Volume", "HyM.Adjusted"))
