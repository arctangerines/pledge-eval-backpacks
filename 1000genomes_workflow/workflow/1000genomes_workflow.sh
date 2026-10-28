#! /bin/bash
set -e

NUM_CHR=1

chr_i=5

if [[ ! -f ALL.chr1.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.annotation.vcf ]]; then 
    wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/supporting/functional_annotation/filtered/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.annotation.vcf.gz
    gunzip ALL.chr1.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.annotation.vcf.gz
fi

for ((i=1; i <= chr_i; i++)); do gunzip -f -k ALL.chr${i}.250000.vcf.gz; done

makeflow --jx ./1000genomes.sh.jx -T vine -p 9129

# bin/individuals.py ALL.chr${chr_i}.250000.vcf ${chr_i} 1 201 6000;
# bin/individuals_merge.py ${chr_i} chr${chr_i}n-1-201.tar.gz
# bin/sifting.py ALL.chr${chr_i}.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.annotation.vcf ${chr_i}
# bin/mutation_overlap.py -c ${chr_i} -pop EAS 
# bin/frequency.py -c ${chr_i} -pop EAS 


#  for chr_i in $(seq 1 $NUM_CHR); do
#         set -x
#         bin/individuals.py ALL.chr${chr_i}.250000.vcf ${chr_i} 1 201 6000;
#         # bin/individuals.py ALL.chr${chr_i}.250000.vcf ${chr_i} 201 401 6000;
#         # bin/individuals.py ALL.chr${chr_i}.250000.vcf ${chr_i} 401 601 6000;
#         # bin/individuals.py ALL.chr${chr_i}.250000.vcf ${chr_i} 601 801 6000 &
#         set +x
# done
# wait

# for chr_i in $(seq 1 $NUM_CHR); do
#     set -x
#     bin/individuals_merge.py ${chr_i} chr${chr_i}n-1-201.tar.gz \
#             # chr${chr_i}n-201-401.tar.gz \
#             # chr${chr_i}n-401-601.tar.gz \
#             # chr${chr_i}n-601-801.tar.gz &
#     set +x
# done
# wait

# for chr_i in $(seq 1 $NUM_CHR); do
#     set -x
#     bin/sifting.py ALL.chr${chr_i}.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.annotation.vcf ${chr_i} &
#     set +x
# done
# wait

# for chr_i in $(seq 1 $NUM_CHR); do
#     set -x
#     bin/mutation_overlap.py -c ${chr_i} -pop EAS &
#     #bin/mutation_overlap.py -c ${chr_i} -pop AMR &
#     set +x
# done
# wait

# for chr_i in $(seq 1 $NUM_CHR); do
#     set -x
#     bin/frequency.py -c ${chr_i} -pop EAS &
#     #bin/frequency.py -c ${chr_i} -pop AMR &
#     set +x
# done
# wait
