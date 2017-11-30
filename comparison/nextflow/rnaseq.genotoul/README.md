# nextflow

Duo : seb/ludo

## Installation steps :

User guide [instruction](https://www.nextflow.io/docs/latest/index.html)

Setup environment :

 * nextflow
```
module load bioinfo/Java8
wget -qO- get.nextflow.io | bash
```

run command :
```
# premier run sur cluster
./nextflow run rnaseq.nf -profile cluster

# rerun
./nextflow run rnaseq.nf -profile cluster -resume
```

## Issues :



