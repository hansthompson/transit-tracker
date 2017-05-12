library(XML);library(dlayr);library(dplyr)
library(lubridate);library(tidyr);library(gtfsr)
my_daily_gtfs <- daily_gtfs_obj(url = "https://transitfeeds.com/link?u=http://gtfs.muni.org/People_Mover.gtfs.zip")
save(my_daily_gtfs, file = "/srv/shiny-server/dlayr-maps/dlayr-debug/my_daily_gtfs.rda")
