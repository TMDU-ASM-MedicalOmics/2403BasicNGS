#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=10G
#$ -j y
#$ -N DESeq2_DEG
#$ -o log/BulkRNAseq/

echo start
date

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGSR

R --slave --vanilla --args \
../output/DESeq2/res.txt \
../output/DESeq2/res_DEG.txt \
< BulkRNAseq/DESeq2_DEG.R

echo finish
date
