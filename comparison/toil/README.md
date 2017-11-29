# Toil

Duo : Estelle and Celine

## Installation steps :

User guide [instruction](http://toil.readthedocs.io/en/3.12.0/gettingStarted/install.html)

Setup environment :
```
virtualenv ~/venv
virtualenv ~/venv --system-site-packages
source ~/venv/bin/activate
pip install toil
pip install toil[cwl]

```
Example execution :
```
python HelloToil.py file:my-job-store
toil-cwl-runner example.cwl example-job.yaml
python HelloToil.py --batchSystem gridEngine --disableCaching file:my-job-store 

```

Demo workflow execution
``` 
toil-cwl-runner --batchSystem gridEngine --disableCaching ../../to_start/bioinfo_example_cwl/fastqc_iterable.cwl --read1 ../../to_start/data/reads/sample_R1.fastq.gz --read1 ../../to_start/data/reads/sample_R2.fastq.gz
```

## Issues :


