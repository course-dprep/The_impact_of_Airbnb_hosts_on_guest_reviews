# Check where the csv file is downloaded 
# Set the working directory for where the file is

#Load required libraries
library(readr)
library(dplyr)
library(tidyverse)
library(data.table)

#We want to select the variables that are used in our dataset, hence we need to wrangle the data.

#First we have to create a function that creates an url variable from the webscraped countries, regions and urls
#Create a function to extract the url from the scraped url dataset and call it 'get_region_url'
get_region_url <- function(region_name) {
  #Save the read dataset under a variable
  url_data <- read.csv("Inside_Airbnb_URL_Dataset.csv")
  
  #Create a filter that matches the given region name and its url
  region_url <- url_data %>%
    filter(Region == region_name) %>%
    select(Link)
  
  #Create a variable called value that extracts only the url
  value <- region_url[1, "Link"]
  
  #Return the URL
  return(value)
}

#Implementing the function to create the region urls
#Greece
url_Athens <- get_region_url("Athens")
url_Crete <- get_region_url("Crete")
url_South_Aegean <- get_region_url("South Aegean")
url_Thessaloniki <- get_region_url("Thessaloniki")
#France
url_Bordeaux <- get_region_url("Bordeaux")
url_Lyon <- get_region_url("Lyon")
url_Paris <- get_region_url("Paris")
url_Pays_Basque <- get_region_url("Pays Basque")

#Second we create a function that wrangles the dataset to our selected regions and returns the selected data
download_and_process_selected_airbnb_data <- function(url, region, country) {
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
  
  # Create a new csv file with only the selected variables
  selected_data <- select(data, 
                          host_id, host_url, host_has_profile_pic, host_identity_verified, review_scores_rating)
  
  write.csv(selected_data, paste(region, "_selected_data.csv", sep = ""), row.names = TRUE)
  
  # Add the variables "Region" and "Country"
  selected_data_data <- mutate(selected_data, Region_Dataset = region, Country_Dataset = country)
  
  # Return the modified data
  return(selected_data)
}

#Implementing the function to create datasets of the needed regions
#Greece
athens_selected_data <- download_and_process_selected_airbnb_data(url_Athens, "Athens", "Greece")
crete_selected_data <- download_and_process_selected_airbnb_data(url_Crete, "Crete", "Greece")
south_aegean_selected_data <- download_and_process_selected_airbnb_data(url_South_Aegean, "South Aegean", "Greece")
thessaloniki_selected_data <- download_and_process_selected_airbnb_data(url_Thessaloniki, "Thessaloniki", "Greece")
#France
bordeaux_selected_data <- download_and_process_selected_airbnb_data(url_Bordeaux, "Bordeaux", "France")
lyon_selected_data <- download_and_process_selected_airbnb_data(url_Lyon, "Lyon", "France")
paris_selected_data <- download_and_process_selected_airbnb_data(url_Paris, "Paris", "France")
pays_basque_selected_data <- download_and_process_selected_airbnb_data(url_Pays_Basque, "Pays Basque", "France")


#Third we combine all the selected regions of Greece and France together to make a dataset called 'France_Greece_selected_data' in csv form
France_Greece_selected_data <- bind_rows(athens_selected_data, crete_selected_data, south_aegean_selected_data, thessaloniki_selected_data, bordeaux_selected_data, lyon_selected_data, paris_selected_data, pays_basque_selected_data)
write.csv(France_Greece_selected_data, "France_Greece_selected_data.csv", row.names = TRUE)
View(France_Greece_selected_data)

####### WE ARE MISSING THE VARIABLE FOR REGION AND COUNTRY #######

#De functie van Rolf en Julian dient gecombineerd te worden.
#Optimalisatie mogelijk bij stap 3. Dit zou een functie kunnen zijn, zodat het geschikt is voor meerdere regios die gecombineerd worden.
#Alle functies kunnen in een totale functie gezet worden. Zodat bij ingave van alle regio's het definitieve csv bestand gemaakt wordt.
#Reden: snelheid en optimalisatie automatisering. 
