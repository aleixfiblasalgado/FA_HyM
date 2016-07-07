# FAMA-FRENCH WITH THREE FACTORS

library(quantmod)
library(xts)

## Step 1: Import Portfolio Returns Data
load(".Rdata")

## Step 2: Import Fama-French Data Retrieved From Ken French's Website
FF.raw <- read.csv(file = "F-F_Research_Data_Factors.CSV",sep = ",", dec = ".", skip = 4)
FF.raw <- FF.raw[-1078:-1169, ]
names(FF.raw) <- paste(c("text.date", "RmxRf", "SMB", "HML", "Rf"))

## When the data is read-in,all the variables are considered Factors by R. We need to convert all these variables
## into either Date or numberic. The date variable is harder to convert, so the easier alternative is to generate 
## a sequence of monthly date observations and use that new series.
FF.raw <- FF.raw[ ,-1]
FF.raw$RmxRf <- as.numeric(as.character(FF.raw$RmxRf))/100
FF.raw$Rf <- as.numeric(as.character(FF.raw$Rf))/100
FF.raw$SMB <- as.numeric(as.character(FF.raw$SMB))/100
FF.raw$HML <- as.numeric(as.character(FF.raw$HML))/100
FF.raw$FF.date <- seq(from = as.Date("1926-07-01"),to = as.Date("2016-03-01"), by="months")
FF.raw$FF.date <- as.yearmon(FF.raw$FF.date, "%Y-%m-%d")

## Step 3: Subset Fama-French Data to Relevant time Period

FF.data <- subset(FF.raw,
                  FF.raw$FF.date >= "2010-02-01" &
                  FF.raw$FF.date <= "2015-12-31")

## Step 4: Combine Portfolio Returns Data and Fama-French Data

options(digits = 3)
FF.data <- cbind(FF.data, data.frame(port))
rownames(FF.data) <- seq(1, nrow(FF.data))
FF.data$date <- format(FF.data$date, "%Y-%m")
FF.data$exret <- FF.data$port.ret-FF.data$Rf
FF.data$exmkt <- combo$exmkt
FF.data <- FF.data[ ,-1]

## Step 5: Run Regression Using Fama-French Factors

FF.reg <- lm(FF.data$exret~exmkt+SMB+HML, data = FF.data)

## Compare Fama-French Results with CAPM Results

CAPM.reg <- lm(exret~exmkt, data = FF.data)
Betas <- rbind(
  cbind(summary(FF.reg)$coefficient[2],
        summary(FF.reg)$coefficient[14],
        summary(FF.reg)$adj.r.squared),
  cbind(summary(CAPM.reg)$coefficient[2],
        summary(CAPM.reg)$coefficient[8],
        summary(CAPM.reg)$adj.r.squared)
)

colnames(Betas) <- paste(c("Beta","p-Value", "Adj.R-squared"))
rownames(Betas) <- paste(c("Fama-French", "CAPM"))
options(digits = 5)

