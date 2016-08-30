library(raster)
library(rasterVis)
library(RCurl)

##Solar irradiation data from CMSAF 
old <- setwd(tempdir())
download.file('https://raw.github.com/oscarperpinan/spacetime-vis/master/data/SISmm2008_CMSAF.zip',
              'SISmm2008_CMSAF.zip', method='curl')
unzip('SISmm2008_CMSAF.zip')

listFich <- dir(pattern='\\.nc')
stackSIS <- stack(listFich)
stackSIS <- stackSIS * 24 ##from irradiance (W/m2) to irradiation Wh/m2

idx <- seq(as.Date('2008-01-15'), as.Date('2008-12-15'), 'month')

SISmm <- setZ(stackSIS, idx)
names(SISmm) <- month.abb

setwd(old)