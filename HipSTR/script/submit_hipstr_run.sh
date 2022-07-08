#!/usr/bin/bash


#SAMPLE=$1
RESULT=/scratch3/users/yal084/STR_Call/HipSTR/result/H3A_Baylor
SUCCEED_RUN=$(cat ${RESULT}/succeed_run.txt)
REF_DIR=/scratch3/users/yal084/STR_Call/HipSTR/files_for_run
REF_FILE=/scratch3/users/yal084/STR_Call/HipSTR/files_for_run/hipref.bed
SUBMISSION_LOG=$(date '+%Y-%m-%d')


#mkdir -p ${RESULT}/${SAMPLE}

start_job()
{
	job_name=$(basename $1)
	if echo ${SUCCEED_RUN} | grep -w ${job_name} > /dev/null;
	then
		echo "${job_name} already analyzed"
	
	else
		echo "Submitting Job ${job_name}"
		sbatch --job-name=${job_name} \
	       	       --output=${RESULT}/${job_name}/${job_name}_slurm_%j.out \
	      	        /scratch3/users/yal084/STR_Call/HipSTR/script/run_hipstr.slurm $1
		echo "${job_name} submitted" >> ${RESULT}/Jobs_${SUBMISSION_LOG}.txt
	fi
}



#mkdir -p ${REF_dir}/${SAMPLE}
split -dl 26000 ${REF_FILE} ${REF_DIR}/hipref_ -a 2
for splited_sample in $(ls -d ${REF_DIR}/hipref_*);
do
	split_batch=$(basename ${splited_sample})
	mkdir -p ${RESULT}/${split_batch}
	#echo ${splited_sample}
	start_job ${splited_sample}
done
