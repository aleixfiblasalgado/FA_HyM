# INFLATION RATE

library(xts)
library(quantmod)

## 1. Import CPI Data: 

EU.CPI <- read.csv("CPIAUCNS.csv", skip = 10, sep =";", dec = ",")
EU.CPI$date <- as.Date(EU.CPI$observation_date, "%Y-%m-%d")
EU.CPI$CPIAUCNS <- as.numeric(as.character(EU.CPI$CPIAUCNS))
EU.CPI <- xts(EU.CPI$CPIAUCNS, order.by = EU.CPI$date)
names(EU.CPI) <- paste("CPIAUCNS")

## 2. Calculate a 12-Month Lag Variable: Since the inflation rate is calculated as year-over-year changes in CPI,
## we create a variable that takes on the value of the CPI during the same month the year before. As we have monthly 
## data, this requires us to take a 12-month lag of the data

EU.Lag12 <- Lag(EU.CPI$CPIAUCNS, k = 12)

## 3. Combine both CPI and Lag CPI data

EU.CPI <- merge(EU.CPI, EU.Lag12)
names(EU.CPI) <- paste(c("eu.cpi", "lag.cpi")) ## rename to make it easier to remember

## 4. Calculate the Inflation Rate. We can calculate the inflation rate as the percentage change between eu.cpi and
## lag.cpi for each period in which we have both values populated

EU.CPI$inflation <- (EU.CPI$eu.cpi/EU.CPI$lag.cpi-1)*100

## 5. Subset Inflation data over last 50 Years

EU.CPI <- subset(EU.CPI[ ,3], 
                 index(EU.CPI) >= "1966-01-01" &
                   index(EU.CPI) <= "2016-04-01")

## 6. Plot the Inflation Rate Data

plot(x = index(EU.CPI), 
     y = EU.CPI$inflation, 
     xlab = "Date", 
     ylab = "Inflation Rate (%)", 
     type = "l", 
     col = "magenta", 
     main = "EU Inflation Rates From 1966 to 2016
     Based on Year Over Year Changes in CPI")

## Shaded areas to identify the recession periods within our date range

shade <- par("usr")
rect(as.Date("2007-12-01"), shade[2], 
     as.Date("2009-06-01"), shade[3], col = "gray60", lty = 0)
rect(as.Date("2001-03-01"), shade[2], 
     as.Date("2001-11-01"), shade[3], col = "gray60", lty = 0)
rect(as.Date("1990-07-01"), shade[2], 
     as.Date("1991-03-01"), shade[3], col = "gray60", lty = 0)
rect(as.Date("1981-07-01"), shade[2], 
     as.Date("1982-11-01"), shade[3], col = "gray60", lty = 0)
rect(as.Date("1980-01-01"), shade[2], 
     as.Date("1980-07-01"), shade[3], col = "gray60", lty = 0)
rect(as.Date("1973-11-01"), shade[2], 
     as.Date("1975-03-01"), shade[3], col = "gray60", lty = 0)
rect(as.Date("1969-12-01"), shade[2], 
     as.Date("1970-11-01"), shade[3], col = "gray60", lty = 0)
box(which = "plot", lty = 1)

lines(x = index(EU.CPI), y = EU.CPI$inflation)
abline(h = 0)
