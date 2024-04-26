#!/usr/bin/env R

args <- commandArgs(T)
library(Seurat)

counts <- Read10X_h5(args[1])
Seurat <- CreateSeuratObject(counts = counts,project = args[2],
                                min.cells = 3, min.features = 200)
saveRDS(Seurat,args[3])
