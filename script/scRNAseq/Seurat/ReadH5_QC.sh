#!/usr/bin/env bash
#$ -S /bin/bash
#$ -l s_vmem=20G
#$ -pe def_slot 2
#$ -cwd
#$ -j y
#$ -N ReadH5_QC
#$ -o log/scRNAseq/Seurat/

echo start
date

mkdir -p ../output/scRNAseq/Seurat

echo Hs_HSV1 Hs_Mock | xargs -n 1 -P 2 bash -c \
'
. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGSR

DataID=${0}

R --slave --vanilla --args \
../output/scRNAseq/CellRanger/${DataID}/${DataID}/outs/filtered_feature_bc_matrix.h5 \
${DataID} \
../output/scRNAseq/Seurat/${DataID}.rds \
< scRNAseq/Seurat/ReadH5_QC.R
'

echo finish
date
