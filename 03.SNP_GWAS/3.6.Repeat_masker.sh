#!/bin/bash

# morph to use as reference
morph=Afem_1354 # change for other assemblies
morph_name=A1354 # change for other assemblies

# names for raw and upper case genomes
rawgenome="$morph_name"_ragtag.fa
upgenome="$morph_name"_ragtag_UPPER.fa

data_fp="/path/to/$morph/output/RagTag"
cd "$data_fp"

# change all letters to uppercase
awk '{{ if ($0 !~ />/) {{print toupper($0)}} else {{print $0}} }}' "$data_fp"/$rawgenome > "$data_fp"/$upgenome


cd /path/to/$morph/output/"$morph"_repeatmodeler/


# Build repeat database
BuildDatabase -engine ncbi -name ${rawgenome%.fasta} "$data_fp"/$upgenome

# Run RepeatModeler
RepeatModeler -engine ncbi -LTRStruct -pa 19 -database ${rawgenome%.fasta} >& "$morph_name"_RM.log


cd ../

mkdir "$morph_name"_repeatmasker/
cd "$morph_name"_repeatmasker/

# Run RepeatMasker
RepeatMasker -cutoff 225 -pa 19 -a -xsmall -gccalc -gff -dir ./ -lib ../"$morph_name"_repeatmodeler/${rawgenome%.fasta}-families.fa "$data_fp"/$upgenome
