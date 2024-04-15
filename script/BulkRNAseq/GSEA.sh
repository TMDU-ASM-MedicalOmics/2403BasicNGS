#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=3G
#$ -pe def_slot 8
#$ -j y
#$ -N GSEA
#$ -o log/BulkRNAseq/

echo start
date

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGSR

mkdir -p ../output/GSEA
R --slave --vanilla --args \
../output/DESeq2/res.txt \
../input/c5.go.bp.v7.3.rds \
../output/GSEA/GSEA_res.txt \
< BulkRNAseq/GSEA.R

echo finish
date
