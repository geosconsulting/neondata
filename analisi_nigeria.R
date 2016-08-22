library(raster)
library(sp)
library(rgdal)

nigeria_anom <- raster("rasterNigeria/anm_Nig_1928_08_19792016.tif")
nigeria_mean <- raster("rasterNigeria/mean_Nig_1928_08_19792016.tif")
nigeria_last <- raster("rasterNigeria/TP_08190829_clip.tif")
nigeria_grib <- raster("rasterNigeria/Nig_1928_08_19792016.grib")
plot(nigeria_anom)
hist(nigeria_anom)

rasterlist_nigeria <- list(nigeria_anom,nigeria_mean,nigeria_last)
rgbRasterNigeria <- stack(rasterlist_nigeria)
plot(rgbRasterNigeria)
hist(rgbRasterNigeria)

grib <- readGDAL(nigeria_grib)
summary = GDALinfo(gribfile,silent=TRUE)