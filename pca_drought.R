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
plot(drought_stack)

#sr <- sampleRandom(drought_stack, 5000) # sample 5000 random grid cells

# run PCA on random sample with correlation matrix
# retx=FALSE means don't save PCA scores 
#pca <- prcomp(sr, scale=TRUE, retx=FALSE) 

# write PCA model to file 
#dput(pca, file="data_pca.csv")

#x <- predict(rasters, pca, index=1:6) # create new rasters based on PCA predictions

pca1 <- rasterPCA(drought_stack)

plot(pca1$map)
