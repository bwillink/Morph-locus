#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other assemblies
morph_name=A1354 # change for other assemblies

#file paths
data_fp=/path/to/$morph/output/Var_call/'$morph_name'_scaffolds_allsites
out_fp=/path/to/$morph/output/Var_call/"$morph"_scaffolds_filtered_pixy

pogen_in_fp=/path/to/pogen/data

# get scaffold ids
grep '>' $data_fp/$REF | sed 's/>//g' > $data_fp/"$morph"_scaffolds_ids


# list of samples
sample="samples_bcf"


#get file list
cat $data_fp/"$morph"_scaffolds_ids \
| sed -E 's/(.*)/\/path\/to\/'$morph'\/output\/Var_call\/'$morph_name'_scaffolds_filtered_pixy\/'$morph_name'_Allsites\1-filtered-sorted.vcf/g' \
> $data_fp/vcf_pixy_files


#Filter snps
cat $data_fp/"$morph"_scaffolds_ids | \
parallel -j 25 "bcftools filter -i 'INFO/MQ>20 & INFO/DP<1360' -g 3 -Ov --threads 2 $out_fp/'$morph_name'_ragtag_Allsites{}.bcf | 

#Sort and zip
bcftools sort -Ov -T $out_fp/pixy{} -o $out_fp/'$morph_name_ragtag_Allsites-pixy{}-filtered-sorted.vcf"

#concatenate into one vcf 
bcftools concat -f $out_fp/vcf_pixy_files --threads 10 -Ov | bgzip -c > $pogen_in_fp/"$morph_name"-ragtag-allsites-pixy-filtered-sorted.vcf.gz

#index
tabix -f -p vcf $pogen_in_fp/"$morph_name"-ragtag-allsites-pixy-filtered-sorted.vcf.gz

