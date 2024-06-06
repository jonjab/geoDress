# ep 7

# lesson says we need:
library(sf)
library(terra)
library(ggplot2)



# this really needs goals re-stated in english.

# 3 shapefiles from ep 6 if you lost them:
aoi_boundary_HARV <- st_read("data/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")
lines_HARV <- st_read("data/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")
point_HARV <- st_read('data/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp')

# 4 different pieces of metadata we can look at:
st_geometry_type(aoi_boundary_HARV)
nrow(point_HARV)
st_bbox(aoi_boundary_HARV)

# not super exciting metadata, and only about as informative as:
point_HARV

# and these are base R, so this is review:
ncol(point_HARV)
ncol(lines_HARV)
names(lines_HARV)
