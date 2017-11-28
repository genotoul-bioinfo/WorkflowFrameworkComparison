#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

# Inspired by
# https://github.com/InSilicoDB/pipeline-kallisto/blob/develop/main.nf

requirements:
  ScatterFeatureRequirement: {}

inputs:
  read1: File[]

outputs:
  OUTPUT:
    type: Directory[]
    outputSource: qc1/report
  
steps:
  qc1:
    run: ./tools/fastqc.cwl
    in:
      fastqFile: read1 
    scatter: fastqFile
    out: [report]
