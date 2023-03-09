#!/bin/bash

# morph to use as reference
morph=A1354 # change for other assemblies

# file paths
data_fp=/path/to/popgen/data
out_fp=/path/to/popgen/output

# my vcf
fn="$morph"-ragtag-allsites-pixy-filtered-sorted-norepeat

VCF="$data_fp/$fn".vcf.gz
window=30000

vcftools --gzvcf $VCF --TajimaD window --out $out_fp/"$morph"_"$window"

