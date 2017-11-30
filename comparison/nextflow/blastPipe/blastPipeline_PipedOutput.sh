
#!/usr/bin/env nextflow
 
/*
 * Defines the pipeline inputs parameters (giving a default value for each for them)
 * Each of the following parameters can be specified as command line options
 */
params.query = "./input.fa"
params.db = "./sample.fa"
params.out = "./result.txt"
params.chunkSize = 10
 
db_name = file(params.db).name
db_path = file(params.db).parent
 
/*
 * Given the query parameter creates a channel emitting the query fasta file(s),
 * the file is split in chunks containing as many sequences as defined by the parameter 'chunkSize'.
 * Finally assign the result channel to the variable 'fasta'
 */
Channel
    .fromPath(params.query)
    .splitFasta(by: params.chunkSize)
    .set { fasta }
 
/*
 * Executes a BLAST job for each chunk emitted by the 'fasta' channel
 * and creates as output a channel named 'top_hits' emitting the resulting
 * BLAST matches 
 */
process blast {
    input:
    file 'query.fa' from fasta
    file db_path
 
    output:
    stdout top_hits
 
    """
    blastn -db $db_path/$db_name -query query.fa -outfmt 6 | head -n 10 | cut -f 2
    """
}
 
 
/*
 * Each time a file emitted by the 'top_hits' channel an extract job is executed
 * producing a file containing the matching sequences
 */
process extract {
    input:
    file db_path
	val top_hits
	
    output:
    file sequences
 
    """
    echo "$top_hits" | blastdbcmd -db $db_path/$db_name -entry_batch - | head -n 10 > sequences
    """
}
 
/*
 * Collects all the sequences files into a single file
 * and prints the resulting file content when complete
 */
sequences
    .collectFile(name: params.out)
    .println { file -> "matching sequences:\n ${file.text}" }

