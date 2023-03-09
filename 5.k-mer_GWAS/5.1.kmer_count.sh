#!/bin/bash/

# path to external programs 
export PATH=/mnt/griffin/beawil/software/external_programs/:$PATH

# go to data directory
cd ./data

# put sample directories into an array
shopt -s nullglob
sample=(*/)
shopt -u nullglob

for j in ${sample[@]};
do

  cd ./data/"$j"
  # create a text file with paths to all samples
  ls -d $PWD/* | grep -E L00 > input_files.txt
  
  # run kmc with canonized counts
  kmc_v3 -t10 -k31 -ci2 @input_files.txt output_kmc_canon ./ 1> kmc_canon.1 2> kmc_canon.2
  # run kmc with no canonization
  kmc_v3 -t10 -k31 -ci0 -b @input_files.txt output_kmc_all ./ 1> kmc_all.1 2> kmc_all.2
  
  # combine information from both runs into one list of k-mers
  kmers_add_strand_information -c output_kmc_canon -n output_kmc_all -k 31 -o kmers_with_strand > ${j%?}.log
  
  # remove large kmc files after merging
  rm *.kmc*
 
  # remove .gz files to make space
 # rm *.gz
done
