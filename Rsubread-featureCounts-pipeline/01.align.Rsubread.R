library(Rsubread)

args <- commandArgs()
index <- args[6]
# read_path <- args[7]
# read_name <- basename(read_path)
in_dir <- args[7]
read_base <- args[8]

out_dir <- args[9]
out_bam <- paste0(out_dir,"/",read_base,".bam")
#out_stat <- paste0(out_dir,"/",read_base,".log")


r1 <- paste0(in_dir,"/",read_base,".clean_1P") #afer trimmomatic filtering
r2 <- paste0(in_dir,"/",read_base,".clean_2P")
#?align
align.stat <- align(

  # index for reference sequences
  index=index,

  # input reads and output
  readfile1 =r1,
  readfile2 =r2,
  type = "rna",
  input_format = "FASTQ",
  output_format = "BAM",
  output_file = out_bam,

  # offset value added to Phred quality scores of read bases
  phredOffset = 33,

  # thresholds for mapping
  nsubreads = 10,
  TH1 = 3,
  TH2 = 1,
  maxMismatches = 3,

  # unique mapping and multi-mapping
  unique = FALSE,
  nBestLocations = 1,

  # read trimming
  nTrim5 = 0,
  nTrim3 = 0,

  # number of CPU threads
  nthreads = 8,
  # read order
  #keepReadOrder = FALSE,
  sortReadsByCoordinates = T,
)

#write.csv2(align.stat, file = out_stat)