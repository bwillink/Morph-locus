#/bin/bash

# file paths
data_fp=./Tol/output
out_fp=./Afem_1354/output

#filenames
sample=("ToL")

# path to repetitive content
rep_masker=./Afem_1354/output/A1354_repeatmasker/A1354_ragtag_UPPER.fa.out.gff
RED=./Afem_1354/output/RED/A1354_ragtag_RED.bed

# A female contig 
contig=("SUPER_13_unloc_2_RagTag")

# window size to average read depth
window=500

# calculate read depth

for  j in ${sample[@]};
do
  for k in ${contig[@]};
  do
    mosdepth -t 4 -n -b $window -c "$k" Afem_aln_sorted_"$k"_"$window" "$sample"_Afem_aln_sorted.bam
  done
done

# move files to output directory
mv *mosdepth* $out_fp/nanopore_cov
mv *regions* $out_fp/nanopore_cov


for  j in ${sample[@]};
do
    # open bed file (concatenate contigs if more than one)
    zcat $out_fp/nanopore_cov/"$j"_${contig[0]}_"$window".regions.bed.gz > .$out_fp/nanopore_cov/"$j"_${contig[0]}_"$window".regions.bed
    #filter repetitive content > 10%
    bedtools intersectBed -a $out_fp/nanopore_cov/"$j"_${contig[0]}_"$window".regions.bed \
                                              -b $rep_masker $RED \
                                              -v -f 0.10 > $out_fp/nanopore_cov/"$j"_"$window"_"$contig"_regions.bed           
done
