#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=3G
#$ -pe def_slot 8
#$ -j y
#$ -N GO_overlap
#$ -o log/BulkRNAseq/

echo start
date

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGSR

mkdir -p ../output/GOenrich
R --slave --vanilla --args \
../output/DESeq2/res.txt \
../input/c5.go.bp.v7.3.rds \
../output/GOenrich/GO_overlap_res.txt \
< BulkRNAseq/GO_overlap.R

echo finish
date
