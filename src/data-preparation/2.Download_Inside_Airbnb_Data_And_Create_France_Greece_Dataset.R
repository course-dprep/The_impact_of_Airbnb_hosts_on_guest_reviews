# Load required packages
library(readr)
install.packages('dplyr')
library(dplyr)
library(tidyverse)
library(data.table)

# Wrangling the data

# Creating a function that creates an url variable from the webscraper including country, region and url
# Function to extract the url from the scraped url dataset and call it 'get_region_url'
get_region_url <- function(region_name) {
  #Save the read dataset under a variable. read.csv is chosen, because read_csv breaks the code. Enhancement not needed, because of the small size of the dataset. 
  url_data <- read.csv("Data/Inside_Airbnb_URL_Dataset.csv")
  
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
url_thessaloniki <- get_region_url("Thessaloniki")

#France
url_Bordeaux <- get_region_url("Bordeaux")
url_Lyon <- get_region_url("Lyon")
url_Paris <- get_region_url("Paris")
url_Pays_Basque <- get_region_url("Pays Basque")

# Creating a function that wrangles the dataset to our selected regions and returns the selected data
# Load required packages

# Creating a place to save the files
dir.create('Gen')
dir.create('Gen/data-preparation')
dir.create('Gen/data-preparation/input')
dir.create('Gen/data-preparation/output')

# Function to extract the url from the scraped url dataset and call it 'get_region_url'
get_region_url <- function(region_name) {
  #Save the read dataset under a variable.
  url_data <- read.csv("Data/Inside_Airbnb_URL_Dataset.csv")
  
  #Create a filter that matches the given region name and its url
  region_url <- url_data %>%
    filter(Region == region_name) %>%
    select(Link)
  
  #Create a variable called value that extracts only the url
  value <- region_url$Link
  
  #Return the URL
  return(value)
}

# Creating a function that wrangles the dataset to our selected regions and returns the selected data
Create_Region_Dataset <- function(url, region, country) {
  # Downloading the needed dataset from the url and saving it to our wanted file
  file_name <- paste0("Gen/data-preparation/input/", region, ".csv")
  if (!file.exists(file_name)) {
    message("Downloading file from ", url)
    tryCatch(download.file(url, file_name, mode = "wb"), 
             error = function(e) {
               stop("Error downloading the file: ", conditionMessage(e))
             })
  }
  
  # Read the downloaded file
  message("Reading the dataset...")
  data <- read.csv(file_name)
  
  # Create a selection of the dataset with host and review variables.
  selected_data <- data %>%
    select(starts_with("host"), starts_with("review")) %>%
    mutate(Region_Dataset = region, Country_Dataset = country)
  
  # Define a new filename for the modified dataset and saving location
  modified_file_name <- paste0("Gen/data-preparation/output/", region, "_selected.csv")
  
  # Add this new selection to the dataset
  message("Writing to CSV file...")
  write.csv(selected_data, modified_file_name, row.names = FALSE)
  
  message("Process completed successfully.")
  
  # Return the selected data
  return(selected_data)
}

# Greece
url_Athens <- get_region_url("Athens")
url_Crete <- get_region_url("Crete")
url_South_Aegean <- get_region_url("South Aegean")
url_thessaloniki <- get_region_url("Thessaloniki")

athens_selected_data <- Create_Region_Dataset(url_Athens, "Athens", "Greece")
crete_selected_data <- Create_Region_Dataset(url_Crete, "Crete", "Greece")
south_aegean_selected_data <- Create_Region_Dataset(url_South_Aegean, "South Aegean", "Greece")
thessaloniki_selected_data <- Create_Region_Dataset(url_thessaloniki, "Thessaloniki", "Greece")

# France
url_Bordeaux <- get_region_url("Bordeaux")
url_Lyon <- get_region_url("Lyon")
url_Paris <- get_region_url("Paris")
url_Pays_Basque <- get_region_url("Pays Basque")

bordeaux_selected_data <- Create_Region_Dataset(url_Bordeaux, "Bordeaux", "France")
lyon_selected_data <- Create_Region_Dataset(url_Lyon, "Lyon", "France")
paris_selected_data <- Create_Region_Dataset(url_Paris, "Paris", "France")
pays_basque_selected_data <- Create_Region_Dataset(url_Pays_Basque, "Pays Basque", "France")

# Combining all the selected regions of Greece and France together to make a dataset called 'France_Greece_selected_data' in csv form
Inside_Airbnb_Final_Dataset <- bind_rows(athens_selected_data, crete_selected_data, south_aegean_selected_data, thessaloniki_selected_data, bordeaux_selected_data, lyon_selected_data, paris_selected_data, pays_basque_selected_data)
write.csv(Inside_Airbnb_Final_Dataset, "Gen/data-preparation/output/Inside_Airbnb_Final_Dataset.csv", row.names = FALSE)

# Greece
athens_selected_data <- Create_Region_Dataset(url_Athens, "Athens", "Greece")
crete_selected_data <- Create_Region_Dataset(url_Crete, "Crete", "Greece")
south_aegean_selected_data <- Create_Region_Dataset(url_South_Aegean, "South Aegean", "Greece")
thessaloniki_selected_data <- Create_Region_Dataset(url_thessaloniki, "Thessaloniki", "Greece")

# France
bordeaux_selected_data <- Create_Region_Dataset(url_Bordeaux, "Bordeaux", "France")
lyon_selected_data <- Create_Region_Dataset(url_Lyon, "Lyon", "France")
paris_selected_data <- Create_Region_Dataset(url_Paris, "Paris", "France")
pays_basque_selected_data <- Create_Region_Dataset(url_Pays_Basque, "Pays Basque", "France")

# Combining all the selected regions of Greece and France together to make a dataset called 'France_Greece_selected_data' in csv form
Inside_Airbnb_Final_Dataset <- bind_rows(athens_selected_data, crete_selected_data, south_aegean_selected_data, thessaloniki_selected_data, bordeaux_selected_data, lyon_selected_data, paris_selected_data, pays_basque_selected_data)
final_dataset_file <- "Gen/data-preparation/output/Inside_Airbnb_Final_Dataset.csv"
write.csv(Inside_Airbnb_Final_Dataset, final_dataset_file, row.names = TRUE)
