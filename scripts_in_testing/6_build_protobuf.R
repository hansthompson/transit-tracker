# write the protocol buffer. Start out by pasting an example object and use the script from api-realtime-bus. 


if(dim(combined_data)[1] != 0) {
  
  data_for_protobuf <-   combined_data %>%
    mutate(min_seq = min(sequence)) %>%
    filter(min_seq == sequence) %>%
    unique() %>% group_by(trip_id, sequence) %>% filter(row_number(sequence) == 1) %>%
    arrange(trip_id, sequence) 
  
  current_trips <- unique(combined_data$trip_id)
  
  protobuf_list <- vector(mode = "list", length = length(current_trips))
  
  for(i in 1:length(current_trips)) {
    
    deviation <- data_for_protobuf %>% filter(trip_id == current_trips[i]) %>% arrange(sequence)
    stop_time_update_list <- vector(mode = "list", length = dim(deviation)[1])
    
    for(j in 1:dim(deviation)[1]) { 
      
      trip_id <- as.character(deviation$trip_id[j])
      
      stop_time_update_object <- new(transit_realtime.TripUpdate.StopTimeUpdate,
                                     stop_sequence = deviation$sequence[j],
                                     arrival = new(transit_realtime.TripUpdate.StopTimeEvent,
                                                   delay = as.numeric(deviation$dev[j]))
      )
      
      stop_time_update_list[j] <- stop_time_update_object
      
    }
    
    e <- new(transit_realtime.FeedEntity,
             id = as.character(deviation$trip_id[j]),
             trip_update = new(transit_realtime.TripUpdate,
                               trip = new(transit_realtime.TripDescriptor,
                                          trip_id = as.character(deviation$trip_id[j])),
                               stop_time_update = stop_time_update_list
             )
    )
    
    protobuf_list[i] <- e
  }
  
  header_object <- new(transit_realtime.FeedHeader,
                       gtfs_realtime_version = "1.0",
                       incrementality = "FULL_DATASET",
                       timestamp = as.numeric(as.POSIXlt(Sys.time(), "AKST")))
  
  m <- new(transit_realtime.FeedMessage,
           header = header_object,
           entity = protobuf_list) # use entity_list
  
  writeLines(as.character(m))
  serialize(m, paste0(write_dir, "people_mover.pb"))
  
} else { # write no message in the protobuf.  Just update the header with the timestamp.
  
  header_object <- new(transit_realtime.FeedHeader,
                       gtfs_realtime_version = "1.0",
                       incrementality = "FULL_DATASET",
                       timestamp = as.numeric(as.POSIXlt(Sys.time(), "AKST")))
  
  m <- new(transit_realtime.FeedMessage,
           header = header_object) # use entity_list
  
  writeLines(as.character(m))
  serialize(m, paste0(write_dir, "people_mover.pb"))
}
