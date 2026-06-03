FROM condaforge/miniforge3:latest

RUN apt-get update && apt-get install -y \
    wget git curl bzip2 unzip build-essential \
    python3 python3-dev python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN conda config --add channels conda-forge \
    && conda config --add channels bioconda \
    && conda config --set channel_priority strict

# python=3.10 satisfies sniffles>=3.10; svim and svim-asm have no strict version pins
RUN mamba create -y -n yeast_sv python=3.10 \
    snakemake flye minimap2 samtools pbsv sniffles=2.3.3 cutefc svim svim-asm chopper \
    canu racon ragtag bedtools mummer quast longshot samplot deeptools truvari bcftools \
    && mamba clean -a

SHELL ["conda", "run", "-n", "yeast_sv", "/bin/bash", "-c"]

WORKDIR /data
CMD ["bash"]
