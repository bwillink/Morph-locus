#!/bin/bash

comp=AO # substitute for other comparisons

cd ./output/blast_out

# softlink to genome
ln -s /path/to/reference/genome # substitute depending on the analysis

# blast for short sequences
REF="Afem_1354_ragtag.fa" # substitute depending on the analysis


# make the db
ncbi-blast-n-rmblast-2.2.28+/makeblastdb -in "$REF" -dbtype nucl

# blast
query="$comp"_kmers.fa
database="$REF"

# short sequence
ncbi-blast-n-rmblast-2.2.28+/blastn -task blastn-short -query "$query" -db "$database" -evalue 0.01 -out "$query"_v_"${database%%.*}".tsv -outfmt 6 -max_target_seqs 5 -num_threads 40

#filter by identity
awk -F"\t" '{if ($3 >99 && $4 >30 ) print $0,$2,$9}' "$query"_v_"${database%%.*}".tsv > "$query"_v_"${database%%.*}"_table.tsv


