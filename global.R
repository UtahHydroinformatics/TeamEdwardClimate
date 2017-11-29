# Load Precipitation and SNOTEL data

load('data/snoteldata.Rdata')
load('data/prcp_proj.Rdata')
load('data/locations.Rdata')
names(locations) <- c("Station", "lat", "long")


library(ggplot2)
library(leaflet)

twilighticon <- makeIcon(
  iconUrl = "https://cdn.images.express.co.uk/img/dynamic/36/590x/Twilight-star-Robert-Pattinson-as-Edward-Cullen-794437.jpg",
  iconWidth = 60, iconHeight = 80,
  iconAnchorX = 22, iconAnchorY = 94)

