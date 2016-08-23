library(lubridate)
library(ggplot2)
library(gridExtra)
library(scales)

harMetDaily15.09.11 <- read.csv(
  file="NEON-DS-Met-Time-Series/HARV/FisherTower-Met/Met_HARV_Daily_2009_2011.csv",
  stringsAsFactors = FALSE)

# convert datetime to POSIXct
harMetDaily15.09.11$date<-as.Date(harMetDaily15.09.11$date)

harMetMonthly15.09.11 <- read.csv(
  file="NEON-DS-Met-Time-Series/HARV/FisherTower-Met/Met_HARV_Monthly_2009_2011.csv",
  stringsAsFactors = FALSE)

# monthly HARV temperature data, 2009-2011
harTemp.monthly.09.11<-read.csv(
  file="NEON-DS-Met-Time-Series/HARV/FisherTower-Met/Temp_HARV_Monthly_09_11.csv",
  stringsAsFactors=FALSE
)

# datetime field is actually just a date 
#str(harTemp.monthly.09.11) 

# convert datetime from chr to date class & rename date for clarification
harTemp.monthly.09.11$date <- as.Date(harTemp.monthly.09.11$datetime)

qplot(x=date,
      y=airt,
      data=harMetDaily15.09.11,na.rm=TRUE,
      main="Air Temperature",
      xlab="Date", ylab="Temperature (C)")


ggplot(harMetDaily15.09.11,aes(date,airt)) +
  geom_point(na.rm=TRUE)

ggplot(harMetDaily15.09.11,aes(date,airt)) +
  geom_point(na.rm=TRUE,color="blue",size=3,pch=18)

