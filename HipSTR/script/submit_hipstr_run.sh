#!/usr/bin/bash

SAMPLE=$1
RESULT=/scratch3/users/yal084/STR_Call/HipSTR/result/H3A_Baylor
SUCCEED_RUN=$(cat ${RESULT}/succeed_run.txt)

SUBMISSION_LOG=$(date '+%Y-%m-%d')

if echo ${SUCCEED_RUN} | grep -w ${SAMPLE} > /dev/null;
then
	echo "${SAMPLE} already analyzed"
	continue
else
	mkdir -p ${RESULT}/${SAMPLE}
	echo "Submitting Job ${SAMPLE}"
	sbatch --job-name=${SAMPLE} \
	       --output=${RESULT}/${SAMPLE}/${SAMPLE}_slurm_%j.out \
	       /scratch3/users/yal084/STR_Call/HipSTR/script/run_hipstr.slurm ${SAMPLE}
	echo "${SAMPLE} submitted" >> ${RESULT}/Jobs_${SUBMISSION_LOG}.txt
fi
