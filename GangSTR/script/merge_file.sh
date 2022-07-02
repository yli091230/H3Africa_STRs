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

files=/scratch3/users/yal084/STR_Call/GangSTR/files_for_run/all_samples_vcf_dir.txt
#files=/scratch3/users/yal084/STR_Call/GangSTR/files_for_run/H3_Baylor_vcf_dir.txt
##out_dir=/scratch3/users/yal084/STR_Call/GangSTR/result/merged_TrypanoGEN_gangstr
out_dir=/scratch3/users/yal084/STR_Call/GangSTR/result/merged_all_gangstr
file_list=$(cat ${files})

mergeSTR \
	--vcfs ${file_list} \
	--out ${out_dir} \
	--vcftype gangstr \
	--verbose
