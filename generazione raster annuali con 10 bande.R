fname = "C:/meteorological/ecmwf/1_gribs_from_ecmwf/ElHonNicGua_2604_08_09_19792016.grib"
gribdata = readGDAL(fname)
summary(gribdata)

gribdata@grid
gribdata@bbox
gribdata@proj4string

grib_stack <- stack(gribdata)
grib_stack@crs
primi_10 <- list(grib_stack[[1:10]])
class(primi_10)

primi_10_rast <- Reduce("sum",primi_10)
writeRaster(primi_10_rast,"sum_1979_26Ago2016_daR.tiff", 
            format="GTiff", 
            overwrite=TRUE, 
            NAflag=-9999)

ogni_10_giorni = grib_stack@layers[[1]]
for(i in 2:370){
  ogni_10_giorni = ogni_10_giorni + grib_stack@layers[[1]]
  if(i==10){
    writeRaster(ogni_10_giorni,
                "mean_26Ago2016_daR.tiff", 
                format="GTiff", 
                overwrite=TRUE, 
                NAflag=-9999)
   }
   else if(i==20){
     print("1980")
   }
}


