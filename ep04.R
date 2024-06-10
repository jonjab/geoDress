library(tidyverse)
library(terra)

DTM_HARV <- rast("data/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif")
DTM_HARV


DSM_HARV <- rast("data/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")
DSM_HARV

# simple subtraction to create CHM

CHM_HARV <- DSM_HARV - DTM_HARV
plot(CHM_HARV)


# do it with lapp()
# CHM_HARV_lapp <- lapp(sds(list(DSM_HARV, DTM_HARV_df){
#  then a function goes in here.
# }))