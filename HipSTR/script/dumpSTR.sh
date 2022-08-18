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

FILE_DIR=/scratch3/users/yal084/STR_Call/HipSTR/result/H3A_Baylor
SEGDUP_DIR=/scratch3/users/yal084/STR_Call/additional_files/hg38_segDups_sorted.bed.gz
time dumpSTR \
	--vcf ${FILE_DIR}/${FILE_NAME}.vcf.gz \
	--out ${FILE_DIR}/${FILE_NAME}_filtered \
	--vcftype hipstr \
	--filter-regions ${SEGDUP_DIR} \
	--filter-regions-names SEGDUP \
	--filter-hrun \
	--hipstr-min-call-Q 0.9 \
	--hipstr-min-call-DP 10 \
	--hipstr-max-call-DP 1000 \
	--hipstr-max-call-flank-indel 0.15 \
	--hipstr-max-call-stutter 0.15 \
	--min-locus-callrate 0.75 \
 	--min-locus-hwep 0.000001 \
	--zip
	
echo "Job done and remove the temp folder"
rm -r /scratch3/users/yal084/${SLURM_JOB_ID}
echo "cleaned and exit"
