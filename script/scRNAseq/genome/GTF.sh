#! /usr/bin/env bash
#$ -S /bin/bash
#$ -l s_vmem=10G
#$ -cwd
#$ -j y
#$ -N MakeGTF
#$ -o log/scRNAseq/genome/

echo start
date

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGS

python scRNAseq/genome/RemoveAlt.py \
../output/genome/Homo_sapiens/GCF_000001405.39_GRCh38.p13_genomic.fna \
../output/genome/Homo_sapiens/Homo_sapiens.fa \
> ../output/genome/Homo_sapiens/ChNames.txt

python scRNAseq/genome/MakeBlackList.py \
../output/genome/Homo_sapiens/ChNames.txt \
../output/genome/Homo_sapiens/GCF_000001405.39_GRCh38.p13_genomic.gtf \
> ../output/genome/Homo_sapiens/BlackList.txt

python scRNAseq/genome/GTFfilter.py \
../output/genome/Homo_sapiens/ChNames.txt \
../output/genome/Homo_sapiens/BlackList.txt \
../output/genome/Homo_sapiens/GCF_000001405.39_GRCh38.p13_genomic.gtf \
> ../output/genome/Homo_sapiens/Homo_sapiens.gtf

echo finish
date
