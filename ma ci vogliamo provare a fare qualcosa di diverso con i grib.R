library(rgdal)
library(raster)
library(rasterVis)

fname = "C:/meteorological/ecmwf/1_gribs_from_ecmwf/ElHonNicGua_2604_08_09_19792016.grib"
GDALinfo(fname)

#LOCALI
gribs<-raster(fname)
nbands(gribs)
crs(gribs)
extent(gribs)

gribdata = readGDAL(fname)
summary(gribdata)

gribdata@grid
gribdata@bbox
gribdata@proj4string
gribdata@data

banda1 <- gribdata@data$band1
banda1
pixel_1_1 <- gribdata@data[[1,1]]
banda1[1:10]

banda5 <- gribdata@data[[5]]
banda5

grib_stack <- stack(gribdata)
grib_stack@crs
grib_stack@layers[[200]]

hist(grib_stack[200],breaks=10)
#plot(grib_stack[1:370])
plot(grib_stack,col=terrain.colors(10))
primi_10_giorni = grib_stack@layers[[1]] + grib_stack@layers[[2]] +
                  grib_stack@layers[[3]] + grib_stack@layers[[4]] +
                  grib_stack@layers[[5]] + grib_stack@layers[[6]] +
                  grib_stack@layers[[7]] + grib_stack@layers[[8]] +
                  grib_stack@layers[[9]] + grib_stack@layers[[10]]
plot(primi_10_giorni)


sum(grib_stack[1:10,])
sum(grib_stack[11:20,])

MeanDaGribs <- mean(grib_stack)
writeRaster(MeanDaGribs,"mean_26Ago2016_daR.tiff", format="GTiff", overwrite=TRUE, NAflag=-9999)

hist(mean,breaks=25)
hist(last,breaks=25)
hist(anm,breaks=25)

MedianDaGribs <- calc(grib_stack,median)
writeRaster(MedianDaGribs,"median_26Ago2016_daR.tiff", format="GTiff", overwrite=TRUE, NAflag=-9999)

hist(MeanDaGribs,breaks=15)
hist(MedianDaGribs,breaks=15)

SDDaGribs <- calc(grib_stack,sd)
writeRaster(SDDaGribs,"sd_26Ago2016_daR.tiff", format="GTiff", overwrite=TRUE, NAflag=-9999)

