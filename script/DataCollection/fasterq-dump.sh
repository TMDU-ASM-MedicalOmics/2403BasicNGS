#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=5G
#$ -pe def_slot 6
#$ -j y
#$ -o log/DataCollection/
#$ -N fasterq-dump

echo start
date

mkdir -p ../output/fastq
tail -n +2 ../input/RNAseq_single.txt | cut -f 6 | xargs -n 1 -P 1 bash -c \
'
. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGS
fasterq-dump \
--split-files \
-p -e 6 \
-O ../output/fastq/ \
../output/sra/${0}/${0}.sra
'
echo finish
date
