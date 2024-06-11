# episode 8: multiple vectors


library(ggplot2)
library(dplyr)
library(sf)


# do we user terra?
# library(terra)

# same 3 files from episode 6:
# a shapefile with 1 shape
  aoi_boundary_HARV <- st_read("data/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")
# roads of the test forest
  lines_HARV <- st_read("data/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")
# a single point
  point_HARV <- st_read('data/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp')

# and they forget to make road_colors  
  road_colors <- c("blue", "green", "navy", "purple")
  
# straightforward
# stacked up geom_sf's
ggplot() +
  geom_sf(data = aoi_boundary_HARV, fill = "grey", color = "grey") +
  geom_sf(data = lines_HARV, aes(color = TYPE), size = 1) +
  geom_sf(data = point_HARV) +
  ggtitle("NEON Harvard Forest Field Site") +
  coord_sf()


# then there's a lot more about
# controlling the legend,
# until we get to here:

ggplot() +
  geom_sf(data = aoi_boundary_HARV, fill = "grey", color = "grey") +
  geom_sf(data = point_HARV, aes(fill = Sub_Type), shape = 15) +
  geom_sf(data = lines_HARV, aes(color = TYPE),
          show.legend = "line", size = 1) +
  scale_color_manual(values = road_colors, name = "Line Type") +
  scale_fill_manual(values = "black", name = "Tower Location") +
  ggtitle("NEON Harvard Forest Field Site") +
  coord_sf()


# CHALLENGE: Plotting polygons by attribute
# create a map of study plot locations, with 
# each point colored by the soil type (soilTypeOr). 
# How many different soil types are there 
# at this particular field site? 
# Overlay this layer on top of the lines_HARV layer (the roads). 

# Create a custom legend that applies line symbols to lines and 
# point symbols to the points.

plot_locations <- read_sf("data/NEON-DS-Site-Layout-Files/HARV/PlotLocations_HARV.shp")
str(plot_locations)
str(plot_locations$soilTypeOr)

# we need that factor
plot_locations$soilTypeOr <- as.factor(plot_locations$soilTypeOr)

levels(plot_locations$soilTypeOr)
# I'll need 2 colors
blue_orange <- c("cornflowerblue", "darkorange")

plot(plot_locations)

# start with just the points
ggplot() +
  geom_sf(data = plot_locations, aes(color = soilTypeOr)) +
  scale_fill_manual(values = blue_orange) +
  coord_sf()

# now add the other geom, and a title
ggplot() +
  geom_sf(data = plot_locations, aes(color = soilTypeOr)) +
  scale_color_manual(values = blue_orange) +  
  geom_sf(data = lines_HARV, aes(color = TYPE)) +
  scale_fill_manual(values = road_colors) +
  ggtitle("NEON Harvard Forest Field Site") +
  coord_sf()

# now add names to the legend
# and specify a shape
ggplot() +
  geom_sf(data = lines_HARV, aes(color = TYPE)) +
  geom_sf(data = plot_locations, aes(fill = soilTypeOr)) +
  scale_color_manual(name = "Line Type", values = road_colors) +
  scale_fill_manual(name = "Soil Type", values = blue_orange) +
  ggtitle("NEON Harvard Forest Field Site") +
  coord_sf()

# add more
# to the legend
ggplot() +
  geom_sf(data = lines_HARV, aes(color = TYPE)) +
  geom_sf(data = plot_locations, aes(fill = soilTypeOr),
          shape = 21) +
  scale_color_manual(name = "Line Type", values = road_colors) +
  scale_fill_manual(name = "Soil Type", values = blue_orange) +
  ggtitle("NEON Harvard Forest Field Site") +
  coord_sf()



ggplot() +
  geom_sf(data = lines_HARV, aes(color = TYPE), show.legend = "line") +
  geom_sf(data = plot_locations, aes(fill = soilTypeOr),
          shape = 21, show.legend = 'point') +
  scale_color_manual(name = "Line Type", values = road_colors,
                     guide = guide_legend(override.aes = list(linetype = "solid",
                                                              shape = NA))) +
  scale_fill_manual(name = "Soil Type",  values = blue_orange,
                    guide = guide_legend(override.aes = list(linetype = "blank", shape = 21,
                                                             colour = NA))) +
  ggtitle("NEON Harvard Forest Field Site") +
  coord_sf()

