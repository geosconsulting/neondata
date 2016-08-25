library(raster)
library(rgdal)

# Load raster into R
DTM_HARV <- raster("NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif")
DTM_hill_HARV <- raster("NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_DTMhill_WGS84.tif")

# plot hillshade using a grayscale color ramp 
plot(DTM_hill_HARV,
     col=grey(1:100/100),
     legend=FALSE,
     main="DTM Hillshade\n NEON Harvard Forest Field Site")

# overlay the DTM on top of the hillshade
plot(DTM_HARV,
     col=terrain.colors(10),
     alpha=1,
     add=F,
     legend=FALSE)

crs(DTM_HARV)
crs(DTM_hill_HARV)

# reproject to UTM
DTM_hill_UTMZ18N_HARV <- projectRaster(DTM_hill_HARV, 
                                       crs=crs(DTM_HARV))

# compare attributes of DTM_hill_UTMZ18N to DTM_hill
crs(DTM_hill_UTMZ18N_HARV)
extent(DTM_hill_UTMZ18N_HARV)
extent(DTM_hill_HARV)

# compare resolution
res(DTM_hill_UTMZ18N_HARV)

# adjust the resolution 
DTM_hill_UTMZ18N_HARV <- projectRaster(DTM_hill_HARV, 
                                       crs=crs(DTM_HARV),
                                       res=1)
# view resolution
res(DTM_hill_UTMZ18N_HARV)

# plot newly reprojected hillshade
plot(DTM_hill_UTMZ18N_HARV,
     col=grey(1:100/100),
     legend=F,
     main="DTM with Hillshade\n NEON Harvard Forest Field Site")

# overlay the DTM on top of the hillshade
plot(DTM_HARV,
     col=rainbow(100),
     alpha=0.4,
     add=T,
     legend=F)
