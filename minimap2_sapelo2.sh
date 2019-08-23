!#/bin/bash
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

minimap2 

