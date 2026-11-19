#!/bin/bash
set -e 
set -o pipefail

#FastqFiles=("SRR10307460" "ERR4179434" "SRR40644330" "SRR40639328" "SRR40639326" "SRR40315802" "SRR40315804" "SRR40315804" "SRR40315805" "SRR40315806")
FastqFiles=("SRR10307460")
FastqBase="${FastqFiles[0]}"
BaseFastaGz="GRCh38.primary_assembly.genome.fa.gz"
BaseFasta="GRCh38.primary_assembly.genome.fa"
FastaPrefix="GRCh38.gencode.pa.genome"
MAXFA=5
GenomeDir="gdir"
STAR_filein="${FastqBase}.fastq"
#head -n 26091 SRR40671052.fastq > srr_trimmed.fastq
ThreadNum=1

printf -v row "%$(tput cols)s"; echo "${row// /=}"
echo "Generate GenomeRequirements.txt"
printf -v row "%$(tput cols)s"; echo "${row// /=}"
STAR --runThreadN ${ThreadNum} --runMode genomeGenerate --genomeDir ${GenomeDir} --genomeFastaFiles "${FastaPrefix}"*.fa --genomeSAindexNbases 2

printf -v row "%$(tput cols)s"; echo "${row// /=}"
echo "Mapping Fastq files"
printf -v row "%$(tput cols)s"; echo "${row// /=}"

STAR --runThreadN ${ThreadNum} --genomeDir ${GenomeDir} --readFilesIn shortened_${FastqBase}_1.fastq shortened_${FastqBase}_2.fastq --outFileNamePrefix ${FastqBase} --outSAMtype BAM SortedByCoordinate Unsorted --outSAMattrRGline ID:srr SM:Sample1 PL : ILLUMINA LB:Lib1

samtools index "${FastqBase}Aligned.sortedByCoord.out.bam"

for i in $(seq 1 $MAXFA); do


	samtools faidx "${FastaPrefix}.${i}.fa"

	if [[ -f "${FastaPrefix}.${i}.dict" ]]; then
		printf -v row "%$(tput cols)s"; echo "${row// /*}"
		echo "Deleting previous dictionary"
		printf -v row "%$(tput cols)s"; echo "${row// /*}"
		rm "${FastaPrefix}.${i}.dict"
	fi
	gatk CreateSequenceDictionary -R ${FastaPrefix}.${i}.fa

	printf -v row "%$(tput cols)s"; echo "${row// /=}"
	echo "Running the HaplotypeCaller"
	printf -v row "%$(tput cols)s"; echo "${row// /=}"
	gatk --java-options "-Xmx16g" HaplotypeCaller --native-pair-hmm-threads 1  -R ${FastaPrefix}.${i}.fa -I "${FastqBase}Aligned.sortedByCoord.out.bam" -O "${FastqBase}.g.vcf.${i}.gz"
done
