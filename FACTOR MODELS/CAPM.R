# CAPM 

## Run a regression 
## Import the monthly returns and convert to data.frame object
library(xts)
library(quantmod)
port <- read.csv("Hypothetical (Monthly) returns.csv")
port$date <- as.yearmon(as.character(port$date), "%b %Y")
port.df <- data.frame(port)

## Now we need to calculate also the monthly returns for our market proxy. In our case we have used the OMXS30
## an indiex of the Stockholm stock exchange
data.OMX <- read.csv("OMX30.csv")
date <- as.Date(data.OMX$Date, format = "%Y-%m-%d")
data.OMX <- cbind(date, data.OMX[ ,-1])
data.OMX <- data.OMX[order(data.OMX$date), ]
data.mkt <- xts(data.OMX[ ,2:7], order.by = data.OMX[ ,1])
names(data.mkt)[1:6] <- paste(c("OMX.Open", "OMX.High", "OMX.Low", 
                                "OMX.Close", "OMX.Volume", "OMX.Adjusted"))

mkt.monthly <- to.monthly(data.mkt)
mkt.monthly <- mkt.monthly[ ,6]
mkt.ret <- Delt(mkt.monthly$data.mkt.Adjusted)
names(mkt.ret) <- paste("mkt.ret")
mkt.ret <- mkt.ret[-1,]
market.df <- data.frame(mkt.ret)

## Import also Risk-free Rate data from Swedish bonds 
rf <- read.csv("Bonds.csv", sep = ";", dec = ",", skip = 11)
rf[,1] <- as.Date(rf[ ,1], "%Y-%m-%d")
rf[,2] <- as.numeric(as.character(rf[,2]))
rf <- xts(rf[ ,2], order.by = rf[ ,1])
names(rf) <- paste("OMX")
rf.monthly <- to.monthly(rf)
options(scipen = "100")
rf.monthly <- (1+rf.monthly[,1]/100)^(1/12)-1
rf.sub <- rf.monthly[c(277:nrow(rf.monthly)), ]
rf.sub <- data.frame(rf.sub)
extra <- rep(mean(rf.sub[,1]), times = 8)
for(i in 1:8){
  rf.sub <- rbind(rf.sub, data.frame(rf.Open = extra[i]))
}

## Combine Firm, Market and Risk-free data into one data object
combo <- cbind(market.df, data.frame(rf.sub), port.df$port.ret)
names(combo) <- paste(c("mkt.ret", "rf", "port.ret"))

## Calculate Excess Firm Return and Excess Market Return (ri - rf) and (ri - rm)
combo$exret <- combo$port.ret - combo$rf
combo$exmkt <- combo$mkt.ret - combo$rf

## Run regression of excess firm return on Excess Market Return
options(digits = 5)
CAPM <- lm(combo$exret~combo$exmkt)
summary(CAPM)

## We appreciate that our beta stands for 0.74731. This beta of 0,74731 means that if the market goes up by 1%, we expect
## our portfolio to go up by 0,74% (Also the contrary if the market goes down)
## Betas that are less than one are consistent with betas of defensive stocks as these stocks are less affected by adverse market movements

