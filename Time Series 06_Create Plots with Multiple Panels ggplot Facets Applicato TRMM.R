# Remember it is good coding technique to add additional 
# libraries to the top of your script 
library(lubridate) # for working with dates
library(ggplot2)  # for creating graphs
library(scales)   # to access breaks/formatting functions
library(gridExtra) # for arranging plots
library(grid)   # for arrangeing plots
library(dplyr)  # for subsetting by season

data.dir <- "C:/sparc/input_data/landslides/landslides_R/TRMM_2000_2015/"
cntry <- "india"
ext <- ".csv"

cntry.precipitation <- read.csv(
  file=paste(data.dir,cntry,ext,sep=""),
  stringsAsFactors = FALSE,
  skip = 6)

# convert datetime to POSIXct
cntry.precipitation$date<-as.Date(cntry.precipitation$time)
names(cntry.precipitation) <- c('time','prec','date')

cntry.precipitation$year <- year(cntry.precipitation$date)
# convert with yday into a new column "julian"
cntry.precipitation$julian <- yday(cntry.precipitation$date)

PrecDaily <- ggplot(cntry.precipitation,aes(julian,prec)) +
  geom_bar(stat = "identity",na.rm=TRUE) +
  ggtitle(paste("TRMM Precipitation 2000-2015 \n", cntry,sep="")) +
  xlab("Julian Day") + ylab("Precipitation (inches)") +
  # se plotto usando il julian day tutte le formattazioni sulle date saltano
  #  scale_x_date(labels = date_format("%m-%y"),breaks = date_breaks("1 year"))+
  theme(plot.title = element_text(lineheight = .8,face ="bold",size =20))+
  theme(text=element_text(size=18))
PrecDaily

PrecDaily + facet_grid(year ~ .)

PrecDaily + facet_wrap(~year,ncol=4)

