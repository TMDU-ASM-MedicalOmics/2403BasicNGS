#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=10G
#$ -j y
#$ -o log/DataCollection/GetSra/
#$ -N GetSra

echo start
date

mkdir -p ../output/sra
sample_ID=`tail -n +2 ../input/RNAseq_single.txt | cut -f 6 | head -n ${SGE_TASK_ID} | tail -n 1`

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGS
prefetch --output-directory ../output/sra/ ${sample_ID}

echo finish
date
