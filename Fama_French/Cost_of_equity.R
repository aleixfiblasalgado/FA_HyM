## Cost of equity FF

source("FF.R")
beta <- summary(FF.reg)$coefficient[2]
rf <- mean(combo$rf)
HML <- mean(FF.data$HML)
SMB <- mean(FF.data$SMB)
MKTPremium<- mean(combo$exmkt)

Cost_of_equity <- rf + beta*(MKTPremium) + HML + SMB
Cost_of_equity <- (((1+Cost_of_equity)^12) - 1)*100

cat("The cost of equity for H&M would be", Cost_of_equity, "%")