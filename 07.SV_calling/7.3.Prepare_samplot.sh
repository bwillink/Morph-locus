#!/bin/bash/

# morph to use as reference
morph=Ofem_0081 # change for other reference assemblies
morph_short=O

# go to directory with bam files
cd /path/to/$morph/output/GWAS_preprocess

# filter scaffold

sample="$(cat "/path/to/data/samplesID_batch1" "/path/to/data/samplesID_batch2")"

for j in ${sample[@]};
do
  samtools view -bS -F4 -q20 SUPER_13_unloc_2_RagTag "$j".bam > ../"$morph"_filtered/"$j"_SUPER_13_unloc_2.bam
  samtools index ../"$morph"_fitered/"$j"_SUPER_13_unloc_2.bam
done

# merge bams of each morph
cd ../"$morph"_filtered


# A females
samtools merge -1 A_to_"$morph_short".bam \
TE-2564-SwD136_S46_SUPER_13_unloc_2.bam \
TE-2564-SwD138_S47_SUPER_13_unloc_2.bam \
TE-2564-SwD149_S35_SUPER_13_unloc_2.bam \
TE-2564-SwD170_S36_SUPER_13_unloc_2.bam \
TE-2564-SwD191_S39_SUPER_13_unloc_2.bam \
TE-2564-SwD238_S49_SUPER_13_unloc_2.bam \
TE-2564-SwD242_S50_SUPER_13_unloc_2.bam \
TE-2564-SwD243_S51_SUPER_13_unloc_2.bam \
TE-2564-SwD27_S38_SUPER_13_unloc_2.bam \
TE-2564-SwD283_S40_SUPER_13_unloc_2.bam \
TE-2564-SwD29_S41_SUPER_13_unloc_2.bam \
TE-2564-SwD308_S44_SUPER_13_unloc_2.bam \
TE-2564-SwD309_S45_SUPER_13_unloc_2.bam \
TE-2564-SwD31_S42_SUPER_13_unloc_2.bam \
TE-2564-SwD32_S43_SUPER_13_unloc_2.bam \
TE-2564-SwD65_S48_SUPER_13_unloc_2.bam \
UE-2969-57584_S97_SUPER_13_unloc_2.bam \
UE-2969-57846_S98_SUPER_13_unloc_2.bam \
UE-2969-61346_S99_SUPER_13_unloc_2.bam

# I females
samtools merge -1 I_to_"$morph_short".bam \
TE-2564-SwD108_S67_SUPER_13_unloc_2.bam \
TE-2564-SwD143_S68_SUPER_13_unloc_2.bam \
TE-2564-SwD152_S64_SUPER_13_unloc_2.bam \
TE-2564-SwD153_S65_SUPER_13_unloc_2.bam \
TE-2564-SwD172_S37_SUPER_13_unloc_2.bam \
TE-2564-SwD174_S55_SUPER_13_unloc_2.bam \
TE-2564-SwD178_S56_SUPER_13_unloc_2.bam \
TE-2564-SwD19_S52_SUPER_13_unloc_2.bam \
TE-2564-SwD21_S53_SUPER_13_unloc_2.bam \
TE-2564-SwD215_S62_SUPER_13_unloc_2.bam \
TE-2564-SwD216_S63_SUPER_13_unloc_2.bam \
TE-2564-SwD240_S66_SUPER_13_unloc_2.bam \
TE-2564-SwD257_S69_SUPER_13_unloc_2.bam \
TE-2564-SwD263_S57_SUPER_13_unloc_2.bam \
TE-2564-SwD288_S54_SUPER_13_unloc_2.bam \
TE-2564-SwD51_S58_SUPER_13_unloc_2.bam \
TE-2564-SwD55_S59_SUPER_13_unloc_2.bam \
TE-2564-SwD57_S60_SUPER_13_unloc_2.bam \
TE-2564-SwD67_S61_SUPER_13_unloc_2.bam

# O females

samtools merge -1 O_to_"$morph_short".bam \
UE-2969-57120_S90_SUPER_13_unloc_2.bam \
UE-2969-57123_S82_SUPER_13_unloc_2.bam \
UE-2969-57210_S81_SUPER_13_unloc_2.bam \
UE-2969-57263_S78_SUPER_13_unloc_2.bam \
UE-2969-57302_S83_SUPER_13_unloc_2.bam \
UE-2969-57359_S84_SUPER_13_unloc_2.bam \
UE-2969-57373_S85_SUPER_13_unloc_2.bam \
UE-2969-57560_S86_SUPER_13_unloc_2.bam \
UE-2969-57561_S87_SUPER_13_unloc_2.bam \
UE-2969-57945_S88_SUPER_13_unloc_2.bam \
UE-2969-58733_S92_SUPER_13_unloc_2.bam \
UE-2969-59008_S89_SUPER_13_unloc_2.bam \
UE-2969-60117_S80_SUPER_13_unloc_2.bam \
UE-2969-60681_S93_SUPER_13_unloc_2.bam \
UE-2969-61106_S79_SUPER_13_unloc_2.bam \
UE-2969-61361_S94_SUPER_13_unloc_2.bam \
UE-2969-Sw1118_S96_SUPER_13_unloc_2.bam \
UE-2969-Sw469_S95_SUPER_13_unloc_2.bam

