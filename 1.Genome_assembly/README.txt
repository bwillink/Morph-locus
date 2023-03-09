This folder includes general scripts used for assembly and polishing of morph specific genomes of Ischnura elegans and Ischnura senegalensis.  These analysis were conducted with support from K. Tunström.

1.1. Assembly.sh: takes uncompressed long-read data and generates draft assemblies using Shasta and one of four possible configuration files. BBmap is then used com compute quality statistics and busco is used to assess completeness of conserved insect genes.

1.2. Pepper_polish.sh: is the first polishing step using PEPPER. Raw Nanopore data is aligned to the draft assembly and used for polishing. QC is conducted as in 1.

1.3. Purge_dups.sh: purges haplotigs from haploid assemblies. QC is conducted as in 1.

1.4. Polca_polish.sh: is the final polishing step using using short-read Illumina data. QC is conducted as in 1.
