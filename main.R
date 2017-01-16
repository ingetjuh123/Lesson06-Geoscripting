# Name: Script0rs - Inge van der Mond, David Swinkels
# Date: 16 January 2017

# Import packages
library(raster)
library(rgdal)

source("R/download.R")
source("R/ProximityToRailway.R")


## Download places and railways data 
download('http://www.mapcruzin.com/download-shapefile/netherlands-places-shape.zip', "data/places.zip", "Places")
download('http://www.mapcruzin.com/download-shapefile/netherlands-railways-shape.zip', "data/railways.zip", "Railways")

## Place Proximity To Railway
Cityplace <- ProximityToRailway("data/Railways","data/Places")

## Print name of city (Utrecht) and its population (100.000)
print(paste("This is the city of", Cityplace$name, "which has a population of", Cityplace$population))


