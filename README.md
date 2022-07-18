1. Location of reference genome
/cbio/dbs/references/GRCh38_reference_genome

2. It includes 314 high coverage (average 30X) samples sequenced on the
Illumina X-Ten, also available as individual datasets under the H3Africa Chip
study (EGAS00001002976) and 112 medium coverage (average 10X) samples from the
rypanGen study (EGAS00001002602) sequenced on Illumina HiSeq 2500 
* Data set description can be found on: https://ega-archive.org/datasets/EGAD00001005310/files


3. GangSTR called STRs on each sample individually. HipSTR called STRs on joint samples from Baylor or TrypanoGEN.

```
--STR_call
    |--HipSTR
    |     |--files_for_run
    |     |--results
    |     |     |--H3A_Baylor
    |     |     |--TrypanoGEN
    |     |--scripts
    |--GangSTR
          |--files_for_run
          |--results
	  |    |--H3A_Baylor
          |    |--TrypanoGEN
          |--scripts 
```
4. CODIS U.S genotypes were download from [NIST](https://strbase.nist.gov/fbicore.htm) [population dataset](https://strbase.nist.gov/NISTpop.htm) and regions of CODIS for hg38 was download from UCSC genomebrowser. 
