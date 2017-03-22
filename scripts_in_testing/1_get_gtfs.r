# get the gtfs internet file address and use package, gtfsr, to build it into a r data object. 
library(gtfsr)

gtfs_url <- "http://transitfeeds.com/link?u=http://gtfs.muni.org/People_Mover.gtfs.zip"

gtfs_obj <- import_gtfs(gtfs_url)




