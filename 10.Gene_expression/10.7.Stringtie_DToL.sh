#!/bin/bash

# path to genome
REF=./ToL/data/processed/oIscEleg1.1.primary.fa


# define data and output directories
DATA_fp="/path/to/$morph/output/ToL_rnaseq_mapping"
OUT_fp="/path/to/$morph/output/ToL_Stringtie_transcripts"
ANNOT_fp="/path/to/$morph/output/ToL_Stringtie_transcripts/ToL_expression"


# samples
sample="$(cat "/path/to/data/lund_samples")"

# assemble transcripts without inferring new ones (-e option)
for j in ${sample[@]};
do
  stringtie $DATA_fp/"$j".bam \
           -o $OUT_fp/"$j".gtf \
           -f 0.01 -m 200 -a 10 -j 1 -c 1 -g 50 -M 0.95 -p 8 \
           -G $REF_fp/ToL_annot_renamed.gtf -e
done

ls $OUT_fp/SJ*.gtf > $OUT_fp/mergelist.txt


stringtie $OUT_fp/mergelist.txt --merge \
            -o $OUT_fp/ToL_expression/ToL_emode.gtf


# quantify expression
for j in ${sample[@]};
do
  mkdir $OUT_fp/$j
  stringtie $DATA_fp/"$j".bam \
            -o $OUT_fp/$j/"$j".gtf \
            -G $ANNOT/ToL_emode.gtf \
            -e -B -p 8 \
            # defautl options
            -m 200 -a 10 -j 1 -c 1 -g 50 -M 0.95
done

cd $OUT_fp

# create count matrices
python3 prepDE.py3



