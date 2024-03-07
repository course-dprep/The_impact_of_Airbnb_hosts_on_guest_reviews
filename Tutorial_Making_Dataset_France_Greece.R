#This dataset merges the datasets about Greece, it is created to examine the influence of the hosts on the review rating.

#Step 1 set the working directory. Change this to the location on your computer. We should automate this in the future.
setwd("C:\\Users\\JAMPe\\OneDrive\\Documenten\\HBO & Master\\Tilburg University\\2.Master Marketing Analytics\\DPREP\\Week 5\\Week 5 merged dataset of Greece")

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

#Step 3 Downloading the datapackage using the url variable and naming the dataset to our liking for further coding automation.Note that we first provide the url variable and second the name we want our csv.file to have. Don't forget to include '.csv' at the end of naming it. 
#Downloading the datapackages of the regions in Greece
download.file(url_Athens, "Athens_data.csv")
download.file(url_crete, "Crete_data.csv")
download.file(url_South_Aegean, "South_Aegean_data.csv")
download.file(url_thessaloniki, "Thessaloniki_data.csv")

#Downloading the datapackages of the regions in France
download.file(url_Bordeaux, "Bordeaux_data.csv")
download.file(url_Lyon, "Lyon_data.csv")
download.file(url_Paris, "Paris_data.csv")
download.file(url_Pays_Basque, "Pays_Basque_data.csv")

#Step 4 Data is possibly compressed in the datafile, hence we need to decompress the files to get the data. 
#Decompressing the datapackages of the regions in Greece
system(paste("gzip -d", "Athens_data.csv"))
system(paste("gzip -d", "Crete_data.csv"))
system(paste("gzip -d", "South_Aegean_data.csv"))
system(paste("gzip -d", "Thessaloniki_data.csv"))

#Decompressing the datapackages of the regions in France
system(paste("gzip -d", "Bordeaux_data.csv"))
system(paste("gzip -d", "Lyon_data.csv"))
system(paste("gzip -d", "Paris_data.csv"))
system(paste("gzip -d", "Pays_Basque_data.csv"))

#Step 5 Loading the data in the workspace to be able to wrangle the data
library(dplyr) #Write if sequence to install it if that is needed
library(tidyverse) #See comment above
library(data.table) #See comment above

#Loading the data of the regions in Greece
Athens_data <- read_csv("Athens_data.csv")
Crete_data <- read_csv("Crete_data.csv")
South_Aegean_data <- read_csv("South_Aegean_data.csv")
Thessaloniki_data <- read_csv("Thessaloniki_data.csv")

#Loading the data of the regions in France
Bordeaux_data <- read_csv("Bordeaux_data.csv")
Lyon_data <- read_csv("Lyon_data.csv")
Paris_data <- read_csv("Paris_data.csv")
Pays_Basque_data <- read_csv("Pays_Basque_data.csv")

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
Crete_Host_Review_data <- Crete_Host_Review_data %>% mutate(Region_Dataset="Athens", Country_Dataset='Greece')

#South_Aegean
South_Aegean_Host_Review_data <- South_Aegean_Host_Review_data %>% mutate(Region_Dataset="Athens", Country_Dataset='Greece')

#Thessaloniki
Thessaloniki_Host_Review_data <- Thessaloniki_Host_Review_data %>% mutate(Region_Dataset="Athens", Country_Dataset='Greece')

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
write.csv(France_Host_reviews, "Greece_Host_reviews.csv", row.names = TRUE)
View(France_Host_reviews)

#Well done you just created 2 datasets. One called Greece_Host_reviews and one called France_Host_reviews -> Checking origin variable errors!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#Step 10 Possible in the future to combine the Greece and France dataset. By using a simular principle of creating the country datasets

#Step 11 -> in the future make step 1 t/m 8 a function. Simular proces is done again.
