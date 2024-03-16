#This file could be uptimized still, we will talk about it on monday. 

# Step 11: the regression
Data_Greece_France <- read.csv("France_Greece_selected_data.csv")

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

# Step 12: Calculate mean review scores rating by host profile picture and country
library(dplyr)
mean_review_scores_profilepic <- Data_Greece_France %>%
  group_by(host_has_profile_pic, Country_Dataset) %>%
  summarise(mean_review_score = mean(review_scores_rating, na.rm = TRUE))
mean_review_scores_identity <- Data_Greece_France %>%
  group_by(host_identity_verified, Country_Dataset) %>%
  summarise(mean_review_score = mean(review_scores_rating, na.rm = TRUE))

# Grouping values table
print(mean_review_scores_profilepic)
print(mean_review_scores_identity)

###################################TRYING VISUALISATION####################################
# Step 13: visualisation, barplot
library(ggplot2)
ggplot(mean_review_scores, aes(x = host_has_profile_pic, y = mean_review_score, fill = Country_Dataset)) +
  geom_bar(stat = "identity", position = "dodge", color = "green") +
  labs(title = "Mean Review Scores Rating by Host Profile Picture and Country",
       x = "Host Has Profile Picture",
       y = "Mean Review Scores Rating",
       fill = "Country") + 
  scale_x_discrete(labels = c("False_Greece", "True_Greece", "False_France", "True_France"))