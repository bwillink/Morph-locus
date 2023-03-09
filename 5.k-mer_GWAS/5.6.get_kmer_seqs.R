# required packages
x <-  c("tidyr", "seqinr")

lapply(x, function(y) {
  # check if installed, if not install
  if (!y %in% installed.packages()[, "Package"])
    install.packages(y)
  
  # load package
  try(require(y, character.only = T), silent = T)
})

# morph comparison
comp <- "AO" # substitute for other comparison

# kmer GWAS resluts
in_file <- paste0("./output/results31_", comp, "/kmers/pass_threshold_5per")

# read kmer GWAS output table
kmers_5 <-
  read.table("in_file", header = T)

# separate position in read from sequence
kmers_5 <-
  separate(
    data = kmers_5,
    col = rs,
    into = c("kmer", "pos"),
    sep = "_"
  )
kmers <- kmers_5$kmer

# name kmers sequentially
kmer_names <- paste0("kmer_", seq(1:length(kmers)))

# write as fasta
write.fasta(
  sequences = as.list(kmers),
  names = kmer_names,
  file.out = paste0("./output/blast_out/", comp, "_kmers.fa",
  as.string = F
)