##################1. quality control and filtration. 
##"module load cmds" were recorded for the applications on the MOGON cluster
##Let's assume all the fastq files have been stored in the current dir "./", we could check fastq quality with "fastqc" and "multiqc":

#module load bio/FastQC/0.11.9-Java-11
for i in `ls -1 *.fq.gz`; do fastqc $i ; done

#module load bio/MultiQC/1.7-foss-2018a-Python-3.6.4
multiqc ./

##Use trimomatic to remove low quality reads.
#module load bio/parallel_Trimmomatic/0.2.1

#http://www.usadellab.org/cms/?page=trimmomatic
java -Xmx4G -jar trimmomatic.jar PE \
-threads 4 raw_1.fq.gz raw_2.fq.gz \
-baseout clean \
ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 \
SLIDINGWINDOW:4:15 MINLEN:36

###to use fastqc again, check wether all the adapters have been removed
#module load bio/FastQC/0.11.9-Java-11
for i in `ls -1 *.clean_P?`; do fastqc $i ; done

#module load bio/MultiQC/1.7-foss-2018a-Python-3.6.4
multiqc ./