#!/bin/bash

# create variables
morph=A1354 # substitute for other assemblies
run= 1 # substitute for other configuration files

Data_dir=./data/raw/path/to/morph/data/fastq_pass/
unpolished_dir=./output/Shasta_Run"$run"_Pepper
Out_dir=./output/Shasta_Run"$run"_Pepper_purgedups

REF="$unpolished_dir"/"$morph"_Shasta_run"$run".PMDV.HAP1.fasta
config=

#create output directory
mkdir $Out_dir
cd $Out_dir

ls $Data_dir > ont.fofn                                                     
                                                                                            
ontfofn="$Out_dir/ont.fofn"

# run configuration script
purge_dups/scripts/pd_config.py -l $Out_dir -n config.Shasta"$run"."$morph".asm1.json "$REF" "$ontfofn"

# run purgedups script
python3 run_purge_dups.py config.Shasta"$run"."$morph".asm1.json src $morph -p bash

# assembly statistics
bbmap/stats.sh ./$Out_dir/"$morph"_Shasta_run"$run".PMDV.HAP1/seqs/"$morph"_Shasta_run"$run".PMDV.HAP1.purged.fa > ./$Out_dir/"$morph"_Shasta_run"$run".PMDV.HAP1/seqs/Shasta"$run"_Pepper_purged_bbmap_stats.txt

# gene completeness
export BUSCO_CONFIG_FILE=/mnt/griffin/beawil/software/busco_config/config.ini


# define datasets
genome="$morph"_Shasta_run"$run".PMDV.HAP1.purged.fa
library=insecta_odb10
outfile="$morph"_Shasta"$run"_Pepper_purged_insecta_odb10

# Run BUSCO
python3 busco -i ./$Out_dir/"$morph"_Shasta_run"$run".PMDV.HAP1/seqs/$genome -l $library -m genome -o ./$Out_dir/"$morph"_Shasta_run"$run".PMDV.HAP1/seqs/$outfile -c 40
