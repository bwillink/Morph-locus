#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other assemblies
morph_name=A1354 # change for other assemblies

# reference
REF=/path/to/$morph/output/RagTag/"$morph_name"_ragtag.fa                                                                              

# path to data files
data_fp="/path/to/poolseq/data/"

# output file path
out_fp="/path/to/$morph/output/pool_mapping"

sample=("wHADPI032623-101" "wHADPI032624-90")

# map pool seq data
for j in ${sample[@]};
do  
  bwa mem -M -t 20 $REF $data_fp/FCH7L3LBBXX_L8_"$j"_1.fq.gz $data_fp/FCH7L3LBBXX_L8_"$j"_2.fq.gz | \
  samtools view -bS -F4 -q 20 | \
  samtools sort -m 1G -@ 5 -o $out_fp/"$j"_"$morph_name".bam

  samtools index $out_fp/"$j"_"$morph_name".bam
done

