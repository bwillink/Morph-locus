#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other reference assemblies
sample_name=A1354 # change for other reference assemblies
morph_short=Afem # change for other reference assemblies


# define data and output directories
DATA_fp="/path/to/$morph/output/rnaseq_mapping_Isen"
OUT_fp="/path/to/$morph/output/Stringtie_transcripts_Isen"

#samples
sample=("DRR278566" "DRR278567" "DRR278568" "DRR278569" "DRR278570" "DRR278571" "DRR278572" "DRR278573" "DRR278574" "DRR278575" "DRR278576" "DRR278577" "DRR278578" "DRR278579" "DRR278580" "DRR278581" "DRR278582" "DRR278583" "DRR278584" "DRR278585" "DRR278586" "DRR278587" "DRR278588" "DRR278589")

for j in ${sample[@]};
do
  stringtie $DATA_fp/"$j".bam \
            -o $OUT_fp/"$j".gtf \
           -f 0.01 -m 200 -a 10 -j 1 -c 1 -g 50 -M 0.95 -p 8 \
           -l Isen
done

ls $OUT_fp/DRR*.gtf > $OUT_fp/mergelist_Isen.txt

stringtie $OUT_fp/mergelist_Isen.txt --merge \
            -o $OUT_fp/Isen/Isen.gtf \
            -l Isen \
            -f 0.01 -m 50 -c 1 -F 0 -T 0
            -G  $OUT_fp/"$morph_short"_all/"$morph_short"_ragtag.gtf


