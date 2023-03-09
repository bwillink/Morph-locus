#!/bin/bash

# output file path
out_fp="./output"

# calculate kinship matrix
emma_kinship_kmers -t ${out_fp}/kmers31_table -k 31 --maf 0.05 > ${out_fp}/kmers31_table.kinship


