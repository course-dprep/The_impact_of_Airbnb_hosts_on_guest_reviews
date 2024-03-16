#Import the request datapackage, this allows web scraping
import requests

#Hardcode the url of the static website
url = "http://insideairbnb.com/get-the-data"

#Write a new variable that could request the website metadata
request_object = requests.get(url)

#Write a new variable that extracts the HTML source code
source_code = request_object.text

#Import the bs4 package to use the beautifulsoup function to turn our metadata to readable HTML code
from bs4 import BeautifulSoup

#Write a new variable storing the raw html code
soup = BeautifulSoup(source_code, "html.parser")

#We want to extract the country, region and URL hence we need to locate these in the HTML code.

#Write a new variable containing all the cities and URLs provided on the website
#In the html code this is stored under 'tbody'
regions_list = soup.find_all('tbody')

#Write a new variable containing all the regions and countries, to combine this to the URLs
#In the html code this is stored under 'h3'
identifier_list = soup.find_all('h3')

#For future research all the URLs linked to listings csv.gz files will be stored in a csv file. 
#To improve the automation the process of extracting each link is looped.

#Create a list to store in a csv file
region_data=[]

#Create a counter for a printer to see if the URL is added to the csv file
Region_counter = 0

#Create a loop to scrape the desired regions
for region in range(len(regions_list)):
    Region_counter += 1
    #Extracting the region name with "a" and the URL with "href"
    tmp_url = regions_list[region].find("a").get('href')
    #Adding the country and region to the region that was just scraped
    identifier = identifier_list[region].text
    country = identifier.split(",",3)[-1]
    region = identifier.split(",",3)[0]

    #Encode the URLs to handle non-ASCII characters (#Added fix url, testing)
    import urllib3
    import urllib.parse
    encoded_url = urllib.parse.quote(tmp_url, safe=':/')

    #Create a new variable that stores region, country and url in a temporaty dictionary
    region_info = {"Country": country, "Region": region, "Link": encoded_url}
    print(f"Saving download URL for {region}, {country} ({Region_counter}/{len(regions_list)})")

    #Add the temporary dictionary to the list created above
    region_data.append(region_info)

#Now we save this list to a csv file
#Import the pandas datapackage, this allows to create a csv file
import pandas as pd

# Create a dataframe with the variables country, regions and URLs
df = pd.DataFrame(region_data)

#Create a csv file of the final dataframe called "Inside_Airbnb_Final_Dataset.csv"
df.to_csv("Inside_Airbnb_URL_Dataset.csv", index=False)

# Create a text to show that the code was successful
print("Saved all download URLs to src/Inside_Airbnb_URL_Dataset.csv")


