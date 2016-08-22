library(rgdal)
library(raster)

# Read the .csv file
plot.locations_HARV <- 
  read.csv("NEONDSSiteLayoutFiles/HARV/HARV_PlotLocations.csv",
           stringsAsFactors = FALSE)

# look at the data structure
str(plot.locations_HARV)
names(plot.locations_HARV)

head(plot.locations_HARV$easting)
head(plot.locations_HARV$northing)

# note that  you can also call the same two columns using their COLUMN NUMBER
# view first 6 rows of the X and Y columns
head(plot.locations_HARV[,1])
head(plot.locations_HARV[,2])

# Import the line shapefile
lines_HARV <- readOGR( "NEONDSSiteLayoutFiles/HARV", "HARV_roads")

## OGR data source with driver: ESRI Shapefile 
## Source: "NEON-DS-Site-Layout-Files/HARV/", layer: "HARV_roads"
## with 13 features
## It has 15 fields

# view CRS
crs(lines_HARV)
extent(lines_HARV)

utm18nCRS <- crs(lines_HARV)
class(utm18nCRS)

plot.locationsSp_HARV <- SpatialPointsDataFrame(plot.locations_HARV[,1:2],
                                                plot.locations_HARV,
                                                proj4string = utm18nCRS)
crs(plot.locationsSp_HARV)
plot(plot.locationsSp_HARV,main="Map of Plot Locations")

# create boundary object 
aoiBoundary_HARV <- readOGR("NEONDSSiteLayoutFiles/HARV","HarClip_UTMZ18")
plot(aoiBoundary_HARV,main="Aoi Boundary")
plot(plot.locationsSp_HARV,pch=8,add=TRUE)

crs(aoiBoundary_HARV)
crs(plot.locationsSp_HARV)

extent(aoiBoundary_HARV)
extent(plot.locationsSp_HARV)

plot(extent(plot.locationsSp_HARV),
     col="purple", 
     xlab="easting",
     ylab="northing", lwd=8,
     main="Extent Boundary of Plot Locations \nCompared to the AOI Spatial Object",
     ylim=c(4712400,4714000)) # extent the y axis to make room for the legend

plot(extent(aoiBoundary_HARV), 
     add=TRUE,
     lwd=6,
     col="springgreen")

legend("bottomright",
       #inset=c(-0.5,0),
       legend=c("Layer One Extent", "Layer Two Extent"),
       bty="n", 
       col=c("purple","springgreen"),
       cex=.8,
       lty=c(1,1),
       lwd=6)

plotLoc.extent <- extent(plot.locationsSp_HARV)
plotLoc.extent

# grab the x and y min and max values from the spatial plot locations layer
xmin <- plotLoc.extent@xmin
xmax <- plotLoc.extent@xmax
ymin <- plotLoc.extent@ymin
ymax <- plotLoc.extent@ymax

# adjust the plot extent using x and ylim
plot(aoiBoundary_HARV,
     main="NEON Harvard Forest Field Site\nModified Extent",
     border="darkgreen",
     xlim=c(xmin,xmax),
     ylim=c(ymin,ymax))

plot(plot.locationsSp_HARV, 
     pch=8,
     col="purple",
     add=TRUE)

# add a legend
legend("bottomright", 
       legend=c("Plots", "AOI Boundary"),
       pch=c(8,NA),
       lty=c(NA,1),
       bty="n", 
       col=c("purple","darkgreen"),
       cex=.8)

writeOGR(plot.locationsSp_HARV,getwd(),"Plotlocation_HARV",driver="ESRI Shapefile")
