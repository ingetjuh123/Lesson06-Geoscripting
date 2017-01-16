ProximityToRailway <-function(filepathRailways, filepathPlaces){
  ## Select industrial railways
  ReadRailways <- readOGR(file.path(filepathRailways), layer = "railways")
  IndustrialRailways <- subset(ReadRailways,ReadRailways$type == "industrial")
  
  ## Collecting places in SpatialPointsDataFrame 
  ReadPlaces <- readOGR(file.path(filepathPlaces), layer = "places")
  
  ## Adding planar coordinate system RD_new
  prj_string_RD <- CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.2369,50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,4.0812 +units=m +no_defs")
  RailwaysRD <- spTransform(IndustrialRailways, prj_string_RD)
  PlacesRD <- spTransform(ReadPlaces, prj_string_RD)
  
  ## Buffering the industrial railways with a buffer of 1000m
  Railwaybuf <- gBuffer(RailwaysRD, byid=T, width = 1000)
  
  ## Finding place intersecting with Railwaybuf
  CityPoint <- gIntersection(PlacesRD, Railwaybuf, id=as.character(PlacesRD$osm_id), byid=T)
  CityPlace <- PlacesRD[PlacesRD$osm_id == rownames(CityPoint@coords),]
  
  ## Visualization
  zoom<-1000
  xlim<-c((Railwaybuf@bbox[1,1]-zoom),(Railwaybuf@bbox[1,2]+zoom))
  ylim=c((Railwaybuf@bbox[2,1]-zoom),(Railwaybuf@bbox[2,2]+zoom))
  
  plot(Railwaybuf, xlim =xlim, ylim = ylim, col="grey")
  plot(PlacesRD, add = T, lbl=PlacesRD$name, col="blue")
  text(PlacesRD, labels=PlacesRD$name, cex=0.6, pos=4, col="blue")
  plot(RailwaysRD, type = "Industrial", col = "red", lwd=2, add=T)
  grid()
  mtext(side = 3, line=1, paste("Industrial Railway in Proximity of", CityPlace$name),  cex = 2)
  
  return(CityPlace)
}



