#!/usr/bin/env bash
#$ -S /bin/bash
#$ -l s_vmem=8G
#$ -cwd
#$ -q '!mjobs_rerun.q'
#$ -pe def_slot 16
#$ -j y
#$ -N mkref
#$ -o log/scRNAseq/

echo start
date

CellRanger=~/local/src/cellranger-7.2.0
PATH=$PATH:${CellRanger}
source ${CellRanger}/sourceme.bash
mkdir -p ../output/scRNAseq/CellRanger_ref
cd ../output/scRNAseq/CellRanger_ref
fasta=../../genome/Homo_sapiens/Homo_sapiens.fa
gtf=../../genome/Homo_sapiens/Homo_sapiens.gtf

${CellRanger}/cellranger mkref \
--genome=Homo_sapines \
--fasta=${fasta} \
--genes=${gtf} \
--nthreads=15 \
--memgb=120

echo finish
date
