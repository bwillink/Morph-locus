#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other reference assemblies
morph_short=Afem # change for other reference assemblies


# define data and output directories
DATA_fp="/path/to/$morph/output/Stringtie_transcripts_Isen"
OUT_fp="/path/to/$morph/output/Stringtie_transcripts_Isen/count"
ANNOT_fp="/path/to/$morph/output//Stringtie_transcripts_Isen/Isen"

#samples
sample=("DRR278566" "DRR278567" "DRR278568" "DRR278569" "DRR278570" "DRR278571" "DRR278572" "DRR278573" "DRR278574" "DRR278575" "DRR278576" "DRR278577" "DRR278578" "DRR278579" "DRR278580" "DRR278581" "DRR278582" "DRR278583" "DRR278584" "DRR278585" "DRR278586" "DRR278587" "DRR278588" "DRR278589")


# count transcripts 
for j in ${sample[@]};
do
  mkdir $OUT_fp/$j
  stringtie $DATA_fp/"$j".bam \
            -o $OUT_fp/$j/"$j".gtf \
            -G $ANNOT_fp/Isen.gtf \
            -e -B -p 8 \
            # defautl options
            -m 200 -a 10 -j 1 -c 1 -g 50 -M 0.95
done


cd $OUT_fp

# create count matrices
python3 prepDE.py3
