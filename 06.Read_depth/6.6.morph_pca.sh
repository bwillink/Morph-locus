#!/bin/bash

# data file path
data_fp=/path/to/GWAS/data

# output file path
/path/to/GWAS/output

# variables
morph_name=A1354 # change to I1049 for I reference
from=1 # change to 3550000 for I reference
to=1600000 # change to 3700000 for I reference 
fn="$morph_name"_Allsites-filtered-sorted
VCF_genome=/path/to/GWAS/data/$fn.vcf.gz

# filter variants
vcftools --gzvcf $VCF_genome --recode --recode-INFO-all --chr "SUPER_13_unloc_2_RagTag" --from-bp 1 --to-bp 1600000 --out $data_fp/${fn%\-*}

VCF=$data_fp/"$morph_name"_SUPER_13_unloc_2-filtered.recode.vcf

#out filepath
out_fp="/mnt/griffin/beawil/GWAS/output/pca"

plink --vcf $VCF --double-id --allow-extra-chr \
                 --set-missing-var-ids @:# \
                 --indep-pairwise 50 10 0.1 --out $data_fp/"$morph_name"_all

# prune and create pca
plink --vcf $VCF --double-id --allow-extra-chr \
                 --set-missing-var-ids @:# \
                 --extract $data_fp/"$morph_name"_all.prune.in \
                 --make-bed --pca --out $out_fp/"$morph_name"_all



