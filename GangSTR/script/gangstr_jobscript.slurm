#!/usr/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=30:00:00
#SBATCH --mem=2G
#SBATCH --export=ALL

module purge
module load anaconda3 bcftools
source /software/common/anaconda3/2021.11/etc/profile.d/conda.sh
#eval "$(conda shell.bash hook)"
#conda deactivate 
conda activate gangstr

SAMPLE=$1

REF_GENOME=/cbio/dbs/references/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa
INFO=/scratch3/users/yal084/STR_Call/GangSTR/files_for_run/hg38_info_full.bed
REGIONS=/scratch3/users/yal084/STR_Call/GangSTR/files_for_run/hg38_supp.bed

#CRAM=/cbio/datasets/human/baylor/b38/cram/${SAMPLE}/${SAMPLE}.md.recal.cram
CRAM=/cbio/datasets/human/trypanogen/b38/cram/${SAMPLE}/${SAMPLE}.md.recal.cram
WORKING_DIR=/scratch3/users/yal084/STR_Call/GangSTR
OUT=${WORKING_DIR}/result/TrypanoGEN/${SAMPLE}

#mkdir -p ${OUT}

date '+%Y-%m-%d:%H-%M-%s' > ${OUT}/${SAMPLE}_time_tokens.txt 

time GangSTR \
	--bam ${CRAM} \
	--bam-samps ${SAMPLE} \
	--ref ${REF_GENOME} \
	--str-info ${INFO} \
	--regions ${REGIONS} \
	--out ${OUT}/${SAMPLE} \
	2> ${OUT}/${SAMPLE}_run.err \
	1> ${OUT}/${SAMPLE}_run.out \
	|| (echo ${SAMPLE} $(date '+%Y-%m-%d:%H-%M-%S') >> \
	${WORKING_DIR}/result/TrypanoGEN/failed_run.txt)

bcftools sort ${OUT}/${SAMPLE}.vcf -o ${OUT}/${SAMPLE}.sorted \
&& rm ${OUT}/${SAMPLE}.vcf \
&& mv ${OUT}/${SAMPLE}.sorted ${OUT}/${SAMPLE}.vcf \
&& bgzip ${OUT}/${SAMPLE}.vcf \
&& tabix -p vcf ${OUT}/${SAMPLE}.vcf.gz
	

date '+%Y-%m-%d:%H-%M-%S' >> ${OUT}/${SAMPLE}_time_tokens.txt

echo ${SAMPLE} $(date '+%Y-%m-%d:%H-%M-%S') >> ${WORKING_DIR}/result/TrypanoGEN/succeed_run.txt
