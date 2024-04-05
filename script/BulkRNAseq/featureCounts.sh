#!/usr/bin/env bash
#$ -S /bin/bash
#$ -cwd
#$ -pe def_slot 10
#$ -l s_vmem=2.5G
#$ -N featureCounts
#$ -j y
#$ -o log/BulkRNAseq/
#$ -hold_jid "STAR"

echo start
date

. ~/miniconda3/etc/profile.d/conda.sh
conda activate BasicNGS

mkdir -p ../output/featureCounts
featureCounts \
-T 10 -t exon -g gene \
-a ../output/genome/Homo_sapiens/GCF_000001405.39_GRCh38.p13_genomic.gtf \
-o ../output/featureCounts/featureCounts.txt \
../output/STAR/*/*Aligned.sortedByCoord.out.bam

tail -n +2 ../output/featureCounts/featureCounts.txt \
| cut -f 1,7- \
| sed -e "s/\.\.\/output\/STAR\///g" \
| sed -e "s/Aligned.sortedByCoord.out.bam//g" \
| sed -e "s/SRR[0-9]\+\///g" \
| sed -e "s/ERR[0-9]\+\///g" \
> ../output/featureCounts/rawCounts.txt

tail -n +2 ../output/featureCounts/featureCounts.txt \
| cut -f 1,6 \
> ../output/featureCounts/GeneLength.txt

echo finish
date
