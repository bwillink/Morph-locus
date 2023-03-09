#!/bin/bash

data_fp="/path/to/raw/data"
out_fp="/path/to/data/processed/trimmed_reads/"

Samples and lanes
sample="$(cat "/path/to/data/samples_ID_batch1")" # channge for second batch of sequencing
lane=("L001" "L002" "L003" "L004") # channge to L003 for second batch of sequencing

for j in ${sample[@]};
do
  echo starting sample directory
  echo "${j}"
    
  # cut last part of sample name to match directory names
  temp=${j%_*}
  echo $temp

  for k in ${lane[@]};
  do
  fastp \
     --in1 "$data_fp"/Sample_"$temp"/"$j"_"$k"_R1_001.fastq.gz \
     --out1 "$out_fp"/"$j"_"$k"_R1_001.trimmed.fq.gz \
     --in2 "$data_fp"/Sample_"$temp"/"$j"_"$k"_R2_001.fastq.gz \
     --out2 "$out_fp"/"$j"_"$k"_R2_001.trimmed.fq.gz \
     --thread 16
  done
done
