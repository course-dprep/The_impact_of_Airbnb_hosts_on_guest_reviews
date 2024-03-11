library(readr)
library(dplyr)
library(tidyverse)
library(data.table)

###################### Function with explanation & example ###########################

download_and_process_airbnb_data <- function(url, region, country) {
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
  
  # Create a new csv file with all "host" and "review" variables
  selected_data <- select(data, starts_with("host"), starts_with("review"))
  write.csv(selected_data, paste(region, "_Host_Review_data.csv", sep = ""), row.names = TRUE)
  
  # Add the variables "Region" and "Country"
  full_data <- mutate(selected_data, Region_Dataset = region, Country_Dataset = country)
  
  # Return the modified data
  return(full_data)
}

# EXAMPLE for Greece datasets...
athens_data <- download_and_process_data(url_Athens, "Athens", "Greece")
crete_data <- download_and_process_data(url_crete, "Crete", "Greece")
south_aegean_data <- download_and_process_data(url_South_Aegean, "South_Aegean", "Greece")
thessaloniki_data <- download_and_process_data(url_thessaloniki, "Thessaloniki", "Greece")

# ... and than combine the datasets for Greece
greece_host_reviews <- bind_rows(athens_data, crete_data, south_aegean_data, thessaloniki_data)
write.csv(greece_host_reviews, "Greece_Host_reviews.csv", row.names = TRUE)
View(greece_host_reviews)



###################### Function without explanation & example ###########################

download_and_process_airbnb_data <- function(url, region, country) {
  file_name <- paste(region, "_data.csv", sep = "")
  
  if (!file.exists(file_name)) {
    download.file(url, file_name)
  }
  
  if (grepl(".gz", file_name)) {
    system(paste("gzip -d", file_name))
    file_name <- gsub(".gz", "", file_name)
  }

  data <- read_csv(file_name)

  selected_data <- select(data, starts_with("host"), starts_with("review"))
  write.csv(selected_data, paste(region, "_Host_Review_data.csv", sep = ""), row.names = TRUE)

  full_data <- mutate(selected_data, Region_Dataset = region, Country_Dataset = country)

  return(full_data)
}
