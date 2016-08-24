library(lubridate)
library(ggplot2)
library(gridExtra)
library(scales)

harMetDaily15.09.11 <- read.csv(
  file="NEON-DS-Met-Time-Series/HARV/FisherTower-Met/Met_HARV_Daily_2009_2011.csv",
  stringsAsFactors = FALSE)

# convert datetime to POSIXct
harMetDaily15.09.11$date<-as.Date(harMetDaily15.09.11$date)


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
  geom_point(na.rm=TRUE,color="blue",size=3,pch=20) +
  ggtitle("Air Temperature 2009-2011") +
  xlab("Date") + ylab("Air Temperature")

#posso assegnarlo a un oggetto ma non renderizza automaticamente
AirTempDaily <- ggplot(harMetDaily15.09.11,aes(date,airt)) +
  geom_point(na.rm=TRUE,color="purple",size=3,pch=20) +
  ggtitle("Air Temperature 2009-2011") +
  xlab("Date") + ylab("Air Temperature")

#cambio formato plot date
AirTempDailyb <- AirTempDaily +
  (scale_x_date(labels=date_format("%b %y")))
AirTempDailyb

#cambio formato plot date per averlo 
#ogni 6 mesi invece che uno annuo
AirTempDaily_6mo <- AirTempDaily +
  (scale_x_date(breaks=date_breaks("6 months"),labels=date_format("%b %y")))
AirTempDaily_6mo

#cambio formato plot date per averlo 
#uno annuo invece che ogni 6 mesi
AirTempDaily_1y <- AirTempDaily +
  (scale_x_date(breaks=date_breaks("1 year"),labels=date_format("%b %y")))
AirTempDaily_1y


#limitato a un periodo tutto avviene in scale_x_date
startTime <- as.Date("2011-01-01")
endTime <- as.Date("2012-01-01")
start.end <- c(startTime,endTime)
start.end

AirTempDaily_2011 <- ggplot(harMetDaily15.09.11,aes(date,airt)) +
  geom_point(na.rm=TRUE,color="green",size=2) +
  ggtitle("Air Temperature 2009-2011") +
  xlab("Date") + ylab("Air Temperature") +
  (scale_x_date(limits = start.end,
                breaks=date_breaks("1 year"),
                labels = date_format("%b %y")))
AirTempDaily_2011

#usando temi
AirTempDaily_bw <- AirTempDaily_1y +
  theme_bw()
AirTempDaily_bw

# install additional themes
# install.packages('ggthemes', dependencies = TRUE)
library(ggthemes)
AirTempDaily_economist <- AirTempDaily_1y +
  theme_economist() + scale_colour_economist()
AirTempDaily_economist

#Si puo customizzare il tema a piacimento
# format x axis with dates
AirTempDaily_custom<-AirTempDaily_1y +
  # theme(plot.title) allows to format the Title seperately from other text
  theme(plot.title = element_text(lineheight=.8, face="bold",size = 20)) +
  # theme(text) will format all text that isn't specifically formatted elsewhere
  theme(text = element_text(size=18)) 
AirTempDaily_custom

#barplot con ggplot
PrecipDailyBarA <- ggplot(harMetDaily15.09.11,aes(date,prec)) +
  geom_bar(stat = "identity",na.rm=TRUE) +
  ggtitle("Daily Precipitation") +
  xlab("Date") + ylab("Precipitation (mm)") +
  scale_x_date(labels = date_format("%b %y"), breaks=date_breaks("1 year")) +
  theme(plot.title = element_text(lineheight = .8,face="bold",size=20)) +
  theme(text=element_text(size=18))
PrecipDailyBarA

# specifying color by name
PrecipDailyBarB <- PrecipDailyBarA +
  geom_bar(stat="identity", colour="darkblue")
PrecipDailyBarB

#Plot con linee
AirTempDaily_line <- ggplot(harMetDaily15.09.11, aes(date, airt)) +
  geom_line(na.rm=TRUE, color="grey") +  
  geom_point(na.rm=TRUE, color="brown",size=1) +
  ggtitle("Air Temperature \n 2009-2011") +
  xlab("Date") + ylab("Air Temperature (C)") +
  scale_x_date(labels=date_format ("%b %y"), breaks=date_breaks("4 months")) +
  theme(plot.title = element_text(lineheight=.8, face="bold", 
                                  size = 20)) +
  theme(text = element_text(size=18))

AirTempDaily_line

# linee di trend sul plot
AirTempDaily_trend <- AirTempDaily + stat_smooth(colour="green")
AirTempDaily_trend

## ----plot-airtemp-Monthly, echo=FALSE------------------------------------
AirTempMonthly <- ggplot(harTemp.monthly.09.11, aes(date, mean_airt)) +
  geom_point() +
  ggtitle("Average Monthly Air Temperature\n 2009-2011\n NEON Harvard Forest") +
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
  theme(text = element_text(size=18)) +
  xlab("Date") + ylab("Air Temperature (C)") +
  scale_x_date(labels=date_format ("%b%y"))

AirTempMonthly

# note - be sure library(gridExtra) is loaded!
# stack plots in one column 
grid.arrange(AirTempDaily, AirTempMonthly, ncol=1)

grid.arrange(AirTempDaily, AirTempMonthly, ncol=2)
