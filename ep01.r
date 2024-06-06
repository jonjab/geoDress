
# ep 1 and 2 practice
# https://datacarpentry.org/r-raster-vector-geospatial/01-raster-structure.html

library(ggplot2)
library(terra)
library(dplyr)

describe("data/NEON-DS-Airborne-Remote-Sensing/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")


# Make an object:
DSM_HARV <- rast("data/NEON-DS-Airborne-Remote-Sensing/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")
DSM_HARV
summary(DSM_HARV)
