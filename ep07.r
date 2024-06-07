# ep 7

# lesson says we need:
library(sf)
library(terra)
library(dplyr)
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

# challenge: "Attributes for different spatial classes" 
# for the point and poly files:
#    1. How many attributes does each have?
#    2. Who owns the site in the point_HARV
#       data object?  
#    3. Which of the following is NOT an attribute of the
#        point_HARV data object?
#         A) Latitude
#         B) County 
#         C) Country


ncol(point_HARV)
ncol(aoi_boundary_HARV)

# explore a shapefile
lines_HARV$TYPE
unique(lines_HARV$TYPE)


# make an object with subsetted lines
# this requires dplyr
footpath_HARV <- lines_HARV %>% 
  filter(TYPE == "footpath")


# p 6 of notes pdf
ggplot() +
  geom_sf (data = footpath_HARV)+
  ggtitle(
  "NEON Harvard Forest Field Site", 
   subtitle  =  "Footpaths"
) + coord_sf()

# is that 1 line or 2?
# same as above, with an
# aesthetic added to the lines
# (color and size)
# the factor for the color scheme gets built on the fly
ggplot() +
  geom_sf(data = footpath_HARV, 
          aes(color = factor(OBJECTID)), 
          size = 1.5) + 
          labs(color = 'Footpath ID') +
  ggtitle(
    "NEON Harvard Forest Field Site", 
    subtitle  =  "Footpaths"
  ) + coord_sf()

# Can graph all the lines:
# (this part not in lesson)
ggplot() +
  geom_sf(data = lines_HARV, 
          aes(color = factor(OBJECTID)), 
          size = 1.5) + 
  labs(color = 'Footpath ID') +
  ggtitle(
    "NEON Harvard Forest Field Site", 
    subtitle  =  "All the lines"
  ) + coord_sf()

# Challenge:
# Filter out just the boardwalks and
# map them.

boardwalks_HARV <- lines_HARV %>% 
  filter(TYPE == "boardwalk")  

ggplot() +
  geom_sf(data = boardwalks_HARV, 
          aes(color = factor(OBJECTID)), 
          size = 1.5) + 
  labs(color = 'Footpath ID') +
  ggtitle(
    "NEON Harvard Forest Field Site", 
    subtitle  =  "Just the romantic boardwalks"
  ) + coord_sf() 


# challenge part 2:
# Stone walls, each colored differently

unique(lines_HARV$TYPE)

walls_HARV <- lines_HARV %>% 
  filter(TYPE == "stone wall")  

ggplot() +
  geom_sf(data = walls_HARV, 
          aes(color = factor(OBJECTID)), 
          size = 1.5) + 
  labs(color = 'Footpath ID') +
  ggtitle(
    "NEON Harvard Forest Field Site", 
    subtitle  =  "Just the romantic boardwalks"
  ) + coord_sf() 



  ggtitle("NEON Harvard Forest Field Site", subtitle = "Footpaths") +  coord_sf()