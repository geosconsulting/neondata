# load required libraries
# for vector work; sp package will load with rgdal.
library(rgdal)  
# for metadata/attributes- vectors or rasters
library(raster) 

# set working directory to the directory location on your computer where
# you downloaded and unzipped the data files for the tutorial
# setwd("pathToDirHere")

# Import a polygon shapefile: readOGR("path","fileName")
# no extension needed as readOGR only imports shapefiles
aoiBoundary_HARV <- readOGR("NEONDSSiteLayoutFiles/HARV", "HarClip_UTMZ18")

# view just the class for the shapefile
class(aoiBoundary_HARV)

## [1] "SpatialPolygonsDataFrame"
## attr(,"package")
## [1] "sp"

# view just the crs for the shapefile
crs(aoiBoundary_HARV)

## CRS arguments:
##  +proj=utm +zone=18 +datum=WGS84 +units=m +no_defs +ellps=WGS84
## +towgs84=0,0,0

# view just the extent for the shapefile
extent(aoiBoundary_HARV)

# alternate way to view attributes 
aoiBoundary_HARV@data

# view a summary of metadata & attributes associated with the spatial object
summary(aoiBoundary_HARV)

# create a plot of the shapefile
# 'lwd' sets the line width
# 'col' sets internal color
# 'border' sets line color
plot(aoiBoundary_HARV, col="cyan1", border="black", lwd=3, main="AOI Boundary Plot")

aoiRoads_HARV <- readOGR("NEONDSSiteLayoutFiles/HARV", "HARV_roads")
aoiTower_HARV <- readOGR("NEONDSSiteLayoutFiles/HARV", "HARVtower_UTM18N")
aoiCanopyModel <-raster("NEONDSAirborneRemoteSensing/HARV/CHM/HARV_chmCrop.tif")

# Plot multiple shapefiles
plot(aoiCanopyModel,  main="Map of Study Area w/ \nCanopy Height Model")
plot(aoiBoundary_HARV, add = TRUE)
plot(aoiRoads_HARV, add = TRUE)

# use the pch element to adjust the symbology of the points
plot(aoiTower_HARV, add  = TRUE, pch = 19, col = "purple")
