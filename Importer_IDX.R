# Gathering stock data
library(zoo)
library(xts)

## Importing data into R
data.INDITEX <- read.csv("INDITEX.csv", header = TRUE)

## Convert the variable data from a Factor to a Date
date <- as.Date(data.INDITEX$Date, format = "%Y-%m-%d")

## Combine date and data.INDITEX
data.INDITEX <- cbind(date, data.INDITEX[ ,-1])

## Sort the data in Chronological Order
data.INDITEX <- data.INDITEX[order(data.INDITEX$date), ]

## Convert from data.frame Object to xts object
data.INDITEX <- xts(data.INDITEX[ ,2:7], order.by = data.INDITEX[ ,1])

## Rename Variables (columns)
names(data.INDITEX) <- paste(c("INDITEX.Open", "INDITEX.High", "INDITEX.Low", "INDITEX.Close", "INDITEX.Volume", "INDITEX.Adjusted"))
