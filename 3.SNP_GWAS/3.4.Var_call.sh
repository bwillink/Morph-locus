#!/bin/bash

# morph of the reference asembly
morph=Afem_1354 # change for other assemblies

# morph name in assembly file
morph_name=A1354

#file paths
data_fp="/path/to/$morph/output/GWAS_preprocess"
out_fp="/path/to/$morph/output/Var_call/'$morph_name'_scaffolds_allsites"

# reference
REF_fp=/path/to/$morph/output/RagTag # change for DToL
REF="$morph_name"_ragtag.fa # change for DToL

# get scaffold ids
grep '>' $REF_fp/$REF | sed 's/>//g' > $data_fp/"$morph"_scaffolds_ids

# index the genome assembly
samtools faidx $REF_fp/$REF

# list of samples
sample="samples_bcf"

# run mpilup to generate vcf format
cat $data_fp/"$morph"_scaffolds_ids |parallel -j 25 "bcftools mpileup -Ou \
                                                            --threads 2 --ff DUP -f $REF_fp/$REF -r {} \
                                                            $data_fp/TE-2564-SwD108_S67_marked_duplicates.bam \ # could not give file names in a txt file
                                                            $data_fp/TE-2564-SwD136_S46_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD138_S47_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD143_S68_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD149_S35_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD152_S64_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD153_S65_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD170_S36_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD172_S37_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD174_S55_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD178_S56_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD19_S52_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD191_S39_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD21_S53_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD215_S62_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD216_S63_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD238_S49_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD240_S66_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD242_S50_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD243_S51_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD257_S69_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD263_S57_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD27_S38_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD283_S40_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD288_S54_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD29_S41_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD308_S44_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD309_S45_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD31_S42_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD32_S43_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD51_S58_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD55_S59_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD57_S60_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD65_S48_marked_duplicates.bam \
                                                            $data_fp/TE-2564-SwD67_S61_marked_duplicates.bam \
                                                            $data_fp/UE-2969-57120_S90_marked_duplicates.bam \
                                                            $data_fp/UE-2969-57123_S82_marked_duplicates.bam \
                                                            $data_fp/UE-2969-57210_S81_marked_duplicates.bam \
                                                            $data_fp/UE-2969-57263_S78_marked_duplicates.bam \
                                                            $data_fp/UE-2969-57302_S83_marked_duplicates.bam \
                                                            $data_fp/UE-2969-57359_S84_marked_duplicates.bam \
                                                            $data_fp/UE-2969-57373_S85_marked_duplicates.bam \
                                                            $data_fp/UE-2969-57560_S86_marked_duplicates.bam \
                                                            $data_fp/UE-2969-57561_S87_marked_duplicates.bam \
                                                            $data_fp/UE-2969-57584_S97_marked_duplicates.bam \
                                                            $data_fp/UE-2969-57846_S98_marked_duplicates.bam \
                                                            $data_fp/UE-2969-57945_S88_marked_duplicates.bam \
                                                            $data_fp/UE-2969-58013_S91_marked_duplicates.bam \
                                                            $data_fp/UE-2969-58733_S92_marked_duplicates.bam \
                                                            $data_fp/UE-2969-59008_S89_marked_duplicates.bam \
                                                            $data_fp/UE-2969-60117_S80_marked_duplicates.bam \
                                                            $data_fp/UE-2969-60681_S93_marked_duplicates.bam \
                                                            $data_fp/UE-2969-61106_S79_marked_duplicates.bam \
                                                            $data_fp/UE-2969-61346_S99_marked_duplicates.bam \
                                                            $data_fp/UE-2969-61361_S94_marked_duplicates.bam \
                                                            $data_fp/UE-2969-Sw1118_S96_marked_duplicates.bam \
                                                            $data_fp/UE-2969-Sw469_S95_marked_duplicates.bam | \
bcftools call -m -Ob -f GQ --threads 2 -o $out_fp/"$morph_name"_Allsites{}.bcf"


