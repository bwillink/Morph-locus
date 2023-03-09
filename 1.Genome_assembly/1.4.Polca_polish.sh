#!/bin/bash/

# create variables
morph=A1354 # substitute for other assemblies
run= 1 # substitute for other configuration files

unpolished_dir=./output/Shasta_Run"$run"_Pepper_purgedups/"$morph"_Shasta_run"$run".PMDV.HAP1/seqs/
Out_dir=./output/Shasta_Run"$run"_Pepper_purgedups_polca

unpolished="$unpolished_dir"/"$morph"_Shasta_run"$run".PMDV.HAP1.purge.fa
config=

#create output directory
mkdir $Out_dir
cd $Out_dir

# add path to short read data and run polca script 
polca.sh -a $unpolished -r './data/raw/path/to/morph/data/_1.fq.gz ./data/raw/path/to/morph/data/_2.fq.gz' -t 40

# assembly statistics
bbmap/stats.sh ./$Out_dir/"$morph"_Shasta_run"$run".PMDV.HAP1.purged.fa > ./$Out_dir/"$morph"_Shasta_run"$run".PMDV.HAP1/seqs/Shasta"$run"_Pepper_purged_bbmap_stats.txt

# gene completeness
export BUSCO_CONFIG_FILE=/mnt/griffin/beawil/software/busco_config/config.ini


# define datasets
genome="$morph"_Shasta_run"$run".PMDV.HAP1.purged.fa.PolcaCorrected.fa
library=insecta_odb10
outfile="$morph"_Shasta"$run"_Pepper_purged_polca_insecta_odb10

# Run BUSCO
python3 busco -i ./$Out_dir/$genome -l $library -m genome -o ./$Out_dir/$outfile -c 40
