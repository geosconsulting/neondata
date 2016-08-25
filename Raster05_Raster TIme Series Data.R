library(raster)
library(rgdal)

NDVI_HARV_path <- "NEON-DS-LandSat-NDVI/HARV/2011/NDVI"
all_NDVI_HARV <- list.files(NDVI_HARV_path,
                            full.names=T,
                            pattern = ".tif$")
all_NDVI_HARV

# Create a raster stack of the NDVI time series
NDVI_HARV_stack <- stack(all_NDVI_HARV)

crs(NDVI_HARV_stack)
extent(NDVI_HARV_stack)

# view the y resolution of our rasters
yres(NDVI_HARV_stack)

# view the x resolution of our rasters
xres(NDVI_HARV_stack)

# view a plot of all of the rasters
# 'nc' specifies number of columns (we will have 13 plots)
#plot(NDVI_HARV_stack, 
#     zlim = c(1500, 10000), 
#     nc = 4)

# apply scale factor to data
#il RASTER e' stato moltiplicato per avere valori interi che fanno il raster piu piccolo
NDVI_HARV_stack <- NDVI_HARV_stack/10000
# plot stack with scale factor applied
# apply scale factor to limits to ensure uniform plottin
plot(NDVI_HARV_stack,
     zlim = c(.15, 1),  
     nc = 4)

# create histograms of each raster
hist(NDVI_HARV_stack, xlim = c(0, 1))

Landsat_HARV_path <- "NEON-DS-LandSat-NDVI/HARV/2011/RGB"
all_Landsat_HARV <- list.files(Landsat_HARV_path,
                            full.names=T,
                            pattern = ".tif$")
all_Landsat_HARV

Landsat_HARV_stack <- stack(all_Landsat_HARV)
plot(Landsat_HARV_stack[[11]])
plot(Landsat_HARV_stack[[12]])
par(mfrow=c(2,2))
plot(Landsat_HARV_stack)
par(mfrow=c(1,1))
