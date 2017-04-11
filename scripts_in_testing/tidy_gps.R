library(XML)

get_tidy_gps <- function() {
  xml_list <- xmlToList(xmlParse("http://bustracker.muni.org/InfoPoint/XML/vehiclelocation.xml"))
  list_length <- length(xml_list) 
  bus_route <- c()
  bus_latitude <- c()
  bus_longitude <- c()
  bus_direction <- c()
  for(i in 2:list_length) {
    bus_route_piece <- xml_list[i]$vehicle$routeid
    bus_lat_piece <- xml_list[i]$vehicle$latitude
    bus_lon_piece <- xml_list[i]$vehicle$longitude
    bus_dir_piece <- xml_list[i]$vehicle$direction
    bus_longitude  <- c(bus_longitude, bus_lon_piece)
    bus_latitude  <- c(bus_latitude, bus_lat_piece)
    bus_route      <- c(bus_route, bus_route_piece)
    bus_direction  <- c(bus_direction, bus_dir_piece)
  }
  tidy_gps <- data.frame(lat = bus_latitude, lon = bus_longitude, route = bus_route) %>% filter(!bus_route %in% c("0"))
  tidy_gps <- tidy_gps %>% mutate(direction = bus_direction) %>% filter(route != "99")
  tidy_gps$direction[tidy_gps$direction == "I"] <- "1"
  tidy_gps$direction[tidy_gps$direction == "O"] <- "0"
  tidy_gps$direction <- as.numeric(tidy_gps$direction)
  tidy_gps %>% filter(!is.na(direction)) %>% mutate(datetime = Sys.time(), lat = as.numeric(as.character(lat)), lon = as.numeric(as.character(lon)))
}

