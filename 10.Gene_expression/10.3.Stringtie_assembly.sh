#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other reference assemblies
sample_name=A1354 # change for other reference assemblies
morph_short=Afem # change for other reference assemblies

# path to genome
REF=/path/to/$morph/output/RagTag/"$sample_name"_ragtag.fa


# define data and output directories
DATA_fp="/path/to/$morph/output/rnaseq_mapping"
OUT_fp="/path/to/$morph/output/Stringtie_transcripts"

#samples
sample="$(cat "/path/to/data/lund_samples")"

for j in ${sample[@]};
do
  stringtie $DATA_fp/"$j".bam \
            -o $OUT_fp/"$j".gtf \
           -f 0.01 -m 200 -a 10 -j 1 -c 1 -g 50 -M 0.95 -p 8 \
           -l $morph_short
done

ls $OUT_fp/SJ*.gtf > $OUT_fp/mergelist.txt


stringtie $OUT_fp/mergelist.txt --merge \
            -o $OUT_fp/"$morph_short"/"$morph_short"_all_ragtag.gtf \
            -l $morph_short

