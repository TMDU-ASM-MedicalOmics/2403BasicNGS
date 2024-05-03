#!/usr/bin/env bash
#$ -S /bin/bash
#$ -l s_vmem=8G
#$ -pe def_slot 4
#$ -cwd
#$ -j y
#$ -N UMAP
#$ -o log/scRNAseq/Seurat/

echo start
date

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGSR

R --slave --vanilla --args \
../output/scRNAseq/Seurat/Hs.rds \
../output/scRNAseq/Seurat/UMAP.pdf \
< scRNAseq/Seurat/UMAP.R

echo finish
date
