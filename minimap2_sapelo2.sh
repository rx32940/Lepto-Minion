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

# map to lepto reference genome
# for file in $data_path/demultiplex2/barcode*/; do
#     barcode=$(basename "$file")
#     echo $barcode
#     minimap2 -ax map-ont $data_path/Lepto_ref/Leptospira_interrogans_Copenhageni_CI.fa $data_path/demultiplex2/$barcode/$barcode.fastq > $output_path/map_lepto/${barcode}_CI.sam
#     minimap2 -ax map-ont $data_path/Lepto_ref/Leptospira_interrogans_Copenhageni_CII.fa $data_path/demultiplex2/$barcode/$barcode.fastq > $output_path/map_lepto/${barcode}_CII.sam

#     # sam to bam 
#     samtools view -b -o $output_path/map_lepto/${barcode}_CI.bam $output_path/map_lepto/${barcode}_CI.sam
#     samtools view -b -o $output_path/map_lepto/${barcode}_CII.bam $output_path/map_lepto/${barcode}_CII.sam

#     # sort alignment by leftmost chromosomal coordinates
#     samtools sort -o $output_path/map_lepto/${barcode}_CI_sort.bam $output_path/map_lepto/${barcode}_CI.bam
#     samtools sort -o $output_path/map_lepto/${barcode}_CII_sort.bam $output_path/map_lepto/${barcode}_CII.bam

#     # indexing the bam file
#     samtools index $output_path/map_lepto/${barcode}_CI_sort.bam
#     samtools index $output_path/map_lepto/${barcode}_CII_sort.bam

#     # mapping stats
#     samtools flagstat $output_path/map_lepto/${barcode}_CI_sort.bam > $output_path/map_lepto/${barcode}_CI_stats.txt
#     samtools flagstat $output_path/map_lepto/${barcode}_CII_sort.bam > $output_path/map_lepto/${barcode}_CII_stats.txt

# done

# map to bovine reference genome
for file in $data_path/demultiplex2/barcode*/; do
    barcode=$(basename "$file")
    minimap2 -ax map-ont $data_path/Bovine_ref/GCF_002263795.1_ARS-UCD1.2_genomicUnpaired.fasta $data_path/demultiplex2/$barcode/$barcode.fastq > $output_path/map_bovine/$barcode.sam

    samtools view -b -o $output_path/map_bovine/$$barcode.bam $output_path/map_bovine/$barcode.sam

    samtools sort -o $output_path/map_bovine/${barcode}_sorted.bam $output_path/map_bovine/$barcode.bam

    samtools index $output_path/map_bovine/${barcode}_sorted.bam

    samtools flagstat $output_path/map_bovine/${barcode}_sorted.bam
done
