#!/bin/bash

# morph assmebly to be used as reference
morph=Afem_1354 # change for other assemblies

# path to files
data_fp="/path/to/$morph/output/reseq_mapping"

# path to output
out_fp="/path/to/$morph/output/GWAS_preprocess"

# samples and lane
sample="$(cat "/path/to/data/samplesID_batch1")" # change to batch 2 to second batch of sequencing
lane=("L001" "L002" "L003" "L004") # change to L003 for second batch of sequencing

for j in ${sample[@]};
do
  for k in ${lane[@]};
  do
    # add read group ID for each lane
   java -jar $PICARD_ROOT/picard.jar AddOrReplaceReadGroups \
           I=$data_fp/"$j"_"$k".bam \
           O=$data_fp/"$j"_"$k"_labelled.bam \
           RGID=$k \
           RGLB=lib1 \
           RGPL=illumina \
           RGPU=unit1 \
           RGSM=$j
  done

  # flag duplicates with gatk and automatically coordinate sort records
  # this will also merge read groups belonging to a single biological sample into one file

  gatk MarkDuplicatesSpark --java-options "-Xmx8G" \ # for batch 1 of sequencing with multiple lanes per sample
            -I $data_fp/"$j"_${lane[0]}_labelled.bam \
            -I $data_fp/"$j"_${lane[1]}_labelled.bam \ 
            -I $data_fp/"$j"_${lane[2]}_labelled.bam \
            -I $data_fp/"$j"_${lane[3]}_labelled.bam \
            -O $out_fp/"$j"_marked_duplicates.bam \
            -M $out_fp/"$j"_marked_dup_metrics.txt \
            --allow-multiple-sort-orders-in-input true
 
 #  gatk MarkDuplicatesSpark --java-options "-Xmx6G" \ # for batch 1 of sequencing with only one lane per sample
 #            -I $data_fp/"$j"_${lane[0]}_labelled.bam \
 #            -O $out_fp/"$j"_marked_duplicates.bam \
 #            -M $out_fp/"$j"_marked_dup_metrics.txt \
 #            --allow-multiple-sort-orders-in-input true
            

  # remove labelled bam files to clear space
     rm $data_fp/*_labelled.bam
done


