#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other reference assemblies
morph_name=A1354 # change for other reference assemblies
morph_short=A # change for other reference assemblies

# path to files bam files
data_fp=out_fp="/path/to/$morph/output/longread_mapping"

# path to output
out_fp="/path/to/$morph/output/Sniffles_call"

# reference
REF="/path/to/$morph/output/RagTag/"$morph_name"_ragtag.fa"

cd $out_fp

sample=("Ifem1049" "Ofem0081") # change for other comparisons

for j in ${sample[@]};
do
  # generate MD tag
  samtools calmd -b $data_fp/"$j"_"$morph_name"_aln_sorted.bam $REF SUPER_13_unloc_2_RagTag > $out_fp/"$j"_"$morph_name"_md.bam
  
# call variants on every sample
  sniffles -m $out_fp/"$j"_"$morph_name"_md.bam -q 20 -r 2000 -s 10 -l 100 -v $out_fp/"$j"_"$morph_name"_sniffles.vcf
  cat $out_fp/"$j"_"$morph_name"_sniffles.vcf | grep "SUPER_13_unloc_2" > $out_fp/"$j"_"$morph_name"_SUPER13_2_sniffles.vcf
done
