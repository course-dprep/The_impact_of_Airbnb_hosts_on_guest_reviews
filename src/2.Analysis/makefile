ANOutput = Gen\2.Analysis\output

all: $(ANOutput)/2.Visualization.pdf $(ANOutput)/barplot_identity.pdf $(ANOutput)/barplot_profilepic.pdf $(ANOutput)/coefficients_plot.pdf $(ANOutput)/interaction_plot.pdf

## Performing the analysis and creating visuals
$(ANOutput)/barplot_identity.pdf: 1.Regression_Analysis.R
	R --vanilla < 1.Regression_Analysis.R
$(ANOutput)/barplot_profilepic.pdf: 1.Regression_Analysis.R
	R --vanilla < 1.Regression_Analysis.R
$(ANOutput)/coefficients_plot.pdf: 1.Regression_Analysis.R
	R --vanilla < 1.Regression_Analysis.R
$(ANOutput)/interaction_plot.pdf: 1.Regression_Analysis.R
	R --vanilla < 1.Regression_Analysis.R

## Visualize the analysis
$(ANOutput)/2.Visualization.pdf: 2.Visualization.Rmd
	Rscript -e 'rmarkdown::render("2.Visualization.RMD")'