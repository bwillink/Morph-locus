#!/bin/bash

# morph to use as new reference
morph_n=Afem_1354 # change for other reference assemblies
morph_n_short=A

# morph used as original reference
morph_o=Ofem_0081 # change for other reference assemblies
morph_o_short=O

# variables

SV_loc="3K" # change to 22K for the second break point

breakpoint="3650-3950" # change to 22550-22850 for the second break point


cd /path/to/$morph_o/output/SV

# sample names
sample="$(cat "/path/to/data/samplesID_batch1" "/path/to/data/samplesID_batch2")"

for j in ${sample[@]};
do

  # get reads mapped to the original reference
  samtools view /path/to/$morph_o/output/"$morph_o"_filtered/"$j"_SUPER_13_unloc_2.bam SUPER_13_unloc_2_RagTag:"$breakpoint" | \

  # get read names
  grep "^[^@;]" | cut -f 1 > "$morph_n_short"v"$morph_o_short"_"$SV_loc"_reads.txt

  # Find reads in alignment to new assembly 
  samtools view /path/to/$morph_n/output/"$morph_n"_filtered/"$j"_SUPER_13_unloc_2.bam | grep -f "$morph_n_short"v"$morph_o_short"_"$SV_loc"_reads.txt_reads.txt | \

 # cut starting positions and add sample name
  awk '{ if ($5 >= 20) { print } }'| cut -f 4 | sort | sed "s/$/\t"$j"/" >> "$morph_n_short"v"$morph_o_short"_"$SV_loc".tsv

done

