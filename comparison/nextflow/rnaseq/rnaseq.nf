params.outdir = "$baseDir/results/"
params.readfiles = "$baseDir/../../../to_start/data/reads/*{1,2}.fastq.gz"
params.genome = "$baseDir/../../../to_start/data/reference/reference.fa"
params.annotation = "$baseDir/../../../to_start/data/reference/reference.gtf"
params.index = "$baseDir/index/"


outdir = params.outdir
readfiles = params.readfiles
genome = file(params.genome)
annotation = file(params.annotation)
index = params.index

Channel.fromPath(readfiles).set { reads }

process fastqc {
	publishDir outdir, mode: 'copy', overwrite: true

	input:
	file read from reads
	
	output:
	file '*html' into fastqc
	
	"""
	fastqc --noextract ${read}
	"""
}

Channel.fromFilePairs(readfiles).set { pair_reads }

process cutadapt {
	input:
	set pair_id, file(read) from pair_reads
	
	output:
	set pair_id, 'clean_*' into clean_files1, clean_files2
	
	"""
	cutadapt -o clean_${pair_id}1.fastq.gz -p clean_${pair_id}2.fastq.gz ${read}
	"""
}

process indexGenome {
	storeDir index
	
	input:
	file ref from genome
	file annot from annotation
	
	output:
	file "${dbname}.star/*" into startDb
	
	script:
	dbname = ref.baseName
	"""
	mkdir ${dbname}.star
	STAR --runMode genomeGenerate --genomeDir ${dbname}.star --genomeFastaFiles ${ref} --sjdbGTFfile ${annot} --sjdbOverhang 99
	"""
}


process mapping {
	publishDir outdir, mode: 'copy', overwrite: true

	input:
	set pair_id, file(read) from clean_files1
	val starDB from startDb
	
	output:
	file "*bam" into aligned_sorted_files
	
	script:
	starDBpath = starDB[0].parent
	"""
	STAR --genomeDir $starDBpath --runThreadN 1 --readFilesIn ${read} --outFileNamePrefix ${pair_id} --readFilesCommand zcat --outSAMtype BAM SortedByCoordinate --outFilterType BySJout
	"""
}

process mapping2 {
	publishDir outdir, mode: 'copy', overwrite: true

	input:
	set pair_id, file(read) from clean_files2
	val starDB from startDb
	
	output:
	file "*sam" into aligned_files
	
	script:
	starDBpath = starDB[0].parent
	"""
	STAR --genomeDir $starDBpath --runThreadN 1  --readFilesIn ${read} --outFileNamePrefix ${pair_id} --readFilesCommand zcat --outFilterType BySJout
	"""
}

