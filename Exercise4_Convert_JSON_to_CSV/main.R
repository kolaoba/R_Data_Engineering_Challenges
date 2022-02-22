
# load relevant libraries
pacman::p_load(jsonlite, dplyr, tidyr)

# crawl dara directory and identify all json files
json_files <- list.files(pattern = "*.json", recursive=T, full.names = T)

# write function to read json and convert to dataframe
json_to_df <- function(json_file) {
  read_json(json_file) %>%
    rbind()  %>%
    data.frame()
}

# iteratively run custom read function on json files and return single dataframe
raw_df <- purrr::map_df(json_files, json_to_df)

# flatten out columns except geolocation column
df <- raw_df %>% unnest(cols= -c(geolocation))

# flatten out geolocation column and resulting coordinates column to long and lat
final_df <- df %>% unnest_wider(geolocation) %>% unnest_wider(coordinates, c("long", "lat"))

# write result dataframe to a csv file
write.csv(final_df, "output.csv", row.names=F)
