# Loading the needed packages
library(dplyr)
library(tidyverse)

# Creating a data frame from the csv file
df <- read.csv("../gen/data_preparation/output/project_dataset.csv")

# Check unique values in the columns
unique(df$host_has_profile_pic)
unique(df$host_identity_verified)

# Recode the dummy variables
df <- df %>%
  mutate(host_has_profile_pic_dummy = case_when(
    host_has_profile_pic == "t" ~ "Profile picture",
    host_has_profile_pic == "f" ~ "No profile picture",
    TRUE ~ NA_character_
  ),
  host_identity_verified_dummy = case_when(
    host_identity_verified == "t" ~ "Identity verified",
    host_identity_verified == "f" ~ "Identity NOT verified",
    TRUE ~ NA_character_
  ))

# Save the modified DataFrame to a new CSV file
write.csv(df, "../gen/data_preparation/output/selected_dataset.csv", row.names = FALSE)