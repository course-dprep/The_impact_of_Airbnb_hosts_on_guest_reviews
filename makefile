# Define variables
SRC_DIR := src
GEN_DIR := gen
R_SCRIPTS := france_greece_dataset.R clean_dataset.R regression_analysis.R
RMD_SCRIPTS := data_exploration.Rmd visualization.Rmd

# Define targets
all: $(R_SCRIPTS) $(RMD_SCRIPTS)

# Rule to run R scripts
%.R:
	@echo "Running $@"
	@R --vanilla < $(SRC_DIR)/$@

# Rule to run R markdown files
%.Rmd:
	@echo "Running $@"
	@R -e "rmarkdown::render('$(SRC_DIR)/$@')"

# Rule to clean generated files
clean:
	@echo "Cleaning generated files"
	@if exist $(GEN_DIR) rmdir /s /q $(GEN_DIR)

# Phony targets
.PHONY: all clean

# Hide commands during make -n
.SILENT: all clean




# Marc poging
# all: src/france_greece_dataset.R 
# 	R --vanilla < src/france_greece_dataset.R

# gen_france_greece_dataset: src/france_greece_dataset.R 
# 	R --vanilla < src/france_greece_dataset.R







# old: 
# 1.Data-preparation:
# 	make -C src/1.Data-preparation

# 2.Analysis:
# 	make -C src/2.Analysis

# clean:
# 	-rm -r data
# 	-rm -r gen