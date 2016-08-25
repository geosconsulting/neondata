library(raster)

GDALinfo("NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif")
GDALinfo("NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")

# load the DTM & DSM rasters
DTM_HARV <- raster("NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif")
DSM_HARV <- raster("NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")

# create a quick plot of each to see what we're dealing with
plot(DTM_HARV, main="Digital Terrain Model \n Forest Field Site")
plot(DSM_HARV, main="Digital Surface Model \n Forest Field Site")

# Raster math example
CHM_HARV <- DSM_HARV - DTM_HARV 

# plot the output CHM
plot(CHM_HARV,
     main="Canopy Height Model - Raster Math Subtract\n NEON Harvard Forest Field Site",
     axes=FALSE) 

hist(CHM_HARV,
     breaks=25,
     col="springgreen4",
     main="Histogram of Canopy Heigth Model \n Forest Field Site",
     ylab="Nuber of Pixels",
     xlab="Tree Height (m)")

CHM_ov_HARV <- overlay(DSM_HARV,
                       DTM_HARV,
                       fun=function(r1,r2){return(r1-r2)})

plot(CHM_ov_HARV,
     main="Canopy Heigth Model - Overlay Substract")

writeRaster(CHM_ov_HARV, "chm_HARV.tiff",
            format="GTiff",
            overwrite=T,
            NAFlag=-9999)

# load the DTM & DSM rasters
DTM_SJER <- raster("NEON-DS-Airborne-Remote-Sensing/SJER/DTM/SJER_dtmCrop.tif")
DSM_SJER <- raster("NEON-DS-Airborne-Remote-Sensing/SJER/DSM/SJER_dsmCrop.tif")

CHM_ov_SJER <- overlay(DSM_SJER,
                    DTM_SJER,
                    fun=function(n1,n2){return(n1-n2)})

hist(CHM_ov_SJER,
     breaks=25,
     col="springgreen1",
     main="Histogram of Canopy Heigth Model \n SJER",
     ylab="Nuber of Pixels",
     xlab="Tree Height (m)")

writeRaster(CHM_ov_SJER, "chm_SJER.tiff",
            format="GTiff",
            overwrite=T,
            NAFlag=-9999)
