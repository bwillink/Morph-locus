#!bin/bash

# morph to use as reference
morph=Afem_1354 # change for other assemblies
morph_name=A1354 # change for other assemblies

sample_pool=("wHADPI032623-101" "wHADPI032624-90") # for pool seq samples

# go to poolseq samples
data_fp=/path/to/$morph/output/pool_mapping/
  cd $data_fp

# for the pool seq data I'll need to calculate coverage across the wole genome
grep '>' /path/to/$morph/output/RagTag/"$morph_name"_ragtag.fa | sed 's/>//' > ref_scaffolds.txt
contig="$(cat "ref_scaffolds.txt")"

window=500

# read depth of poolseq samples
for  j in ${sample_reseq[@]};
do
   for k in ${contig[@]};
   do
     mosdepth -t 4 -n -b $window -c "$k"_RagTag "$j"_"$k"_"$window" "$j"_"$morph_name".bam 
   done

done

out_fp=/path/to/$morph/output/pool_coverage/

# move to output directory
mv *mosdepth*  $out_fp
mv *regions*  $out_fp

file path with repeat annotations
rep_masker=/path/to/$morph/output/"$morph_name"_repeatmasker/"$morph_name"_ragtag_UPPER.fa.out.gff
RED=/path/to/$morph/output/RED/"$morph_name"_ragtag_RED.bed


for  j in ${sample_pool[@]};
do
  temp="${j%%.*}"
  zcat $out_fp/"$j"_${contig[0]}_"$window".regions.bed.gz \
       $out_fp/"$j"_${contig[1]}_"$window".regions.bed.gz \
        > $out_fp/"$j"_"$window".regions.bed
  bedtools intersectBed -a $out_fp/"$j"_"$window".regions.bed \
                        -b $rep_masker $RED \
                        -v -f 0.10 > $out_fp/"$j"_"$window"_norepeat.regions.bed
done

cat $out_fp/*"$window"_norepeat.regions.bed > $out_fp/pool_coverage_norepeat_"$window"_window.bed
