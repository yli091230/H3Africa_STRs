# Install HipSTR
1. Download HipSTR v0.7 from https://github.com/tfwillems/HipSTR/archive/refs/tags/v0.7.tar.gz, unzip and install under your own directory. Note: The current version of the HipSTR have a small bug, will provide a link for updated version.
2. Splict HipSTR reference file to small batches, each contains 26,000 STRs.There are 64 split files. HipSTR run for hipref_63 failed due to memory issue, this file contains STRs on ChrY, so ignore this one.
3. Concatenate all HipSTR call to one single file using `bcftools concat -f ../../files_for_run/H3A_hipstr_file_list.txt -O z -o H3A_Baylor_combined`, where H3A_hipstr_file_list.txt is the directory for those split HipSTR call files.
4. Running DumpSTR to filter HipSTR call result
```
dumpSTR \
	--vcf ${FILE_DIR}/${FILE_NAME}.vcf.gz \ #directory for input vcf files
	--out ${FILE_DIR}/${FILE_NAME}_filtered \ #directory for output vcf files
	--vcftype hipstr \ #tell dumpSTR this is for  HipSTR call
	--filter-regions ${SEGDUP_DIR} \ #directory to bed file containing the segmental duplication region
	--filter-regions-names SEGDUP \ #name of the filter-regions
	--filter-hrun \ #hipstr specific filter to remove repeats with long homopolyer runs
	--hipstr-min-call-Q 0.9 \ #
	--hipstr-min-call-DP 10 \
	--hipstr-max-call-DP 1000 \
	--hipstr-max-call-flank-indel 0.15 \
	--hipstr-max-call-stutter 0.15 \
	--min-locus-callrate 0.75 \
 	--min-locus-hwep 0.000001 \
	--zip #output bgzipped file and tabix indexed
```
