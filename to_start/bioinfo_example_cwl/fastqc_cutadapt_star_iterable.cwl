#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

# Inspired by
# https://github.com/InSilicoDB/pipeline-kallisto/blob/develop/main.nf
# This is an example with few parameters.
requirements:
  ScatterFeatureRequirement: {}

inputs:
  read1: File[]
  read2: File[]
  genome: Directory

outputs:
  out_qc1:
    type: File[]
    outputSource: qc1/zippedFile
  out_qc2:
    type: File[]
    outputSource: qc2/zippedFile
  out_clean1:
    type: File[]
    outputSource: cutadapt/reads1_cutadapt
  out_clean2:
    type: File[]?
    outputSource: cutadapt/reads2_cutadapt
 
steps:
  qc1:
    run: ./tools/fastqc.cwl
    in:
      fastqFile: read1 
    out: [zippedFile]
    scatter: fastqFile
  qc2:
    run: ./tools/fastqc.cwl
    in:
      fastqFile: read2
    out: [zippedFile]
    scatter: fastqFile
  cutadapt:
    run: ./tools/cutadapt.cwl
    in:
      fileR1: read1
      fileR2: read2
    out:
      [reads1_cutadapt,
      reads2_cutadapt]
    scatterMethod: dotproduct
    scatter: 
      - fileR1
      - fileR2
  star:
    run: ./tools/STAR.cwl 
    in:
      fastq1: cutadapt/reads1_cutadapt
      fastq2: cutadapt/reads2_cutadapt
      index: genome
      #readFilesCommand: { default: zcat }
      outReadsUnmapped: { default: None }
      alignSJDBoverhangMin: { default: 10 }
      alignIntronMax: { default: 200000 }
      runThreadN: { default: 5 }
      limitBAMsortRAM: { default : "31532137230" }
      outSAMtype: { default: BAM }
      outSAMsecond: { default: SortedByCoordinate }  
    scatterMethod: dotproduct
    scatter: 
      - fastq1
      - fastq2
    out :
      [output]
      
