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
execution on local , OK

on SGE, you should configure enviroment veriable
```
export TOIL_GRIDENGINE_PE="parallel_smp" 
export TOIL_WORKDIR=~/work/WorkflowFrameworkComparison/comparison/toil/workdir
```

Try a simply fastqc :
```
toil-cwl-runner --batchSystem gridEngine --disableCaching ../../to_start/bioinfo_example_cwl/tools/fastqc.cwl --fastqFile ../../to_start/data/reads/sample_R1.fastq.gz 
```

```
toil-cwl-runner --batchSystem gridEngine 
--basedir ~/work/WorkflowFrameworkComparison/comparison/toil/workdir 
--outdir ~/work/WorkflowFrameworkComparison/comparison/toil/workdir 
--disableCaching ../../to_start/bioinfo_example_cwl/fastqc_iterable.cwl 
--read1 ../../to_start/data/reads/sample_R1.fastq.gz 
--read1 ../../to_start/data/reads/sample_R2.fastq.gz
```
## State first day :
With python class development :
 - Launch a simple hello world.
 - Unable to run fastqc with python class, as I wasn't able to define output directory.
 
With cwl file :
 - run in local without problem.
 - run in cluster a simple tool, get lots of trouble :
   - must specifie environement variable TOIL_GRIDENGINE_PE
   - main pb was to find how to redefine working directory (by default
    when a job is submit, search for input file in /tmp, but in nodeX 
    it's not the same as in frontal node!)
     - try TOIL_WORKDIR doesn't work for SGE (set in .bashrc), 
     - use basedir/outdir options => still doesn't work !
   
## Issues :
(after one day)
 - SGE execution
 - Developping in Python and understand how to handle files (input and output)


## Success :
 - Run a CWL workflow in local 
