# Directory
SRC_DIR = src
DATA_DIR = data
GEN_DIR = gen

# Files
PY_SCRIPTS = $(wildcard $(SRC_DIR)/*.py)
R_SCRIPTS = $(wildcard $(SRC_DIR)/*.R)
RMD_FILES = $(wildcard $(SRC_DIR)/*.Rmd)

# Targets
.PHONY: all run knit

all: run knit

run:
	python $(SRC_DIR)/webscraper_urls.py	
	Rscript $(SRC_DIR)/france_greece_dataset.R
	Rscript $(SRC_DIR)/clean_dataset.R
	Rscript $(SRC_DIR)/regression_analysis.R

knit: $(SRC_DIR)/data_exploration.Rmd $(SRC_DIR)/visualization.Rmd
	Rscript -e "rmarkdown::render('$(SRC_DIR)/data_exploration.Rmd', output_file = '../data_exploration.html')"
	Rscript -e "rmarkdown::render('$(SRC_DIR)/visualization.Rmd', output_file = '../visualization.html')"

clean:
	del /q $(DATA_DIR)\*.* $(GEN_DIR)\*.*
	rmdir /s /q $(DATA_DIR)
	rmdir /s /q $(GEN_DIR)