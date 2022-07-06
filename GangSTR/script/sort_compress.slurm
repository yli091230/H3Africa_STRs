#!/usr/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=60:00:00
#SBATCH --mem=4G
#SBATCH --export=ALL

module purge
module load anaconda3 bcftools
source /software/common/anaconda3/2021.11/etc/profile.d/conda.sh
#eval "$(conda shell.bash hook)"
#conda deactivate 
conda activate gangstr
export TMPDIR=/scratch/users/yal084/${SLURM_JOB_ID}
echo ${SLURM_JOB_ID}

FILE_NAME=$1
FILE_DIR=/scratch3/users/yal084/STR_Call/GangSTR/result

time bcftools sort ${FILE_DIR}/${FILE_NAME}.vcf -o ${FILE_DIR}/${FILE_NAME}.sorted -T ${FILE_DIR} \
&& rm ${FILE_DIR}/${FILE_NAME}.vcf \
&& mv ${FILE_DIR}/${FILE_NAME}.sorted ${FILE_DIR}/${FILE_NAME}.vcf \
&& bgzip ${FILE_DIR}/${FILE_NAME}.vcf \
&& tabix -p vcf ${FILE_DIR}/${FILE_NAME}.vcf.gz
	


