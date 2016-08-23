library(ggplot2)

# Load csv file of daily meteorological data from Harvard Forest
harMet.daily <- read.csv(
  file="NEON-DS-Met-Time-Series/HARV/FisherTower-Met/hf001-06-daily-m.csv",
  stringsAsFactors = FALSE
)

harMet.daily$date <- as.Date(harMet.daily$date)
head(harMet.daily$date)

class(harMet.daily)
head(harMet.daily)
str(harMet.daily)

qplot(x=date,y=airt,
      data=harMet.daily,
      main="Daily Air Temperature",
      xlab = "Date",
      ylab = "Daily Precipitation")

