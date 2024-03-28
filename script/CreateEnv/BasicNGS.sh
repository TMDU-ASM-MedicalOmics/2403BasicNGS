#! /usr/bin/env bash
#$ -S /bin/bash
#$ -l s_vmem=10G
#$ -cwd
#$ -q '!mjobs_rerun.q'
#$ -j y
#$ -N BasicNGS
#$ -o log/CreateEnv/

echo start
date

. ~/miniconda3/etc/profile.d/conda.sh
conda create -y -n BasicNGS
conda activate BasicNGS
conda install -y -c bioconda sra-tools

echo end
date
