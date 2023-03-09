#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other reference assemblies
sample_name=A1354 # change for other reference assemblies

# path to genome
REF=/path/to/$morph/output/RagTag/"$sample_name"_ragtag.fa


# define data and output directories
DATA_fp="/path/to/data/raw/RNAseq/SJ-2341/200409_A00605_0119_AHLVHFDRXX"
OUT_fp="/path/to/$morph/output/rnaseq_mapping"

#samples
sample="$(cat "/path/to/data/lund_samples")"

# create index
cd $OUT_fp
hisat2-build -p 20 "$REF_fp"/"$REF" "$OUT_fp"/genome

# map and filter reads
for j in ${sample[@]};
do
  dr=${j%_*}
  hisat2 -x "$OUT_fp"/genome \
  -1 "$DATA_fp"/Sample_"$dr"/"$j"_L001_R1_001.fastq.gz,"$DATA_fp"/Sample_"$dr"/"$j"_L002_R1_001.fastq.gz \
  -2 "$DATA_fp"/Sample_"$dr"/"$j"_L001_R2_001.fastq.gz,"$DATA_fp"/Sample_"$dr"/"$j"_L002_R2_001.fastq.gz \
  -S "$OUT_fp"/"$j".sam \
 -p 20 --dta --fr --time

  samtools view -bS -F4 -q 60 "$OUT_fp"/"$j".sam | samtools sort -m 2G -@ 20 -o "$OUT_fp"/"$j".bam

done

# remove uncompressed files for space
rm $OUT_fp/*.sam

