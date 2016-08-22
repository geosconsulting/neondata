library(raster)
library(sp)
library(rgdal)

band19 <- "rasterLayers_tif/band19.tif"
band34 <- "rasterLayers_tif/band34.tif"
band58 <- "rasterLayers_tif/band58.tif"

#create list of files to make raster stack
rasterlist <-  list.files('rasterLayers_tif', full.names=TRUE)

rasterlist_fab <- list(band19,band34,band58)

rgbRaster <- stack(rasterlist_fab)
plot(rgbRaster)

#plot an RGB version of the stack
plotRGB(rgbRaster,r=3,g=2,b=1, scale=800, stretch = "Lin")
hist(rgbRaster)
object.size(plotRGB)

#remember that crop function? You can crop all rasters within a raster stack too
#finally you can crop all rasters within a raster stack!
rgbCrop <- c(256770.7,256959,4112140,4112284)
rgbRaster_crop <- crop(rgbRaster, rgbCrop)
plot(rgbRaster_crop)

#create raster brick
RGBbrick <- brick(rgbRaster)
plotRGB(RGBbrick,r=3,g=2,b=1, scale=800, stretch = "Lin")

#the brick contains ALL of the data stored in one object
#the stack contains links or references to the files stored on your computer
object.size(RGBbrick)

#Make a new stack in the order we want the data in: 
finalRGBstack <- stack(rgbRaster$band58,rgbRaster$band34,rgbRaster$band19)
#write the geotiff - change overwrite=TRUE to overwrite=FALSE if you want to make sure you don't overwrite your files!
writeRaster(finalRGBstack,"rgbRaster.tif","GTiff", overwrite=TRUE)

#Import Multi-Band raster
newRaster <- stack("rgbRaster.tif") 
#then plot it
plot(newRaster)
plotRGB(newRaster,r=1,g=2,b=3, scale=800, stretch="lin")

plotRGB(rgbRaster,r=2,g=3,b=1, scale=800, stretch="lin")
