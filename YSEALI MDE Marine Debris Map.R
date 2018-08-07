# Zhi Yi Yeo
# Singapore, Yale-NUS
# YSEALI MDE
# Marine Debris Map 

library(ggmap)
library(scales)
library(scatterpie)
set.seed(1)
# Get coordinates for location site using either manual entry or geocode function 
add <- c(114.839558, 4.957150)
# Create map layer
map <- get_map(location = add,
               source = "google",
               zoom = 18)
# Include dummy variables for locations 
latpoints <- c(4.956220, 4.955960, 4.956988, 4.956614, 4.956389) 
lonpoints <- c(114.839268, 114.838886, 114.840052, 114.839812, 114.839565)
points <- cbind(latpoints, lonpoints)
# randomize size numbers 
size <- rnorm(5, 150, 75)
# Randomize data for respective groups 
points <- data.frame(points, size)
points <- data.frame(points, Plastic = rnorm(5, 100, 40))
points <- data.frame(points, Metal = rnorm(5, 50, 25))
points <- data.frame(points, Organic = rnorm(5, 100, 40))
points <- data.frame(points, Paper = rnorm(5, 50, 25))
points <- data.frame(points, "Fishing Gear" = rnorm(5, 100, 40))
points <- data.frame(points, Others = rnorm(5, 100, 40))

# Initialize map layer
g <- ggmap(map)
# Add pie charts and piechart legend
trash.map <- g + geom_scatterpie(aes(x = lonpoints, y = latpoints, r = size/2000000),
             data = points, alpha = 0.5, cols = names(points[ ,4:9])) +
  theme(axis.ticks = element_blank(),
        axis.text = element_blank(),
        legend.position = "bottom") +
  xlab("") + 
  ylab("") + 
  scale_fill_discrete(name = "Type") + 
  geom_scatterpie_legend(c(80,150,200,250)/2000000, x = 114.838123, y = 4.958248,
                         labeller = function(x) round(x * 2000000))
print(trash.map)
# Export map
ggsave("YSEALI_MDE_dummymap.png", trash.map, device = "png",
       width = 7, height = 7)
