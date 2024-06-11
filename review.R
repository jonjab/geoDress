# Review

# You all are awesome!


# Did you know we sat through a building takeover yesterday?







library(sf)
library(terra)
library(ggplot2)
library(dplyr)
   # ... and probably other pieces of the tidyverse

# raster files
# DEM's
DTM_SJER <- rast("data/NEON-DS-Airborne-Remote-Sensing/NEON-DS-Airborne-Remote-Sensing/SJER/DTM/SJER_dtmCrop.tif")
DTM_SJER

DSM_SJER <- rast("data/NEON-DS-Airborne-Remote-Sensing/NEON-DS-Airborne-Remote-Sensing/SJER/DSM/SJER_dsmCrop.tif")
DSM_SJER


CHM_SJER <- DSM_SJER - DTM_SJER

plot(CHM_SJER)

# rasters need to be dataframes
# to be mapped in ggplot
CHM_SJER_df <- as.data.frame(CHM_SJER, xy=TRUE)


ggplot() +
  geom_raster(data = CHM_SJER_df, 
              aes(x = x, y = y, 
                  fill = SJER_dsmCrop)
  ) + 
  scale_fill_gradientn(name = "Canopy Height", 
                       colors = terrain.colors(10)) + 
  coord_quickmap()

# and that is weirdly slow


# Q: Are trees tall in the SJER?
names(CHM_SJER_df)
ggplot(CHM_SJER_df) +
  geom_histogram(aes(SJER_dsmCrop))









#A: No. There's a lot of brush and/or bare ground



# do you have a projection example?
   # hopefully in ep. 7
# These are really long ggplots


# Today:
# Color!
# Shapefiles!

# ..... and just possibly an interruption to accomodate a final exam