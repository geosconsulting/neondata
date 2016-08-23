library(lubridate)
library(ggplot2)

harMet_15Min <- read.csv(
  file="NEON-DS-Met-Time-Series/HARV/FisherTower-Met/hf001-10-15min-m.csv",
  stringsAsFactors = FALSE)

harMet_15Min$datetime <- as.POSIXct(harMet_15Min$datetime,
                                    format = "%Y-%m-%dT%H:%M",
                                    tz = "America/New_York")

harMet15.09.11 <- subset(harMet_15Min,
                         datetime>= as.POSIXct('2009-01-01 00:00',
                                               tz = "America/New_York") &
                         datetime<= as.POSIXct('2011-12-31 23:59',
                                               tz="America/New_York"))

tail(harMet15.09.11)
head(harMet15.09.11)

sum(is.na(harMet15.09.11$datetime))
sum(is.na(harMet15.09.11$airt))
harMet15.09.11[is.na(harMet15.09.11$airt),]

sum(is.na(harMet15.09.11$prec))
sum(is.na(harMet15.09.11$parr))

mean(harMet15.09.11$airt)

mean(harMet15.09.11$airt,na.rm=TRUE)
