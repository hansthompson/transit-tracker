library(XML)

gps_locations <- xmlParse("http://bustracker.muni.org/InfoPoint/XML/vehiclelocation.xml")

xml_list <- xmlToList(gps_locations)

list_length <- length(xml_list) 

bus_route <- c()
bus_latitude <- c()
bus_longitude <- c()
for(i in 2:list_length) {
 bus_route_piece <- xml_list[i]$vehicle$routeid
 bus_lat_piece <- xml_list[i]$vehicle$latitude
 bus_lon_piece <- xml_list[i]$vehicle$longitude
 bus_longitude  <- c(bus_longitude, bus_lon_piece)
 bus_latitude  <- c(bus_latitude, bus_lat_piece)
 bus_route  <- c(bus_route, bus_route_piece)
}
bus_longitude
bus_latitude
bus_route

data.frame(bus_latitude, bus_longitude, bus_route)
