# The regression
# Loading the dataset in the workspace
#Eline om in de toekomst verwarring te voorkomen noem de variabele naar het bestand en pas je code hierop aan.
Inside_Airbnb_Final_Dataset <- read.csv("Gen/data-preparation/output/Inside_Airbnb_Final_selected_Dataset.csv")

# Opening the dataset
View(Inside_Airbnb_Final_Dataset)

# Regression on the review scores rating
# Regression of each variable on the review score rating
Host_Review_lm <- lm(review_scores_rating ~ host_has_profile_pic * host_identity_verified * Country_Dataset, Inside_Airbnb_Final_Dataset)
summary(Host_Review_lm)

# Calculate the mean review scores rating by host profile picture and country
library(dplyr)
average_ratings_profilepic <- tapply(Inside_Airbnb_Final_Dataset$review_scores_rating, list(Inside_Airbnb_Final_Dataset$Country_Dataset, Inside_Airbnb_Final_Dataset$host_has_profile_pic), mean, na.rm = TRUE)
average_ratings_identity <- tapply(Inside_Airbnb_Final_Dataset$review_scores_rating, list(Inside_Airbnb_Final_Dataset$Country_Dataset, Inside_Airbnb_Final_Dataset$host_identity_verified), mean, na.rm = TRUE)

# Table with average ratings on the variables
print(average_ratings_profilepic)
print(average_ratings_identity)

# Visualization 

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
  Coefficients = c(4.74031, -0.07679, -0.03875, -0.27412, 0.08669, 0.27739, 0.38644, -0.30163),
  Standard_Error = c(0.02441, 0.02481, 0.02644, 0.05528, 0.02684, 0.05613, 0.05713, 0.05799),
  P_Value = c(2e-16, 0.00197, 0.14269, 7.11e-07, 0.00124, 7.75e-07, 1.34e-11, 1.98e-07),
  Significance = c("significant", "significant", "not significant", "significant", "significant", "significant", "significant", "significant")
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
ggplot(Inside_Airbnb_Final_Dataset, aes(x = host_has_profile_pic, y = review_scores_rating, color = host_identity_verified)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Host Has Profile Pic", y = "Review Scores Rating", color = "Host Identity Verified") +
  facet_wrap(~ Country_Dataset)

# NA's eruit, klopt deze zo?
ggplot(na.omit(Inside_Airbnb_Final_Dataset), 
       aes(x = host_has_profile_pic, y = review_scores_rating, color = host_identity_verified)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Host Has Profile Pic", y = "Review Scores Rating", color = "Host Identity Verified") +
  facet_wrap(~ Country_Dataset)

#klopt nog niet!
# Coefficients Plot (not done yet)
coef_data <- data.frame(coef = coef(Host_Review_lm), variable = names(coef(Host_Review_lm)))
ggplot(coef_data, aes(x = variable, y = coef)[-1]) +
  geom_bar(stat = "identity") +
  labs(x = "Variable", y = "Coefficient")


