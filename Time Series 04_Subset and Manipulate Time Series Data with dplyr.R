library(lubridate)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(scales)

harMet15.09.11 <- read.csv(
  file="NEON-DS-Met-Time-Series/HARV/FisherTower-Met/Met_HARV_15min_2009_2011.csv",
  stringsAsFactors = FALSE)

# convert datetime to POSIXct
harMet15.09.11$datetime<-as.POSIXct(harMet15.09.11$datetime,
                                    format = "%Y-%m-%d %H:%M",
                                    tz = "America/New_York")

harMet15.09.11$year <- year(harMet15.09.11$datetime)
names(harMet15.09.11)

head(harMet15.09.11)
str(harMet15.09.11$year)

# Create a group_by object using the year column 
HARV.grp.year <- group_by(harMet15.09.11, # data_frame object
                          year) # column name to group by

# view class of the grouped object
class(HARV.grp.year)
tally(HARV.grp.year)

#LA MEAN RITORNA NA perche ci sono due NA nella serie
summarize(HARV.grp.year, mean(airt))
sum(is.na(HARV.grp.year$airt))

# where are the no data values
# just view the first 6 columns of data
HARV.grp.year[is.na(HARV.grp.year$airt),1:6]

#Rimuovo i NA e mi da la media
summarize(HARV.grp.year, mean(airt, na.rm=TRUE))

#CON Dyplr fai tutto creando una catena di comandi e giuntandoli con %>%
harMet15.09.11 %>%
  group_by(year) %>% 
  tally()

year.sum <- harMet15.09.11 %>%
            group_by(year) %>%
            summarize(mean(airt,na.rm=TRUE))

jday.avg <- harMet15.09.11 %>%
            group_by(jd) %>%
            summarize(mean_airt_jd = mean(airt,na.rm=TRUE))

qplot(jday.avg$jd,jday.avg$mean_airt_jd)

harMet15.09.11 %>%
  group_by(year,jd) %>% 
  tally()

harMet15.09.11 %>%
  group_by(year,jd) %>%
  summarize(mean_airt = mean(airt,na.rm = TRUE))

total.prec <- harMet15.09.11 %>%
        group_by(year,jd) %>%
        summarize(sum_airt = sum(airt))
            
qplot(total.prec$jd,total.prec$sum_airt)

#fa parte delle possibilit' usare ,mutate per aggiungere 
#campi ai dataframe intermedi con dplyr
harTemp.daily.09.11<-harMet15.09.11 %>%
      mutate(year2 = year(datetime)) %>%
      group_by(year2,jd) %>%
      summarize(mean_airt=mean(airt,na.rm=TRUE), datetime = first(datetime))
