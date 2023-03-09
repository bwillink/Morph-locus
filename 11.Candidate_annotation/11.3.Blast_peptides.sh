#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other reference assemblies
morph_short=Afem # change for other reference assemblies

# data output and software file paths
data_fp=/path/to/$morph/output/Candidate_annotation
out_fp=$data_fp

cd $out_fp

blastp -query "$morph_short"_all_incomplete_prot.fa -db swissprot \
       -out "$morph_short"_all_incomplete_blastp_uniprot_sptrembl.txt \
       -outfmt 7 -evalue 0.00001 \
       -gapopen 11 -gapextend 1 \
       -word_size 3 -matrix BLOSUM62 \
       -max_target_seqs 20 -num_threads 20

