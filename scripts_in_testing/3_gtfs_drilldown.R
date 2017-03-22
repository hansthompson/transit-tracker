library(gtfsdrilldown)
# Filter the gtfs object to just the current day. 
load("gtfs_obj.Rdata")

gtfs_drilldown(gtfs_obj, today = structure(17243, class = "Date"))


