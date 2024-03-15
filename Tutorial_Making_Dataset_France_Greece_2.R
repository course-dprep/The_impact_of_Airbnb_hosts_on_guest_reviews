############### Step 1 ###############
##### Loading necessary libraries#####

library(dplyr) 
library(tidyverse) 
library(data.table) 
library(ggplot2)

############### Step 2 ###############
#### Making variables of the URLs ####

url_Athens <- "http://data.insideairbnb.com/greece/attica/athens/2023-12-25/data/listings.csv.gz"
url_crete <- "http://data.insideairbnb.com/greece/crete/crete/2023-12-27/data/listings.csv.gz"
url_South_Aegean <- "http://data.insideairbnb.com/greece/south-aegean/south-aegean/2023-12-20/data/listings.csv.gz"
url_thessaloniki <- "http://data.insideairbnb.com/greece/central-macedonia/thessaloniki/2023-12-25/data/listings.csv.gz"
url_Bordeaux <- "http://data.insideairbnb.com/france/nouvelle-aquitaine/bordeaux/2023-12-15/data/listings.csv.gz"
url_Lyon <- "http://data.insideairbnb.com/france/auvergne-rhone-alpes/lyon/2023-12-15/data/listings.csv.gz"
url_Paris <- "http://data.insideairbnb.com/france/ile-de-france/paris/2023-12-12/data/listings.csv.gz"
url_Pays_Basque <- "http://data.insideairbnb.com/france/pyr%C3%A9n%C3%A9es-atlantiques/pays-basque/2023-12-18/data/listings.csv.gz"


############### Step 3 ###############
## Functions to create the datasets ##

# Function 1 -> creates the whole dataset 
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
  
  # Add the variables "Region" and "country"
  full_data <- mutate(selected_data, Region_Dataset = region, Country_Dataset = country)
  
  # Return the modified data
  return(full_data)
}


# Function 2 -> creates dataset only with variables relevant for the research question 
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



############### Step 4 ###############
######## Create the data set #########
athens_necessary_data <- download_and_process_necesarry_airbnb_data(url_Athens, "Athens", "Greece")
crete_necessary_data <- download_and_process_necesarry_airbnb_data(url_crete, "Crete", "Greece")
south_aegean_necessary_data <- download_and_process_necesarry_airbnb_data(url_South_Aegean, "South Aegean", "Greece")
thessaloniki_necessary_data <- download_and_process_necesarry_airbnb_data(url_thessaloniki, "Thessaloniki", "Greece")

bordeaux_necessary_data <- download_and_process_necesarry_airbnb_data(url_Bordeaux, "Bordeaux", "France")
lyon_necessary_data <- download_and_process_necesarry_airbnb_data(url_Lyon, "Lyon", "France")
paris_necessary_data <- download_and_process_necesarry_airbnb_data(url_Paris, "Paris", "France")
pays_basque_necessary_data <- download_and_process_necesarry_airbnb_data(url_Pays_Basque, "Pays Basque", "France")

# Combine the datasets for both Greece and France
all_necessary_data <- bind_rows(
  athens_necessary_data,
  crete_necessary_data,
  south_aegean_necessary_data,
  thessaloniki_necessary_data,
  bordeaux_necessary_data,
  lyon_necessary_data,
  paris_necessary_data,
  pays_basque_necessary_data
)

# Write the combined dataset to a CSV file and view it
write.csv(all_necessary_data, "All_Necessary_Data.csv", row.names = FALSE)
View(all_necessary_data)


############### Step 5 ###############
######## Regression Analysis #########

# Encoding the variables profile picture, idenity verified and country as dummy variables
all_necessary_data_encoded <- within(all_necessary_data, {
  host_has_profile_pic <- as.numeric(host_has_profile_pic)  # TRUE=1, FALSE=0
  host_identity_verified <- as.numeric(host_identity_verified)  # TRUE=1, FALSE=0
  Country_Dataset <- ifelse(Country_Dataset == "Greece", 1, 0)  # Greece=1, France=0
})

View(all_necessary_data_encoded)

# Regression on scores rating
Host_Review_lm1 <- lm(review_scores_rating ~ host_has_profile_pic + host_identity_verified + Country_Dataset, all_necessary_data_encoded)
summary(Host_Review_lm1)

# Calculate mean review scores rating by host profile picture and country
mean_review_scores_profilepic <- all_necessary_data_encoded %>%
  group_by(host_has_profile_pic, Country_Dataset) %>%
  summarise(mean_review_score = mean(review_scores_rating, na.rm = TRUE))
mean_review_scores_identity <- all_necessary_data_encoded %>%
  group_by(host_identity_verified, Country_Dataset) %>%
  summarise(mean_review_score = mean(review_scores_rating, na.rm = TRUE))

# Grouping values table
print(mean_review_scores_profilepic)
print(mean_review_scores_identity)


############### Step 6 ###############
########### Visualization ############

# Barplot
