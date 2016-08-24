library(raster)
library(rgdal)

# Load raster into R
DSM_HARV <- raster("NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")

plot(DSM_HARV,main="Digital Surface Model")
