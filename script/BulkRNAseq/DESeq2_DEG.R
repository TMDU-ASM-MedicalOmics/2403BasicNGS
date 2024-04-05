#!/usr/bin/env R

args <- commandArgs(T)
res <- read.table(args[1],sep="\t",header=T)
res <- na.omit(res)
res <- res[res$padj <= 0.001,]
res <- res[res$baseMean >= 1000,]
res <- res[res$log2FoldChange >= 6,]
res <- res[order(res$log2FoldChange,decreasing=T),]
write.table(res,args[2],quote=F,sep="\t")
