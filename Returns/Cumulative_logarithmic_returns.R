# Cumulating Logarithmic Returns
## This is a more simple way to get the cumulative returns just by adding the logarithmic returns over the t periods

## Import the data
source("Log_returns_HyM.R")
HyM.logcum <- HyM.log.ret

## Set the firs log return to zero
HyM.logcum[1, 1] <- 0

## Take the dum of all logarithmic returns during the investment period
logcumret = sum(HyM.logcum$HyM.log.ret)

## Convert log return back to arithmetic return
cumret = exp(logcumret)-1
