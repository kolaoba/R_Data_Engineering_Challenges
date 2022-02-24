
# create log directory and file

create_log_file <- function() {
  # create log directory
  log_dir <- './log'
  if(!dir.exists(log_dir)){dir.create(log_dir)}

  # create log file
  log_filename <<- paste0(log_dir, '/main.log')
  if(!file.exists(log_filename)){file.create(log_filename)}
  # return(log_filename)
  # assign("log_filename", log_filename, envir = .GlobalEnv)
}

# open file connection and start logging

start_logging <- function(){

  # log_filename <- get("log_filename", envir = .GlobalEnv)

  # open connection to log file
  con <<- file(description=log_filename, open = "at")

  # divert message output to log file
  sink(con, append = T, type="message")

  # log starting message
  message(Sys.time(),":........................Starting new session........................")

  # assign("con", con, envir = .GlobalEnv)
}

# create destination folder

create_downloads_folder <- function(){
  # create destination folder
  output_dir <<- 'downloads'
  if (!dir.exists(output_dir)) {
    dir.create(output_dir)
    message(Sys.time(),": ",output_dir, " folder created successfully")
  }
  # assign("output_dir", output_dir, envir = .GlobalEnv)
}

# close log connection
stop_logging <- function(){
  # con <- get("con", envir = .GlobalEnv)

  close(con)
}
