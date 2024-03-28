#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=10G
#$ -j y
#$ -o log/DataCollection/
#$ -N GetSra

echo start
date

mkdir -p ../output/sra
tail -n +2 ../input/RNAseq_single.txt | cut -f 6 | xargs -n 1 -P 1 bash -c \
'
. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGS
prefetch --output-directory ../output/sra/ ${0}
'
echo finish
date