#!/bin/bash


ref_path='/mnt/LTR_userdata/majid001/mec/haplotyping_pacbio_diploid/ref' #'/mnt/scratch/majid001/human/humane_ref/chr21_noN_capital.fa'
#pbsim_model_path='/home/majid001/Install/pbsim/data/model_qc_clr'   # the model of pbsim is within the folder which it is installed, do not use ~ for home.
haplogen_path='/mnt/LTR_userdata/majid001/mec/haplotyping_pacbio_diploid/haplogen'

ReadGenerating()
{   printf '=%.0s' {1..100}; printf "\n"; printf "ART started    \n"; printf '=%.0s' {1..100}; printf "\n"
    mkdir out_art
    for idx in {1..2}; do 
    #pbsim --prefix out_pbsim/hap${idx} --depth 50  --data-type CLR --model_qc $pbsim_model_path ${haplogen_path}/sim_hap$idx.fa;
    art_illumina -p -na -ss MS -i ${haplogen_path}/sim_hap$idx.fa -l 250 -f 45 -m 300 -s 5 -o out_art/hap${idx}_R
    done
    #for idx in {1..2}; do 
    #sed  "s/@chr/@chr_hap$idx/g" out_art/hap${idx}_1.fastq >> out_art/reads1.fastq
    #sed  "s/@chr/@chr_hap$idx/g" out_art/hap${idx}_2.fastq >> out_art/reads2.fastq
    #done
    
    cat out_art/hap1_R1.fq out_art/hap2_R1.fq >> out_art/R1.fq
    cat out_art/hap2_R1.fq out_art/hap2_R2.fq >> out_art/R2.fq
    
 }
 
Aligning()
{   printf '=%.0s' {1..100}; printf "\n"; printf "Aligning  started        \n"; printf '=%.0s' {1..100}; printf "\n"
    mkdir out_aligner; 
    #minimap2  -ax map-pb  ${ref_path}/ref.fa out_pbsim/reads.fastq > out_aligner/reads.sam
    
    bwa index ${ref_path}/ref.fa
    bwa mem  ${ref_path}/ref.fa out_art/R1.fq out_art/R2.fq > out_aligner/reads.sam



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




