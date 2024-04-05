#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=4.2G
#$ -pe def_slot 20
#$ -j y
#$ -N STAR_Index
#$ -o log/BulkRNAseq/

echo start
date

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGS

mkdir -p ../output/STARIndex
cd ../output/STARIndex/
STAR \
--runThreadN 20 \
--runMode genomeGenerate \
--limitGenomeGenerateRAM 64000000000 \
--genomeDir ./ \
--genomeFastaFiles ../genome/Homo_sapiens/GCF_000001405.39_GRCh38.p13_genomic.fna \
--sjdbGTFfile ../genome/Homo_sapiens/GCF_000001405.39_GRCh38.p13_genomic.gtf

echo end
date