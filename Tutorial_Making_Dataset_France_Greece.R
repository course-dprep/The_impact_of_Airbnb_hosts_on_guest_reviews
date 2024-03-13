#This dataset merges the datasets about Greece, it is created to examine the influence of the hosts on the review rating.

setwd("C:/Users/HP/OneDrive/Documenten/M Marketing Analytics/Skills Data Preparation & Workflow Management/Week 6 dprep")
getwd()

#Step 2 Coding the url's of the datapackages to variables. This is done to ensure that the other code keeps working and only the url needs to be changed over time.
#The url's to the datapackages of the regions in Greece
url_Athens <- "http://data.insideairbnb.com/greece/attica/athens/2023-12-25/data/listings.csv.gz"
url_crete <- "http://data.insideairbnb.com/greece/crete/crete/2023-12-27/data/listings.csv.gz"
url_South_Aegean <- "http://data.insideairbnb.com/greece/south-aegean/south-aegean/2023-12-20/data/listings.csv.gz"
url_thessaloniki <- "http://data.insideairbnb.com/greece/central-macedonia/thessaloniki/2023-12-25/data/listings.csv.gz"

#The url's to the datapackages of the regions in France
url_Bordeaux <- "http://data.insideairbnb.com/france/nouvelle-aquitaine/bordeaux/2023-12-15/data/listings.csv.gz"
url_Lyon <- "http://data.insideairbnb.com/france/auvergne-rhone-alpes/lyon/2023-12-15/data/listings.csv.gz"
url_Paris <- "http://data.insideairbnb.com/france/ile-de-france/paris/2023-12-12/data/listings.csv.gz"
url_Pays_Basque <- "http://data.insideairbnb.com/france/pyr%C3%A9n%C3%A9es-atlantiques/pays-basque/2023-12-18/data/listings.csv.gz"

# Step 3 Downloading the datapackage using the url variable and naming the dataset to our liking for further coding automation.Note that we first provide the url variable and second the name we want our csv.file to have. Don't forget to include '.csv' at the end of naming it. 
# Downloading the datapackages of the regions in Greece

# Adjustment: changing the csv files to csv.gz and adding mode = "wb"
download.file(url_Athens, "Athens_data.csv.gz", mode = "wb")
download.file(url_crete, "Crete_data.csv.gz", mode = "wb")
download.file(url_South_Aegean, "South_Aegean_data.csv.gz", mode = "wb")
download.file(url_thessaloniki, "Thessaloniki_data.csv.gz", mode = "wb")

#Downloading the datapackages of the regions in France
download.file(url_Bordeaux, "Bordeaux_data.csv.gz", mode = "wb")
download.file(url_Lyon, "Lyon_data.csv.gz", mode = "wb")
download.file(url_Paris, "Paris_data.csv.gz", mode = "wb")
download.file(url_Pays_Basque, "Pays_Basque_data.csv.gz", mode = "wb")

# Step 4 Converting all the csv.gz files to csv files
# Encapsulating all the code related to each URL, including downloading, decompressing, reading, and saving the CSV file.
# Creating vectors of the urls
urls_greece <- c("Athens_data.csv.gz", "Crete_data.csv.gz", "South_Aegean_data.csv.gz", "Thessaloniki_data.csv.gz")
urls_france <- c("Bordeaux_data.csv.gz", "Lyon_data.csv.gz", "Paris_data.csv.gz", "Pays_Basque_data.csv.gz")

# Greece
for (url in urls_greece) {
  greece <- gzfile(url, "r")
  data <- read.csv(greece)
  close(greece)

  write.csv(data, gsub(".csv.gz", ".csv", url), row.names = FALSE)
}

#France
for (url in urls_france) {
  france <- gzfile(url, "r")
  data <- read.csv(france)
  close(france)
  
  write.csv(data, gsub(".csv.gz", ".csv", url), row.names = FALSE)
}

# Check if it worked
list.files(pattern = ".csv$") #shows 8 csv files if correct

#Step 5 Loading the data in the workspace to be able to wrangle the data
library(dplyr) #Write if sequence to install it if that is needed
library(tidyverse) #See comment above
library(data.table) #See comment above

#Loading the data of the regions in Greece
Athens_data <- read.csv("Athens_data.csv")
Crete_data <- read.csv("Crete_data.csv")
South_Aegean_data <- read.csv("South_Aegean_data.csv")
Thessaloniki_data <- read.csv("Thessaloniki_data.csv")

#Loading the data of the regions in France
Bordeaux_data <- read.csv("Bordeaux_data.csv")
Lyon_data <- read.csv("Lyon_data.csv")
Paris_data <- read.csv("Paris_data.csv")
Pays_Basque_data <- read.csv("Pays_Basque_data.csv")

#Step 6 wrangle the datasets to create a new one that fits our research purpose. We want all the data about hosts and reviews, hence we select this and save this selection.
#Wrangle the data of the regions in Greece
Athens_Host_Review_data <- select(Athens_data, starts_with("host"), starts_with("review"))
Crete_Host_Review_data <- select(Crete_data, starts_with("host"), starts_with("review"))
South_Aegean_Host_Review_data <- select(South_Aegean_data, starts_with("host"), starts_with("review"))
Thessaloniki_Host_Review_data <- select(Thessaloniki_data, starts_with("host"), starts_with("review"))

#Wrangle the data of the regions in France
Bordeaux_Host_Review_data <- select(Bordeaux_data, starts_with("host"), starts_with("review"))
Lyon_Host_Review_data <- select(Lyon_data, starts_with("host"), starts_with("review"))
Paris_Host_Review_data <- select(Paris_data, starts_with("host"), starts_with("review"))
Pays_Basque_Host_Review_data <- select(Pays_Basque_data, starts_with("host"), starts_with("review"))

#Step 7 Make a new dataset from our selection that we just made that only contains the wanted variables.
#Making the datasets containing the wanted variables of the regions in Greece
write.csv(Athens_Host_Review_data, "Athens_Host_Review_data.csv", row.names = TRUE)
write.csv(Crete_Host_Review_data, "Crete_Host_Review_data.csv", row.names = TRUE)
write.csv(South_Aegean_Host_Review_data, "South_Aegean_Host_Review_data.csv", row.names = TRUE)
write.csv(Thessaloniki_Host_Review_data, "Thessaloniki_Host_Review_data.csv", row.names = TRUE)

#Making the datasets containing the wanted variables of the regions in France
write.csv(Bordeaux_Host_Review_data, "Bordeaux_Host_Review_data.csv", row.names = TRUE)
write.csv(Lyon_Host_Review_data, "Lyon_Host_Review_data.csv", row.names = TRUE)
write.csv(Paris_Host_Review_data, "Paris_Host_Review_data.csv", row.names = TRUE)
write.csv(Pays_Basque_Host_Review_data, "Pays_Basque_Host_Review_data.csv", row.names = TRUE)

#Step !8! The datasets are going to be merged and compered per region and country, therefore it is important to add the variables Region_dataset and Country_dataset to distinguish this. To retrieve the origin of the data.
#Adding the variables to the data of the regions in Greece
#Athens
Athens_Host_Review_data <- Athens_Host_Review_data %>% mutate(Region_Dataset="Athens", Country_Dataset='Greece')

#Crete
Crete_Host_Review_data <- Crete_Host_Review_data %>% mutate(Region_Dataset="Crete", Country_Dataset='Greece')

#South_Aegean
South_Aegean_Host_Review_data <- South_Aegean_Host_Review_data %>% mutate(Region_Dataset="South_Aegean", Country_Dataset='Greece')

#Thessaloniki
Thessaloniki_Host_Review_data <- Thessaloniki_Host_Review_data %>% mutate(Region_Dataset="Thessaloniki", Country_Dataset='Greece')

#Adding the variables to the data of the regions in France
#Bodreaux
Bordeaux_Host_Review_data <- Bordeaux_Host_Review_data %>% mutate(Region_Dataset="Bordeaux", Country_Dataset='France')

#Lyon
Lyon_Host_Review_data <- Lyon_Host_Review_data %>% mutate(Region_Dataset="Lyon", Country_Dataset='France')

#Paris
Paris_Host_Review_data <- Paris_Host_Review_data %>% mutate(Region_Dataset="Paris", Country_Dataset='France')

#Pays_Basque
Pays_Basque_Host_Review_data <- Pays_Basque_Host_Review_data %>% mutate(Region_Dataset="Pays_Basque", Country_Dataset='France')

#Step 9 Adding the subdatasets of regions to a country dataset
#Creating the dataset for Greece
Greece_Host_reviews <- bind_rows(Athens_Host_Review_data, Crete_Host_Review_data, South_Aegean_Host_Review_data, Thessaloniki_Host_Review_data)
write.csv(Greece_Host_reviews, "Greece_Host_reviews.csv", row.names = TRUE)
View(Greece_Host_reviews)

#Creating the dataset for France
France_Host_reviews <- bind_rows(Bordeaux_Host_Review_data, Lyon_Host_Review_data, Paris_Host_Review_data, Pays_Basque_Host_Review_data)
write.csv(France_Host_reviews, "France_Host_reviews.csv", row.names = TRUE)
View(France_Host_reviews)

#Well done you just created 2 datasets. One called Greece_Host_reviews and one called France_Host_reviews -> Checking origin variable errors!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#Step 10 Combining the Greece and France dataset. By using a simular principle of creating the country datasets
Data_Greece_France <- bind_rows(Greece_Host_reviews, France_Host_reviews)
write.csv(Data_Greece_France, "Data_Greece_France", row.names = TRUE)
View(Data_Greece_France)

# Getting insights in the data by looking at the regions
region_counts <- table(Data_Greece_France$Region_Dataset)
print(region_counts)
# Found a mistake in the region name so adjusted it so the dataset is right!

# Step 11: the regression
# Loading the data
Data_Greece_France <- read.csv("Data_Greece_France")

# Encoding the variables profile picture, idenity verified and country as dummy variables
Data_Greece_France <- within(Data_Greece_France, {
  host_has_profile_pic <- as.numeric(host_has_profile_pic == "t") #true=1
  host_identity_verified <- as.numeric(host_identity_verified == "t") #true=1
  Country_Dataset <- as.numeric(Country_Dataset == "Greece") #Greece=1
})

View(Data_Greece_France)

# Regression option 1: scores value
Host_Review_lm1 <- lm(review_scores_value ~ host_has_profile_pic + host_identity_verified + Country_Dataset, Data_Greece_France)
summary(Host_Review_lm1)

# Regression option 2; scores rating
Host_Review_lm2 <- lm(review_scores_rating ~ host_has_profile_pic + host_identity_verified + Country_Dataset, Data_Greece_France)
summary(Host_Review_lm2)

###################################TRYING VISUALISATION####################################
library(broom)
Host_Review <- augment(Host_Review_lm1)
library(ggplot2)
ggplot(Host_Review, aes(.resid)) + geom_histogram(aes(y = after_stat(density)), binwidth = 5) + stat_function(fun = dnorm, args = list(mean = mean(Host_Review$.resid), sd = sd(Host_Review$.resid)), color="red", linewidth=1)
plot(Host_Review_lm1, which=1)

# Line graph; does not work
agg_data <- aggregate(review_scores_rating ~ Country_Dataset + host_has_profile_pic + host_identity_verified, data = Data_Greece_France, FUN = mean)
ggplot(agg_data, aes(x = Country_Dataset, y = review_scores_rating, color = factor(host_has_profile_pic), linetype = factor(host_identity_verified))) +
  geom_line() +
  labs(x = "Country", y = "Mean Review Score", color = "Profile Picture", linetype = "Identity Verified") +
  scale_color_manual(values = c("FALSE" = "blue", "TRUE" = "red"), labels = c("No Profile Pic", "Profile Pic")) +
  scale_linetype_manual(values = c("FALSE" = "dashed", "TRUE" = "solid"), labels = c("Not Verified", "Verified")) +
  theme_minimal()



######################### FUNCTION 1##################################

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

# EXAMPLE for Greece datasets...
athens_data <- download_and_process_airbnb_data(url_Athens, "Athens", "Greece")
crete_data <- download_and_process_airbnb_data(url_crete, "Crete", "Greece")

# ... and than combine the datasets for Greece
partial_greece_data <- bind_rows(athens_data, crete_data)
write.csv(greece_host_reviews, "Greece_Host_reviews.csv", row.names = TRUE)
View(partial_greece_data)



######################### FUNCTION 2##################################
##########(only take necessary variables into account)################

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

# ... and than combine the datasets for Greece
greece_necessary_data <- bind_rows(athens_necesarry_data, crete_necesarry_data)
write.csv(greece_necessary_data, "Greece_necesarry_data.csv", row.names = TRUE)
View(greece_necessary_data)



