#!/bin/bash
#
genome_folder=$1 #../../00Reference
genome_index=$2 #./03genome
input_folder=$3 #./02clean
mapping_folder=$4 #./04mapping
transcript_folder=$5 #./05transcript
DEGs_folder=$6 #./06DEGs
filename=$7 #AMuV1 AMuV2 AWTV1 AWTV2 OMuV1 OMuV2 OWTV1 OWTV2 
#mapping by STAR
STAR --runThreadN 15 --genomeDir $genome_index --readFilesIn $input_folder/clean_${filename}_1.fq $input_folder/clean_${filename}_2.fq --outSAMattrIHstart 0 --alignSJDBoverhangMin 1 --outReadsUnmapped Fastx --outFilterMismatchNoverLmax 0.05 --outFilterScoreMinOverLread 0.90 --outFilterMatchNminOverLread 0.90 --alignIntronMax 100000 --outSAMtype BAM SortedByCoordinate --outSAMattributes NH HI NM MD AS XS --outSAMstrandField intronMotif --outFileNamePrefix $mapping_folder/${filename} --outFilterType BySJout 1>> info1 
#
#assemble transcripts by stringtie
#mkdir $transcript_folder/temp_${filename}
#
stringtie $mapping_folder/${filename}Aligned.sortedByCoord.out.bam -G $genome_folder/TAIR10.gff -l ${filename} -o $transcript_folder/${filename}.gtf -p 1 -v -a 10 -m 200 -j 1 -f 0.1 -C $transcript_folder/known_${filename} -c 2.5 -g 50 -A $transcript_folder/temp_${filename}/gene_abund_${filename}.out -b $transcript_folder/temp_${filename} 2> info 
