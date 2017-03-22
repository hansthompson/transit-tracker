library(gtfsdrilldown);library(dplyr);library(lubridate);library(tidyr)
# use the gps and gtfs to find which possible trip ids, then assign them based on some logic. Ends up with a object of trip_ids with gps "id".

#fake data
gps_data <- data.frame(route = rep("75", 2), direction = rep(1, 2), lat = c(61.221720, 61.180904), lon = c(-149.733576, -149.822776), datetime = rep(ymd_hms("2017-03-19 10:48:35"), 2))
load("gtfs_obj.Rdata")
gtfs_today <- gtfs_drilldown(gtfs_obj, today = structure(17243, class = "Date"))



gps_data
gtfs_obj

gps_data_route_subset <- gps_data %>% filter(route == "75", direction == 1)

n_trips <- nrow(gps_data_route_subset)

# vectorize
current_time <- 
  hours(hour(gps_data$datetime[1])) + 
  minutes(minute(gps_data$datetime[1])) + 
  seconds(second(gps_data$datetime[1]))

trip_ids_for_route <- 
  gtfs_today$todays_trips %>% 
  filter(route_id == gps_data$route, direction_id == gps_data$direction) %>% 
  .$trip_id

stop_ids_for_route <- 
  gtfs_today$today_stop_times %>% 
  filter(trip_id %in% trip_ids_for_route)

trip_ids_for_route <- stop_ids_for_route %>% 
  group_by(trip_id) %>% 
  filter(min(stop_sequence) == stop_sequence) %>% 
  ungroup() %>% 
  filter(hms(departure_time) > current_time) %>% 
  top_n(wt = departure_time, -n_trips) %>% .$trip_id

# get route with all stops

set_of_stops_in_active_trip_ids <- 
  gtfs_obj$stop_times_df  %>% 
  filter(trip_id %in% trip_ids_for_route) %>% 
  group_by(stop_sequence) %>% 
  ungroup() %>% 
  inner_join(gtfs_obj$stops_df, by = "stop_id") %>% 
  select(stop_lat, stop_lon, stop_id, stop_sequence, trip_id)

gtfs_gps_join_prep <- set_of_stops_in_active_trip_ids[rep(1:nrow(set_of_stops_in_active_trip_ids), n_trips),] 
gtfs_gps_join_prep$primary_id <- paste(out$trip_id, rep(1:n_trips, each=nrow(set_of_stops_in_active_trip_ids)), sep="-")

x <- gps_data_route_subset[rep(1:nrow(gps_data_route_subset), n_trips),] 
x$primary_id <- paste(trip_ids_for_route, rep(1:n_trips, each=nrow(gps_data_route_subset)), sep = "-")


gps_data_route_subset <- gps_data_route_subset %>% mutate(primary_id = row_number())

# use this http://gis.stackexchange.com/questions/93332/calculating-distance-scale-factor-by-latitude-for-mercator

set_of_stops_in_active_routes %>% group_by(trip_id) 
gps_data_route_subset
