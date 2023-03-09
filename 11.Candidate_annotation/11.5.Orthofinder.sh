#!/bin/bash

data_fp="/path/to/ToL/data/proteomes"

# Extract the longest transcript variant per gene
for f in $data_fp/*.fa* ; do python primary_transcript.py $f ; done                                                                                         

# Run orthofinder
orthofinder -f $data_fp/primary_transcripts/ -t 30 -a 5
