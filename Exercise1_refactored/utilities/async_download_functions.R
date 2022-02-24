# extract filename from url
extract_filename <- function(url){

  # extract filename
  filename <<- stringr::str_match(url, '(.*)/(.*).(zip)')[,-1] %>% dplyr::nth(-2L)
}

# create filename for zip file
create_zipfile_details <- function(){

  # create filename for zip file
  zipfilename <<- paste0(output_dir,"/",filename,".zip")

  # declare unzip destination folder
  unzipdir <<- paste0(getwd(), "/", output_dir)
}


# download zip file
download_zipfile <- function(url=url){

  message(Sys.time(),": ","Starting download...")
  # download zip file
  suppressWarnings(download.file(url = url, destfile = zipfilename))
  message(Sys.time(),": ",filename, ".zip was downloaded successfully")

}

# extract csv from zip file
extract_csv <- function(){

  # unzip to destination folder
  unzip(zipfilename, exdir = unzipdir)
  message(Sys.time(),": ",filename, ".csv was extracted successfully")

}

# delete zip file
delete_zipfile <- function(){

  unlink(zipfilename)
  message(Sys.time(),": ",filename, ".zip was deleted successfully")
}

# write async function
run_async_download <- function(url) {

  # declare async function with error handling
  promises::future_promise({
    tryCatch(
      expr = {
        extract_filename(url)
        create_zipfile_details()
        download_zipfile(url)
        extract_csv()
        delete_zipfile()
      },
      error = function(err) {
        message(Sys.time(), ": Error while downloading ", filename, ".zip")
        message(Sys.time(), ": URL does not seem to exist: ", url)
      }
    )
  })
}
