#!bin/bash

data_fp="./data"
out_fp="./output"


# create a file listing all k-mer list files, each lines includes a full path  {tab} and sample name
# for I. elegans samples
ls -l ${data_fp} | tail -n +2 | awk '{printf "/mnt/griffin/beawil/kmerGWAS/data/%s/kmers_with_strand\t%s\n", $NF,$NF}' > ${out_fp}/kmers31_list_paths.txt

# combine and filter the lists of kmers to one file
list_kmers_found_in_multiple_samples -l  ${out_fp}/kmers31_list_paths.txt -k 31 --mac 5 -p 0.2 -o ${out_fp}/kmers31_to_use

# create  the k-mers table
build_kmers_table -l ${out_fp}/kmers31_list_paths.txt -k 31 -a ${out_fp}/kmers31_to_use -o ${out_fp}/kmers31_table

