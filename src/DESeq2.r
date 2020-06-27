# Script that analyzes the differential expression of the samples with DESeq2

# Import the library
library("DESeq2")

directory <- ""

# Prepare data to use for DESeq2
deseq_input <- read.csv("/home/mees/NGS_Alzheimer/DESeq2_data_table.csv")
sampleFiles <- deseq_input$HTSeq
sampleCondition <- deseq_input$condition
sampleNames <- deseq_input$SRR

sampleTable <- data.frame(sampleName = sampleNames, fileName = sampleFiles, condition = sampleCondition)
sampleTable$condition <- factor(sampleTable$condition)

# Build the DESeqDataSet
ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable, directory = directory, design= ~ condition)

# Pre-filtering
keep <- rowSums(counts(ddsHTSeq)) >= 10
dds <- ddsHTSeq[keep,]

dds <- DESeq(dds)
res <- results(dds)

write.csv(res, file = "/media/mees/Elements/ngs_data/DESeq/output.csv")