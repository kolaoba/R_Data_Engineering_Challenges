
# load relevant library
pacman::p_load(dplyr)

# declare target url
base_url <- 'https://www.ncei.noaa.gov/data/local-climatological-data/access/2021/'

# declare target date
target_date <- "2022-02-07 14:03"

# read page html into R
content <- xml2::read_html(base_url)

# extract table attrinbutes from page html
tables <- content %>% rvest::html_table(fill=T)


target_urls <- tables[[1]] %>%
  # filter last modified column for target date
  filter(`Last modified` == target_date) %>%
  # extract relevant column (csv name) into vector
  pull(`Name`) %>%
  # extract first csv name
  first() %>%
  # append base_url to csv name to create downlod link
  paste0(base_url,.)

# read csv file from http link
df <- readr::read_csv(target_urls)

# extract record(s) with highest HourlyDryBulbTemperature
df %>%
  select(`STATION`,`HourlyDryBulbTemperature`) %>%
  tidyr::drop_na(`HourlyDryBulbTemperature`) %>%
 slice_max(`HourlyDryBulbTemperature`) %>%
  print()



