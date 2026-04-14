# Yeast-Synthetic-Genomes Workshop

## Overview

This mini-workshop intents to show the participants common steps in the analysis of yeast chromosomes
Specifically focusing in SCRaMblEd genomes to identify and characterize Structural Variants (SV's)

Additionally this workshop shows common usage of tools that can be easily transferable to related projects and other genomes

## What you will need:

1\. Setup the environment using a docker image and the install the following programs-

* Installation of conda or miniconda

## 🐳 Run with Docker

Build the image:

```bash

docker build -t yeast-genomics:latest .

docker run -it --rm -v $(pwd):/data yeast-genomics:latest

conda activate yeast\_env

```
The rest of the programs have to be installed independently

**Fasterq-dump**
[Install-fasterq-dump](https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit)

**Dorado**
[Install-dorado](https://github.com/nanoporetech/dorado)

Then you are ready to Process your data and start working!


3\. Process data



4\. Run analysis



\## Quick Start



```bash

git clone https://github.com/yourname/project.git

cd project

bash scripts/download.sh

