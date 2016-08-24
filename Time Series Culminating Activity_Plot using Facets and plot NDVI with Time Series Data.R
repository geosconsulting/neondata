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

str(harMetDaily15.09.11)

# read in the NDVI CSV data; if you dont' already have it 
NDVI.2011 <- read.csv(
  file="NEON-DS-Met-Time-Series/HARV/NDVI/meanNDVI_HARV_2011.csv", 
  stringsAsFactors = FALSE
)

# check out the data
str(NDVI.2011)

# convert datetime to POSIXct
harMetDaily15.09.11$date<-as.Date(harMetDaily15.09.11$date)
NDVI.2011$Date<-as.Date(NDVI.2011$Date)

harMetDaily15.09.11$year <- year(harMetDaily15.09.11$date)

harMet.daily2011 <- filter(harMetDaily15.09.11,year==2011)

# plot NDVI by date
plot.NDVI.2011<-ggplot(NDVI.2011, aes(Date, meanNDVI))+
  geom_point(colour = "forestgreen", size = 4) +
  ggtitle("Daily NDVI Forest, 2011")+
  theme(legend.position = "none",
        plot.title = element_text(lineheight=.8, face="bold",size = 20),
        text = element_text(size=20))

# plot PAR daily
plot.par.2011<-ggplot(harMet.daily2011, aes(date, part))+
  geom_point(colour = "black", size = 2) +
  ggtitle("Daily PAR, 2011")+
  theme(legend.position = "none",
        plot.title = element_text(lineheight=.8, face="bold",size = 20),
        text = element_text(size=20))

grid.arrange(plot.par.2011, plot.NDVI.2011)

limits_plot=c(min=min(NDVI.2011$Date),max=max(NDVI.2011$Date))

# plot PAR
plot2.par.2011 <- plot.par.2011 +
  scale_x_date(labels = date_format("%b %d"),
               date_breaks = "3 months",
               date_minor_breaks= "1 week",
               limits=limits_plot) +
                ylab("Total PAR") + 
                xlab ("")

# plot NDVI
plot2.NDVI.2011 <- plot.NDVI.2011 +
  scale_x_date(labels = date_format("%b %d"),
               date_breaks = "3 months", 
               date_minor_breaks= "1 week",
               limits=limits_plot)+
  ylab("Total NDVI") + xlab ("Date")

# Output with both plots
grid.arrange(plot2.par.2011, plot2.NDVI.2011) 
