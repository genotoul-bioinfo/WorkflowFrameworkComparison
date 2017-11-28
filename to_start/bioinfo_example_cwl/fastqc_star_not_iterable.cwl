#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

# Inspired by
# https://github.com/InSilicoDB/pipeline-kallisto/blob/develop/main.nf

requirements:
  ScatterFeatureRequirement: {}

inputs:
  
  read1: File
  read2: File
  genome: Directory

outputs:
  OUTPUT:
    type: File[]
    outputSource: star/output
  
steps:
  qc1:
    run: ./tools/fastqc.cwl
    in:
      fastqFile: read1 
    out: [report]

  qc2:
    run: ./tools/fastqc.cwl
    in:
      fastqFile: read2
    out: [report]

  star:
    run: ./tools/STAR.cwl 
    in:
      fastq1: read1 
      fastq2: read2
      index: genome
      readFilesCommand: { default: zcat }
      outReadsUnmapped: { default: None }
      alignSJDBoverhangMin: { default: 10 }
      alignIntronMax: { default: 200000 }
      runThreadN: { default: 5 }
      limitBAMsortRAM: { default : "31532137230" }
      outSAMtype: { default: BAM }
      outSAMsecond: { default: SortedByCoordinate }
    
    out :
      [output]

