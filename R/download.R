## Download and unzip zip file from url
download <- function(linkzip, destfile, dirname){
  download.file(url= linkzip, destfile, method = 'auto')
  unzip(destfile, exdir= paste0("data/", dirname))
}



