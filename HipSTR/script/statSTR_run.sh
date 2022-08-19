#!/usr/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=100:00:00
#SBATCH --mem=24G
#SBATCH --export=ALL

module purge
module load anaconda3 bcftools
source /software/common/anaconda3/2021.11/etc/profile.d/conda.sh
#eval "$(conda shell.bash hook)"
#conda deactivate
conda activate gangstr
export TMPDIR=/scratch3/users/yal084/${SLURM_JOB_ID}/tmp
mkdir -p ${TMPDIR}
echo ${SLURM_JOB_ID}

files=/scratch3/users/yal084/STR_Call/HipSTR/result/H3A_Baylor/H3A_Baylor_combined_filtered.vcf.gz
out_dir=/scratch3/users/yal084/STR_Call/HipSTR/result/H3A_Baylor/H3A_Baylor_combined_filtered.stats

time statSTR \
	--vcf ${files} \
	--out ${out_dir} \
	--vcftype hipstr \
	--thresh --afreq --acount --hwep --het \
	--mean --mode --var --numcalled \
	2>> ${out_dir}.error \
	1> ${out_dir}.out
rm -r /scratch3/user/yal084/${SLURM_JOB_ID}
echo "tmp file cleaned and stats job done!"

