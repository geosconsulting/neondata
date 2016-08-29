library(rgdal)
library(raster)
library(rasterVis)

#GLOBALI
# gribs<-raster("C:/meteorological/ecmwf/1_gribs_from_ecmwf/GLOBAL_2605_0809_19792015.grib")
# mean<-raster("C:/meteorological/ecmwf/2_mean_from_gribs/mean_GLOBAL_2605_0809_19792015.tif")
# last<-raster("C:/meteorological/ecmwf/3_ecmwf_ftp_wfp/TP_09260905.tif")
# anm<-raster("C:/meteorological/ncep_ncar/anm_26Ago2016.tif")

fname = "C:/meteorological/ecmwf/1_gribs_from_ecmwf/ElHonNicGua_2604_08_09_19792016.grib"
GDALinfo(fname)

#LOCALI
gribs<-raster("C:/meteorological/ecmwf/1_gribs_from_ecmwf/ElHonNicGua_2604_08_09_19792016.grib")
nbands(gribs)
crs(gribs)
extent(gribs)

gribdata = readGDAL(fname)
summary(gribdata)

gribdata@grid
gribdata@bbox
gribdata@proj4string

banda1 <- gribdata@data$band1
hist(banda1)

grib_stack <- stack(gribdata)
grib_stack@crs
grib_stack@layers[[200]]

hist(grib_stack[200],breaks=10)
#plot(grib_stack[1:370])
plot(grib_stack,col=terrain.colors(10))

sum(grib_stack[1:10,])
sum(grib_stack[11:20,])

MeanDagribs <- mean(grib_stack)
writeRaster(MeanDagribs,"mean_26Ago2016_daR.tiff", format="GTiff", overwrite=TRUE, NAflag=-9999)

hist(mean,breaks=25)
hist(last,breaks=25)
hist(anm,breaks=25)
