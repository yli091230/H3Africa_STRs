#!/usr/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=60:00:00
#SBATCH --mem=16G
#SBATCH --export=ALL

module purge
module load anaconda3 bcftools
source /software/common/anaconda3/2021.11/etc/profile.d/conda.sh
#eval "$(conda shell.bash hook)"
#conda deactivate
conda activate gangstr
export TMPDIR=/scratch3/users/yal084/${SLURM_JOB_ID}/tmp
mkdir -p ${TMPDIR}
echo "tmp file direction set to ${TMPDIR}"
FILE_NAME=$1
FILE_DIR=/scratch3/users/yal084/STR_Call/GangSTR/result
SEGDUP_DIR=/scratch3/users/yal084/STR_Call/additional_files/hg38_segDups_sorted.bed.gz
time dumpSTR \
	--vcf ${FILE_DIR}/${FILE_NAME}.vcf.gz \
	--out ${FILE_DIR}/${FILE_NAME}_filtered \
	--vcftype gangstr \
	--min-locus-callrate 0.75 \
	--min-locus-hwep 0.000001 \
	--filter-regions ${SEGDUP_DIR} \
	--filter-regions-names SEGDUP \
	--gangstr-filter-spanbound-only \
	--gangstr-filter-badCI
echo "Job done and remove the temp folder"
rm -r /scratch3/users/yal084/${SLURM_JOB_ID}
echo "cleaned and exit"
