#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=7.5G
#$ -pe def_slot 8
#$ -j y
#$ -N fastp
#$ -o log/BulkRNAseq/

echo start
date

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGS

mkdir -p ../output/fastq_trim
mkdir -p ../output/QC

tail -n +2 ../input/RNAseq_single.txt | cut -f 6 | xargs -n 1 -P 1 bash -c \
'
fastp \
--thread 8 \
--in1 ../output/fastq/${0}.sra.fastq \
--out1 ../output/fastq_trim/${0}.fastq \
--json ../output/QC/${0}.json \
--html ../output/QC/${0}.html \
--report_title "${0}"
'

echo finish
date

