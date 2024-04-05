#!/usr/bin/env R

library(DESeq2)
library(apeglm)
library(BiocParallel)
register(MulticoreParam(8))
args <- commandArgs(T)

sample <- read.table(args[1],sep="\t",header=T)
exp <- read.table(args[2], sep = "\t", header = T, row.names = 1,check.names=F)

sample$treatment_type <- factor(sample$treatment_type,level=c("Mock","IFN"))
sample$cell_type <- factor(sample$cell_type,level=c("dermal_fibroblast","MDM"))
sample$data_info <- factor(sample$data_info,level = colnames(exp))
sample <- sample[order(sample$data_info),]
rownames(sample) <- sample$data_info

dds <- DESeqDataSetFromMatrix(countData = as.matrix(exp), colData = sample, design = ~ treatment_type + cell_type)
dds <- DESeq(dds,parallel=T)
resLFC <- lfcShrink(dds, coef=2, type="apeglm")
res <- results(dds,contrast = c("treatment_type", "IFN","Mock"))
write.table(res, file = args[3], row.names = T, col.names = T, sep = "\t", quote = F)
