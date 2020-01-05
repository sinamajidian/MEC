#!/bin/bash


ref_path='/mnt/LTR_userdata/majid001/mec/haplotyping_pacbio_diploid/ref' #'/mnt/scratch/majid001/human/humane_ref/chr21_noN_capital.fa'
pbsim_model_path='/home/majid001/Install/pbsim/data/model_qc_clr'   # the model of pbsim is within the folder which it is installed, do not use ~ for home.
haplogen_path='/mnt/LTR_userdata/majid001/mec/haplotyping_pacbio_diploid/haplogen'

ReadGenerating()
{   printf '=%.0s' {1..100}; printf "\n"; printf "PBSIM started    \n"; printf '=%.0s' {1..100}; printf "\n"
    mkdir out_pbsim
    for idx in {1..2}; do 
    pbsim --prefix out_pbsim/hap${idx} --depth 50  --data-type CLR --model_qc $pbsim_model_path ${haplogen_path}/sim_hap$idx.fa;
    done
    for idx in {1..2}; do sed  "s/@S1/@S1_hap$idx/g" out_pbsim/hap${idx}_0001.fastq >> out_pbsim/reads.fastq ; done
    
 }
 
Aligning()
{   printf '=%.0s' {1..100}; printf "\n"; printf "Aligning  started        \n"; printf '=%.0s' {1..100}; printf "\n"
    mkdir out_aligner; 
    minimap2  -ax map-pb  ${ref_path}/ref.fa out_pbsim/reads.fastq > out_aligner/reads.sam
    cd out_aligner
    samtools view -bS  reads.sam  -o  reads.bam
    samtools sort -o sorted.bam reads.bam
    samtools index sorted.bam
    cd ../
}




mkdir $1
cd $1
ReadGenerating
Aligning




