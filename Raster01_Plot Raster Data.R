library(raster)
library(rgdal)

# Load raster into R
DSM_HARV <- raster("NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")
plot(DSM_HARV,main="Digital Surface Model")

# import DSM hillshade
DSM_hill_HARV <- 
  raster("NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_DSMhill.tif")

DSMhist <- hist(DSM_HARV,
                breaks=3,
                main="Histogram Digital Surface",
                col="wheat3",
                xlab="Elevation (m)")

DSMhist$breaks
DSMhist$counts

# plot using breaks.
plot(DSM_HARV, 
     breaks = c(300, 350, 400, 450), 
     col = terrain.colors(3),
     main="Digital Surface Model (DSM)\n NEON Harvard Forest Field Site")

myCol <- terrain.colors(3)
# plot using breaks.
plot(DSM_HARV, 
     breaks = c(300, 350, 400, 450), 
     col = myCol,
     main="Digital Surface Model (DSM)\n NEON Harvard Forest Field Site",
     xlab="UTM Westing Coords",
     ylab="UTM Northing Coords")

# rimuovere lee coordinate di plottaggio
plot(DSM_HARV, 
     breaks = c(300, 350, 400, 450), 
     col = myCol,
     main="Digital Surface Model (DSM)\n NEON Harvard Forest Field Site",
     axes=FALSE)


DSMhist_6 <- hist(DSM_HARV,
                breaks=6,
                main="Histogram Digital Surface",
                col="wheat3",
                xlab="Elevation (m)")

col6valori <- terrain.colors(6)
# rimuovere lee coordinate di plottaggio
plot(DSM_HARV, 
     breaks = DSMhist_6$breaks, 
     col = col6valori,
     main="Digital Surface Model (DSM)\n NEON Harvard Forest Field Site",
     axes=FALSE)

# plot hillshade using a grayscale color ramp that looks like shadows.
plot(DSM_hill_HARV,
     col=grey(1:100/100),  # create a color ramp of grey colors
     legend=FALSE,
     main="Hillshade - DSM\n NEON Harvard Forest Field Site",
     axes=FALSE)

#Lo metto sopra allo shaded per avere l'effetto bantu
plot(DSM_HARV,
     col=rainbow(100),
     alpha=0.4,
     add=T,
     legend=F)
