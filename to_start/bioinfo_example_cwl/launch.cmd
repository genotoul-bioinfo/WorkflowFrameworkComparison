cwltool fastqc_star_not_iterable.cwl --read1 ../data/reads/sample_CD4_R1.fastq.gz --read2 ../data/reads/sample_CD4_R2.fastq.gz --genome ../data/reference/StarIndex
cwltool fastqc_iterable.cwl --read1 ../data/reads/sample_CD4_R1.fastq.gz --read1 ../data/reads/sample_CD4_R2.fastq.gz
cwltool fastqc_cutadapt__star_iterable.cwl --read1 ../data/reads/sample_CD4_R1.fastq.gz --read2 ../data/reads/sample_CD4_R2.fastq.gz --genome ../data/reference/StarIndex
