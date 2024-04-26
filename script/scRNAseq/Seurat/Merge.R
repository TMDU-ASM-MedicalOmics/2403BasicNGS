#!/usr/bin/env R

args <- commandArgs(T)
library(Seurat)
library(tidyverse)
library(future)
plan("multicore",workers=9)
options(future.globals.maxSize = 64000000000)
set.seed(1)

Infected <- readRDS(args[1])
Mock <- readRDS(args[2])
Seurat <- merge(Mock, y=Infected,
  add.cell.ids=c("Mock","Infected"), project="Merge")
Seurat.n <- NormalizeData(Seurat,verbose=F)
Seurat.s <- SplitObject(Seurat,split.by = "orig.ident")
for (i in 1:length(Seurat.s))  Seurat.s[[i]] <- SCTransform(Seurat.s[[i]],verbose=F)
Seurat.features <- SelectIntegrationFeatures(object.list = Seurat.s, nfeatures = 2000)
Seurat.s <- PrepSCTIntegration(object.list = Seurat.s, anchor.features = Seurat.features)
reference_dataset <- which(names(Seurat.s) == "HS_Mock")
combined <- FindIntegrationAnchors(Seurat.s, normalization.method = "SCT", 
    anchor.features = Seurat.features, reference = reference_dataset,verbose=F)
combined <- IntegrateData(combined, normalization.method = "SCT",verbose=F)
combined <- RunPCA(combined)
saveRDS(combined,args[3])
