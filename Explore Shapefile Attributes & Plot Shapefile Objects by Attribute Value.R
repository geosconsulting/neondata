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
lines_HARV <- readOGR("NEONDSSiteLayoutFiles/HARV", "HARV_roads")
point_HARV <- readOGR("NEONDSSiteLayoutFiles/HARV", "HARVtower_UTM18N")

class(x=point_HARV)
length(lines_HARV)
length(lines_HARV@data)
extent(lines_HARV)
crs(lines_HARV)

names(lines_HARV@data)
names(point_HARV@data)

head(lines_HARV@data)
levels(lines_HARV@data$TYPE)
plot(lines_HARV@data$TYPE)

lines_HARV$TYPE
table(lines_HARV$TYPE)

lines_HARV[lines_HARV$type == "footpath",]

footpath_HARV <- lines_HARV[lines_HARV$TYPE == "footpath",]
footpath_HARV
length(footpath_HARV)
length(lines_HARV)

plot(lines_HARV,col='red')
plot(footpath_HARV,add=TRUE,col=c("green","blue"),lwd=6)

#per usare i valori per classificare deve essere tipo "factor" verifichiamo
class(lines_HARV$TYPE)
levels(lines_HARV$TYPE)
summary(lines_HARV$TYPE)

# create a color palette of 4 colors - one for each factor level
roadPalette <- c("blue","green","grey","purple")
roadPalette

## [1] "blue"   "green"  "grey"   "purple"

# create a vector of colors - one for each feature in our vector object
# according to its attribute value
roadColors <- c("blue","green","grey","red")[lines_HARV$TYPE]
roadColors

# plot the lines data, apply a diff color to each factor level)
# plot(lines_HARV, 
#      col=roadColors,
#      lwd=6,
#      main="NEON Harvard Forest Field Site\n Roads & Trails")

# create vector of line widths
lineWidths <- (c(1,2,3,4))[lines_HARV$TYPE]
# adjust line width by level
# in this case, boardwalk (the first level) is the widest.
plot(lines_HARV, 
     col=roadColors,
     main="NEON Harvard Forest Field Site\n Roads & Trails \n Line width varies by TYPE Attribute Value",
     lwd=lineWidths)

legend("bottomright",
       legend = levels(lines_HARV$TYPE),
       fill=roadPalette,
       bty = "n",
       cex=.8)
