#!/bin/bash

# morph to use as reference
morph=Ofem_0081 # change for other reference assemblies
morph_short=O

# variables for output file name
region="1-30K" # change to plot other regions
ref=$morph_short
samples=all # change if only plotting individual samples

# variables for plotting window
start=3500 # change to plot other regions
end=23500 # change to plot other regions
SV_type="INV" # change to highlight other SVs

cd /path/to/$morph/output/SV

time samplot plot \
    -n I-females A-females O-females \
    -b ../"$morph"_filtered/I_to_"$morph_short".bam \
       ../"$morph"_filtered/A_to_"$morph_short".bam \
       ../"$morph"_filtered/O_to_"$morph_short".bam \
    -o SUPER_13_unloc_2_"$ref"_"$region"_"$samples".svg \
    -c SUPER_13_unloc_2_RagTag \
    --same_yaxis_scales \
    --dpi 600 \
    -H 4 \
    -W 4 \
    -s "$start" \
    -e "$end" \
    -q 20 \
    -w 4000 \
    -t "$SV_type" 

