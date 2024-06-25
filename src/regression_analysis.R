# Opening needed packages
# install.packages("kableExtra")
library(data.table)
library(ggplot2)
library(knitr)
library(kableExtra)

# Creating a place to save the files
dir.create('../gen/analysis')
dir.create('../gen/analysis/output')

# The regression
# Loading the dataset in the workspace
Inside_Airbnb_Final_Dataset <- read.csv("../gen/data_preparation/output/selected_dataset.csv")

# Opening the dataset
# View(Inside_Airbnb_Final_Dataset)

# Regression on the review scores rating
Host_Review_lm <- lm(review_scores_rating ~ host_has_profile_pic_dummy * host_identity_verified_dummy * Country_Dataset, Inside_Airbnb_Final_Dataset)
summary(Host_Review_lm)

# Extract coefficients, standard errors, p-values, and significance levels
coefficients <- coef(Host_Review_lm)
standard_errors <- summary(Host_Review_lm)$coefficients[, "Std. Error"]
p_values <- summary(Host_Review_lm)$coefficients[, "Pr(>|t|)"]
significance <- ifelse(p_values < 0.05, "significant", "not significant")

# Creating a data table
datatable <- data.table(
  Effect = c("Intercept", "Profile picture", "Identity verification", "Country",
             "Profile picture x Identity verification", "Profile picture x Country",
             "Identity verification x Country", "Profile picture x Identity verification x Country"),
  Coefficients = coefficients,
  Standard_Error = standard_errors,
  P_Value = p_values,
  Significance = significance
)

# Calculate the mean review scores rating
library(dplyr)
average_ratings_profilepic <- tapply(Inside_Airbnb_Final_Dataset$review_scores_rating, list(Inside_Airbnb_Final_Dataset$Country_Dataset, Inside_Airbnb_Final_Dataset$host_has_profile_pic_dummy), mean, na.rm = TRUE)
average_ratings_identity <- tapply(Inside_Airbnb_Final_Dataset$review_scores_rating, list(Inside_Airbnb_Final_Dataset$Country_Dataset, Inside_Airbnb_Final_Dataset$host_identity_verified_dummy), mean, na.rm = TRUE)

# Table with average ratings on the variables
print(average_ratings_profilepic)
print(average_ratings_identity)

# Visualization 
# Visualization of the average review score rating
# Barplot for the effect of the presence of a profile picture of the host and the country on review score ratings
pdf("../gen/analysis/output/barplot_profilepic.pdf")
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
pdf("../gen/analysis/output/barplot_identity.pdf")
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

# Plot Interaction Plot for all pairs of independent variables
interaction_plot <- ggplot(Inside_Airbnb_Final_Dataset, aes(x = host_has_profile_pic_dummy, y = review_scores_rating, color = host_identity_verified_dummy)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Host Has Profile Pic", y = "Review Scores Rating", color = "Host Identity Verified") +
  facet_wrap(~ Country_Dataset)

# Save Interaction Plot as PDF
interaction_plot_path <- "../gen/analysis/output/interaction_plot.pdf"
ggsave(interaction_plot_path, plot = interaction_plot, device = "pdf")

# Plot Coefficients Plot
# Excluding the intercept coefficient
coef_data <- data.frame(coef = coef(Host_Review_lm)[-1], variable = names(coef(Host_Review_lm))[-1])

# Print coef_data to check its structure and values
# print(coef_data)

coefficients_plot <- ggplot(coef_data, aes(x = variable, y = coef)) +
  geom_bar(stat = "identity") +
  labs(x = "Variable", y = "Coefficient")

# Print the plot to check its appearance
# print(coefficients_plot)

# Save Coefficients Plot as PDF
coefficients_plot_path <- "../gen/analysis/output/coefficients_plot.pdf"
ggsave(coefficients_plot_path, plot = coefficients_plot, device = "pdf")