#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=5G
#$ -pe def_slot 6
#$ -j y
#$ -o log/scRNAseq/DataCollection/
#$ -N fasterq-dump
#$ -hold_jid GetSra

echo start
date

mkdir -p ../output/scRNSseq/fastq
SRRID=`echo SRR22321958 SRR22321959 | cut -d " " -f ${SGE_TASK_ID}`

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGS
fasterq-dump \
--split-files \
-p -e 6 \
-O ../output/scRNAseq/fastq/ \
../output/scRNAseq/sra/${SRRID}/${SRRID}.sra

echo finish
date
