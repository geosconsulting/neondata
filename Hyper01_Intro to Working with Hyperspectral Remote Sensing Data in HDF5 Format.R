#use the code below to install the rhdf5 library if it's not already installed.
#source("http://bioconductor.org/biocLite.R")
#biocLite("rhdf5")
library(raster)
library(rhdf5)
library(rgdal)

f<- 'SJER_140123_chip.h5'
h5ls(f,all=T)
spInfo <- h5readAttributes(f,"spatialInfo")
spInfo

#r get attributes for the Reflectance dataset
reflInfo <- h5readAttributes(f,"Reflectance")
reflInfo

#read in the wavelength information from the HDF5 file
wavelengths<- h5read(f,"wavelength")
wavelengths

wavelengths[19]

nRows <- reflInfo$row_col_band[1]
nCols <- reflInfo$row_col_band[2]
nBands <- reflInfo$row_col_band[3]


#The HDF5 read function reads data in the order: Cols, Rows and bands
#This is different from how R reads data (rows, columns, bands). We'll adjust for 
#this later

#Extract or "slice" data for band 34 from the HDF5 file
b34 <- h5read(f,"Reflectance",index=list(1:nCols,1:nRows,34))

#Convertito in una matrice 
b34<-b34[,,1]

image(log(b34))
hist(b34,breaks=40,col="darkmagenta",xlim=c(0,5000))
hist(b34,breaks=40,col="darkmagenta",xlim=c(5000,15000),ylim=c(0,100))

myNoDataValue <- as.numeric(reflInfo$'data ignore value')
myNoDataValue

b34[b34==myNoDataValue]<-NA

image(log(b34))

b34 <- t(b34)
image(log(b34))

mapInfo <- h5read(f,"map info")
mapInfo <- unlist(strsplit(mapInfo,","))

res <- spInfo$xscale
xMin <- as.numeric(mapInfo[4])
yMax <- as.numeric(mapInfo[5])

xMax <- (xMin + (ncol(b34)*res))
yMin <- (yMax - (nrow(b34)*res))

rasExt <- extent(xMin,xMax,yMin,yMax)

extent(b34) <- rasExt
