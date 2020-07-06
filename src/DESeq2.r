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
res

resultsNames(dds)

# Shrinkage of effect size, since it is useful for visualization and ranking genes
resLFC <- lfcShrink(dds, coef="condition_Old_vs_Aged_diseased", type="apeglm")
resLFC

# Make MA plots
plotMA(res, ylim=c(-3,3) , main="Normal data")
plotMA(resLFC, ylim=c(-3,3), main="Shrunken log2 fold changes")

# Transform the data for clustering
vsd <- vst(dds, blind=FALSE)

# Heatmap of the count matrix
library("pheatmap")
select <- order(rowMeans(counts(dds, normalized=TRUE)), decreasing=TRUE)[1:20]
df <- as.data.frame(colData(dds)[c("condition")])
pheatmap(assay(vsd)[select,], annonation_col=df)

#Heatmap of the sample-to-sample distance
sampleDists <- dist(t(assay(vsd)))
library("RColorBrewer")
sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(vsd$condtion)
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette(rev(brewer.pal(9, "Blues")))(255)
pheatmap(sampleDistMatrix, clustering_distance_rows=sampleDists, clustering_distance_cols=sampleDists, col=colors)

# Principal Component plot of the samples
plotPCA(vsd, intgroup=c("condition"))

# Dispersion plot
plotDispEsts(dds)

write.csv(res, file = "/media/mees/Elements/ngs_data/DESeq/output.csv")
write.csv(resLFC, file = "/media/mees/Elements/ngs_data/DESeq/output_LFC.csv")