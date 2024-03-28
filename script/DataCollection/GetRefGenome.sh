#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=10G
#$ -j y
#$ -o log/DataCollection/
#$ -N GetRefGenome

echo start
date
#Homo sapiens
mkdir -p ../output/genome/Homo_sapiens
wget -P ../output/genome/Homo_sapiens \
https://ftp.ncbi.nlm.nih.gov/genomes/all/annotation_releases/9606/109.20200228/GCF_000001405.39_GRCh38.p13/GCF_000001405.39_GRCh38.p13_genomic.fna.gz
gunzip ../output/genome/Homo_sapiens/GCF_000001405.39_GRCh38.p13_genomic.fna.gz
echo finish
date
