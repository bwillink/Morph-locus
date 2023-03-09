This folder includes general scripts used for generating k-mer lists and conducting k-mer based GWAS in Ischnura elegans. Scripts 5.1 - 5.5. were taken ad adapted from Voichek, Y. & Weigel, D. 2020 Nat Genetics. These analyses were conducted with support from R. Chikhi and T. Lemane.

5.1. kmer_count.sh: takes short-read Illumina data as input and counts k-mers for each resequencing sample.

5.2. list_kmers.sh: creates a list of all k-mers in all samples and puts them into a table of presence/absence patterns.

5.3. kinship_table.sh: calculates a kinship matrix between samples based on the k-mer table.

5.4. table_to_plink.sh: converts the k-mer table to PlINK format to be used in GWAS.

5.5. kmer_gwas.sh: conducts the k-mer based GWAS analysis.

5.6. get_kmer_seqs.R: extracts sequences of significant k-mers and outputs a fasta file.

5.7. blast_kmers.sh: finds the mapping locations of significant k-mers on a reference assembly.
