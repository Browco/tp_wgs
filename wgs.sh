#!/bin/bash
# AUTHOR : CORALIE CAPRON
# DATE : 23.09.2019
#chmod +x wgs.sh
#./wgs.sh ALL_GENOME R1 R2 OUTPUT_DIRECTORY

all_genome=$1
R1=$2
R2=$3
OUTPUT=$4
mkdir $OUTPUT/samtools
base=$(basename $all_genome)
echo $base

base_read=$(basename $R1)

#Create index
../tp_2/soft/bowtie2-build $all_genome ../tp_2/databases/index

##Bowtie
#Abundance
#Create Sam
../tp_2/soft/bowtie2 -x ../tp_2/databases/index -1 $R1 -2 $R2 -S $OUTPUT/samtools/${base}.sam
#Sam To Bam
../tp_2/soft/samtools-1.6/samtools view -b $OUTPUT/samtools/${base}.sam > $OUTPUT/samtools/${base}.bam
#Sort Bam
../tp_2/soft/samtools-1.6/samtools sort $OUTPUT/samtools/${base}.bam -o $OUTPUT/samtools/${base}.sorted.bam
#Index Bam
../tp_2/soft/samtools-1.6/samtools index  $OUTPUT/samtools/${base}.sorted.bam
#Extract count
../tp_2/soft/samtools-1.6/samtools idxstats $OUTPUT/samtools/${base}.sorted.bam > $OUTPUT/samtools/indexation.txt

mkdir $OUTPUT/association
#Count and associate
grep ">" ../tp_2/databases/all_genome.fasta|cut -f 2 -d ">" > $OUTPUT/association/association.tsv
join -1 1 -2 1 <(sort -k 1 $OUTPUT/samtools/indexation.txt) <(sort -k 1 $OUTPUT/association/association.tsv) > $OUTPUT/association/merge_index.tsv

##Megahit
#Genome assembly
mkdir $OUTPUT/megahit
../tp_2/soft/megahit -1 $R1 -2 $R2 --k-min 21 --k-max 21 --memory 0.1 -o $OUTPUT/megahit/EchG.fasta 
#Predict genes on contigs
mkdir $OUTPUT/prodigal
../tp_2/soft/prodigal -i $OUTPUT/megahit/EchG.fasta/final.contigs.fa -d $OUTPUT/prodigal/gene_EchG.fna
#Select only complete genes
sed "s:>:*\n>:g" $OUTPUT/prodigal/gene_EchG.fna | sed -n "/partial=00/,/*/p"|grep -v "*" > $OUTPUT/prodigal/genes_full.fna

#Create database with the resfinder file 
mkdir $OUTPUT/blast
makeblastdb -in ../tp_2/databases/resfinder.fna -dbtype nucl -out ../tp_2/databases/resfinder_db.fasta
#...and blast
../tp_2/soft/blastn -db ../tp_2/databases/resfinder_db.fasta -query $OUTPUT/prodigal/genes_full.fna -out $OUTPUT/blast/results.out -outfmt 6 -perc_identity 80 -qcov_hsp_perc 80 -evalue 0.001
 

#Est ce que vos génomes présentent des gènes de résistance pour certains antibiotiques ?
#Parmi les top hits (50premiers) du blast des gènes complets sur la base de données resfinder, on retrouve des gènes codants pour des gènes de résistance aux antibiotiques tels que :
#fosfomycin_fosA qui est  "FosA family fosfomycin resistance glutathione transferase" selon Uniprot
# ou la vancomycin_VanA qui est "Vancomycin/teicoplanin A-type resistance protein VanA" selon Uniprot
