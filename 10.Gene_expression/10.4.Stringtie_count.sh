#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other reference assemblies
morph_short=Afem # change for other reference assemblies


# define data and output directories
DATA_fp="/path/to/$morph/output/Stringtie_transcripts"
OUT_fp="/path/to/$morph/output/Stringtie_transcripts/count"
ANNOT_fp="/path/to/$morph/output//Stringtie_transcripts/"$morph_short""

#samples
sample="$(cat "/path/to/data/lund_samples")"

# count transcripts 
for j in ${sample[@]};
do
  mkdir $OUT_fp/$j
  stringtie $DATA_fp/"$j".bam \
            -o $OUT_fp/$j/"$j".gtf \
            -G $ANNOT_fp/"$morph_short"_all_ragtag.gtf \
            -e -B -p 8 \
            # defautl options
            -m 200 -a 10 -j 1 -c 1 -g 50 -M 0.95
done


cd $OUT_fp

# create count matrices
python3 prepDE.py3
