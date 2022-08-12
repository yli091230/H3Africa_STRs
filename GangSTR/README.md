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

3. Combine all gangSTR results with mergeSTR, then sort, comparess and index the results for dumpSTR to filter.
* DumpSTR outputs files show how many locis passed the fitler. There are about half STRs failed HWE filter in TrypanoGEN dataset, this might due to the low reads.
* Focus on the H3Africa_Baylor dataset now.
	1. dumpSTR output files and FILTER filed contains information of all applied filters. There are 1103525 STRs pass all filters (merged_H3A_Baylor_gangstr_filtered.vcf.gz).
	2. STR genotypes that pass dumpSTR filters ./H3A_Baylor_merged/merged_H3A_Baylor_gangstr_filtered_GT.tsv
	3. filtered STRs used for PCA, H3A_Baylor_gangstr_GT_for_PCA.tsv
* Realize mergeSTR will produce duplicated STRs that partially overlaps, need to remove those STRs.
4. 1000 Genome data is located in ./results/1000Genomes 
