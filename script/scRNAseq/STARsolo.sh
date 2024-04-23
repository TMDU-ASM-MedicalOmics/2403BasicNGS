#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=3G
#$ -pe def_slot 21
#$ -j y
#$ -N STARsolo
#$ -o log/scRNAseq/STARsolo/

echo start
date

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGS

SRRID=`echo SRR22321958 SRR22321959 | cut -d " " -f ${SGE_TASK_ID}`
DataID=`echo Hs_HSV1 Hs_Mock | cut -d " " -f ${SGE_TASK_ID}`

mkdir -p ../output/scRNAseq/STARsolo/${DataID}
cd ../output/scRNAseq/STARsolo/${DataID}
file1=../../fastq/${SRRID}/${DataID}_S1_*_R1_001.fastq.gz
file2=../../fastq/${SRRID}/${DataID}_S1_*_R2_001.fastq.gz
CellRanger=~/local/src/cellranger-7.2.0
index=../../../STARIndex

STAR --runThreadN 20 \
--genomeDir ${index} \
--genomeSAsparseD 3 \
--readFilesIn ${file2} ${file1} \
--readFilesCommand gunzip -c \
--runMode alignReads \
--outFileNamePrefix ./ \
--outFilterScoreMin 30 \
--outSAMtype BAM SortedByCoordinate \
--outBAMsortingThreadN 20 \
--outSAMunmapped Within \
--soloCellFilter EmptyDrops_CR \
--soloCBmatchWLtype 1MM_multi_Nbase_pseudocounts \
--soloCBwhitelist ${CellRanger}/lib/python/cellranger/barcodes/737K-august-2016.txt \
--soloFeatures Gene Velocyto \
--soloOutFileNames ${DataID}_ \
--soloMultiMappers Uniform \
--soloType CB_UMI_Simple \
--soloUMIlen 12 \
--soloUMIfiltering MultiGeneUMI_CR \
--soloUMIdedup 1MM_CR

echo finish
date
