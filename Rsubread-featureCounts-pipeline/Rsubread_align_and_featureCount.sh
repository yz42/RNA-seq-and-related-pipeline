##################2. alignment and count expression
##"module load cmds" were recorded for the applications on the MOGON cluster
##Let's assume all the fastq files have been stored in the current dir "./"


###first to build index for the ref genome
#usage: to substitute the contents in <> with actual path (absolute path recommonded)
Rscript a0.build_index.R <index_base_name_that_you_want_to_create> <path_ref_genome.fa>


###2nd to align reads to ref genome using Rsubread
#ml lang/R/4.2.0-foss-2021b #mogon

index=index_base_name_that_you_want_to_create
in_dir=/path/to/the/input/fastq/
fq_base_name=basename_of_fastq_file
out_dir=/path/to/the/output/bam/

Rscript 01.align.Rsubread.R \
 $index \
 $in_dir \
 $fq_base_name \
 $out_dir

#assume the in_dir is /x/y/, fq_base_name is z ,then the actual fq files should be /x/y/z.clean_1P and /x/y/z.clean_2P (naming system from trimomatic), otherwise if you use different name, please consider recode in 01.align.Rsubread.R


####3rd to count expression 
num_treads=16
anno="ref_annotation.gtf"
out_file="all_feature.txt"
bam1="samp1.bam"
bam2="samp2.bam"
bamN="sampN.bam"


featureCounts \
  -T $num_treads \ 
  -p \
  -t exon \
  -g gene_id \
  --ignoreDup \
  -a $anno \
  -o $out_file \
  $bam1 \
  $bam2 \
  $bamN

## -T specify the  # of threads to use; --ignoreDup to remove duplicates which are marked in Rsubread; provide -a the genome annotation in the gtf format; -o specify the output name; bam1 bam2...bamN are list of bam files generated from Rsubread, the split in the bam file list are spaces or tabs.