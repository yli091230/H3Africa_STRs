#!/bin/bash

#PBS -N HG02281
#PBS -l nodes=1:ppn=1
#PBS -l walltime=60:00:00
#PBS -o /projects/ps-gymreklab/mousavi/results/1000genomes/outs/AFR/ACB/HG02281/log/HG02281.out
#PBS -e /projects/ps-gymreklab/mousavi/results/1000genomes/outs/AFR/ACB/HG02281/log/HG02281.err
#PBS -A gymreklab-group



REF_GENOME=/projects/ps-gymreklab/resources/dbase/human/hg38/hg38.fa
REGIONS=/projects/ps-gymreklab/mousavi/analysis/1000genomes/additional_runtime_files/regions/hg38_supp.bed
INFO=/projects/ps-gymreklab/mousavi/analysis/1000genomes/additional_runtime_files/regions/hg38_info_full.bed


CRAM=/projects/ps-gymreklab/resources/datasets/1000Genomes/cram/HG02281.final.cram
RUN=/projects/ps-gymreklab/mousavi/results/1000genomes/outs/AFR/ACB/HG02281/running_out/HG02281
OUT=/projects/ps-gymreklab/mousavi/results/1000genomes/outs/AFR/ACB/HG02281/gangstr_out/HG02281


date '+%Y-%m-%d:%H-%M-%S' > /projects/ps-gymreklab/mousavi/results/1000genomes/outs/AFR/ACB/HG02281/log/time_tokens.txt
time /projects/ps-gymreklab/mousavi/analysis/1000genomes/GangSTR-2.4.5  \
    --bam $CRAM \
    --bam-samps HG02281 \
    --samp-sex M \
    --ref $REF_GENOME \
    --str-info $INFO \
    --regions $REGIONS \
    --grid-threshold 250 \
    --out $RUN \
    2> /projects/ps-gymreklab/mousavi/results/1000genomes/outs/AFR/ACB/HG02281/log/HG02281.run.err \
    1> /projects/ps-gymreklab/mousavi/results/1000genomes/outs/AFR/ACB/HG02281/log/HG02281.run.out \
    && bcftools sort ${RUN}.vcf -o ${RUN}.sorted \
    && rm ${RUN}.vcf \
    && mv ${RUN}.sorted ${RUN}.vcf \
    && bgzip ${RUN}.vcf \
    && tabix -p vcf ${RUN}.vcf.gz \
    && cp ${RUN}.samplestats.tab ${OUT}.samplestats.tab \
    && cp ${RUN}.vcf.gz ${OUT}.vcf.gz \
    && cp ${RUN}.vcf.gz.tbi ${OUT}.vcf.gz.tbi

gzip /projects/ps-gymreklab/mousavi/results/1000genomes/outs/AFR/ACB/HG02281/log/HG02281.run.err
gzip /projects/ps-gymreklab/mousavi/results/1000genomes/outs/AFR/ACB/HG02281/log/HG02281.run.out

echo "GangSTR job done! (HG02281)"
date '+%Y-%m-%d:%H-%M-%S' >> /projects/ps-gymreklab/mousavi/results/1000genomes/outs/AFR/ACB/HG02281/log/time_tokens.txt
