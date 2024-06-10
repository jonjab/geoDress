
# ep 1 and 2
# https://datacarpentry.org/r-raster-vector-geospatial/01-raster-structure.html

library(ggplot2)
library(terra)
library(dplyr)

describe("data/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")


# Make an object:
DSM_HARV <- rast("data/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")
DSM_HARV
summary(DSM_HARV)

DSM_HARV_df <- as.data.frame(DSM_HARV, xy=TRUE)
str(DSM_HARV_df)

# pause for question
crs(DSM_HARV)
crs(DSM_HARV, proj = TRUE)

# digression about the with and without coord_quickmap
ggplot() +
  geom_raster(data = DSM_HARV_df,
  aes(x=x, y=y, fill = HARV_dsmCrop)) +
  scale_fill_viridis_c() +
  coord_quickmap()

# should be coord_sf()
ggplot() +
  geom_raster(data = DSM_HARV_df,
              aes(x=x, y=y, fill = HARV_dsmCrop)) +
  scale_fill_viridis_c() +
  coord_sf()
# with this, it's more visible in the zoom out window
ggplot() +
  geom_raster(data = DSM_HARV_df,
              aes(x=x, y=y, fill = HARV_dsmCrop)) +
  scale_fill_viridis_c() 



str(DSM_HARV_df)

# challenge: NA values are in the describe() function
describe("data/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")

describe("data/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmhill.tif")
hill_HARV <- rast("data/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmhill.tif")
crs(hill_HARV)
crs(DSM_HARV)

str(DSM_HARV_df)

# let's bin some data
DSM_HARV_df <- DSM_HARV_df %>% 
  mutate(fct_elevation = cut(HARV_dsmCrop, breaks=3))
str(DSM_HARV_df)


ggplot() +
  geom_raster(data = DSM_HARV_df,
              aes(x=x, y=y, fill = fct_elevation)) +
  scale_fill_manual(values=terrain.colors(3)) +
  coord_sf()

# let's do it with more bins!
DSM_HARV_df <- DSM_HARV_df %>% 
  mutate(fct_elevation9 = cut(HARV_dsmCrop, breaks=9))
str(DSM_HARV_df)

ggplot() +
  geom_raster(data = DSM_HARV_df,
              aes(x=x, y=y, fill = fct_elevation9)) +
  scale_fill_manual(values=terrain.colors(9)) +
  coord_sf()


###Layering rasters
str(hill_HARV)
hill_HARV_df <- as.data.frame(hill_HARV, xy=TRUE)

str(hill_HARV_df)

# the hillshade by itself
ggplot() +
  geom_raster(data = hill_HARV_df, aes(x=x, y=y,
                                       alpha= HARV_DSMhill)) +
  scale_alpha(range = c(0.15, 0.65), guide="none") +
  geom_raster(data=DSM_HARV_df,
              aes(x=x, y=y, fill = HARV_dsmCrop)) +
  scale_fill_viridis_c() +
  coord_sf()

SJER_dsm <- rast("data/NEON-DS-Airborne-Remote-Sensing/SJER/DSM/SJER_dsmCrop.tif")              
SJER_dsm_df <- as.data.frame(SJER_dsm, xy=TRUE)

SJER_hill <- rast("data/NEON-DS-Airborne-Remote-Sensing/SJER/DSM/SJER_dsmHill.tif")              
SJER_hill_df <- as.data.frame(SJER_hill, xy=TRUE)
SJER_hill

str(SJER_hill_df)


ggplot() +
  geom_raster(data = SJER_hill_df, aes(x=x, y=y,
                                       alpha= SJER_dsmHill)) +
  scale_alpha(range = c(0.15, 0.65), guide="none") +
  geom_raster(data=SJER_dsm_df,
              aes(x=x, y=y, fill = SJER_dsmCrop)) +
  scale_fill_viridis_c() +
  coord_sf()

# order matters!
ggplot() +
  geom_raster(data=SJER_dsm_df,
              aes(x=x, y=y, fill = SJER_dsmCrop)) +
  scale_fill_viridis_c() +
  geom_raster(data = SJER_hill_df, aes(x=x, y=y,
                                       alpha= SJER_dsmHill)) +
  scale_alpha(range = c(0.15, 0.65), guide="none") +
    coord_sf()
