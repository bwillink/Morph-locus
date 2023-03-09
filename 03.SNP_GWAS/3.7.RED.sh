#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other assemblies
morph_name=A1354 # change for other assemblies

# reference
REF_fp=/path/to/$morph/output/RagTag # change for DToL
REF="$morph_name"_ragtag.fa # change for DToL

out_fp=/path/to/$morph/output/RED/

python redmask.py -i $REF_fp/$REF -o $out_fp/"$morph_name"_ragtag_RED.bed
