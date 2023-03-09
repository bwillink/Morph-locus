#!/bin/bash/

# morph to use as reference
morph=Afem_1354 # change for other assemblies
morph_name=A1354 # change for other assemblies

#file paths
data_fp=/path/to/$morph/output/"$morph"_repeatmasker/
out_fp=/path/to/$morph/output/repeats/

cd $out_fp

# build dictionary
build_dictionary.pl --rm $data_fp/Afem_1354_ragtag_UPPER.fa.out > dictionary_output.txt

# find TEs
one_code_to_find_them_all.pl --rm $data_fp/Afem_1354_ragtag_UPPER.fa.out --ltr dictionary_output.txt
