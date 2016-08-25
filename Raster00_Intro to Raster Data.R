library(raster)
library(rgdal)

nomefile <- "NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif"
# Load raster into R
DSM_HARV <- raster(nomefile)

plot(DSM_HARV,main="Digital Surface Model")

crs(DSM_HARV)
myCRS <- crs(DSM_HARV)

minValue(DSM_HARV)
maxValue(DSM_HARV)

# view histogram of data
hist(DSM_HARV,
     main="Distribution of Digital Surface Model Values\n 
            Histogram Default: 100,000 pixels",
     maxpixels=ncell(DSM_HARV),
     xlab="DSM Elevation Value (m)",
     ylab="Frequency",
     col="wheat")

# view histogram of data
hist(DSM_HARV,
     main="Distribution of Digital Surface Model Values\n 
            Histogram Default: 100,000 pixels",
     #con questo forzo il software a usare TUTTI i pixel
     # s el'immagine e' grande puo esser eproblematico
     maxpixels=ncell(DSM_HARV),
     xlab="DSM Elevation Value (m)",
     ylab="Frequency",
     col="wheat4")

#numero bande nel raster
nlayers(DSM_HARV)

GDALinfo(nomefile)

