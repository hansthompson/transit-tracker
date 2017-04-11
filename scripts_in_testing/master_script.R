library(gtfsdrilldown);library(dplyr);library(lubridate);library(tidyr);library(leaflet) 
# use the gps and gtfs to find which possible trip ids, then assign them based on some logic. Ends up with a object of trip_ids with gps "id".

tidy_gps_obj <- data.frame(lat =   c(61.167986,    61.131665,    61.213679,   61.219051),
                           lon = c(-149.868008, -149.864108,  -149.778465, -149.825072),
                           route =      c(60, 60, 8, 8), 
                           direction =  c(1,1,0,0),
                           datetime = ymd_hms(Sys.time()))

tidy_gps_obj <- get_tidy_gps()

my_daily_gtfs <- daily_gtfs_obj(url = "https://transitfeeds.com/link?u=http://gtfs.muni.org/People_Mover.gtfs.zip")

calculate_delays(my_gps_data = tidy_gps_obj,
                 gtfs_today = my_daily_gtfs,
                 lat_factor = 2.1)
