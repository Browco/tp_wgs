# tp_wgs
## Author : CAPRON Coralie

 > **Note to Diderot Bioinformatics Master students looking at this repository :** 
 > Bonjour à tous, vous avez accès ici à un repo que j'ai laissé en public pour évaluation en premier lieu puis en guise de démonstration du travail que j'ai pu faire lors de mon M2 par la suite. Vous avez donc la possibilité en tant qu'étudiant de regarder et/ou de cloner ce repo. A savoir toutefois que, bien que ce repo puisse vous inspirer (ou non) ou vous aider pour avancer dans votre travail, celui-ci est soumis à la propriété intellectuelle. A savoir donc que : Le plagiat, selon son niveau de gravité, est une contrefaçon. L'article L122-4 du Code de la propriété intellectuelle prévoit que "toute représentation ou reproduction intégrale ou parielle faite sans le consentement de l'auteur ou de ses ayants droit ou ayants cause est illicite". Soyez critique sur ce que vous trouverez dans ce repository, et dans les résultats qui y sont produits. Aidez-vous de ce travail mais par pitié, ne le plagiez pas bêtement, vous devez vous casser la tête pour devenir ensuite de bons bioinformaticiens. A bon entendeur. 

## Aim of this project
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
