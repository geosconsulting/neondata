library(rgdal)
library(raster)
library(rasterVis)
library(maptools)
library(ggplot2)

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
pixel_1_1 <- gribdata@data[[1,1]]
banda1[1:10]

banda5 <- gribdata@data[[5]]

grib_stack <- stack(gribdata)
grib_stack@crs
grib_stack@layers[[200]]

#hist(grib_stack[200],breaks=10)
#plot(grib_stack[1:370])
#plot(grib_stack,col=terrain.colors(10))
primi_10_giorni = grib_stack@layers[[1]] + grib_stack@layers[[2]] +
                  grib_stack@layers[[3]] + grib_stack@layers[[4]] +
                  grib_stack@layers[[5]] + grib_stack@layers[[6]] +
                  grib_stack@layers[[7]] + grib_stack@layers[[8]] +
                  grib_stack@layers[[9]] + grib_stack@layers[[10]]

#cols <- c("light blue", "dark blue", "purple")
#plot(primi_10_giorni, col=cols, legend=FALSE)
#legend("bottomright", 
#       legend=c("low", "medium", "high"), 
#       fill=cols, bg="white")


sum(grib_stack[1:10,])
sum(grib_stack[11:20,])

MeanDaGribs <- mean(grib_stack)

#writeRaster(MeanDaGribs,"_mean_26Ago2016_daR.tiff", format="GTiff", overwrite=TRUE, NAflag=-9999)

MedianDaGribs <- calc(grib_stack,median)


par(mfrow=c(1,3))
plot(MeanDaGribs,main="Mean from  ECMWF grib file")
plot(MedianDaGribs,main="Median from  ECMWF grib file")
#writeRaster(MedianDaGribs,"_median_26Ago2016_daR.tiff", format="GTiff", overwrite=TRUE, NAflag=-9999)
SDDaGribs <- calc(grib_stack,sd)
plot(SDDaGribs,main="Standard Deviation from  ECMWF grib file")
#writeRaster(SDDaGribs,"_sd_26Ago2016_daR.tiff", format="GTiff", overwrite=TRUE, NAflag=-9999)


par(mfrow=c(1,2))
hist(MeanDaGribs,breaks=15,main="Histogram for mean frequencies")
hist(MedianDaGribs,breaks=15,main="Histogram for median frequencies")


last_forecast <- raster("C:/meteorological/ecmwf/3_ecmwf_ftp_wfp/last_ElHonNicGua_2604_08_09_19792016.tif")
p <- levelplot(last_forecast,main="Last ECWMF Forecast Precipitation")
p
# cols <- c("light blue", "dark blue", "purple")
# plot(last_forecast, col=cols, legend=FALSE)
# legend("bottomright", 
#        legend=c("low", "medium", "high"), 
#        fill=cols, bg="white")

last_mean <- overlay(last_forecast,
                     MeanDaGribs,
                     fun=function(r1,r2){return(r1-r2)})

last_median <- overlay(last_forecast,
                     MedianDaGribs,
                     fun=function(r1,r2){return(r1-r2)})

par(mfrow=c(1,2))
plot(last_mean,main="Difference with the mean")
plot(last_median,main="Difference with the median")

#hist(last_forecast,breaks=15)

imgs_1 <- list(grib_stack[[1:10]])
imgs_2 <- list(grib_stack[[11:20]])
imgs_3 <- list(grib_stack[[21:30]])
imgs_4 <- list(grib_stack[[31:40]])

#yr_1979 <- Reduce("sum",imgs_1)
#yr_1980 <- Reduce("sum",imgs_2)
#yr_1981 <- Reduce("sum",imgs_3)
#yr_1982 <- Reduce("sum",imgs_4)

#plot(yr_1979)
#hist(yr_1979)
#plot(yr_1980)
#hist(yr_1980)

#writeRaster(primi_10_rast,"sum_1979_26Ago2016_daR.tiff", 
#            format="GTiff", 
#            overwrite=TRUE, 
#            NAflag=-9999)

#ogni_10_giorni = grib_stack@layers[[1]]

#for(i in 1:370){
#  ogni_10_giorni = ogni_10_giorni + grib_stack@layers[[1]]
#  if(i==10){
#    writeRaster(ogni_10_giorni,
#                "mean_26Ago2016_daR.tiff", 
#                format="GTiff", 
#                overwrite=TRUE, 
#                NAflag=-9999)
#   }
#   else if(i==20){
#     print("1980")
#   }
#}

for(i in 1:370){
  if(i==10){
    print("1979")
  }
  else if(i==20){
    print("1980")
  }
}