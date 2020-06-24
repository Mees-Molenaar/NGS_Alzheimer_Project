# Next-Generation Sequencing Alzheimer's Disease Project

In this project I have used RNA-seq data from this GEO code: [GSE104704](hhttps://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE104704).
However, since I don't have a lot of memory, I have used only one aged control sample \(SRR6145423\) and one AD sample \(SRR6145433\), which SRA accession numbers can be found in SraAccList.txt. If you are planning to use this Jupyter notebook for your research, you should change the SRA accession numbers to the ones you would like to use.

The plan is to make a RNA-seq pipeline in a Jupyter Notebook.

I have used the latest human assembly [GRCh38.p13](https://www.ncbi.nlm.nih.gov/assembly/GCF_000001405.39).

First we download the data using the [SRA-tools](https://www.github.com/ncbi/sra-tools).
Then, the we control the quality of the reads using FastQC.
