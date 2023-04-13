library(Rsubread)

args <- commandArgs()
#index <- args[6]
in_dir <- args[6]
index_base <- args[7]
ref_genome <- args[8]

setwd(in_dir)

buildindex(basename=index_base,reference=ref_genome)