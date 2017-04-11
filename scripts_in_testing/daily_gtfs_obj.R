library(gtfsdrilldown);library(gtfsr)
# Filter the gtfs object to just the current day. 

daily_gtfs_obj <- function(day = Sys.Date() {
  gtfs_obj <- import_gtfs("https://transitfeeds.com/link?u=http://gtfs.muni.org/People_Mover.gtfs.zip")
  gtfs_drilldown(gtfs_obj, day)
}
