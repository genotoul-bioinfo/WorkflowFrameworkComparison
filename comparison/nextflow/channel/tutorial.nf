params.query = "uniprot-cytb.fa"
params.db = "db/uniprotdb"
params.chunkSize = 4

db = file(params.db)

Channel
    .fromPath(params.query)
    .splitFasta(by: params.chunkSize)
    .set { fasta }


process blastSearch {
    input:
    file 'query.fa' from fasta

    output:
    file top_hits

    """
    blastp -db $db -query query.fa -outfmt 6 > blast_result
    cat blast_result | head -n 10 | cut -f 2 > top_hits
    """
}


process extractTopHits {
    input:
    file top_hits

    output:
    file sequences

    """
    blastdbcmd -db ${db} -entry_batch $top_hits > sequences
    """
}
