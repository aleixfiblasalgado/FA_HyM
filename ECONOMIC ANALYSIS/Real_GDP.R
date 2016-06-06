# REAL GDP
## Could be taken as an indicator of the strength of the economy. When the economy goes well, securities'
## prices tend to rise and viceversa. An analysis can be performed to determine the growth in Real GDP.
## With data obtained from the IMF website we are able to project Real GDP growth using past data.

library(xts)

## 1. Import Historical and projected real GDP growth data from the IMF website
rgdp <- read.csv("RGDP.csv", header = FALSE, sep = ";")
rgdp <- rgdp[ ,5:ncol(rgdp)]
rgdp <- t(rgdp)

## 2. Rename the variables and fix indexes of our data object
colnames(rgdp) <- paste(c("Year", "Value"))
rownames(rgdp) <- seq(1, nrow(rgdp), 1)
rgdp <- data.frame(rgdp)

## 3. Create a separate variable for Historical Real GDP growth data
rgdp$historical <- ifelse(rgdp$Year <= 2012, rgdp$Value,0)
rgdp$projected <- ifelse(rgdp$Year > 2012, rgdp$Value,0)

## 4. Set up Data for Transposition and Transpose the Data
rgdp <- rgdp[ ,3:4]
eu.mat <- as.matrix(rgdp)
t.eu <- t(eu.mat)

## 5. Setup sequence of even Years o customize x-axis
xlabel = seq(1980, 2018, by = 1)
even.years <- xlabel %% 2 == 0
years.even <- cbind(data.frame(xlabel), data.frame(even.years))
years.even$Year <- ifelse(years.even$even.years == "TRUE", xlabel, " ")
xlabel.even <- years.even [ ,3]

## 6. Plot a Bar Chart of Annual Real GDP growth rate
range(rgdp)
y.range <- c(-4, 8)
barplot(t.eu, col = c("blue", "cyan"),
        ylab = "Real GDP Growth (%)",
        ylim = y.range, 
        names.arg = xlabel.even,
        las = 2,
        main = "Eurozone Real GDP Growth
        Historical (1980-2012) and Forecasted (2013-2018)")
legend("topright",
       c("Historical", "Forecasted"),
       col = c("blue", "cyan"),
       pch = c(15, 15))
