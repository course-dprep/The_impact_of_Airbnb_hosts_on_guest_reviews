Data = Data
DAInput = Gen\1.Data-preparation\input
DAOutput = Gen\1.Data-preparation\output

all: $(DAOutput)/Inside_Airbnb_Final_Dataset.csv $(DAOutput)/Inside_Airbnb_Final_selected_Dataset.csv $(DAOutput)/3.Data_explorating.pdf

## Scrape the URLs from inside airbnb
$(Data)/Inside_Airbnb_URL_Dataset.csv: 1.Webscrape_Inside_Airbnb_Download_URLs_And_Create_CSV.py
	py --vanilla < 1.Webscrape_Inside_Airbnb_Download_URLs_And_Create_CSV.py

## Download and create the France and Greece dataset
$(DAInput)/Inside_Airbnb_Final_Dataset.csv: 2.Download_Inside_Airbnb_Data_And_Create_France_Greece_Dataset.R 
	R --vanilla < 2.Download_Inside_Airbnb_Data_And_Create_France_Greece_Dataset.R

## Explore the data
$(DAOutput)/3.Data_explorating.pdf: 3.Data_explorating.Rmd
	Rscript -e 'rmarkdown::render("3.Data_explorating.RMD")'

## Clean the data and create the final dataset
$(DAOutput)/Inside_Airbnb_Final_selected_Dataset.csv: 4.Cleaning_Inside_Airbnb_final_Dataset.R
	R --vanilla < 4.Cleaning_Inside_Airbnb_final_Dataset.R