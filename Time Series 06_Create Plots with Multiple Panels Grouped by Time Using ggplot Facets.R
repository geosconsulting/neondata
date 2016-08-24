# Remember it is good coding technique to add additional 
# libraries to the top of your script 
library(lubridate) # for working with dates
library(ggplot2)  # for creating graphs
library(scales)   # to access breaks/formatting functions
library(gridExtra) # for arranging plots
library(grid)   # for arrangeing plots
library(dplyr)  # for subsetting by season
library(zoo)

harMetDaily15.09.11 <- read.csv(
  file="NEON-DS-Met-Time-Series/HARV/FisherTower-Met/Met_HARV_Daily_2009_2011.csv",
  stringsAsFactors = FALSE)

# convert datetime to POSIXct
harMetDaily15.09.11$date<-as.Date(harMetDaily15.09.11$date)

AirTempDaily <- ggplot(harMetDaily15.09.11,aes(date,airt)) +
  geom_point() +
  ggtitle("Daily Air temeprature \n 2009-2011") +
  xlab("Date") + ylab("Temprature (C)") +
  scale_x_date(labels = date_format("%m-%y"),breaks = date_breaks("6 months"))+
  theme(plot.title = element_text(lineheight = .8,face ="bold",size =20))+
  theme(text=element_text(size=18))
AirTempDaily

harMetDaily15.09.11$year <- year(harMetDaily15.09.11$date)
head(harMetDaily15.09.11$year)
tail(harMetDaily15.09.11$year)

AirTempDaily + facet_grid( . ~ year)

AirTempDaily_jd <- ggplot(harMetDaily15.09.11,aes(jd,airt)) +
  geom_point() +
  ggtitle("Daily Air temeprature \n 2009-2011") +
  xlab("Julian Day") + ylab("Temprature (C)") +
  #scale_x_date(labels = date_format("%m-%y"),breaks = date_breaks("6 months"))+
  theme(plot.title = element_text(lineheight = .8,face ="bold",size =20))+
  theme(text=element_text(size=18))
AirTempDaily_jd
AirTempDaily_jd + facet_grid( . ~ year)
AirTempDaily_jd + facet_grid(year ~ . )
AirTempDaily_jd + facet_wrap(~year,ncol=2)

harMetDaily15.09.11$month <- month(harMetDaily15.09.11$date)
airSoilTemp_Plot <- ggplot(harMetDaily15.09.11,aes(airt,s10t)) +
  geom_point() +
  ggtitle("Air vs. Soil Temperature \n 2009-2011") +
  xlab("Air Temperature (C)") + ylab("Soil Temperature (C)") +
  theme(plot.title = element_text(lineheight = .8,face = "bold", size = 20)) +
  theme(text=element_text(size=18))
airSoilTemp_Plot

# create faceted panel
airSoilTemp_Plot + facet_grid(year ~ .)
airSoilTemp_Plot + facet_wrap(~month,ncol=3)

# format e' la base fondamentale per formattare le date 
#ed estrarre parti dal campo che contiene le date
harMetDaily15.09.11$month_name <- format(harMetDaily15.09.11$date,"%B")
head(harMetDaily15.09.11$month_name)
tail(harMetDaily15.09.11$month_name)

airSoilTemp_Plot <- ggplot(harMetDaily15.09.11,aes(airt,s10t)) +
  geom_point() +
  ggtitle("Air vs. Soil Temperature \n 2009-2011") +
  xlab("Air Temperature (C)") + ylab("Soil Temperature (C)") +
  theme(plot.title = element_text(lineheight = .8,face = "bold", size = 20)) +
  theme(text=element_text(size=18))
airSoilTemp_Plot
airSoilTemp_Plot + facet_wrap(~month_name,ncol=3)

harMetDaily15.09.11$month_name <- factor(harMetDaily15.09.11$month_name,
                                      levels=c('January','February','March',
                                                  'April','May','June','July',
                                                  'August','September','October',
                                                  'November','December'))

airSoilTemp_Plot <- ggplot(harMetDaily15.09.11,aes(airt,s10t)) +
  geom_point() +
  ggtitle("Air vs. Soil Temperature \n 2009-2011") +
  xlab("Air Temperature (C)") + ylab("Soil Temperature (C)") +
  theme(plot.title = element_text(lineheight = .8,face = "bold", size = 20)) +
  theme(text=element_text(size=18))
airSoilTemp_Plot
airSoilTemp_Plot + facet_wrap(~month_name,ncol=3)

harMetDaily15.09.11 <- harMetDaily15.09.11 %>% 
  mutate(season = 
           ifelse(month %in% c(12, 1, 2), "Winter",
                  ifelse(month %in% c(3, 4, 5), "Spring",
                         ifelse(month %in% c(6, 7, 8), "Summer",
                                ifelse(month %in% c(9, 10, 11), "Fall", "Error")))))

head(harMetDaily15.09.11$season)
tail(harMetDaily15.09.11$season)

# recreate plot
airSoilTemp_Plot <- ggplot(harMetDaily15.09.11, aes(airt, s10t)) +
  geom_point() +
  ggtitle("Air vs. Soil Temperature\n 2009-2011\n Forest Field Site") +
  xlab("Air Temperature (C)") + ylab("Soil Temperature (C)") +
  theme(plot.title = element_text(lineheight=.8, face="bold",
                                  size = 20)) +
  theme(text = element_text(size=18))

# run this code to plot the same plot as before but with one plot per season
airSoilTemp_Plot + facet_grid(. ~ season)

# for a landscape orientation of the plots we change the order of arguments in
# facet_grid():
airSoilTemp_Plot + facet_grid(season ~ .)

met_monthly_HARV <- read.csv(
  "NEON-DS-Met-Time-Series/HARV/FisherTower-Met/hf001-04-monthly-m.csv",
  stringsAsFactors = FALSE)
met_monthly_HARV$date <- as.Date(as.yearmon(met_monthly_HARV$date))
