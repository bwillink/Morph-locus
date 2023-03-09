#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other reference assemblies
sample_name=A1354 # change for other reference assemblies

# path to genome
REF=/path/to/$morph/output/RagTag/"$sample_name"_ragtag.fa


# define data and output directories
DATA_fp="/path/to/data/raw/sra_data"
OUT_fp="/path/to/$morph/output/rnaseq_mapping_Isen"

cd $DATA_fp

prefetch DRR278566 DRR278567 DRR278568 DRR278569 DRR278570 DRR278571 DRR278572 DRR278573 DRR278574 DRR278575 DRR278576 DRR278577 DRR278578 DRR278579 DRR278580 DRR278581 DRR278582 DRR278583 DRR278584 DRR278585 DRR278586 DRR278587 DRR278588 DRR278589

sra_sample=("DRR278566" "DRR278567" "DRR278568" "DRR278569" "DRR278570" "DRR278571" "DRR278572" "DRR278573" "DRR278574" "DRR278575" "DRR278576" "DRR278577" "DRR278578" "DRR278579" "DRR278580" "DRR278581" "DRR278582" "DRR278583" "DRR278584" "DRR278585" "DRR278586" "DRR278587" "DRR278588" "DRR278589")

# download from NCBI
for i in ${sra_sample[@]};
do
  fasterq-dump "$DATA_fp"/"$i"/"$i".sralite
done

# compress
for i in `find | grep -E "*.fastq"`; do gzip "$i" ; done

# create index
cd $OUT_fp
hisat2-build -p 20 "$REF" $OUT_fp/genome

# map and filter
for j in ${sra_sample[@]};
do
  hisat2 -x "$OUT_fp"/genome \
  -1 "$DATA_fp"/"$j"_1.fastq* \
  -2 "$DATA_fp"/"$j"_2.fastq* \
  -S "$OUT_fp"/"$j".sam \
  -p 20 --dta --fr --time

 samtools view -bS -F4 -q 60 "$OUT_fp"/"$j".sam | samtools sort -m 2G -@ 20 -o "$OUT_fp"/"$j".bam

done

# remove uncompressed files for space
rm $OUT_fp/*.sam
