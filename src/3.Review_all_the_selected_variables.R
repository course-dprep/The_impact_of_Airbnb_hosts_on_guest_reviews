#Load the dataset in the workspace
library(readr)
Inside_Airbnb_Final_Dataset <- read_csv("France_Greece_selected_data.csv")
View(Inside_Airbnb_Final_Dataset)

#Create a function that summarizes all the variables in our dataset. 
summary_statistics <- function(dataset_path) {
  #Create a variable where the dataset is read
  data <- read.csv(dataset_path)
  
  #Request the summary statistics for every column
  summary_stats <- lapply(data, summary)
  
  #Return the summary statistics
  return(summary_stats)
}

#To retrieve the summary results use the function
summary_results <- summary_statistics("Inside_Airbnb_Final_Dataset.csv")

#To see the summary print the variable
print(summary_results)