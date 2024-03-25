# How do Airbnb hosts influence the reviews of their listings? 
This project explores various factors influencing the ratings of Airbnb listings by analyzing host characteristics. It was completed as part of the "Data Preparation and Workflow Management" course in the Marketing Analytics Master's program at Tilburg University.

For more details about the course, refer to the [course contents](https://dprep.hannesdatta.com/docs/course/).  

To evaluate the results, navigate to the `src` folder and run the provided scripts. The full process has been automated by running the `makefile`.


## Academic goal 
The primary objective of this course is to equip students with the skills necessary to automate research projects, facilitating reproducibility of results and enabling easy adjustments to cater to different research interests. For instance, researchers can leverage the provided tools and methodologies to explore alternative effects within the same dataset to uncover new relationships between variables.

## Research motivation
Guest satisfaction during their stay is influenced by three crucial factors: amenities, location, and the behavior of hosts (Source: [Journal of Hospitality Management](https://www-sciencedirect-com.tilburguniversity.idm.oclc.org/science/article/pii/S0278431917307491?casa_token=LwHcyn2IMLcAAAAA:DMpHe_sUw9c2yhfjKSd2MRoi3LbViQ7Sx503VFq3E5DuASjRJe5S5srZQ97KLfzo4U3vGiIUMg)). This project aims to delve deeper into the ways hosts influence review scores, focusing specifically on their perceived trustworthiness online. Key variables associated with this analysis include the host's profile picture and identity verification.

Furthermore, the project seeks to explore potential differences across countries, with particular emphasis on France and Greece. While data for four cities within each country is available, this study concentrates on analyzing country-level trends. By incorporating this variable, insights into cross-cultural variations in customer judgments can be gained.

## Research question

_To what extent does (i) the presence of a profile picture and (ii) the identity verification of the host affect the review score (1-5) on Airbnb between France and Greece?_

## Research method

The repository serves as a comprehensive research workflow, which can be outlined as follows:
1. Data exploration 
2. Data preperation 
3. Analysis 
4. Evaluation and deployment 

Initially, these steps were conducted manually and later optimized and automated. The dataset used for analysis is publicly available and can be easily replicated with the necessary software installed
The primary data source of the project is the `listings.csv.gz` files on [Inside Airbnb](http://insideairbnb.com/get-the-data).   
The variables of interest to this project have been listed in the table below:

|Variable                        |Description                                                                                     |
|--------------------------------|------------------------------------------------------------------------------------------------|
|host_has_profile_pic                            |Whether the host has a profile picture (TRUE vs FALSE)                                                                         |
|host_identity_verified               |Whether the host has been verified (TRUE vs FALSE)                                                                       |
|host_location                   |The location of the listing, specified by city                                                       
|review_scores_rating            |The star rating left by customers on the listing                                                    |

As the unit of analysis in this project is focused on hosts and the country which the listing is situated in, the `host_location` variable has been operationalized to generalize to country level. Consequently, a new variable named `Country_Dataset` has been created, assigning each listing to its corresponding country. All variables will be accessible in RStudio after running the `france_greece_dataset.R` file, allowing for further exploration and potential research opportunities.

## Relevance
The insights generated from this project hold particular relevance for (potential) Airbnb hosts, emphasizing the importance of a profile picture and obtaining a verified account. By demonstrating the potential impact of these factors on their ratings, hosts may be motivated to prioritize these aspects to enhance their listing's performance.

Additionally, stakeholders such as Airbnb and similar hosting companies could gain advantages from the findings of this project. Insights from the analysis could inform platform enhancements or policy adjustments aimed at improving user experience and overall satisfaction.

## Repository overview
- src  
    - clean_dataset.R  
    - data_exploration.R
    - france_greece_dataset.R
    - regression_analysis.R
    - visualization.R
    - webscraper_urls.py
- .gitignore
- LICENSE
- makefile
- README.md

## Dependencies

Before executing the scripts, certain software programs and packages need to be installed. Instructions for downloading these are available on http://tilburgsciencehub.com/.   
The required programs are [Python](https://tilburgsciencehub.com/topics/computer-setup/software-installation/python/python/), [R & RStudio](https://tilburgsciencehub.com/topics/computer-setup/software-installation/rstudio/r/), [Git](https://tilburgsciencehub.com/topics/automation/version-control/start-git/git/) and [Make](https://tilburgsciencehub.com/topics/automation/automation-tools/makefiles/make/).   

The additonal required packages are:

**Python:** 
```
pip install requests 
pip install beautifulsoup 
pip install pandas 
pip install os
```

**R:**
```
install.packages("readr")
install.packages("dplyr")
install.packages("tidyverse")
install.packages("data.table")
install.packages("ggplot2")
install.packages("knitr")
install.packages("kableExtra")
install.packages("readr")
install.packages("tinytex")
install.packages("pandoc")
```

## Running the code
After cloning the repository, the scripts will generate multiple folders and files by making use of the `makefile`.  The output will generate in the new `data` and `gen` folders. The `data` folder is used as a starting point, which generates a list URLs after running `webscraper_urls.py`. `france_greece_dataset.R` will generate our selected datasets (France and Greece cities) into the `gen/data_preperation` folder. This is also where `project_dataset.csv` will generate, which combines all of these files. The (`data_exploration.Rmd`) explores this data, by making use of an `Rmarkdown` script. This generates a PDF with exploratory data analysis, into the `src` file, which will be moved to the `gen` folder later on with the `makefile`. `clean_dataset.R` will narrow down this file with only the selected variables of this project. Then, `regression_analysis.R` will analyse the relationship and `visualization.Rmd` will report the outcomes. The plots are generated into `gen/analysis/output`. As mentioned before, These steps have been automated with the `makefile`. Follow the tutorial below to automatically generate all the data/ 

### Tutorial 
1. Create a (local) repository where the cloned files will be stored
2. In your new folder, type CMD into the search bar. This will open the command line. 
3. Now you are ready to clone `The_impact_of_Airbnb_hosts_on_guest_reviews` from github. Type this into the command line:
```
git clone https://github.com/course-dprep/The_impact_of_Airbnb_hosts_on_guest_reviews
```
4. Now you have the repository downloaded locally and are ready to run the scripts. As this is all automated, all you have to do is go back to the command line and execute:
```
make
```
This will take a couple minutes to run, as the whole research pipeline is being run.   

5. Now you can look at the results in the newly created `gen` folder. 

### Other functions
To clean the output, type this into the command line:
```
make clean
```

To see the "to-be-executed" scripts, type:
```
make -n
```

## Authors
- [Julian Peters](https://github.com/JulianPetersIsCoding),     e-mail: j.a.m.peters@outlook.com
- [Rolf Jens](https://github.com/RolfJens),  e-mail: r.p.jens@tilburguniversity.edu
- [Marc van Tergouw](https://github.com/MSvanTerggouw),  e-mail: m.s.vantergouw@tilburguniversity.edu
- [Eline van Lopik](https://github.com/elinevanlopik), e-mail: e.vanlopik@tilburguniversity.edu

## Tutor
- [Hannes Datta](https://github.com/hannesdatta), email: h.datta@tilburguniversity.edu