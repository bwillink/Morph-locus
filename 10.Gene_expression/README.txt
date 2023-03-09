This folder includes general scripts used for transcript assembly and gene expression analysis of alternative morphs.

10.1. Map_RNAseq.sh: Maps RNAseq data to a reference assembly using HISAT2.

10.2. Map_RNAseq_Isen.sh: Downloads RNAseq data from I. senegalensis and maps to a reference assembly using HISAT2. The data was taken from Okude et al. 2022 PNAS.

10.3. Stringtie_assembly.sh: Assembles transcripts de novo and merges them into a single gtf file using Stringtie.

10.4. Stringtie_count.sh: Estimates transcript abundances based on this global set of transcripts using Stringtie.

10.5. Stringtie_assembly_sen.sh: Assembles transcripts from I. senegalensis them into a single gtf file using Stringtie using the I. elegans gtf as a guide.

10.6. Stringtie_count_sen.sh: Estimates transcript abundances for I. senegalensis based on a gtf that combines transcripts detected in both species, using Stringtie.

10.7. Stringtie_DToL.sh: Assembles transcripts and estimates transcript abundances based on the DToL reference genome and annotation without discovering new transcripts.

10.8. Gene_expression.R: Tests for differential gene expression between morphs in I. elegans and estimates level of expression of candidate genes in both species.





