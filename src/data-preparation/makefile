#The makefile for the data-preparation

#Note that this subfile will contain the sourcecode for downloading, merging, reviewing/summarizing and cleaning the data.

#Example code
DATA = ../../data #hardcoding the variables of the places where it will be saved
DPINPUT = ../../gen/data-preparation/input
DPOUTPUT = ../../gen/data-preparation/output

all: $(DPINPUT)/'1.write the csv here that will be used as input' $(DPOUTPUT)/'Write the csv here that will be generated as output'

#For the webscraper as example
$(DPINPUT)/'1. the csv that needs to be created as input': 'the code file that is used to webscrape'
	R --vanilla < 'the code file that is used to webscrape'

#Do we want to render a rmarkdown file for the summary statistics of the data review/summary?