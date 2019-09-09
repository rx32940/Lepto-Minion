#!/bin/bash
#PBS -q batch                                                            
#PBS -N featureCounts                                            
#PBS -l nodes=1:ppn=2 -l mem=20gb                                        
#PBS -l walltime=20:00:00                                                
#PBS -M rx32940@uga.edu                                                  
#PBS -m abe                                                              
#PBS -o /scratch/rx32940/minion_blood_simulation/runs_polyA/read                        
#PBS -e /scratch/rx32940/minion_blood_simulation/runs_polyA/read                        
#PBS -j oe

module load Subread/1.6.2

output_path="/scratch/rx32940/minion_blood_simulation/runs_polyA/read"
input_path="/scratch/rx32940/minion_blood_simulation/runs_polyA/map/map_lepto"

annotation="/scratch/rx32940/minion_blood_simulation/data/Lepto_ref/Leptospira_interrogans_serovar_copenhageni_icterohaemorrhagiae.ASM168377v1.44.gtf"

featureCounts -p -t exon -g gene_id -a $annotation -o $output_path/barcode03.txt  $input_path/barcode03_CI_sort.bam $input_path/barcode03_CII_sort.bam 