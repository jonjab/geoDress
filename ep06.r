# ep 6

# at the moment, I'm only grabbing the data I need for ep. 7

library(sf)
library(terra)
library(ggplot2)

# a shapefile with 1 shape
aoi_boundary_HARV <- st_read("data/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")

# ...


# challenge
# import line file

lines_HARV <- st_read("data/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")


# ...

point_HARV <- st_read('data/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp')
