#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other reference assemblies
sample_name=A1354 # change for other reference assemblies
morph_short=Afem # change for other reference assemblies

# data output and software file paths
data_fp=/path/to/$morph/output/Candidate_annotation
out_fp=$data_fp

cd $out_fp

# get cds and protein sequences of candidate genes
ln -s /path/to/$morph/output/Stringtie_transcripts/"$morph_short"/"$morph_short"_all_ragtag.gtf
cat Afem_all_ragtag.gtf | awk '{ if ($1 == "SUPER_13_unloc_2_RagTag" && $5 < 1600000) { print } }' | \
                          cut -f 9 | cut -f 2  -d " " | \
                          sort | uniq | \
                          sed 's/\"//g' | sed 's/;//g'> candidates.txt

seqtk subseq "$morph_short"_all_incomplete_cds.fa candidates.txt > "$morph_short"_candidate_cds.fa
seqtk subseq "$morph_short"_all_incomplete_prot.fa candidates.txt > "$morph_short"_candidate_prot.fa

# find cds in TDoL transcriptome                                                                                                  

cds=/path/to/ToL/data/processed/GCF_921293095.1_ioIscEleg1.1_rna.fna                                                                                              

# create database
makeblastdb -in $cds -dbtype nucl -title "ToL"

# then run blast
query="$morph_short"_candidate_cds.fa

blastn -query "${query}" -db "${cds}" -evalue 1 -out "${query}"_v_ToL_cds.tsv -outfmt 7 -num_threads 20

# find peptides in TDoL proteome                                                                                                  

proteome=/path/to/ToL/data/processed/GCF_921293095.1_ioIscEleg1.1_protein.faa.gz                                                                                             

# create database
makeblastdb -in $cds -dbtype prot -title "ToL"

# then run blast
query="$morph_short"_candidate_prot.fa

blastp -query "${query}" -db "${proteome}" -evalue 1 -out "${query}"_v_ToL_prot.tsv -outfmt 7 -num_threads 20

