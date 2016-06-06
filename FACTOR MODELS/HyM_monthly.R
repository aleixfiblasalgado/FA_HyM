## Obtain a csv file with monthly returns
library(xts)
library(quantmod)
data.HyM <- read.csv("H&M.csv", header = TRUE)
date <- as.Date(data.HyM$Date, format = "%Y-%m-%d")
data.HyM <- cbind(date, data.HyM[ ,-1])
data.HyM <- data.HyM[order(data.HyM$date), ]
data.HyM <- xts(data.HyM[ ,2:7], order.by = data.HyM[ ,1])
names(data.HyM) <- paste(c("HyM.Open", "HyM.High", "HyM.Low", "HyM.Close", "HyM.Volume", "HyM.Adjusted"))
HyM.monthly <- to.monthly(data.HyM)
HyM.monthly <- HyM.monthly[ ,6]
HyM.ret <- Delt(HyM.monthly$data.HyM.Adjusted)
names(HyM.ret) <- paste("HyM.ret")
port <- HyM.ret
port$port.ret <- rowMeans(port)
port <- port[-1, 2]

csv.port <- cbind(data.frame(index(port)), data.frame(port))
names(csv.port)[1] <- paste("date")
rownames(csv.port) <- seq(1, nrow(csv.port), by = 1)
write.csv(csv.port, "Hypothetical(Monthly)returns.R")