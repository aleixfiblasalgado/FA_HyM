# Unemployment rate
## Again we import data from the IMF, concretely the unemployment rate for countries in the Eurozone from 1980 to 2020
## (predicted component)

library(xts)

## 1. Import Unemployment rate data
unempl<- read.csv("Unemployment.csv", sep = ";", dec = ",",skip = 10)
unempl$date <- as.Date(unempl$observation_date, "%Y-%m-%d")
unempl$UNRATE <- as.numeric(as.character(unempl$UNRATE))
unempl <- xts(unempl$UNRATE, order.by = unempl$date)
names(unempl) <- paste("UNRATE")

## 2. Subset Data from 1964 to 2013
unempl <- subset(unempl, 
                 index(unempl) >= "1964-01-01" &
                   index(unempl) <= "2015-12-31")

## 3. Calculate long term Average Unemployment Rate
lt.avg <- mean(unempl$UNRATE)

## 4. Plot the unemployment rate data
plot(x = index(unempl), 
     xlab = "Date (Quarters)",
     y = unempl$UNRATE,
     ylab = "Unemployment Rate (%)",
     ylim = c(2, 12),
     type = "l",
     main = "EU unemployment Rate From 1964 to 2013")

## 5. Overlay annotations onto the chart
abline(h = lt.avg, lty = 2, col = "magenta")
text(as.Date("2001-01-01"), 7.4, "Long-Term")
text(as.Date("2001-01-01"), 7, "Avg. = 6.1%")
arrows(x0 = as.Date("2001-01-01"),
       y0 = 6.9,
       x1 = as.Date("2001-01-01"),
       y1 = 6.2,
       code = 2,
       length = 0.10)

## *Point with the highest unemployment rate
points(as.Date("1982-11-01"), 10.8, pch = 16)
text(as.Date("1992-01-01"),11.5, "November 1982")
arrows(x0 = as.Date("1992-01-01"),
       y0 = 11.3,
       x1 = as.Date("1983-07-01"),
       y1 = 10.9,
       code = 2,
       length = 0.10)

points(as.Date("2009-10-01"), 10, pch = 16)
text(as.Date("2010-01-01"),11, "October 2009")
arrows(x0 = as.Date("2009-10-01"),
       y0 = 10.8,
       x1 = as.Date("2009-10-01"),
       y1 = 10.1,
       code = 2,
       length = 0.10)

