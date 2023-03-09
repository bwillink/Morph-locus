#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other assemblies
morph_name=A1354 # change for other assemblies

# file paths
data_fp=/path/to/pixy/data
out_fp=/path/to/pixy/output

fn="$morph_name"-ragtag-allsites-pixy-filtered-sorted

VCF="$data_fp/$fn".vcf.gz

# repeat annotations
rep_masker=/path/to/$morph/output/"$morph_name"_repeatmasker/"$morph_name"_ragtag_UPPER.fa.out.gff
RED=/path/to/$morph/output/RED/"$morph_name"_ragtag_RED.bed

bedtools intersectBed -a $VCF \
                      -b $rep_masker $RED \
                      -v -header > $data_fp/"$fn"-norepeat.vcf.gz
