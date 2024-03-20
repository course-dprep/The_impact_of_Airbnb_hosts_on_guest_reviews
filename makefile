#This file will be used to run every item in the sub src files
#To follow the my_project example of Hannes in week 5 I use the subfiles analysis, data preparation and paper.
#Notice that we need to shovel the files around to fit the needs of the subfiles, I made a setup. But we need to discuss it.

all: data-preparation analysis Paper

data-preparation:
	make -C src/data-preparation

analysis:
	make -C src/analysis

paper: analysis
	make -C src/paper

clean:
	-rm -r data
	-rm -r gen