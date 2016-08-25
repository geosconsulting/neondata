library(raster)
library(rgdal)
library(rasterVis)

NDVI_HARV_path <- "NEON-DS-LandSat-NDVI/HARV/2011/NDVI"
all_NDVI_HARV <- list.files(NDVI_HARV_path,
                            full.names=T,
                            pattern = ".tif$")

# Create a time series raster stack
NDVI_HARV_stack <- stack(all_NDVI_HARV)

# apply scale factor
NDVI_HARV_stack <- NDVI_HARV_stack/10000

# view a histogram of all of the rasters
# nc specifies number of columns
plot(NDVI_HARV_stack, 
     zlim = c(.15, 1), 
     nc = 4)

levelplot(NDVI_HARV_stack,
          main="Landsat NDVI\n Forest")

cols <- colorRampPalette(brewer.pal(9,"YlGn"))
levelplot(NDVI_HARV_stack,
          main="Landsat NDVI\n Forest",
          col.regions=cols)

names(NDVI_HARV_stack)
rasterNames <- gsub("X","Day ",names(NDVI_HARV_stack))
rasterNames <- gsub("_HARV_ndvi_crop","",rasterNames)
rasterNames

levelplot(NDVI_HARV_stack,
          layout=c(5,3),
          main="Landsat NDVI\n Forest",
          col.regions=cols,
          names.attr = rasterNames)
