#!/bin/bash
# AUTHOR : CORALIE CAPRON
# DATE : 23.09.2019
#chmod +x wgs.sh

all_genome=$1
R1=$2
R2=$3
OUTPUT=$4
mkdir $OUTPUT/samtools
base=$(basename $all_genome)
echo $base

base_read=$(basename $R1)

#Create index
#../tp_2/soft/bowtie2-build $all_genome ../tp_2/databases/index

#../tp_2/soft/bowtie2 -x ../tp_2/databases/index -1 $R1 -2 $R2 -S $OUTPUT/samtools/${base}.sam
#../tp_2/soft/samtools-1.6/samtools view -b $OUTPUT/samtools/${base}.sam > $OUTPUT/samtools/${base}.bam
#../tp_2/soft/samtools-1.6/samtools sort $OUTPUT/samtools/${base}.bam -o $OUTPUT/samtools/${base}.sorted.bam
#../tp_2/soft/samtools-1.6/samtools index  $OUTPUT/samtools/${base}.sorted.bam
#../tp_2/soft/samtools-1.6/samtools idxstats $OUTPUT/samtools/${base}.sorted.bam > $OUTPUT/samtools/indexation.txt

#mkdir $OUTPUT/association
#grep ">" ../tp_2/databases/all_genome.fasta|cut -f 2 -d ">" > $OUTPUT/association/association.tsv

#join -1 1 -2 1 <(sort -k 1 $OUTPUT/samtools/indexation.txt) <(sort -k 1 $OUTPUT/association/association.tsv) > $OUTPUT/association/merge_index.tsv

#mkdir $OUTPUT/megahit
#../tp_2/soft/megahit -1 $R1 -2 $R2 --k-min 21 --k-max 21 --memory 0.1 -o $OUTPUT/megahit/EchG.fasta 

#mkdir $OUTPUT/prodigal
#../tp_2/soft/prodigal -i $OUTPUT/megahit/EchG.fasta/final.contigs.fa -d $OUTPUT/prodigal/gene_EchG.fna

#sed "s:>:*\n>:g" $OUTPUT/prodigal/gene_EchG.fna | sed -n "/partial=00/,/*/p"|grep -v "*" > $OUTPUT/prodigal/genes_full.fna

makeblastdb -in ../tp_2/database/resfinder.fna -dbtype nucl
../tp_2/soft/blastn -db ../tp_2/database/resfinder.fna -query $OUTPUT/prodigal/genes_full.fna -out results.out -perc_identity 80 -qcov_hsp_perc 80 -evalue 0.001
 


