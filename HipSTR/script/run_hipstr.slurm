#!/usr/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=180:00:00
#SBATCH --mem=16G
#SBATCH --export=ALL

module purge
module load anaconda3 bcftools
source /software/common/anaconda3/2021.11/etc/profile.d/conda.sh
#eval "$(conda shell.bash hook)"
#conda deactivate
conda activate gangstr


str_ref_dir=$1
file_id=$(basename ${str_ref_dir})
sample=$(echo ${file_id} | cut -d '_' -f 1)
#str_ref_dir=/scratch3/users/yal084/STR_Call/HipSTR/files_for_run/STR_${file_id}_ref.bed
ref_dir=/cbio/dbs/references/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa
HipSTR=/scratch3/users/yal084/tools/HipSTR
cram_file_dir=/scratch3/users/yal084/STR_Call/HipSTR/files_for_run/Baylor_cram_dir_list.txt
cram_list=$(cat ${cram_file_dir})
#echo ${cram_list}
result=/scratch3/users/yal084/STR_Call/HipSTR/result/H3A_Baylor/${sample}
echo ${str_ref_dir}

die()
{
	(echo $1 $(date '+%Y-%m-%d:%H-%M-%S') >> \
        /scratch3/users/yal084/STR_Call/HipSTR/result/H3A_Baylor/failed_run.txt)
	echo "HipSTR run error" >&2
	exit 1
}

echo $(date '+%Y-%m-%d:%H-%M-%s') >> ${result}/${file_id}_time_token.txt 


${HipSTR} \
	--bams ${cram_list} \
	--fasta ${ref_dir} \
	--regions ${str_ref_dir} \
	--str-vcf ${result}/${file_id}.vcf.gz 2>${result}/${file_id}.log || die ${file_id}

echo $(date '+%Y-%m-%d:%H-%M-%S') >> ${result}/${file_id}_time_token.txt

echo ${file_id} $(date '+%Y-%m-%d:%H-%M-%S') >> /scratch3/users/yal084/STR_Call/HipSTR/result/H3A_Baylor/succeed_run.txt
