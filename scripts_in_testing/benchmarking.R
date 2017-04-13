library(XML);library(dlayr);library(dplyr)
library(lubridate);library(tidyr);library(gtfsr)
source("tidy_gps_people_mover.R")

benchmark_gps_feed <- function(tidy_gps_function) {
  all_benchmarks <- c()
  for(i in 1:10) {
    x <- system.time(x <- tidy_gps_function)
    all_benchmarks <-  c(all_benchmarks, x[3])
  }
  all_benchmarks
}
benchmark_gps_feed(tidy_gps_people_mover())


  time_diffs <- c()
  start_time <- proc.time()
  x_time <- proc.time()
  x <- tidy_gps_people_mover() %>% select(-datetime)
  while((proc.time() - start_time)[3] < 600) {
  y_time <- proc.time()
  y <- tidy_gps_people_mover() %>% select(-datetime)
  while(isTRUE(all_equal(y,x))){
    Sys.sleep(n)
    y_time <- proc.time()
    y <- tidy_gps_people_mover() %>% select(-datetime)
  }
  time_diff <- y_time - x_time
  time_diffs <- c(time_diffs, time_diff[3])
  x_time <- proc.time() 
  x <- tidy_gps_people_mover() %>% select(-datetime)
  while(isTRUE(all_equal(y,x))){
    Sys.sleep(n)
    x_time <- Sys.time()
    x <- tidy_gps_people_mover() %>% select(-datetime)
  }
  time_diff <- x_time - y_time
  time_diffs <- c(time_diffs, time_diff[3])
  }
time_diffs