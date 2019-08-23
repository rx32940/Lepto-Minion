#!/bin/bash
#PBS -q batch                                                            
#PBS -N minimap2                                            
#PBS -l nodes=1:ppn=2 -l mem=20gb                                        
#PBS -l walltime=20:00:00                                                
#PBS -M rx32940@uga.edu                                                  
#PBS -m abe                                                              
#PBS -o /scratch/rx32940                        
#PBS -e /scratch/rx32940                        
#PBS -j oe 

cd $PBS_O_WORKDIR

ml minimap2/2.13-foss-2016b
module load SAMtools/1.9-foss-2016b

data_path="/scratch/rx32940/minion_blood_simulation/data"
output_path="/scratch/rx32940/minion_blood_simulation/test_runs/map"

# for nanopore mapping
minimap2 -ax map-ont $data_path/Lepto_ref/Leptospira_interrogans_Copenhageni.fa $data_path/demultiplex2/barcode01/barcode01.fastq > $output_path/barcode01.sam

# sam to bam 
samtools view -b -o $output_path/barcode01.bam $output_path/barcode01.sam

# sort alignment by leftmost chromosomal coordinates
samtools sort -o $output_path/barcode01_sort.bam $output_path/barcode01.bam

# indexing the bam file
samtools index $output_path/barcode01_sort.bam

# mapping stats
samtools flagstat $output_path/barcode01_sort.bam
