This folder includes general scripts used to estimate population genetic statistics fst, Tajima's D and pi. The analyses take as input a VCF file filter for quality and read depth but including all invariant sites and rare polymorphisms.

4.1. Variant_filter_pixy.sh: filters vcf file with criteria suitable for popgen analysis.

4.2. Filter_rep.sh: filters regions with >10% repetititve content from the vcf file.

4.3. pixy_fst.sh: estimates fst between morphs for genomic windows using pixy.

4.4. pixy_pi: estimates pi in the entire population for genomic windows using pixy.

4.5. Tajimas.sh: estimates Tajima's D in the entire population for genomic windows using vcftools.
