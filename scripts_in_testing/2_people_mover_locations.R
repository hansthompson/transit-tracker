# For example purposes, load this formatted R data.frame that came from the people mover xml feed. 

## build the data frame from fake data. lat, lon, route, and maybe a time stamp. 

#fake data
gps_data <- data.frame(route = rep("75", 2), direction = rep(1, 2), lat = c(61.221720, 61.180904), lon = c(-149.733576, -149.822776), datetime = rep(ymd_hms("2017-03-19 10:48:35 AKDT", tz = "AKST"), 2))

library(XML)

gps_data <- xmlToList(xmlParse("http://bustracker.muni.org/InfoPoint/XML/vehiclelocation.xml")) 

data.frame(unlist(lapply(gps_data, function(x) x[2]))[-1],
           unlist(lapply(gps_data, function(x) x[7])),
           unlist(lapply(gps_data, function(x) x[6])))


data.frame(latitude = unlist(lapply(gps_data, function(x) x[6]$latitude)),
           longitude = unlist(lapply(gps_data, function(x) x[7]$longitude)),
           routeid = unlist(lapply(gps_data, function(x) x[2]$routeid)),
           runid = unlist(lapply(gps_data, function(x) x[4]$runid)))

unlist(lapply(gps_data, function(x) x$direction))