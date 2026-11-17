#! /bin/bash
set -e

NUM_CHR=1

chr_i=1

if [[ ! -f ALL.chr1.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.annotation.vcf ]]; then 
    wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/supporting/functional_annotation/filtered/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.annotation.vcf.gz
    gunzip ALL.chr1.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.annotation.vcf.gz
fi

gunzip -f -k ALL.chr1.250000.vcf.gz
bin/individuals.py ALL.chr${chr_i}.250000.vcf ${chr_i} 1 201 6000;
bin/individuals_merge.py ${chr_i} chr${chr_i}n-1-201.tar.gz
bin/sifting.py ALL.chr${chr_i}.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.annotation.vcf ${chr_i}
bin/mutation_overlap.py -c ${chr_i} -pop EAS 
bin/frequency.py -c ${chr_i} -pop EAS 
