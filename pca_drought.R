#PCA used in climate research for defining the leading spatial and temporal
#pattern of climate variability (Richman,1986)
library(raster)
library(rgdal)
library(ggplot2)
library(RStoolbox)


drought_path <- "new_layrs_ethiopia_pca"
all_drought <- list.files(drought_path,
                            full.names=T,
                            pattern = ".tif$")

# Create a time series raster stack
drought_stack <- stack(all_drought)
#hist(drought_stack)
plot(drought_stack)

sr <- sampleRandom(drought_stack, 5000) # sample 5000 random grid cells
hist(sr,breaks=10)

# run PCA on random sample with correlation matrix
# retx=FALSE means don't save PCA scores 
#pca <- prcomp(sr, scale=TRUE, retx=FALSE) 

# write PCA model to file 
#dput(pca, file="data_pca.csv")

#x <- predict(rasters, pca, index=1:6) # create new rasters based on PCA predictions

#reduced number of linear, non-correlated variables 
#that explain most of the total variance (Santos et al.,2010)
pca <- rasterPCA(img=drought_stack, nSamples = 1000,spca = T) #,nComp = 3
summary(pca$model)

hist(pca$map)

plot(pca$map)

#ggRGB(pca$map,1,2,3,stretch = "lin",q=0)
