#!/usr/bin/env R

args <- commandArgs(trailingOnly=T)
library(Seurat)
library(cowplot)
library(tidyverse)
library(future)
plan("multicore",workers=4)
options(future.globals.maxSize = 64000000000)
set.seed(1)

Seurat <- readRDS(args[1])
Seurat@active.assay <- "integrated"
dims <- 1:50
Seurat <- RunUMAP(Seurat,dims =dims,n.neighbors = 30)
Seurat <- FindNeighbors(Seurat, dim =dims,k.param = 20)
Seurat <- FindClusters(Seurat, resolution = 0.8)

p1_1 <- DimPlot(Seurat,group.by="seurat_clusters",label=T)
p1_2 <- DimPlot(Seurat,split.by="orig.ident",label=T)
p1 <- plot_grid(p1_1,p1_2,ncol=2,rel_widths=c(1,2))

pdf(args[2],height=6,width=12)
print(p1)
dev.off()
