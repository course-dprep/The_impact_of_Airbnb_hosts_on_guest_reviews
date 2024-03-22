all: 1.Data-preparation 2.Analysis

1.Data-preparation:
	make -C src/1.Data-preparation

2.Analysis:
	make -C src/2.Analysis

clean:
	-rm -r data
	-rm -r gen