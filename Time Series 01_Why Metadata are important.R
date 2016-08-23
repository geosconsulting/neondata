#library(devtools)
#install_github("ropensci/EML", build=FALSE, dependencies=c("DEPENDS", "IMPORTS"))

library("EML")
library(ggmap)

eml_HARV <- read_eml("http://harvardforest.fas.harvard.edu/data/eml/hf001.xml")
object.size(eml_HARV)
class(eml_HARV)

eml_HARV@dataset@creator
eml_HARV@dataset@methods

XCoord <- eml_HARV@dataset@coverage@geographicCoverage[[1]]@boundingCoordinates@westBoundingCoordinate@.Data
YCoord <- eml_HARV@dataset@coverage@geographicCoverage[[1]]@boundingCoordinates@northBoundingCoordinate@.Data

map <- get_map(location='massachusetts', maptype = "toner", zoom =9)

ggmap(map,extent = TRUE) + 
  geom_point(aes(x=as.numeric(XCoord),
                 y=as.numeric(YCoord)),
             color="darkred",size=6,pch=18)

