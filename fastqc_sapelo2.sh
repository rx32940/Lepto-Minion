#!/bin/bash
#PBS -q batch                                                            
#PBS -N fastqc_minion                                            
#PBS -l nodes=1:ppn=2 -l mem=20gb                                        
#PBS -l walltime=20:00:00                                                
#PBS -M rx32940@uga.edu                                                  
#PBS -m abe                                                              
#PBS -o /scratch/rx32940                        
#PBS -e /scratch/rx32940                        
#PBS -j oe 

cd $PBS_O_WORKDIR

module load FastQC/0.11.8-Java-1.8.0_144

data_path="/scratch/rx32940/minion_blood_simulation/data/PolyAExperiment"
output_path="/scratch/rx32940/minion_blood_simulation/runs_polyA/QC"

cat $data_path/barcode03/*fastq > $data_path/barcode03/barcode03.fastq
fastqc $data_path/barcode03/barcode03.fastq -o $output_path