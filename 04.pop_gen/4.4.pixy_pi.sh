#!/bin/bash

# morph to use as reference
morph=A1354 # change for other assemblies

# file paths
data_fp=/path/to/popgen/data
out_fp=/path/to/popgen/output


cd $data_fp

VCF="$morph"-ragtag-allsites-pixy-filtered-sorted-norepeat.vcf.gz
tabix $morph

window=30000


cd $out_fp

# estimate pi
pixy --stats pi \
     --vcf $data_fp/$VCF \
     --populations $data_fp/SwD_onepop \
     --window_size $window \
     --n_cores 20 \
     --output_folder "$morph"+window_"$window" \
     --output_prefix "$morph"_"$window"_onepop
