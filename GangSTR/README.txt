1. File directories 
```
--/GangSTR 
	|--scripts 
	|--files_for_run 
	|--results 
		|--TrypanoGEN 
		|--H3Africa_Baylor 
			|--succeed_run.txt 
			|--failed_run.txt 
			|--SAMPLE 
				|--SAMPLE.vcf.gz
				|--SAMPLE_slurm_JOBID.out

```
2. Note: sample 32-UO_080C_150813_L003 from TrypanoGEN failed due to Not enough reads

all_samples_vcf_dir.txt contains directories of vcf files from 559 samples (left 1 sample from trypanoGEN due to low coverage), then merged with mergeSTR.

3. Combine all gangSTR results with mergeSTR, then sort, comparess and index the results for dumpSTR
