#!/bin/bash/

# create variables
morph=Afem_1354 # substitute for other assemblies
run= 1 # substitute for other configuration files

Data_dir=./data/raw/path/to/morph/data/fastq_pass/
In_dir=./data/processed/path/to/morph/
unpolished_dir=./output/Shasta_Run"$run"
Out_dir=./output/Shasta_Run"$run"_Pepper


data="$morph"_pass.fastq.gz
BAM="$morph"_on_"$morph"
ASM="Assembly.fasta"
THREADS="20"
SAMPLE_NAME="A1354" # substitute for other assemblies

# map raw data to unpolished assembly
minimap2 -ax map-ont $unpolished_dir/Assembly.fasta $data_dir/$data \
                     | samtools view -b  -F 4 \
                     | samtools sort -@ 20 > $In_dir/"$BAM".bam

# index alignment
cd $In_dir
samtools index $BAM

# create output directory
mkdir $Out_dir
cd $Out_dir

## pull the docker image to sigularity, this is a 6.6GB download
singularity pull docker://kishwars/pepper_deepvariant:r0.4

# The pull command creates pepper_deepvariant_r0.4.sif file locally

# Run PEPPER-Margin-DeepVariant
singularity exec --bind /usr/lib/locale/ \
pepper_deepvariant_r0.4.sif \
run_pepper_margin_deepvariant polish_assembly \
-b "${In_dir}/${BAM}" \
-f "${unpolished_dir}/${ASM}" \
-o "${Out_dir}" \
-t ${THREADS} \
-s ${SAMPLE_NAME} \
--ont

# this generates 2 VCFs, one per haplotype
HAP1_VCF=PEPPER_MARGIN_DEEPVARIANT_ASM_POLISHED_HAP1.vcf.gz
HAP2_VCF=PEPPER_MARGIN_DEEPVARIANT_ASM_POLISHED_HAP2.vcf.gz

POLISHED_ASM_HAP1="$SAMPLE_NAME"_Shasta_run"$run":.PMDV.HAP1.fasta
POLISHED_ASM_HAP2="$SAMPLE_NAME"_Shasta_run"$run".PMDV.HA2.fasta

# Apply the VCF to the assembly
singularity exec --bind /usr/lib/locale/ \
pepper_deepvariant_r0.4.sif \
bcftools consensus \
-f "${unpolished_dir}/${ASM}" \
-H 2 \
-s "${SAMPLE_NAME}" \
-o "${Out_dir}/${POLISHED_ASM_HAP1}" \
"${Out_dir}/${HAP1_VCF}"

singularity exec --bind /usr/lib/locale/ \
pepper_deepvariant_r0.4.sif \
bcftools consensus \
-f "${unpolished_dir}/${ASM}" \
-H 2 \
-s "${SAMPLE_NAME}" \
-o "${Out_dir}/${POLISHED_ASM_HAP2}" \
"${Out_dir}/${HAP2_VCF}"

# assembly statistics
bbmap/stats.sh ./$Out_dir/"$SAMPLE_NAME"_Shasta_run"$run".PMDV.HAP1.fasta > ./$Out_dir/Shasta"$run"_Pepper_bbmap_stats.txt

# gene completeness
export BUSCO_CONFIG_FILE=/mnt/griffin/beawil/software/busco_config/config.ini


# define datasets
genome="$SAMPLE_NAME"_Shasta_run"$run".PMDV.HAP1.fasta
library=insecta_odb10
outfile="$SAMPLE_NAME"_Shasta"$run"_Pepper_insecta_odb10

# Run BUSCO
python3 busco -i ./$Out_dir/$genome -l $library -m genome -o ./$Out_dir/$outfile -c 40


