# Next-Generation Sequencing RNA-seq

Pipeline for analyzing RNA-seq data.

## Table of Contents

* [Introduction](#Introduction)
* [Technologies](#Technologies)
* [Setup](#Setup)
* [Status](#Status)
* [Sources](#Sources)

## Introduction

In this project I have used RNA-seq data from this GEO code: [GSE104704](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE104704).
However, since I don't have a lot of memory, I have used 5 control \(RNA from old brain cells\) and 5 Alzheimer samples, which SRA accession numbers can be found in SraAccList.txt. If you are planning to use this Jupyter notebook for your research, you should change the SRA accession numbers to the ones you would like to use.

The whole pipeline is accesible via [the Jupyter Notebook](https://github.com/Mees-Molenaar/NGS_Alzheimer_Project/blob/master/NGS_pipeline.ipynb).

Additionally, for the alignment and feature count two reference genome files were needed. 

For the alignment, I have used the latest human reference genome [GRCh38.p13](https://www.ncbi.nlm.nih.gov/assembly/GCF_000001405.39).
For the feature count, I used the latest human gene transfer file [GRCH38.100](ftp://ftp.ensembl.org/pub/release-100/gtf/homo_sapiens/Homo_sapiens.GRCh38.100.gtf.gz)

In the pipeline, several tools were used, which I will describe in the technologies section.

## Technologies

* [SRA Tools](https://ncbi.github.io/sra-tools/), which is used for downloading data and converting the .sra files to .fastqc files. (version 2.10.7)
* [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/), which is used to perform a quality control on the downloaded RNA-seq data. (version 0.11.9)
* [Hisat2](http://daehwankimlab.github.io/hisat2/), which is used to align the RNA-seq data to the reference genome. (version 2.2.0)
* [Samtools](http://www.htslib.org/doc/samtools.html), which is used to convert .sam files to .bam files and then sort and index the alignment. (version 1.10)
* [HTSeq](https://htseq.readthedocs.io/en/master/), which is used to count the features (in this case the genes) of the alignments. (version 0.12.4)
* [DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html), which is a R package and is used to analyze the differential expression of the samples. (version 1.28.1)

## Setup

*In progress.*

## Status

*In progress.*

## Sources

 [Wang Z and Ma'ayan A. An open RNA-Seq data analysis pipeline tutorial with an example of reprocessing data from a recent Zika virus study [version 1; peer review: 3 approved]. F1000Research 2016, 5:1574](https://doi.org/10.12688/f1000research.9110.1) 