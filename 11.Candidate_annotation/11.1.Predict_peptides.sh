#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other reference assemblies
sample_name=A1354 # change for other reference assemblies
morph_short=Afem # change for other reference assemblies

# data output and software file paths
data_fp=/path/to/$morph/output/Stringtie_transcripts/"$morph_short"
out_fp=/path/to/$morph/output/Candidate_annotation

#Reference genome and morph
REF=/path/to/$morph/output/RagTag/"$sample_name"_ragtag.fa

cd $out_fp

# get fasta file with transcript sequences
gtf_genome_to_cdna_fasta.pl $data_fp/"$morph_short"_all_ragtag.gtf $REF > "$morph_short"_all_transcripts.fasta 

transfile="$morph_shrot"_all_transcripts.fasta 

# generate candidate ORF predictions
TransDecoder.LongOrfs -t $transfile

# Predict proteins
# if data set is small run with --no_refine_starts
TransDecoder.Predict -t $transfile --no_refine_starts

#convert gtf to gff3
gtf_to_alignment_gff3.pl "$morph_short"_all_ragtag.gtf > "$morph_short"_all_genes.gff3

# generate a genome-based coding region annotation file
cdna_alignment_orf_to_genome_orf.pl \
              "$morph_short"_all_transcripts.fasta.transdecoder.gff3 \
              "$morph_short"_all_genes.gff3 \
              $transfile > "$morph_short"_all_transcripts.transdecoder.genome.gff3

# get cds and proteins from this final annotation
gff_file="$morph_short"_all_transcripts.transdecoder.genome.gff3
root="$morph_short"_all

gffread "$gff_file" -g "$REF" -x "$root"_cds.fa -y "$root"_prot.fa -J 
gffread "$gff_file" -g "$REF" -x "$root"_incomplete_cds.fa -y "$root"_incomplete_prot.fa 

