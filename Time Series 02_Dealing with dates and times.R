library(lubridate)

# Load csv file of 15 min meteorological data from Harvard Forest
# Factors=FALSE so strings, series of letters/words/numerals, remain characters
harMet_15Min <- read.csv(
  file="NEON-DS-Met-Time-Series/HARV/FisherTower-Met/hf001-10-15min-m.csv",
  stringsAsFactors = FALSE)


class(harMet_15Min$datetime)
head(harMet_15Min$datetime)

dateOnly_HARV <- as.Date(harMet_15Min$datetime)
head(dateOnly_HARV)
class(dateOnly_HARV)

timeDate <- as.POSIXct("2015-10-19 10:15")
str(timeDate)
timeDate
unclass(timeDate)


timeDatelt <- as.POSIXlt("2015-10-19 10:15")
str(timeDatelt)
unclass(timeDatelt)

timeDatelt$yday