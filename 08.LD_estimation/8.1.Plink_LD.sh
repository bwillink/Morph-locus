#!bin/bash/


# morph used as reference
morph=Afem_1354
morph_name=A1354

#file paths
data_fp=/path/to/$morph/output/Var_call/"$morph"_scaffolds_filtered
out_fp=/path/to/$morph/output/LD

# variables
chr=("SUPER_1" "SUPER_2" "SUPER_3" "SUPER_4" "SUPER_5" "SUPER_6" "SUPER_7" "SUPER_8" "SUPER_9" "SUPER_10" "SUPER_11" "SUPER_12" "SUPER_X" "SUPER_13" "SUPER_13_unloc_1" "SUPER_13_unloc_2" "SUPER_13_unloc_3" "SUPER_13_unloc_4")
prefix="$morph_name"_ragtag_Allsites
sufix=_RagTag-filtered-sorted


for j in ${chr[@]};
do

comp="$morph_name"_"$j"
fn="$prefix$j$sufix"

VCF="$data_fp/$fn".vcf

# thin vcf
vcftools --vcf $VCF --recode --recode-INFO-all --thin 1000  --chr "$j"_RagTag --from-bp 1 --to-bp 15000000 --out $data_fp/"$comp"_thin

thin_VCF="$data_fp/$comp"_thin.recode.vcf


# recode to create ped file
plink --vcf $thin_VCF --recode \
                      --allow-extra-chr --allow-no-sex \
                      --pheno $data_fp/phenotypes_"$comp".pheno \
                      --out $data_fp/"$comp"

#ld estimation
plink --file $data_fp/"$comp" \
      --allow-extra-chr --allow-no-sex \
      --r2 --out $out_fp/"$comp"_allr \
      --ld-window-kb 15000 \
      --ld-window-r2 0.05 \
      --ld-window 99999

done
