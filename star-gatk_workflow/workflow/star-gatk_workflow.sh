#!/bin/bash
set -e 
set -o pipefail

#FastqFiles=("SRR10307460" "ERR4179434" "SRR40644330" "SRR40639328" "SRR40639326" "SRR40315802" "SRR40315804" "SRR40315804" "SRR40315805" "SRR40315806")
FastqFiles=("SRR10307460")
FastqBase="${FastqFiles[0]}"
BaseFastaGz="GRCh38.primary_assembly.genome.fa.gz"
BaseFasta="GRCh38.primary_assembly.genome.fa"
FastaPrefix="GRCh38.gencode.pa.genome"
MAXFA=3
GenomeDir="gdir"
STAR_filein="${FastqBase}.fastq"
#head -n 26091 SRR40671052.fastq > srr_trimmed.fastq
ThreadNum=1

 if [[ ! -f "${FastqBase}.fastq" ]]; then
    echo "Fetching FASTQ files..."
    fasterq-dump --split-files "${FastqBase}"
    for f in ${FastqBase}*.fastq; do
 	   head -n 40000 ${f} > shortened_${f}
    done 

 else
 	echo "${FastqBase} found..."
 fi

if [[ ! -f "${BaseFasta}" ]]; then
	#wget "https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_50/GRCh38.primary_assembly.genome.fa.gz"
	#gunzip "${BaseFastaGz}"
	zcat "${BaseFastaGz}" > "${BaseFasta}"

else
	echo "${BaseFastaGz} found..."
fi

 for i in $(seq 1 $MAXFA); do 
 	echo "${FastaPrefix}.${i}"
 	if [[ -f ${FastaPrefix}.${i}.fa ]]; then 
 		continue 
 	fi
 	j=$((i + 1))
 	echo "Extracting chr${i} from Fasta file (${BaseFastaGz})" 
 	sed -n "/>chr${i} ${i}/,+1000p" ${BaseFasta} > ${FastaPrefix}.${i}.fa
 done
makeflow --jx ./star_gatk.sh.jx -T vine --project-name "${VINE_MANAGER_NAME}"
