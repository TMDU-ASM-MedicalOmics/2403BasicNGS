#! /usr/bin/env bash
#$ -S /bin/bash
#$ -l s_vmem=10G
#$ -cwd
#$ -q '!mjobs_rerun.q'
#$ -j y
#$ -N BasicNGSR
#$ -o log/CreateEnv/

echo start
date

. ~/miniconda3/etc/profile.d/conda.sh
conda create -y -n BasicNGSR
conda activate BasicNGSR
conda install -y -c conda-forge r-tidyverse
conda install -y -c conda-forge r-seurat r-hdf5r
#conda install -y -c bioconda bioconductor-deseq2 bioconductor-apeglm

echo end
date
