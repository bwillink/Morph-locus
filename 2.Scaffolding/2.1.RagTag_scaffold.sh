#!/bin/bash

REF_fp=./ToL/data/processed
REF=ioIscEleg1.1.primary.fa

# morph assembly to scaffold
morph=Afem_1354 # substitute for other morphs
sample_name=A1354 # substitute for other morphs
run=1 # substitute for other Shasta runs


query_fp=./$morph/output/Shasta"$run"_Pepper_purgedups_polca
query=A1354_Shasta_run"$run".PMDV.HAP1.purged.fa.PolcaCorrected.fa
out_fp=./$morph/output/RagTag


python3 ragtag.py scaffold $REF_fp/$REF $query_fp/$query  \
        -o $out_fp/"$morph"_ragtag \
        -u -f 1000 -d 100000 -r \
        --aligner $nucmer_fp --nucmer-params '-l 100 -c 500'
