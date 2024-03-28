#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=10G
#$ -j y
#$ -o log/DataCollection/
#$ -N GetGtf

echo start
date
#Homo sapiens
wget -P ../output/genome/Homo_sapiens \
https://ftp.ncbi.nlm.nih.gov/genomes/all/annotation_releases/9606/109.20200228/GCF_000001405.39_GRCh38.p13/GCF_000001405.39_GRCh38.p13_genomic.gtf.gz
gunzip ../output/genome/Homo_sapiens/GCF_000001405.39_GRCh38.p13_genomic.gtf.gz
echo finish
date
