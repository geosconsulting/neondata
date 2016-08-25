library(raster)
library(rgdal)
library(ggplot2)

NDVI_HARV_path <- "NEON-DS-LandSat-NDVI/HARV/2011/NDVI"
all_NDVI_HARV <- list.files(NDVI_HARV_path,
                            full.names=T,
                            pattern = ".tif$")

# Create a time series raster stack
NDVI_HARV_stack <- stack(all_NDVI_HARV)

# apply scale factor
NDVI_HARV_stack <- NDVI_HARV_stack/10000

# calculate mean NDVI for each raster
avg_NDVI_HARV <- cellStats(NDVI_HARV_stack,mean)

# convert output array to data.frame
avg_NDVI_HARV <- as.data.frame(avg_NDVI_HARV)

names(avg_NDVI_HARV) <- "meanNDVI"
avg_NDVI_HARV$site <- "HARV"
avg_NDVI_HARV$year <- "2011"

head(avg_NDVI_HARV)

# note the use of the vertical bar character ( | ) is equivalent to "or". This
# allows us to search for more than one pattern in our text strings.
julianDays <- gsub(pattern = "X|_HARV_ndvi_crop", #the pattern to find 
                   x = row.names(avg_NDVI_HARV), #the object containing the strings
                   replacement = "") #what to replace each instance of the pattern with

# alternately you can include the above code on one single line
# julianDays <- gsub("X|_HARV_NDVI_crop", "", row.names(avg_NDVI_HARV))

# make sure output looks ok
head(julianDays)
avg_NDVI_HARV$julianDay <- julianDays

origin <- as.Date("2011-01-01")
avg_NDVI_HARV$julianDay <- as.integer(avg_NDVI_HARV$julianDay)
avg_NDVI_HARV$Date <- origin + (avg_NDVI_HARV$julianDay-1)

head(avg_NDVI_HARV)
class(avg_NDVI_HARV$julianDay)

ggplot(avg_NDVI_HARV,aes(julianDay,meanNDVI), na.rm=TRUE) +
  geom_point(size=4,colour="PeachPuff4") +
  ggtitle("Landsat Derived NDVI - 2011 \n Field Forest Site") +
  xlab("Julian Days") + ylab("Mean NDVI") +
  theme(text=element_text(size=10))


NDVI_SJER_path <- "NEON-DS-LandSat-NDVI/SJER/2011/NDVI"
all_NDVI_SEJR <- list.files(NDVI_SJER_path,
                            full.names=T,
                            pattern = ".tif$")

# Create a time series raster stack
NDVI_SJER_stack <- stack(all_NDVI_SEJR)


# apply scale factor
NDVI_SJER_stack <- NDVI_SJER_stack/10000
plot(NDVI_SJER_stack)
