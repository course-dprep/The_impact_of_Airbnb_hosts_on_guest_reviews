library(readr)
library(dplyr)
library(tidyverse)
library(data.table)

###################### Function with explanation & example ###########################


download_and_process_necesarry_airbnb_data <- function(url, region, country) {
  # Creating a variable of the URL code
  file_name <- paste(region, "_data.csv", sep = "")
  
  # Download the file from the relevant URL
  if (!file.exists(file_name)) {
    download.file(url, file_name)
  }
  
  # Decompress the dataset if it is a csv.gz to a csv file
  if (grepl(".gz", file_name)) {
    system(paste("gzip -d", file_name))
    file_name <- gsub(".gz", "", file_name)
  }
  
  # Read data with the read_csv function
  data <- read_csv(file_name)
  
  # Create a new csv file with only the necessary variables
  selected_data <- select(data, 
                          host_id, host_url, host_has_profile_pic, host_identity_verified, review_scores_rating)
  
  write.csv(selected_data, paste(region, "_necesarry_data.csv", sep = ""), row.names = TRUE)
  
  # Add the variables "Region" and "Country"
  necessary_data <- mutate(selected_data, Region_Dataset = region, Country_Dataset = country)
  
  # Return the modified data
  return(necessary_data)
}

# EXAMPLE for Greece datasets...
athens_necesarry_data <- download_and_process_necesarry_airbnb_data(url_Athens, "Athens", "Greece")
crete_necesarry_data <- download_and_process_necesarry_airbnb_data(url_crete, "Crete", "Greece")
south_aegean_necesarry_data <- download_and_process_necesarry_airbnb_data(url_South_Aegean, "South_Aegean", "Greece")
thessaloniki_necesarry_data <- download_and_process_necesarry_airbnb_data(url_thessaloniki, "Thessaloniki", "Greece")

# ... and than combine the datasets for Greece
greece_necessary_data <- bind_rows(athens_necesarry_data, crete_necesarry_data, south_aegean_necesarry_data, thessaloniki_necesarry_data)
write.csv(greece_necesarry_data, "Greece_necesarry_data.csv", row.names = TRUE)
View(greece_necesarry_data)



###################### Function without explanation & example ###########################

download_and_process_necesarry_airbnb_data <- function(url, region, country) {
  file_name <- paste(region, "_data.csv", sep = "")
  
  if (!file.exists(file_name)) {
    download.file(url, file_name)
  }
  
  if (grepl(".gz", file_name)) {
    system(paste("gzip -d", file_name))
    file_name <- gsub(".gz", "", file_name)
  }
  
  data <- read_csv(file_name)
  
  selected_data <- select(data, 
                          host_id, host_url, host_has_profile_pic, host_identity_verified, review_scores_rating)
  
  write.csv(selected_data, paste(region, "_necesarry_data.csv", sep = ""), row.names = TRUE)
  
  necessary_data <- mutate(selected_data, Region_Dataset = region, Country_Dataset = country)
  
  return(necessary_data)
}

