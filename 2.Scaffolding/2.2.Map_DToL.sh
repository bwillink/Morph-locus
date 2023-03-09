#!/bin/bash

# Afem reference
REF="./Afem_1354/output/RagTag/A1354_ragtag.fa"                                                                              

# path to data files
data_fp="./ToL/data"
# output file path
out_fp="./ToL/output/"


# map ToL data to Afem reference
minimap2 -ax map-pb $REF $data_fp/ERR*fastq.gz | \
         samtools view -bS -F4 -q 60 | \
         samtools sort -o $out_fp/ToL_Afem_aln_sorted.bam

samtools index $out_fp/ToL_Afem_aln_sorted.bam -@ 5

