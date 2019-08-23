#!/bin/bash
#PBS -q batch                                                            
#PBS -N minimap2                                            
#PBS -l nodes=1:ppn=2 -l mem=20gb                                        
#PBS -l walltime=20:00:00                                                
#PBS -M rx32940@uga.edu                                                  
#PBS -m abe                                                              
#PBS -o /scratch/rx32940/minion_blood_simulation/test_runs/map                        
#PBS -e /scratch/rx32940/minion_blood_simulation/test_runs/map                        
#PBS -j oe 

cd $PBS_O_WORKDIR

ml minimap2/2.13-foss-2016b
module load SAMtools/1.9-foss-2016b

data_path="/scratch/rx32940/minion_blood_simulation/data"
output_path="/scratch/rx32940/minion_blood_simulation/test_runs/map"

# for nanopore mapping

for file in data_path/demultiplex2/barcode*/barcode*; do
    barcode=$(basename "$file")
    echo $barcode
    minimap2 -ax map-ont $data_path/Lepto_ref/Leptospira_interrogans_Copenhageni_CI.fa $barcode.fastq > $output_path/${barcode}_CI.sam
    minimap2 -ax map-ont $data_path/Lepto_ref/Leptospira_interrogans_Copenhageni_CII.fa $barcode.fastq > $output_path/${barcode}_CII.sam

    # sam to bam 
    samtools view -b -o $output_path/$barcode.bam $output_path/$barcode.sam

    # sort alignment by leftmost chromosomal coordinates
    samtools sort -o $output_path/${barcode}_sort.bam $output_path/$barcode.bam

    # indexing the bam file
    samtools index $output_path/${barcode}_sort.bam

    # mapping stats
    samtools flagstat $output_path/${barcode}_sort.bam > $output_path/${barcode}_stats.txt

done