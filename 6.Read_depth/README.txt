This folder includes general scripts used for calculating genomic coverage of resequencing samples, long-read samples and pool-seq samples across windows of a referenece genome. Resequencing samples had already been mapped in 3.2

6.1. map_longread.sh: maps long read data to reference assembly using mnimap2.

6.2. map_pool.sh: maps pool-seq data from I. senegalensis to reference assembly using bwa-mem.

6.3. mosedepth_reseq.sh: calculates read-depth coverage of resequencing samples.

6.4. mosedepth_longread.sh: calculates read-depth coverage of long read samples.

6.5. mosedepth_pool.sh: calculates read-depth coverage of pool-seq samples.

6.6. morph_pca.sh: runs PCA analysis of variants between morphs at the morph locus using PLINK.
