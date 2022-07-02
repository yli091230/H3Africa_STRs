#!/usr/bin/bash

RESULT=/scratch3/users/yal084/STR_Call/GangSTR/result/TrypanoGEN
SUCCEED_RUN=$(cat ${RESULT}/succeed_run.txt)

SUBMISSION_LOG=$(date '+%Y-%m-%d')
while read -r SAMPLE
do
	if echo ${SUCCEED_RUN} | grep -w ${SAMPLE} > /dev/null;
	then
		echo "${SAMPLE} already analyzed"
		continue
	else
		mkdir -p ${RESULT}/${SAMPLE}
		echo "Submitting Job ${SAMPLE}"
		sbatch --job-name=${SAMPLE} \
		       --output=${RESULT}/${SAMPLE}/${SAMPLE}_slurm_%j.out \
		       /scratch3/users/yal084/STR_Call/GangSTR/script/gangstr_jobscript.slurm ${SAMPLE}
		echo "${SAMPLE} submitted" >> ${RESULT}/Jobs_${SUBMISSION_LOG}.txt
	fi
done < $1
