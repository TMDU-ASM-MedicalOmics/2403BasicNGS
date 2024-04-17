#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=20G
#$ -j y
#$ -o log/scRNAseq/DataCollection/
#$ -N fastq-dump
#$ -hold_jid GetSra

echo start
date

SRRID=`echo SRR22321958 SRR22321959 | cut -d " " -f ${SGE_TASK_ID}`
mkdir -p ../output/scRNAseq/fastq/${SRRID}

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGS
fastq-dump \
--split-files \
--gzip \
-O ../output/scRNAseq/fastq/${SRRID}/ \
../output/scRNAseq/sra/${SRRID}/${SRRID}.sra

#SRRname=`ls ../output/scRNAseq/fastq/${SRRID}* | sed -e 's/\.sra//g'`
#if [ ! -f ${SRRname} ]; then
#    mv ../output/scRNAseq/fastq/${SRRID}.sra.fastq ../output/scRNAseq/fastq/${SRRID}.fastq
#fi

echo finish
date
