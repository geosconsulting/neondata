#use the code below to install the rhdf5 library if it's not already installed.
#source("http://bioconductor.org/biocLite.R")
#biocLite("rhdf5")
library(raster)
library(rhdf5)
library(rgdal)
library(maps)

f<- 'SJER_140123_chip.h5'
h5ls(f,all=T)

spInfo <- h5readAttributes(f,"spatialInfo")
myCrs <- spInfo$projdef
res <- spInfo$xscale

mapInfo <-h5read(f,"map info")
mapInfo<-unlist(strsplit(mapInfo,","))

xMin<-as.numeric(mapInfo[4])
yMax<-as.numeric(mapInfo[5])

reflInfo<-h5readAttributes(f,"Reflectance")

nRows<-reflInfo$row_col_band[1]
nCols<-reflInfo$row_col_band[2]
nBands<-reflInfo$row_col_band[3]

myNoDataValue<-reflInfo$'data ignore value'

band2raster <- function(file,band,noDataValue,xMin,yMin,res,crs){
  out <- h5read(f,"Reflectance",index=list(1:nCols,1:nRows,band))
  out<- (out[,,1])
  out<-t(out)
  out[out==noDataValue]<-NA
  outr <- raster(out,crs=myCrs)
  xMax<-xMin+(outr@ncols*res)
  yMin<-yMax-(outr@ncols*res)
  
  rasExt<- extent(xMin,xMax,yMin,yMax)
  extent(outr) <-rasExt
  
  return(outr)
  
}

rgb <- list(58,34,19)

rgb_rast <- lapply(rgb, band2raster,file=f,
                   noDataValue=myNoDataValue,
                   xMin=xMin,yMin=yMin,res=1,
                   crs=myCrs)

rgb_rast

hsiStack <- stack(rgb_rast)
#Genero i nomi delle bande manualmente
bandNames <- paste("Band_",unlist(rgb),sep="")

#li applico alle bande dello stack
names(hsiStack) <- bandNames
hsiStack <- hsiStack/reflInfo$`Scale Factor`

plot(hsiStack$Band_58,main="Band 58")

myCol <- terrain.colors(25)
image(hsiStack$Band_58,main="Band 58",col=myCol)

#adjust the zlims or the stretch of the image
image(hsiStack$Band_58, main="Band 58", col=myCol, zlim = c(0,.5))

#try a different color palette
myCol=topo.colors(15, alpha = 1)
image(hsiStack$Band_58, main="Band 58", col=myCol, zlim=c(0,.5))

# create a 3 band RGB image
plotRGB(hsiStack,
        r=1,g=2,b=3, scale=300, 
        stretch = "Lin")

writeRaster(hsiStack,file="rgbImage.tif",format="GTiff",oversrite=T)

#Color Infrared / False Color: rgb: (90,34,19)
cinf <- list(90,34,19)
cinf_rast <- lapply(cinf, band2raster,file=f,
                   noDataValue=myNoDataValue,
                   xMin=xMin,yMin=yMin,res=1,
                   crs=myCrs)

cinf_Stack <- stack(cinf_rast)
plotRGB(cinf_Stack,
        r=1,g=2,b=3, scale=300, 
        stretch = "Lin")

#SWIR, NIR,Red Band – rgb (152,90,58)
swir <- list(90,34,19)
swir_rast <- lapply(swir, band2raster,file=f,
                    noDataValue=myNoDataValue,
                    xMin=xMin,yMin=yMin,res=1,
                    crs=myCrs)

swir_Stack <- stack(swir_rast)
plotRGB(swir_Stack,
        r=1,g=2,b=3, scale=300, 
        stretch = "Lin")

#False Color: – rgb (363,246,55)
fcol <- list(363,364,55)
fcol_rast <- lapply(fcol, band2raster,file=f,
                    noDataValue=myNoDataValue,
                    xMin=xMin,yMin=yMin,res=1,
                    crs=myCrs)

fcol_Stack <- stack(fcol_rast)
plotRGB(fcol_Stack,
        r=1,g=2,b=3, scale=300, 
        stretch = "Lin")

map(database="state",region="california")
points(spInfo$LL_lat~spInfo$LL_lon,pch=15)
title(main="San Joaquin Field Site")

ndvi_bands <- c(58,90)
ndvi_rast <- lapply(ndvi_bands,band2raster,file=f,noDataValue=15000,
                    xMin=xMin,yMin=yMin,
                    crs=myCrs,res=1)
ndvi_stack<- stack(ndvi_rast)

bandNDVINames <- paste("Band_",unlist(ndvi_bands),sep="")
names(ndvi_stack) <- bandNDVINames

ndvi_stack

NDVI <- function(x){
  (x[,2]-x[,1])/(x[,2]+x[,1])
}

ndvi_calc <- calc(ndvi_stack,NDVI)
plot(ndvi_calc,main="NDVI for the field site")

mycolNDVI <- terrain.colors(3)
brk<-c(0,.4,.7,.9)

plot(ndvi_calc,main="NDVI for the Field Site",col=mycolNDVI,breaks=brk)
