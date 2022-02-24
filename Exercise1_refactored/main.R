# install/load relevant libraries
pacman::p_load(httr, future, promises, stringr, purrr)

# run async functions in multiple sessions
future::plan(future::multisession)

# retrieve helper functions from utilities folder
source("./utilities/general_functions.R")
source("./utilities/async_download_functions.R")

# declare target uris
download_uris = c(
  'https://divvy-tripdata.s3.amazonaws.com/Divvy_Trips_2018_Q4.zip',
  'https://divvy-tripdata.s3.amazonaws.com/Divvy_Trips_2019_Q1.zip',
  'https://divvy-tripdata.s3.amazonaws.com/Divvy_Trips_2019_Q2.zip',
  'https://divvy-tripdata.s3.amazonaws.com/Divvy_Trips_2019_Q3.zip',
  'https://divvy-tripdata.s3.amazonaws.com/Divvy_Trips_2019_Q4.zip',
  'https://divvy-tripdata.s3.amazonaws.com/Divvy_Trips_2220_Q1.zip',
  'https://divvy-tripdata.s3.amazonaws.com/Divvy_Trips_2020_Q1.zip'
)

main <- function(){
  create_log_file()
  start_logging()
  create_downloads_folder()
  purrr::walk(download_uris,run_async_download) # loop function over each uri
}

# run function
main()
