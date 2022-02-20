
# install/load relevant libraries
pacman::p_load(httr, promises, dplyr)

# run async functions in multiple sessions
future::plan(future::multisession)

download_uris = c(
  'https://divvy-tripdata.s3.amazonaws.com/Divvy_Trips_2018_Q4.zip',
  'https://divvy-tripdata.s3.amazonaws.com/Divvy_Trips_2019_Q1.zip',
  'https://divvy-tripdata.s3.amazonaws.com/Divvy_Trips_2019_Q2.zip',
  'https://divvy-tripdata.s3.amazonaws.com/Divvy_Trips_2019_Q3.zip',
  'https://divvy-tripdata.s3.amazonaws.com/Divvy_Trips_2019_Q4.zip',
  'https://divvy-tripdata.s3.amazonaws.com/Divvy_Trips_2220_Q1.zip',
  'https://divvy-tripdata.s3.amazonaws.com/Divvy_Trips_2020_Q1.zip'
)

# create log directory
log_dir <- './log'
if(!dir.exists(log_dir)){dir.create(log_dir)}

# create log file
log_filename = './log/main.log'
if(!file.exists(log_filename)){file.create(log_filename)}
con <- file(log_filename, open = "at")

sink(con, append = T, type="message")

message(Sys.time(),":........................Starting new session........................")

# write function to complete the challenge
file_downloadR <- function(url) {

  # extract filename
  filename <- stringr::str_match(url, '(.*)/(.*).(zip)')[,-1] %>% nth(-2L)

  # create destination folder
  output_dir <- 'downloads'
  if (!dir.exists(output_dir)) {
    dir.create(output_dir)
    message(Sys.time(),": ",output_dir, " folder created successfully")
  }
  # create tempname for zip file
  zipfilename <- paste0(output_dir,"/",filename,".zip")

  # declare async function with error handling
  promise <- future_promise({
    tryCatch(
      expr = {
        message(Sys.time(),": ","Starting download...")
        # download zip file
        suppressWarnings(download.file(url = url, destfile = zipfilename))
        message(Sys.time(),": ",filename, ".zip was downloaded successfully")
        # declare unzip destination folder
        unzipdir <- paste0(getwd(), "/", output_dir)
        # unzip to destination folder
        unzip(zipfilename, exdir = unzipdir)
        message(Sys.time(),": ",filename, ".csv was extracted successfully")
        # delete zip file
        unlink(zipfilename)
      },
      error = function(err) {
        message(Sys.time(),": Error while downloading ", filename,".zip")
        message(Sys.time(),": URL does not seem to exist: ", url)
      }
    )
  })
}

# run function on all URLs
purrr::walk(download_uris,file_downloadR)

