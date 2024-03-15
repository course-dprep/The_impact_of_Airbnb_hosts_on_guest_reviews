#Load required libraries
library(dplyr)
library(readr)

#Create a function to extract URLs form a csv file and save these under 'Region_url'

#Function will be added later. It's late i am going to bed :)







#Rolf zijn code -> dit heeft nog geen toepassing
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
  
  write.csv(selected_data, paste(region, "_selected_data.csv", sep = ""), row.names = TRUE)
  
  selected_data <- mutate(selected_data, Region_Dataset = region, Country_Dataset = country)
  
  return(selected_data)
}

#De functie van Rolf en Julian dient gecombineerd te worden.
#Reden: snelheid en optimalisatie automatisering. 