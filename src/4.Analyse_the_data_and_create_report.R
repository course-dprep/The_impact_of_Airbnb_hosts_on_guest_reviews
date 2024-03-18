# Step 11: the regression
# Opening the dataset; is this name right?
Data_Greece_France <- read.csv("France_Greece_selected_data.csv")

# Encoding the variables profile picture, identity verified and country as dummy variables
Data_Greece_France <- within(Data_Greece_France, {
  host_has_profile_pic <- as.numeric(host_has_profile_pic == "t") #true=1
  host_identity_verified <- as.numeric(host_identity_verified == "t") #true=1
  Country_Dataset <- as.numeric(Country_Dataset == "Greece") #Greece=1
})

# Encoding the dummy variables
Data_Greece_France$Country_Dataset <- ifelse(Data_Greece_France$Country_Dataset == 1, "Greece", "France")
Data_Greece_France$host_has_profile_pic <- ifelse(Data_Greece_France$host_has_profile_pic == 1, "Profile_picture", "NO_profile picture")
Data_Greece_France$host_identity_verified <- ifelse(Data_Greece_France$host_identity_verified == 1, "ID_verified", "ID_NOT verified")

# Check whether the variables are the way they should
View(Data_Greece_France)

# Regression on the review scores rating
Host_Review_lm <- lm(review_scores_rating ~ host_has_profile_pic + host_identity_verified + Country_Dataset, Data_Greece_France)
summary(Host_Review_lm)

# Step 12: Calculate mean review scores rating by host profile picture and country
library(dplyr)
average_ratings_profilepic <- tapply(Data_Greece_France$review_scores_rating, list(Data_Greece_France$Country_Dataset, Data_Greece_France$host_has_profile_pic), mean, na.rm = TRUE)
average_ratings_identity <- tapply(Data_Greece_France$review_scores_rating, list(Data_Greece_France$Country_Dataset, Data_Greece_France$host_identity_verified), mean, na.rm = TRUE)

# Table with average ratings on the variables
print(average_ratings_profilepic)
print(average_ratings_identity)

# Step 13: Visualization 
# Visualization of the average review score rating
# Opening needed packages
library(ggplot2)
library(knitr)
library(kableExtra)

# Barplot for the effect of the presence of a profile picture of the host and the country on review score ratings
pdf("barplot_profilepic.pdf")
barplot(
  height = average_ratings_profilepic,
  beside = TRUE,
  col = c("lightblue", "lightgreen"),
  ylim = c(0, 5),
  xlab = "Country - Profile Picture Available",
  ylab = "Average Review Score Rating",
)
legend("right", legend = rownames(average_ratings_profilepic), fill = c("lightblue", "lightgreen"))
dev.off()

# Barplot for the effect of the identity verification of the host and the country on the review score ratings
pdf("barplot_identity.pdf")
barplot(
  height = average_ratings_identity,
  beside = TRUE,
  col = c("lightblue", "lightgreen"),
  ylim = c(0, 5),  
  xlab = "Country - Identity Verified",
  ylab = "Average Review Score Rating",
)
legend("right", legend = rownames(average_ratings_identity), fill = c("lightblue", "lightgreen"))
dev.off()

# Step 14: Data table showcasing all the effects
# Including the coefficients, standard errors, p-values, and significance
datatable <- data.table(
  Coefficients = c(4.62790, -0.03170, -0.06148, -0.11275, 0.07257, 0.12356, 0.28815, -0.17887),
  Standard_Error = c(0.02636, 0.02680, 0.02856, 0.05877, 0.02901, 0.05971, 0.06081, 0.06177),
  P_Value = c(2e-16, 0.23680, 0.03138, 0.05506, 0.01236, 0.03852, 2.16e-06, 0.00378),
  Significance = c("significant", "not significant", "significant", "not significant", "significant", "significant", "significant", "significant")
)

# Assign row names
row_names <- c("Intercept", "Profile picture", "Identity verification", "Country",
               "Profile picture x Identity verification", "Profile picture x Country",
               "Identity verification x Country", "Profile picture x Identity verification x Country")
datatable <- cbind(Effect = row_names, datatable)

# Creating the datatable
datatable %>%
  knitr::kable(format = "markdown", align = "c", caption = "Linear Regression Coefficients") %>%
  kable_styling(full_width = FALSE) %>%
  column_spec(1:5, border_left = TRUE, border_right = TRUE) %>%
  row_spec(1, bold = FALSE)


# Step 15: Visualization of the linear regression
# Interaction Plot for all pairs of independent variables
ggplot(data, aes(x = host_has_profile_pic, y = review_scores_rating, color = host_identity_verified)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Host Has Profile Pic", y = "Review Scores Rating", color = "Host Identity Verified") +
  facet_wrap(~ "Country_Dataset")

# Coefficients Plot (not done yet)
coef_data <- data.frame(coef = coef(Host_Review_lm), variable = names(coef(Host_Review_lm)))
ggplot(coef_data, aes(x = variable, y = coef)) +
  geom_bar(stat = "identity") +
  labs(x = "Variable", y = "Coefficient")

# Any other visualization?
