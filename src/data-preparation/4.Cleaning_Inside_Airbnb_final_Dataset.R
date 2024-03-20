# Loading the needed packages
library('dplyr')
library('tidyverse')

# Creating a data frame from the csv file
df <- read.csv("Gen/data-preparation/output/Inside_Airbnb_Final_Dataset.csv")

# Check unique values in the columns
unique(df$host_has_profile_pic)
unique(df$host_identity_verified)

# Recode the variables to a dummy variable
df$host_has_profile_pic_dummy <- ifelse(df$host_has_profile_pic == "t", 1, 0)
df$host_identity_verified_dummy <- ifelse(df$host_identity_verified == "t", 1, 0)

# Create dummy variable for Country_Dataset where Greece is 1 and France is 0
df$Country_Dataset <- as.numeric(df$Country_Dataset == "Greece")

# Reversing the dummy variable to make France 1 and Greece 0
df$Country_Dataset <- 1 - df$Country_Dataset

# Save the modified DataFrame to a new CSV file
write.csv(df, "Gen/data-preparation/output/Inside_Airbnb_Final_selected_Dataset.csv", row.names = FALSE)
