# ep 7

# lesson says we need:
library(sf)
library(terra)
library(ggplot2)

# not specified in narrative
library(dplyr)




# this really needs goals re-stated in english.

# the shapefile from ep 6 that we are going to use:
# BUT: note the argument
lines_HARV <- st_read("data/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp",
                      stringsAsFactors = TRUE)

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

# Customize Plots
# ^^ header from lesson. Should be: 
# Specify colors for attributes

# we'll need 4 colors
unique(lines_HARV$TYPE)

road_colors <- c("blue", "green", "navy", "purple")

ggplot() +
  geom_sf(data = lines_HARV, aes(color = TYPE)) +
  scale_color_manual(values = road_colors) +
  labs(color = 'Road Type') +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Roads & Trails") +  coord_sf()



# Adjust Line Width
line_widths <- c(.5,1,2,3)

# does this work for anyone?
ggplot() +
  geom_sf(data = lines_HARV, aes(color = TYPE, size = TYPE)) +
  scale_color_manual(values = road_colors) +
  labs(color = 'Road Type') +
  scale_size_manual(values = line_widths) +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "Roads & Trails - Line width varies BROKEN.") +
  coord_sf()

# have to use linewidth! As of ggplot2 3.4.0
#################
ggplot() +
  geom_sf(data = lines_HARV, aes(color = TYPE, linewidth=TYPE)) +
  scale_color_manual(values = road_colors) +
  scale_discrete_manual("linewidth", values=line_widths)+
  labs(color = 'Road Type') +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "Roads & Trails - Line width varies") +
  coord_sf()



# CHALLENGE: customize the attributes:
# woods road size = 6
# boardwalks size = 1
# footpath size = 3
# stone wall size = 2

# can view my previous output OR unique()
# levels() wont' work! because factors
str(lines_HARV$TYPE)
unique(lines_HARV$TYPE)
levels(lines_HARV$TYPE)


# remake our size vector in the same order:
custom_line_widths <- c(1,3,2,6)

ggplot() +
  geom_sf(data = lines_HARV, aes(color = TYPE, linewidth=TYPE)) +
  scale_color_manual(values = road_colors) +
  scale_discrete_manual("linewidth", values=custom_line_widths)+
  labs(color = 'Road Type') +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "Roads & Trails - Fat Purple Road") +
  coord_sf()

# get rid of the size in the legend
ggplot() +
  geom_sf(data = lines_HARV, aes(color = TYPE, linewidth=TYPE)) +
  scale_color_manual(values = road_colors) +
  scale_discrete_manual("linewidth", values=custom_line_widths, guide="none")+
  labs(color = 'Road Type') +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "Roads & Trails - Fat Purple Road") +
  coord_sf()





###################
# Am I skipping customizing the legend box?

new_colors <- c("springgreen", "blue", "magenta", "orange")


# Challenge: Plot lines by Attribute
# Bike and horse paths
# Create a plot that emphasizes roads 
# by showing ONLY roads where
# where bicycles and horses are allowed.
# (hint: lines_HARV$)

levels(lines_HARV$BicyclesHo)
lines_HARV$BicyclesHo

# the lesson advises pull:
lines_HARV %>%
  pull(BicyclesHo) %>%
  unique()

lines_showHarv <-
  lines_HARV %>%
  filter(BicyclesHo == "Bicycles and Horses Allowed")


# this solves the challenge, but is not a good map
ggplot() +
  geom_sf(data = lines_showHarv, aes(color = BicyclesHo), linewidth = 2) +
  scale_color_manual(values = "magenta") +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "Roads Where Bikes and Horses Are Allowed") +
  coord_sf()

# this plots the the other roads as well:
ggplot() +
geom_sf(data = lines_HARV) +
  geom_sf(data = lines_showHarv, aes(color = BicyclesHo), linewidth = 2) +
  scale_color_manual(values = "magenta") +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "Roads Where Bikes and Horses Are Allowed") +
  coord_sf()


# CHALLENGE: Plot Polygons
# Create a map of the state boundaries in the United States 
# using the data located in your downloaded data folder: 
# NEON-DS-Site-Layout-Files/US-Boundary-Layers\US-State-Boundaries-Census-2014. 
# Apply a line color to each state using its region value. Add a legend.

# the st_zm is totally mandatory!
# I have no idea why it gets in the way.
states <- st_read("data/NEON-DS-Site-Layout-Files/US-Boundary-Layers/US-State-Boundaries-Census-2014.shp") %>% st_zm()
colnames(states)
unique(states$region)
str(states$region)

# you don't actually need to do this
# states$region <- as.factor(states$region)

colors <- c("purple", "springgreen", "yellow", "brown", "navy")
ggplot() +
  geom_sf(data = states, aes(color = region)) +
  scale_color_manual(values =colors) +
  ggtitle("U.S. State Boundaries Colored by Region") +
  coord_sf()

  
 
  