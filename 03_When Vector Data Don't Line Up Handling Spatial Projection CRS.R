library(rgdal)
library(raster)

# Read the .csv file
State.Boundary.US <- readOGR("NEONDSSiteLayoutFiles/US-Boundary-Layers",
                             "US-State-Boundaries-Census-2014")

head(State.Boundary.US@data)
class(State.Boundary.US)

# view column names
plot(State.Boundary.US, 
     main="Map of Continental US State Boundaries\n US Census Bureau Data")

# Read the .csv file
Country.Boundary.US <- readOGR("NEONDSSiteLayoutFiles/US-Boundary-Layers",
                               "US-Boundary-Dissolved-States")
class(Country.Boundary.US)

# view column names
plot(State.Boundary.US, 
     main="Map of Continental US State Boundaries\n US Census Bureau Data",
     border="gray40")

# view column names
plot(Country.Boundary.US, 
     lwd=4, 
     border="gray18",
     add=TRUE)

# Import a point shapefile 
point_HARV <- readOGR("NEONDSSiteLayoutFiles/HARV",
                      "HARVtower_UTM18N")

## OGR data source with driver: ESRI Shapefile 
## Source: "NEON-DS-Site-Layout-Files/HARV/", layer: "HARVtower_UTM18N"
## with 1 features
## It has 14 fields

class(point_HARV)

## [1] "SpatialPointsDataFrame"
## attr(,"package")
## [1] "sp"

# plot point - looks ok? 
plot(point_HARV, 
     pch = 19, 
     col = "purple",
     main="Harvard Fisher Tower Location")

crs(point_HARV)
crs(State.Boundary.US)
crs(Country.Boundary.US)

# reproject data
point_HARV_WGS84 <- spTransform(point_HARV, crs(State.Boundary.US))

# what is the CRS of the new object
crs(point_HARV_WGS84)

## CRS arguments:
##  +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0

# does the extent look like decimal degrees?
extent(point_HARV_WGS84)
extent(point_HARV)

# plot point - looks ok? 
plot(point_HARV_WGS84, 
     pch = 19, 
     col = "purple",
     main="Harvard Fisher Tower Location",
     add=TRUE)

