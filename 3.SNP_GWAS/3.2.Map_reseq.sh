#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other reference assemblies
sample_name=A1354 # change for other reference assemblies

# path to genome
REF=/path/to/$morph/output/RagTag/"$sample_name"_ragtag.fa

# create index
bwa index $REF

# path to trimmed reads
data_fp="/path/to/data/processed/trimmed_reads"

# path to output
out_fp="/path/to/$morph/output/reseq_mapping/"

#samples and lanes
sample="$(cat "/path/to/data/samplesID_batch1")" # change to batch2 to second batch of sequencing
lane=("L001" "L002" "L003" "L004") # change to L003 for second batch of sequencing

for j in ${sample[@]};
do
  for k in ${lane[@]};
  do
  # map fastq data, then pipe into samtools, fitering on mapped and MAPQ20 …
  # default samtools is Version: 1.10 (using htslib 1.10)
  bwa mem -M -t 20 "${REF}" "$data_fp"/"$j"_"$k"_R1_001.trimmed.fq.gz "$data_fp"/"$j"_"$k"_R2_001.trimmed.fq.gz \
  | samtools view -bS -F4 -q 20 \
  | samtools sort -m 1G -@ 5 -o "$out_fp"/"$j"_"$k".bam
  done
done 
