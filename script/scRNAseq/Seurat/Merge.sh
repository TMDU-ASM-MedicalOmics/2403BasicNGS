#!/usr/bin/env bash
#$ -S /bin/bash
#$ -l s_vmem=4G
#$ -pe def_slot 10
#$ -cwd
#$ -j y
#$ -N Merge
#$ -o log/scRNAseq/Seurat/

echo start
date

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGSR

R --slave --vanilla --args \
../output/scRNAseq/Seurat/Hs_HSV1.rds \
../output/scRNAseq/Seurat/Hs_Mock.rds \
../output/scRNAseq/Seurat/Hs.rds \
< scRNAseq/Seurat/Merge.R

echo finish
date
