library(XML);library(dlayr);library(dplyr)
library(lubridate);library(tidyr);library(gtfsr)
source("tidy_gps_people_mover.R")

tidy_gps_obj <- tidy_gps_people_mover()

my_daily_gtfs <- daily_gtfs_obj(url = "https://transitfeeds.com/link?u=http://gtfs.muni.org/People_Mover.gtfs.zip")

calculate_delays(my_gps_data = tidy_gps_obj,
                 gtfs_today = my_daily_gtfs,
                 lat_factor = 2.1)


