#!/bin/bash

# output file path
out_fp="./output"

# morphs to compare
comp=AO # substitute for other comparisons

# phenotypic values for samples usedin each comparison
phentypes= phenotypes_"$comp".pheno 

# run GWAS
python2.7 /mnt/griffin/beawil/software/kmers_gwas.py --pheno ${out_fp}/$phenotypes \
                                                     --kmers_table ${out_fp}/kmers31_table -l 31 -p 40 -k 1000000 \
                                                     --outdir ${out_fp}/results31_"$comp" \
                                                     --gemma_path /mnt/griffin/beawil/software/gemma-0.98.5-linux-static-AMD64

