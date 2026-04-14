# Yeast-Syn-Genomes Workshop

## Overview

This mini-workshop intents to show the participants common steps in the analysis of yeast chromosomes, with an specific focus in SCRaMblEd genomes to identify and characterize Structural Variants (SV's)

The intention of this workflow is showing tools that can be easily transferable to related projects and other genomes.

## Workflow

1\. Setup environment using docker images and the following programs have to be installed:

* Installation of conda or miniconda



* Download in your computer the Docker image (Dockerfile) with the neccesary programs, then run the following commands:



``` docker build -t yeast-genomics:latest .

docker run -it --rm -v $(pwd):/data yeast-genomics:latest

conda activate yeast\_env



Then you are ready to Process your data and start working!



The rest of the programs have to be installed independently



**Fasterq-dump**

( go to this link https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit) 



**Dorado** (go to this link https://github.com/nanoporetech/dorado) for basecalling data generated from Nanopore sequencing



3\. Process data



4\. Run analysis



\## Quick Start



```bash

git clone https://github.com/yourname/project.git

cd project

bash scripts/download.sh

