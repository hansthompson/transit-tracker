library(gganimate)
library(ggmap)
library(dlayr)
library(tidyr)
library(animation)
library(dplyr)
library(XML)
library(lubridate)
library(gtfsr)

gtfs_url          <- readLines("/home/ht/gtfs_url.txt")
gps_function_url  <- readLines("/home/ht/gps_function_url.txt")

source(gps_function_url)
#source("https://raw.githubusercontent.com/hansthompson/hansthompson.github.io/master/tidy-gps-functions/anchorage-ak-peoplemover.R")

csvs <- list.files("/home/ht/dump2", pattern = ".csv", full.names = TRUE)
all_data <- do.call(rbind, lapply(csvs, function(x) read.csv(x, stringsAsFactors = FALSE)))
all_data <- all_data %>% arrange(datetime)


data_pull_date <- unique(as.Date(all_data$datetime))
if(length(data_pull_date) == 1) {

gtfs_obj <- import_gtfs(paths =  gtfs_url)
my_daily_gtfs <- gtfs_drilldown(gtfs_obj, today = data_pull_date)



#### PRINT TO CONSOLE SOME INFO THAT WILL TELL 
#### 2. the time range collected (plot too?)
print(paste("Datetime ranges from", min(all_data$datetime), "to", max(all_data$datetime)))
#### 3. number of frames total in the animation
print(paste("Total point in time captures:", length(unique(all_data$datetime))))
#### 4. Do the routes in the gtfs match what we see in the gps
gtfs_routes <- unique(gtfs_obj$trips_df$route_id) 
gps_routes  <- unique(all_data$route)
print(paste("Route/s:", paste(gtfs_routes[!gtfs_routes %in% gps_routes], collapse = ", "), "is/are not included in the gps data."))
print(paste("Route/s:", paste(gps_routes[!gps_routes %in% gtfs_routes], collapse = ", "), "is/are not included in the gtfs data."))
#### 5. Which gifs will be made? 
expected_files <- all_data %>% filter(route %in% gtfs_routes) %>% group_by(route, direction) %>% filter(row_number() == 1) %>% 
  mutate(full_path = paste0(getwd(), "/", paste(route, direction, "outfile.gif", sep = "_"))) %>% .$full_path
print(paste("Expecting", length(expected_files), "gifs"))
print(paste("Those files are:", paste(expected_files, collapse = ", "))


unique_routes <- sort(unique(my_daily_gtfs$todays_trips$route_id))
for(k in unique_routes) {
  
  unqiue_directions <- 
    gtfs_obj$trips_df %>% 
    filter(route_id == k) %>% 
    .$direction_id %>% 
    unique() 
  
  for(l in unqiue_directions) {  
    
    shape_id_for_plot <- 
      gtfs_obj$trips_df %>% 
      select(-trip_id) %>% 
      filter(route_id == k, direction_id == l, service_id == my_daily_gtfs$todays_service_id) %>% 
      .$shape_id %>% 
      unique()
    route_shapes <- gtfs_obj$shapes_df %>% filter(shape_id == shape_id_for_plot)
    shape_starts <- route_shapes %>% filter(shape_pt_sequence == min(shape_pt_sequence))
    coords <- c(left = min(route_shapes$shape_pt_lon)   - 0.05, 
                bottom = min(route_shapes$shape_pt_lat) - 0.05, 
                right = max(route_shapes$shape_pt_lon)  + 0.05, 
                top = max(route_shapes$shape_pt_lat)    + 0.05)
    map <- get_stamenmap(coords, zoom = 12, maptype = "toner-lite")
    
    
    
    #### PULL THIS OUT OF THE INNER LOOP ####
    all_data2 <- data.frame()
    for(i in unique(all_data$datetime)) {
      one_point_in_time <- all_data %>% filter(datetime == i) 
      delays_in_time <-
        calculate_delays(tidy_gps_obj = one_point_in_time, 
                         gtfs_today = my_daily_gtfs, 
                         lat_factor = 2.1)
      print(nrow(one_point_in_time) == nrow(delays_in_time))
      print(i)
      bound_data <- 
        inner_join(all_data %>% select(datetime, route, direction, lat, lon),   # recently removed the order column. 
                   delays_in_time %>% mutate(lat = gps_lat, lon = gps_lon), 
                   by = c("route", "direction", "lon", "lat"))
      all_data2 <- rbind(all_data2, bound_data)
    }
    to_animate <- all_data2 %>% filter(route == k, direction == l)
    to_animate$delay <- second(to_animate$delay)
    to_animate$delay[to_animate$delay < 0] <- 0    
    to_animate <- to_animate %>%
      mutate(  xpos = Inf,
               ypos = Inf,  
               annotateText = as.character(to_animate$delay),
               hjustvar = 1,
               vjustvar = 1)
    
    
    
    #### PULL THIS OUT OF THE THE ROUTE AND DIRECTION LOOP AND DO IT FOR ALL AT SAME TIME FROM CSV DATA NOT to_animate
    scheduled_data <- data.frame()
    for(i in unique(to_animate$datetime)) {
      
      a_point_in_time <- 
        to_animate %>% 
        filter(datetime == i)
      
      A_scheduled_stop <- 
        my_daily_gtfs$today_stop_times %>% 
        filter(trip_id %in% to_animate$trip_id) %>% 
        group_by(trip_id) %>%
        filter(hms(arrival_time) > hms(format(ymd_hms(a_point_in_time$datetime), format="%H:%M:%S"))) %>% 
        arrange(stop_sequence) %>%
        filter(row_number() == 1) %>% 
        ungroup() %>% 
        mutate(type = "A_scheduled_stop")
      
      B_scheduled_stop <- 
        my_daily_gtfs$today_stop_times %>% 
        filter(trip_id %in% to_animate$trip_id) %>% 
        group_by(trip_id) %>%
        filter(hms(departure_time) < hms(format(ymd_hms(a_point_in_time$datetime), format="%H:%M:%S"))) %>% 
        arrange(-stop_sequence) %>%
        filter(row_number() == 1 ) %>% 
        ungroup() %>% 
        mutate(type = "B_scheduled_stop")
      
      scheduled_stops <- rbind(A_scheduled_stop, B_scheduled_stop) 
      
      d <- 
        inner_join(scheduled_stops, gtfs_obj$stops_df, by = "stop_id") %>% 
        select(stop_lat, stop_lon, type, trip_id) %>% 
        mutate(datetime = a_point_in_time$datetime[1])
      
      scheduled_data <- rbind(scheduled_data, d)    
    }
    
    p <- ggmap(map, extent = "device") +   
      geom_path( data = route_shapes,   aes(x= shape_pt_lon, y = shape_pt_lat), color = "pink", size = 2) + 
      geom_point(data = scheduled_data, aes(x = stop_lon, y = stop_lat, frame = datetime), size = 4, color = "green") +
      geom_point(data = to_animate, aes(x = lon, y = lat, frame = datetime, color = delay), size = 4, colour = "black", pch = 21) + 
      scale_colour_gradient2()
    
    gganimate(p, outfile = paste(k, l, "outfile.gif", sep = "_"), convert = "gm convert", ani.height = 480 * 2, title_frame = TRUE, interval = 0.2)
  }
}}
