#!/bin/bash

# align genomes to each other to generate synteny plots
# https://mummer4.github.io/manual/manual.html
# list reference genome first, then query genome

# morph to use as reference
morph_r=Afem_1354 # change for other assemblies
morph_name_r=A1354 # change for other reference assemblies

# morph to use as query
morph_q=Ifem_1049 # change for other assemblies
morph_name_q=I1049 # change for other reference assemblies

# soft link genome assemblies
ln -s /path/to/$morph_r/output/RagTag/"$morph_name_r"_ragtag.fa
ln -s /path/to/$morph_q/output/RagTag/"$morph_name_q"_ragtag.fa

# genomes
Reference="$morph_name_r"_ragtag.fa

Query="$morph_name_q"_ragtag.fa

Prefix=nucmer_aln_"$morph_name_q"_"$morph_name_r"

# generating contig list
grep '>' $Query | sed 's/>//' > query_contigs.txt
grep '>' $Reference | sed 's/>//' > Ref_contigs.txt

#  align with mummer
/data/programs/mummer-4.0.0beta2/nucmer --mum -c 100 -t 5 -p $Prefix $Reference $Query

# non default options
#      --mum                                Use anchor matches that are unique in both the reference and query (false)                                                                                     
#  -c, --mincluster=uint32                  Sets the minimum length of a cluster of matches (65)
#  -t, --threads=NUM                        Use NUM threads (# of cores)

# filter
/data/programs/mummer-4.0.0beta2/delta-filter -q -r -1 $Prefix.delta > $Prefix.qr1_filter.delta

# non default options
# -q            Maps each position of each query to its best hit in
#               the reference, allowing for reference overlaps
# -r            Maps each position of each reference to its best hit
#               in the query, allowing for query overlaps


/data/programs/mummer-4.0.0beta2/show-coords -r -c -l $Prefix.qr1_filter.delta > $Prefix.qr1_filter.coords

# get output for synteny plot
cat $Prefix.qr1_filter.coords | sed 1,5d | \
                               tr -s ' ' | \
                               awk 'BEGIN {FS=" "; OFS=","} {;print $1,$2,$4,$5,$7,$8,$10,$12,$13,$18,$19}' \
                               > $Prefix.qr1_filter.reformat.coords

