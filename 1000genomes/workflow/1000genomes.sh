#! /bin/bash
set -e

NUM_CHR=1

chr_i=5

if [[ ! -f ALL.chr1.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.annotation.vcf ]]; then 
    wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/supporting/functional_annotation/filtered/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.annotation.vcf.gz
    gunzip ALL.chr1.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.annotation.vcf.gz
fi

for ((i=1; i <= chr_i; i++)); do gunzip -f -k ALL.chr${i}.250000.vcf.gz; done

makeflow --jx ./1000genomes.jx -T vine --project-name "${VINE_MANAGER_NAME}"
