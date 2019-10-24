# tp_wgs
## Author : CAPRON Coralie

This script will allow the user to identify one or more microorganisms during an infection. This script use a genome file and reads R1 and R2. It will assemble them, create sam and bam files, create the genes associated and align them. 

## Requirements

* Some tools : 
	- bowtie2 (V2.3.3.1),
	- samtools (V1.6)
	- megahit (v1.1.2)
	- prodigal (V2.6.3: February, 2016)
	- blastn ( Nucleotide-Nucleotide BLAST 2.7.0+)

## Utilization

In a shell : 
```
chmod +x wgs.sh.sh
./wgs.sh ALL_GENOME R1 R2 OUTPUT_DIRECTORY
```

Knowing that :
- ALL_GENOME : The entire genome used
- R1 : Reads forward
- R2 : Reads reverse
- OUTPUT_DIRECTORY : The output directory for the results

## Output

This script will create an output directory with sub-directories for each tool (association, megahit, prodigal, samtools). 
