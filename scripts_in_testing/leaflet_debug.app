  leaflet(surrounding_stops) %>% addTiles() %>% 
    addCircles(~A_lon, ~A_lat, radius = ~A_dist * 50000, weight = 1, color = "green") %>%
    addMarkers(~gps_lon, ~gps_lat) %>% 
    addCircles(~B_lon, ~B_lat, radius = ~B_dist * 50000, weight = 1, color = "red") %>%
    addPolylines(data = inner_join((gtfs_today$today_stop_times   %>% filter(trip_id %in% surrounding_stops$trip_id)), 
                                   (gtfs_today$all_stop_sequences  %>% ungroup()%>% select(-stop_sequence)), by = "stop_id") %>% 
                   group_by(stop_sequence) %>% 
                   filter(row_number() == 1), lng = ~stop_lon, lat = ~stop_lat, color = "yellow") 