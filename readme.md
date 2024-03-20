# How do Airbnb hosts influence the reviews of their listings? 
This project dives into some of the different characteristics of an Airbnb host, which can influence the ratings of their listings. The goal was to find some statistical connections between specific variables and see how they impact the ratings. The project is done for the course "Data Preperation and Workflow Management" as part of the Masters degree Marketing Analytics on Tilburg University ([Course contents](https://dprep.hannesdatta.com/docs/course/)). 

## Academic goal 
The goal of this course is to automate research projects and make it easy to reproduce results or make adjustments for other interests. For example, other researchers can look at different effects in the same environment, to look for other correlations between variables. 

## Research motivation
There are three important aspects which influence a guest's stay: (i) amenities, (ii) location and (iii) the hosts ([source](https://www-sciencedirect-com.tilburguniversity.idm.oclc.org/science/article/pii/S0278431917307491?casa_token=LwHcyn2IMLcAAAAA:DMpHe_sUw9c2yhfjKSd2MRoi3LbViQ7Sx503VFq3E5DuASjRJe5S5srZQ97KLfzo4U3vGiIUMg)). This project will further look into which ways the hosts themselves influence the review scores, specifically their seemed (online) trustworthiness. The variables which are linked to this are (i) profile picture and (ii) identity verification. Additionaly, there could be differences in specific countries or even cities.This project zooms in on just two countries, which are Greece and France (both with 4 cities). Including this variable should give some insights in how the customers differ their judgement in other countries. 

## Research question

_To what extent does (i) the presence of a profile picture and (ii) the identity verification of the host affect the review score (1-5) on Airbnb between France and Greece?_

## Research method

The repository serves as a full research workflow, which can be described as:
1. Data exploration 
2. Data preperation 
3. Analysis 
4. Evaluation and deployment 

All of these steps have first been taken manually and then optimized and automated. The data which is used for the analysis is pubicly avalaible and anyone can easily redo the full analysis with the required software installed. The data which is being used is in the `listings.csv.gz` files on [Inside Airbnb](http://insideairbnb.com/get-the-data). The variables of interest to this project have been listed in the table below:

|Variable                        |Description                                                                                     |
|--------------------------------|------------------------------------------------------------------------------------------------|
|host_has_profile_pic                            |Whether the host has a profile picture (TRUE vs FALSE)                                                                         |
|host_identity_verified               |Whether the host has been verified (TRUE vs FALSE)                                                                       |
|host_location                   |The location of the listing, specified by city                                                       
|review_scores_rating            |The star rating left by customers on the listing                                                    |

As the unit of analysis in this project is focused on hosts and the country which the listing is situated in, the `host_location` variable has been operationalized to generalize to country level, instead of city level. For this there has been created a new variable called `Country_Dataset`, with the corresponding country in each row. All of these variables will show up (in Rstudio) after running the second script in the `src` folder, in case the other variables are to be inspected for other research opportunities.


## Relevance
The insights of this project are mostly useful for (potential) Airbnb hosts, which show the importance of having a profile picure and a verified account. It could convince them to apply these aspects, if their ratings will increase from this. Other stakeholders are Airbnb and similar hosting companies. 

## Repository overview
The scripts which need to be executed have been numbered, to show in which order they should be executed.

- src
    1. Webscraper_to_extract_Inside_Airbnb_dataset_download_URLs_and_create_csv.py
    2. Downloading_Inside_Airbnb_dataset_and_creating_France_Greece_dataset.R
    3. Review_all_the_selected_variables.R
    4. Analyse_the_data_and_create_report.R
- .gitignore
- LICENSE
- makefile
- README.md

## Dependencies

Before executing the scripts, the software programs and packages need to be installed. Instructions for downloading these are available on http://tilburgsciencehub.com/. 
The required programs are [Python](https://tilburgsciencehub.com/topics/computer-setup/software-installation/python/python/), [R & RStudio](https://tilburgsciencehub.com/topics/computer-setup/software-installation/rstudio/r/), [Git](https://tilburgsciencehub.com/topics/automation/version-control/start-git/git/) and [Make](https://tilburgsciencehub.com/topics/automation/automation-tools/makefiles/make/). The additonal required packages are:

**Python:** 
```
pip install requests 
pip install beautifulsoup 
pip install pandas 
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
tinytex::install_tinytex()
```

## Running the code
After cloning the repository, the scripts will generate multiple files of output by making use of _make_. The output will generate in the new `output` folder. This is where a copy of the raw data will be stored as well as the datasets with our selected variables. Moreover, the evaluations will generate automatically by knitting the Rmarkdown file into PDFs. All of the specific code functionality is explained in the code files. 

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
This will take a couple minutes to run, as the whole pipeline is being run. 
5. Now you can look at the results in the newly created `...` folder 

### Other functions
The makefile has been structured to also execute the scripts seperately. To run only script 1 for example, just type: 
```
make 1.webscraper_to_extract_Inside_Airbnb_dataset_download_URLs_and_create_csv.py
```
To clean the output, type:
```
make clean
```

## Authors
- [Julian Peters](https://github.com/JulianPetersIsCoding),     e-mail: j.a.m.peters@outlook.com
- [Rolf Jens](https://github.com/RolfJens),  e-mail: r.p.jens@tilburguniversity.edu
- [Marc van Tergouw](https://github.com/MSvanTerggouw),  e-mail: m.s.vantergouw@tilburguniversity.edu
- [Eline van Lopik](https://github.com/elinevanlopik), e-mail: e.vanlopik@tilburguniversity.edu

## Tutor
- [Hannes Datta](https://github.com/hannesdatta), email: h.datta@tilburguniversity.edu