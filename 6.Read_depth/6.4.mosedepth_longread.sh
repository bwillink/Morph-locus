#!bin/bash

# morph to use as reference
morph=Afem_1354 # change for other assemblies
morph_name=A1354 # change for other assemblies

sample_long=("Afem_1354" "Ifem1049" "Ofem0081") # for long read samples

contig=("SUPER_13_unloc_2" "SUPER_1")

window=500

# go to long read samples
data_fp=/path/to/$morph/output/longread_mapping/
  cd $data_fp

# read depth of long read samples
for  j in ${sample_reseq[@]};
do
   for k in ${contig[@]};
   do
     mosdepth -t 4 -n -b $window -c "$k"_RagTag "$j"_"$k"_"$window" "$j"_"$morph_name"_aln_sorted.bam 
   done

done

out_fp=/path/to/$morph/output/longread_coverage/

# move to output directory
mv *mosdepth*  $out_fp
mv *regions*  $out_fp


file path with repeat annotations
rep_masker=/path/to/$morph/output/"$morph_name"_repeatmasker/"$morph_name"_ragtag_UPPER.fa.out.gff
RED=/path/to/$morph/output/RED/"$morph_name"_ragtag_RED.bed


for  j in ${sample_long[@]};
do
  temp="${j%%.*}"
  zcat $out_fp/"$j"_${contig[0]}_"$window".regions.bed.gz \
       $out_fp/"$j"_${contig[1]}_"$window".regions.bed.gz \
        > $out_fp/"$j"_"$window".regions.bed
  bedtools intersectBed -a $out_fp/"$j"_"$window".regions.bed \
                        -b $rep_masker $RED \
                        -v -f 0.10 > $out_fp/"$j"_"$window"_norepeat.regions.bed
done

cat $out_fp/*"$window"_norepeat.regions.bed > $out_fp/longread_coverage_norepeat_"$window"_window.bed
