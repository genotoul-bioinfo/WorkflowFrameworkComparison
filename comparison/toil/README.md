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
```
## Issues :

AWS support only! 
Stop tests.


