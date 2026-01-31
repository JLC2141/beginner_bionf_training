#Run FASTQC on raw reads
mkdir fastqc_raw
fastqc *.fastq.gz -o fastqc_raw/
#Run multiqc in the fastqc_raw directory
multiqc fastqc_raw/ -o fastqc_raw/

#Run trimming
mkdir fastp_results
fastp -i SRR3747659_1.fastq.gz \
-I SRR3747659_2.fastq.gz \
-o SRR3747659_1_trimmed.fastq.gz \
-O SRR3747659_2_trimmed.fastq.gz \
--html fastp_results/fastp_report.html \
--json fastp_results/fastp_report.json

#Run FASTQC on trimmed reads
mkdir fastqc_trimmed
fastqc *_trimmed.fastq.gz -o fastqc_trimmed/
#Run multiqc in the fastqc_trimmed directory
multiqc fastqc_trimmed/ -o fastqc_trimmed/

#Run assembly with SPAdes
spades.py -1 SRR3747659_1_trimmed.fastq.gz \
-2 SRR3747659_2_trimmed.fastq.gz \
-o assembly/

#Add multiQC report


#Remove cache directory
#d ~/.codespaces/bin
#rm -rf cache/