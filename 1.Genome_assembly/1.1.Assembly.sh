#!/bin/bash/

# create variables
morph=Afem_1354 # substitute for other assemblies
run= 1 # substitute for other configuration files

Data_dir=./data/raw/path/to/morph/data/fastq_pass/
Out_dir=./output/Shasta_Run"$run"

data="$morph"_pass.fastq
config=ISCH_T"$run".conf

# create output directory
mkdir $Out_dir

# run assembler
shasta-Linux-0.7.0 --assemblyDirectory $Out_dir --config ./source/$config --input $Data_dir/$data

# assembly statistics
bbmap/stats.sh ./$Out_dir/Assembly.fasta > ./$Out_dir/Shasta"$run"_bbmap_stats.txt


# gene completeness
export BUSCO_CONFIG_FILE=/mnt/griffin/beawil/software/busco_config/config.ini


# define datasets
genome=Assembly.fasta
library=insecta_odb10
outfile="$genome"_insecta_odb10

# Run BUSCO
python3 busco -i ./$Out_dir/$genome -l $library -m genome -o ./$Out_dir/$outfile -c 40

