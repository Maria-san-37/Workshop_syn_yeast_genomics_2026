# Yeast-Synthetic-Genomes Workshop

## Overview

This mini-workshop intents to show the participants common steps in the analysis of yeast chromosomes
Specifically focusing in SCRaMblEd genomes to identify and characterize Structural Variants (SV's)

Additionally this workshop shows common usage of tools that can be easily transferable to related projects and other genomes

## What you will need:

1\. Setup the environment using a docker image and the install the following programs-

* Installation of conda or miniconda in your local computer

## 🐳 Run with Docker

Build the image:

```bash

docker build -t yeast-genomics:latest .

docker run -it --rm -v $(pwd):/data yeast-genomics:latest

conda activate yeast_env

```
The rest of the programs have to be installed independently

**Fasterq-dump**
[Install-fasterq-dump](https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit)

**Dorado**
[Install-dorado](https://github.com/nanoporetech/dorado)





Then you are ready to start working!
[Assembly and quality check](#Assembly-and-quality-check)
[BASIC USAGE](#basic-usage)
[SNAKEMAKE tool](#SNAKEMAKE-tool)


## Assembly and quality check:

``` bash
flye --nano-raw barcode01.fastq --out-dir barcode01_flye

ragtag.py correct {Reference.fasta} barcode01_flye/assembly.fasta -o assembly_ragtag_correct.fasta
 
ragtag scaffold {Reference.fasta} assembly_ragtag_correct.fasta -o assembly_ragtag_scaffold.fasta

ragtag.py patch {Reference.fasta} assembly_ragtag_scaffold.fasta -o assembly_ragtag_patch.fasta

```
Quality assement of the assembly:

``` bash
quast.py -o quast_result_ID -r . {Reference.fasta} {genome.fasta}
```


## SNAKEMAKE tool:
Optional
3\. Run analysis with Snakemake which allow you to process multiple files at once!

## 🐍 Run Workflow

Install Snakemake:

```bash
snakemake --cores 4 --use-docker -p

```

```bash

git clone https://github.com/yourname/project.git

cd project

bash scripts/download.sh
```
Other useful bash scripts for processing data
[More_scripts] (https://github.com/Maria-san-37/Scripts_metagenomics/tree/main)
