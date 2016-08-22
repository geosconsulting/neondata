library(rgdal)
library(raster)

# Import the line shapefile
aoiBoundary_HARV <- readOGR( "NEONDSSiteLayoutFiles/HARV", "HarClip_UTMZ18")
lines_HARV <- readOGR( "NEONDSSiteLayoutFiles/HARV", "HARV_roads")
point_HARV <- readOGR( "NEONDSSiteLayoutFiles/HARV", "HARVtower_UTM18N")
chm_HARV <- raster("NEONDSAirborneRemoteSensing/HARV/CHM/HARV_chmCrop.tif")

plot(chm_HARV,main="LiDAR CHM - Forest Field Site")

chm_HARV_Crop <- crop(chm_HARV,aoiBoundary_HARV)
plot(extent(chm_HARV),
     lwd=4,
     col="springgreen",
     main="LiDAR Cropped",
     xlab="easting",
     ylab="northing")

plot(chm_HARV_Crop,add=TRUE)

# lets look at the extent of all of our objects
extent(chm_HARV)
extent(chm_HARV_Crop)
extent(aoiBoundary_HARV)

location_from_csv <- readOGR(".","Plotlocation_HARV")
plot(location_from_csv)
plot(chm_HARV_Crop,add=TRUE)
plot(location_from_csv)

rec1_punti<-extent(location_from_csv)
plot(rec1_punti,col="red")

rec2_lidar_tagliato<-extent(chm_HARV_Crop)
plot(rec2_lidar_tagliato,add=TRUE)

# extent format (xmin,xmax,ymin,ymax)
new.extent <- extent(732161.2, 732238.7, 4713249, 4713333)
class(new.extent)

# crop raster
CHM_HARV_manualCrop <- crop(x = chm_HARV, y = new.extent)

# plot extent boundary and newly cropped raster
plot(aoiBoundary_HARV, 
     main = "Manually Cropped Raster\n NEON Harvard Forest Field Site")
plot(new.extent, 
     col="brown", 
     lwd=4,
     add = TRUE)
plot(CHM_HARV_manualCrop, 
     add = TRUE)

tree_height <- extract(x=chm_HARV,
                       y=aoiBoundary_HARV,
                       df=TRUE)
hist(tree_height$HARV_chmCrop)
head(tree_height)
nrow(tree_height)
plot(chm_HARV)
plot(aoiBoundary_HARV,add=TRUE)

# view histogram of tree heights in study area
hist(tree_height$HARV_chmCrop, 
     main="Histogram of CHM Height Values (m) \nNEON Harvard Forest Field Site",
     col="springgreen",
     xlab="Tree Height", ylab="Frequency of Pixels")

summary(tree_height$HARV_chmCrop)

av_tree_heigth_AOI <- extract(x=chm_HARV,
                              y=aoiBoundary_HARV,
                              fun=mean,
                              df=TRUE)
av_tree_heigth_AOI

crs(point_HARV)

av_tree_heigth_tower <- extract(x=chm_HARV,
                                y=point_HARV,
                                buffer=20,
                                fun=mean,
                                df=TRUE)
head(av_tree_heigth_tower)
nrow(av_tree_heigth_tower)