# Loading the needed packages
library(dplyr)
library(tidyverse)

# Creating a data frame from the csv file
df <- read.csv("Gen/data-preparation/output/Inside_Airbnb_Final_Dataset.csv")
View(df)

# Check unique values in the columns
unique(df$host_has_profile_pic)
unique(df$host_identity_verified)

# Copy values of original variable to the dummy variable
df$host_has_profile_pic_dummy <- df$host_has_profile_pic
df$host_identity_verified_dummy <- df$host_identity_verified

# Recode the dummy variables
df$host_has_profile_pic_dummy <- ifelse(df$host_has_profile_pic_dummy == "t", "Profile picture", "No profile picture")
df$host_identity_verified_dummy <- ifelse(df$host_identity_verified_dummy == "t", "Identity verified", "Identity NOT verified")

# Save the modified DataFrame to a new CSV file
write.csv(df, "Gen/data-preparation/output/Inside_Airbnb_Final_selected_Dataset.csv", row.names = FALSE)
