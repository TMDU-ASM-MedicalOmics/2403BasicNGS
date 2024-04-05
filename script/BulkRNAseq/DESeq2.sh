#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=3G
#$ -pe def_slot 8
#$ -j y
#$ -N DESeq2
#$ -o log/BulkRNAseq/

echo start
date

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGSR

mkdir -p ../output/DESeq2
R --slave --vanilla --args \
../input/RNAseq_single.txt \
../output/featureCounts/rawCounts.txt \
../output/DESeq2/res.txt \
< BulkRNAseq/DESeq2.R

echo finish
date
