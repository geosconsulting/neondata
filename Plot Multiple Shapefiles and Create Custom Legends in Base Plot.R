library(rgdal)
library(raster)
library(sp)

# Import a polygon shapefile: readOGR("path","fileName")
# no extension needed as readOGR only imports shapefiles
aoiBoundary_HARV <- readOGR("NEONDSSiteLayoutFiles/HARV", "HarClip_UTMZ18")
lines_HARV <- readOGR("NEONDSSiteLayoutFiles/HARV", "HARV_roads")
point_HARV <- readOGR("NEONDSSiteLayoutFiles/HARV", "HARVtower_UTM18N")

levels(lines_HARV@data$TYPE)

# create vector of line widths
lineWidths <- (c(2,3,4,8))[lines_HARV$TYPE]


# create a color palette of 4 colors - one for each factor level
roadPalette <- c("blue","green","grey","purple")
roadPalette

## [1] "blue"   "green"  "grey"   "purple"

# create a vector of colors - one for each feature in our vector object
# according to its attribute value
roadColors <-roadPalette[lines_HARV$TYPE]
roadColors

# Plot multiple shapefiles
plot(aoiBoundary_HARV, 
     col = "grey93", 
     border="grey",
     main="NEON Harvard Forest Field Site")

plot(lines_HARV, 
     col=roadColors,
     add = TRUE)

plot(point_HARV, 
     add  = TRUE, 
     pch = 19, 
     col = "purple")

plot_HARV <- recordPlot()

labels <- c("Tower","AOI",levels(lines_HARV$TYPE))

plot_HARV

#legend cambia il testo della legenda
#bty toglie la linea itorno alla legenda
legend("bottomright",
       legend=labels,
       bty="n",
       cex = .8)

plotColors <- c("purple","grey",roadPalette)

plot_HARV

#fill d ai colori in legenda
legend("bottomright",
       legend=labels,
       fill=plotColors,
       bty="n",
       cex=.8)

plotSym <- c(16,15,15,15,15,15)

#pch cambia il tipo di simbolo nella legenda
legend("bottomright",
       legend=labels,
       pch=plotSym,
       bty="n",
       col = plotColors,
       cex = .8)

lineLegend= c(NA,NA,1,1,1,1)
#lty cambia il simbolo da poligono a linea
#sequenza due NON linee e 4 linee
legend("bottomright",
       legend=labels,
       pch=plotSym,
       bty="n",
       col = plotColors,
       cex = .8,
       lty=lineLegend)

