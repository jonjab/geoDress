# ep 3 w/ Julien teaching

library(tidyverse)
library(terra)

DTM_HARV <- rast("data/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif")
DTM_HARV

DTM_hill_HARV <- rast("data/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_DTMhill_WGS84.tif")
DTM_hill_HARV

plot(DTM_hill_HARV)
plot(DTM_HARV)

DTM_HARV_df <- as.data.frame(DTM_HARV, xy=TRUE)
DTM_hill_HARV_df <- as.data.frame(DTM_hill_HARV, xy=TRUE)

str(DTM_HARV_df)
str(DTM_hill_HARV_df)


ggplot() +
  geom_raster(data=DTM_HARV_df, 
              aes(x=x, y=y, fill=HARV_dtmCrop))
              
#### skip skip skip
# re-project
DTM_hill_UTMZ18N_HARV <- project(DTM_hill_HARV,
                                 crs(DTM_HARV))
DTM_hill_HARV_reproj_df <- as.data.frame(DTM_hill_UTMZ18N_HARV, xy=TRUE)

str(DTM_hill_HARV_reproj_df)

# does it overlay here?
# yes!
ggplot() +
  geom_raster(data = DTM_HARV_df , 
              aes(x = x, y = y, 
                  fill = HARV_dtmCrop)) + 
  geom_raster(data = DTM_hill_HARV_reproj_df, 
              aes(x = x, y = y, 
                  alpha = HARV_DTMhill_WGS84)) +
  scale_alpha(range = c(0.15, 0.65)) +
              
    scale_fill_gradientn(name = "Elevation", colors = terrain.colors(10)) + 
  coord_quickmap()


ggplot() +
  geom_raster(data = DTM_HARV_df , 
              aes(x = x, y = y, 
                  fill = HARV_dtmCrop)) + 
  geom_raster(data = DTM_hill_HARV_reproj_df, 
              aes(x = x, y = y, 
                  alpha = HARV_DTMhill_WGS84)) +
  scale_alpha(range = c(0.15, 0.65)) +
  scale_fill_gradientn(name = "Elevation",  colors= scale_fill_viridis_c()) + 
  coord_quickmap()

            


# seizes a challenge with SJER



## Ep 4 starts!
