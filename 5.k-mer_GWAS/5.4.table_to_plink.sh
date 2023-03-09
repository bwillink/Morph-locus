#!/bin/bash

# define output directory
out_fp="./output"

cd $out_fp

# phenotypic values for samples usedin each comparison
phentypes= phenotypes_AO.pheno # substitute .pheno file for other comparisons

# condense the kmers table to phenotypes.pheno file
kmers_table_to_bed -t kmers31_table -k 31 -p $phenotypes --maf 0.5 --mac 1 -b 100000000 -o output_file

