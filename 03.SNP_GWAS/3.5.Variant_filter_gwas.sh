#/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other assemblies
morph_name=A1354 # change for other assemblies

#file paths
data_fp=/path/to/$morph/output/Var_call/'$morph_name'_scaffolds_allsites
out_fp=/path/to/$morph/output/Var_call/"$morph"_scaffolds_filtered

GWAS_in_fp=/path/to/GWAS/data

# reference
REF_fp=/path/to/$morph/output/RagTag # change for DToL
REF="$morph_name"_ragtag.fa # change for DToL

# get scaffold ids
grep '>' $REF_fp/$REF | sed 's/>//g' > $data_fp/"$morph"_scaffolds_ids

# list of samples
sample="samples_bcf"
0

# get file list
cat $data_fp/"$morph"_scaffolds_ids | sed -E 's/([A-Z,a-z,0-9,_]*)/\/path\/to\/'$morph'\/output\/Var_call\/'$morph_name'_scaffolds_filtered\/'$morph_name'_Allsites\1-filtered-sorted.vcf/g' > $data_fp/"$morph_name"_vcf_files


# filter snps
cat $data_fp/"$morph"_scaffolds_ids | \
parallel -j 25 "bcftools filter -i'%QUAL>30 & AVG(FMT/GQ)>20 & INFO/MQ>20 & INFO/DP<1360 & MAF>0.02' -g 3 -Ov --threads 2 $out_fp/'$morph_name'_Allsites{}.bcf | 

#Sort and zip
bcftools sort -Ov -o $out_fp/"$morph_name"_Allsites{}-filtered-sorted.vcf"

#concatenate into one vcf 
bcftools concat -f $out_fp/"$morph_name"_vcf_files --threads 10 -Ov | bgzip -c > $GWAS_in_fp/"$morph_name"_Allsites-filtered-sorted.vcf.gz

#index
tabix -f -p vcf  $GWAS_in_fp/"$morph_name"_Allsites-filtered-sorted.vcf.gz
