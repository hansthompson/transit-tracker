library(gtfsr);library(gtfsdrilldown);library(dplyr);library(lubridate)

gtfs_url <- "http://transitfeeds.com/link?u=http://gtfs.muni.org/People_Mover.gtfs.zip"

gtfs_obj <- import_gtfs(gtfs_url)

gtfs_today <- gtfs_drilldown(gtfs_obj, today = structure(17243, class = "Date"))

#fake data
gps_data <- data.frame(route = rep("75", 2), direction = rep(1, 2), lat = c(61.221720, 61.180904), lon = c(-149.733576, -149.822776), datetime = rep(ymd_hms("2017-03-19 10:48:35 AKDT", tz = "AKST"), 2))
load("gtfs_obj.Rdata")
