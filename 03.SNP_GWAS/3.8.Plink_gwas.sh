#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other assemblies
morph_name=A1354 # change for other assemblies

# file paths
data_fp=/path/to/GWAS/data
out_fp=/path/to/GWAS/output

# gunzip my vcf
fn="$morph_name"_Allsites-filtered-sorted
gunzip -c $data_fp/"$fn"_gz > $data_fp/$fn.vcf

VCF="$data_fp/$fn".vcf

# repeat annotations
rep_masker=/path/to/$morph/output/"$morph_name"_repeatmasker/"$morph_name"_ragtag_UPPER.fa.out.gff
RED=/path/to/$morph/output/RED/"$morph_name"_ragtag_RED.bed

bedtools intersectBed -a $VCF \
                      -b $rep_masker $RED \
                      -v -header > $data_fp/"$fn"-norepeat.vcf
                                           
VCF=$data_fp/"$fn"-norepeat.vcf

# specify groups to compate
comp="AvO" # change for other pairwise comparisons
REF=$morph_name

# recode to create ped file
/data/programs/plink1.9/plink --vcf $VCF --recode \
                              --allow-extra-chr --allow-no-sex \
                              --pheno $data_fp/phenotypes_"$comp".pheno \
                              --out $data_fp/"$REF"_"$comp"

### check that the file is intact  and create .bed file
/data/programs/plink1.9/plink --file $data_fp/"$REF"_"$comp" --make-bed \
                              --allow-extra-chr --allow-no-sex \
                              --out $data_fp/"$REF"_"$comp" 

### Summary statistics ###

# on missing data
/data/programs/plink1.9/plink --bfile $data_fp/"$REF"_"$comp" --missing \
                              --allow-extra-chr --allow-no-sex \
                              --out $out_fp/"$REF"_"$comp"_miss_stat

# check the number and proportion of missing individuals per snp
#more $out_fp/"$comp"_miss_stat.imiss

# summary statistics of allele frequencies
/data/programs/plink1.9/plink --bfile $data_fp/"$REF"_"$comp" --freq \
                              --allow-extra-chr --allow-no-sex \
                              --out $out_fp/"$REF"_"$comp"_freq_stat

# basic association analysis
/data/programs/plink1.9/plink --bfile $data_fp/"$REF"_"$comp" --assoc \
                              --allow-extra-chr --allow-no-sex \
                              --adjust --pheno $data_fp/phenotypes_"$comp".pheno \
                              --out $out_fp/"$REF"_"$comp"
