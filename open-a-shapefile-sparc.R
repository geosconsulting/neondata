library(rgdal)
library(raster)
library(ggmap)

paese <- readOGR("C:/sparc/input_data/countries", "El Salvador")
names(paese)
length(paese)
extent(paese)
crs(paese)

dati_paese <- paese@data

plot(paese,col="lightblue",border="blue")
plot(extent(paese),add=TRUE)
summary(paese@data)

# map <- get_map(location='egypt', maptype = "hybrid", zoom = 8)
# ggmap(map,extent = TRUE) + 
#   geom_polygon(aes(x=long, y=lat,group),
#                data = paese, color="white",fill="orangered4",alpha= .4,size=.2)

