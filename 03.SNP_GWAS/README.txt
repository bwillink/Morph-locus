This folder includes general scripts used for variant calling and GWAS analysis. These analysis were conducted with support from C. W. Wheat and K. Tunström.

3.1. Trim_polyg.sh: removes excess poly-G from raw short-read data with fastp.

3.2. Map_reseq.sh: maps the trimmed short reads from all resequencing samples to a reference assembly using bwa-mem.

3.3. GWAS_preprocess.sh: adds group IDs each lane alignment so 4 lanes belong to the same biological sample.The four lanes are combined into a single .bam file and duplicates are marked in a single step.

3.4. Var_call.sh: call variants using bcftools.

3.5. Variant_filter_gwas.sh: filters vcf file with criteria suitable for GWAS.

3.6. Repeat_masker.sh: annotates repetitive content using repeatmodeler and repeatmasker.

3.7. RED.sh: annotates repetitive content more naively using RED.

3.8. Plink_gwas.sh: conducts association test in PLINK after finishing repetitive content.
