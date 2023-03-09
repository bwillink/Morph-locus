#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other reference assemblies
morp_name=A1354 # change for other reference assemblies
morph_short=Afem # change for other reference assemblies

# data and output file paths
vdf_fp=/path/to/pogen/data
out_fp=/path/to/$morph/output/Candidate_annotation

cd $out_fp

gtf="$morph_short"_all_transcripts.transdecoder.genome.gff3

# filter cds of three candidate genes
cat $gtf | awk '{ if ($3 == "CDS") { print } }' | grep  "Afem.4093.5\|Afem.4111.2\|Afem.4119.1" | cut -f 1,4,5,9 > candidate_cds.bed

bcftools view $vcf_fp/"$morph_name"-ragtag-allsites-pixy-filtered-sorted.vcf.gz -R $out_fp/candidate_cds.bed -O v -o "$morph_name"-ragtag-allsites-candidate_gene_cds.vcf

bgzip "$morph_name"-ragtag-allsites-candidate_gene_cds.vcf -c > "$morph_name"-ragtag-allsites-candidate_gene_cds.vcf.gz

tabix -f -p vcf "$morph_name"-ragtag-allsites-candidate_gene_cds.vcf.gz

