#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other assemblies
morph_name=A1354 # change for other assemblies

# reference
REF=/path/to/$morph/output/RagTag/"$morph_name"_ragtag.fa                                                                              

# output file path
out_fp="/path/to/$morph/output/longread_mapping"

sample=("Afem_1354" "Ifem1049" "Ofem0081")

for j in ${sample[@]};
do
  # path to data files
  data_fp="/path/to/$j/raw/data/fastq_pass"

  # map long reads
  minimap2 -ax map-pb $REF $data_fp/*fastq.gz | \
           samtools view -bS -F4 -q 60 | \
           samtools sort -o $out_fp/"$j"_"$morph_name"_aln_sorted.bam

  samtools index $out_fp/"$j"_"$morph_name"_aln_sorted.bam -@ 5

done
