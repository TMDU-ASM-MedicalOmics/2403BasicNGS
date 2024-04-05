#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=7.5G
#$ -pe def_slot 8
#$ -j y
#$ -N STAR
#$ -o log/BulkRNAseq/STAR/
#$ -hold_jid "STAR_Index"

echo start
date

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGS

SampleID=`tail -n +2 ../input/RNAseq_single.txt | cut -f 6 | head -n ${SGE_TASK_ID} | tail -n 1`
mkdir -p ../output/STAR/${SampleID}
STAR \
--runThreadN 8 \
--genomeLoad NoSharedMemory \
--limitBAMsortRAM 30000000000 \
--genomeDir ../output/STARIndex/ \
--readFilesIn ../output/fastq_trim/${SampleID}.fastq \
--outFileNamePrefix ../output/STAR/${SampleID}/${SampleID} \
--outSAMtype BAM SortedByCoordinate \
--outReadsUnmapped Fastx

echo finish
date
