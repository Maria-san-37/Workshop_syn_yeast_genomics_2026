import glob
import os
REFERENCE ="S288C_R64.fasta"

# Automatically discover all barcode folders in current directory
import os

BARCODES = sorted([d for d in os.listdir('.') if os.path.isdir(d) and d.startswith("barcode")])
print(BARCODES)

rule all:
    input:
        expand("results_mapping/{barcode}/results/depth.txt", barcode=BARCODES)

rule mapping:
    input:
        # all .fastq and .fastq.gz files in the barcode folder + reference genome
        lambda wc: glob.glob(f"{wc.barcode}/*.fastq") + \
                   glob.glob(f"{wc.barcode}/*.fastq.gz") 
    output:
        "results_mapping/{barcode}/results/depth.txt"
    container:
        "yourdockerhub/yeast-genomics:latest"
    shell:
        """
        mkdir -p results_mapping/{wildcards.barcode}/results
        minimap2 -ax map-ont {REFERENCE} {input} -o results_mapping/{wildcards.barcode}/results/minimap.sam
        samtools view -S -b results_mapping/{wildcards.barcode}/results/minimap.sam > results_mapping/{wildcards.barcode}/results/minimap.bam
        samtools sort results_mapping/{wildcards.barcode}/results/minimap.bam -o results_mapping/{wildcards.barcode}/results/minimap_sorted.bam
        samtools index results_mapping/{wildcards.barcode}/results/minimap_sorted.bam
        samtools depth results_mapping/{wildcards.barcode}/results/minimap_sorted.bam > {output}
        """
