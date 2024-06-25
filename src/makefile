.PHONY: all coefficients_plot.pdf interaction_plot.pdf barplot_identity.pdf barplot_profilepic.pdf data_exploration.html visualization.html selected_dataset.csv project_dataset.csv

all: ../gen/analysis/output/coefficients_plot.pdf ../gen/analysis/output/interaction_plot.pdf ../gen/analysis/output/barplot_identity.pdf ../gen/analysis/output/barplot_profilepic.pdf ../gen/analysis/output/data_exploration.html ../gen/analysis/output/visualization.html

../gen/analysis/output/coefficients_plot.pdf: regression_analysis.R ../gen/data_preparation/output/selected_dataset.csv
	R --vanilla < regression_analysis.R

../gen/analysis/output/interaction_plot.pdf: regression_analysis.R ../gen/data_preparation/output/selected_dataset.csv
	R --vanilla < regression_analysis.R

../gen/analysis/output/barplot_identity.pdf: regression_analysis.R ../gen/data_preparation/output/selected_dataset.csv
	R --vanilla < regression_analysis.R

../gen/analysis/output/barplot_profilepic.pdf: regression_analysis.R ../gen/data_preparation/output/selected_dataset.csv
	R --vanilla < regression_analysis.R
	
../gen/analysis/output/visualization.html: visualization.Rmd ../gen/data_preparation/output/selected_dataset.csv
	Rscript -e 'rmarkdown::render(input = "$<", output_file = "$@", output_format = "html_document")'

../gen/analysis/output/data_exploration.html: data_exploration.Rmd ../gen/data_preperation/output/project_dataset.csv
	Rscript -e 'rmarkdown::render(input = "$<", output_file = "$@", output_format = "html_document")'
	
../gen/data_preparation/output/selected_dataset.csv: clean_dataset.R ../gen/data_preperation/output/project_dataset.csv
	R --vanilla < clean_dataset.R

../gen/data_preperation/output/project_dataset.csv: france_greece_dataset.R
	R --vanilla < france_greece_dataset.R

