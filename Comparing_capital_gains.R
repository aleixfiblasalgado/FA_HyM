# Some useful exploratory plots for H&M stock data

source("Importer.R") ## to get our data in a correct format H&M
source("Importer_IDX.R") ## to get our data in a correct format INDITEX

## Plotting the data

plot(data.HyM$HyM.Adjusted, ## this is a dirty plot used just to make sure we have all the data
     main = "H&M stock evolution") 

# Compare INDITEX & H&M stock evolution
## Combine all data into one data object
## For our analysis we only need the close price of both data objects (IDX and H&M)

Close.Prices <- (data.HyM$HyM.Close)/9.12968 ## correction for SEK
Close.Prices <- cbind(Close.Prices, data.INDITEX$INDITEX.Close)

## Convert Data into a data.frame. We also change the index to denote the observation number

multi.df <- cbind(index(Close.Prices), data.frame(Close.Prices))
names(multi.df) <- paste(c("date", "HyM", "INDITEX"))
rownames(multi.df) <- seq(1, nrow(multi.df), 1)

## Compute Normalized values for both securities

multi.df$HyM.idx <- multi.df$HyM/multi.df$HyM[1]
multi.df$INDITEX.idx <- multi.df$INDITEX/multi.df$INDITEX[2]
options(digits = 5) ## fixing decimals in 5 digits

## Plot the capital appreciation of both securities (without adjustment)

plot(x = multi.df$date, 
     y = multi.df$HyM.idx,
     type = "l", 
     xlab = "Date", 
     ylim = c(0, 3), 
     ylab = "Value of Investment (€)", 
     col = "red", 
     lty = 1, 
     lwd = 2, 
     main = "Value of 1€ Investment in H&M and Inditex
     January 1, 2010 - December 31, 2015")
lines(x = multi.df$date, 
      y = multi.df$INDITEX.idx, 
      col = "gray", 
      lty = 2, 
      lwd = 1)
abline(h=1, lty = 1, col = "black")
legend("topleft", c("HyM", "INDITEX"), col = c("red", "gray"), lty = c(1, 2), lwd = c(2, 1))

## Plot the capital appreciation of both securities (Adjusted Close price)
## The Adjusted Close price is the price of the share adjusted for dividends and splits
# Compare INDITEX & H&M stock evolution
## Combine all data into one data object
## For our analysis we only need the close price of both data objects (IDX and H&M)

Adj.Close.Prices <- (data.HyM$HyM.Adjusted)/9.12968 ## correction for SEK
Adj.Close.Prices <- cbind(Adj.Close.Prices, data.INDITEX$INDITEX.Adjusted)

## Convert Data into a data.frame. We also change the index to denote the observation number

multi.df <- cbind(index(Adj.Close.Prices), data.frame(Adj.Close.Prices))
names(multi.df) <- paste(c("date", "HyM", "INDITEX"))
rownames(multi.df) <- seq(1, nrow(multi.df), 1)

## Compute Normalized values for both securities

multi.df$HyM.idx <- multi.df$HyM/multi.df$HyM[1]
multi.df$INDITEX.idx <- multi.df$INDITEX/multi.df$INDITEX[2]
options(digits = 5) ## fixing decimals in 5 digits

## Plot the capital appreciation of both securities (without adjustment)

plot(x = multi.df$date, 
     y = multi.df$HyM.idx,
     type = "l", 
     xlab = "Date", 
     ylim = c(0, 7), 
     ylab = "Value of Investment (€)", 
     col = "red", 
     lty = 1, 
     lwd = 2, 
     main = "Value Adjusted of 1€ Investment in H&M and Inditex
     January 1, 2010 - December 31, 2015")
lines(x = multi.df$date, 
      y = multi.df$INDITEX.idx, 
      col = "gray", 
      lty = 2, 
      lwd = 1)
abline(h=1, lty = 1, col = "black")
legend("topleft", c("HyM", "INDITEX"), col = c("red", "gray"), lty = c(1, 2), lwd = c(2, 1))

## Alternative presentation of Normalized Pie Chart

## Set up Chart layout in R
par(oma = c(0, 0, 3, 0))

## Let R now we are plotting two charts in two columns
par(mfrow = c(1, 2))
plot(x = multi.df$date, 
     y = multi.df$HyM.idx,
     type = "l", 
     xlab = "", 
     ylim = c(0, 7), 
     ylab = "", 
     col = "red", 
     lty = 1, 
     lwd = 2, 
     main = "H&M Stock")
lines(x = multi.df$date, y = multi.df$INDITEX.idx, col = "gray")
abline(h=1, lty = 1, col = "black")
plot(x = multi.df$date, 
     xlab = "",
      y = multi.df$INDITEX.idx, 
     ylim = c(0, 7),
     ylab = "", 
     type = "l",
      col = "blue", 
      lty = 1, 
      lwd = 2, 
     main = "INDITEX Stock")
lines(x = multi.df$date, y = multi.df$HyM.idx, col = "gray")
abline(h=1, lty = 1, col = "black")
title1 = "Value of 1€ Invested in H&M and Inditex"
title2 = "January 1, 2010 - December 31, 2015"
title(main = paste(title1, "\n",title2), outer = T)
