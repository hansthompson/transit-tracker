library(devtools)
library(dplyr)
library(tidyr)
library(lubridate)

install_github("hansthompson/gtfsdrilldown")
install_github("ropensci/gtfsr")

library(gtfsdrilldown)
library(gtfsr)

url <- 'https://transitfeeds.com/link?u=http://gtfs.muni.org/People_Mover.gtfs.zip' # change your url here

gtfs_obj <- url %>% import_gtfs

gtfs_for_today <- gtfs_drilldown(gtfs_obj, today = Sys.Date())

