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

makeflow --jx ./star_gatk.sh.jx -T vine --project-name "${VINE_MANAGER_NAME}"
