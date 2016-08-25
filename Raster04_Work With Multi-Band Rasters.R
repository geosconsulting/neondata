library(raster)
library(rgdal)

# Default is the first band only.
RGB_band1_HARV <- 
  raster("NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif")

# create a grayscale color palette to use for the image.
grayscale_colors <- gray.colors(100,            # number of different color levels 
                                start = 0.0,    # how black (0) to go
                                end = 1.0,      # how white (1) to go
                                gamma = 2.2,    # correction between how a digital 
                                # camera sees the world and how human eyes see it
                                alpha = NULL)   #Null=colors are not transparent

# Plot band 1
plot(RGB_band1_HARV, 
     col=grayscale_colors, 
     axes=FALSE,
     main="RGB Imagery - Band 1-Red\nNEON Harvard Forest Field Site") 

RGB_band1_HARV
RGB_band1_HARV@file@nbands

minValue(RGB_band1_HARV)
maxValue(RGB_band1_HARV)

# Default is the first band only.
RGB_band2_HARV <- 
  raster("NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif",
         band = 2)

# plot band 2
plot(RGB_band2_HARV,
     col=grayscale_colors, # we already created this palette & can use it again
     axes=FALSE,
     main="RGB Imagery - Band 2-Green\nNEON Harvard Forest Field Site")

RGB_band2_HARV

RGB_stack_HARV <- 
  stack("NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif")

RGB_stack_HARV
RGB_stack_HARV@layers
RGB_stack_HARV[[1]]

hist(RGB_stack_HARV,
     maxpixel=ncell(RGB_stack_HARV))

# plot all three bands separately
plot(RGB_stack_HARV, 
     col=grayscale_colors)

#Importante ritorno a un plottaggio singolo
par(mfrow=c(1,1))

plot(RGB_stack_HARV[[2]],
     main="Band 2\n",
     col=grayscale_colors)

plotRGB(RGB_stack_HARV,
        r=1,g=2,b=3)

#Equalizziamolo
plotRGB(RGB_stack_HARV,
        r=1,g=2,b=3,
        scale=800,
        stretch="lin")

plotRGB(RGB_stack_HARV,
        r=1,g=2,b=3,
        scale=800,
        stretch="hist")

GDALinfo("NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_Ortho_wNA.tif")

# Default is the first band only.
RGB_HARV_NA <- 
  raster("NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_Ortho_wNA.tif")

RGB_HARV_NA@file@nodatavalue

# Default is the first band only.
RGB_stack_HARV <- 
  stack("NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_Ortho_wNA.tif")

plotRGB(RGB_stack_HARV,r=1,g=2,b=3)

object.size(RGB_stack_HARV)
RGB_brick_HARV <- brick(RGB_stack_HARV)

object.size(RGB_brick_HARV)
plotRGB(RGB_brick_HARV,r=1,g=2,b=3)
