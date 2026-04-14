FROM condaforge/miniforge3:latest

# Install basic packages
RUN apt-get update && apt-get install -y \
    wget git curl bzip2 unzip build-essential \
    python3 python3-dev python3-pip \
    && rm -rf /var/lib/apt/lists/*



# Add channels in the proper order
RUN conda config --add channels conda-forge \
    && conda config --add channels bioconda \
    && conda config --set channel_priority strict


# Create environment with mamba
RUN mamba create -y -n yeast_env python=3.9 \
    snakemake flye nanoplot medaka minimap2 samtools \
    canu racon ragtag bedtools mummer quast longshot samplot deeptools\
    && mamba clean -a

# Set environment as default shell
SHELL ["conda", "run", "-n", "yeast_env", "/bin/bash", "-c"]

WORKDIR /data
CMD ["bash"]
