#!/usr/bin/env cwl-runner

cwlVersion: "v1.0"

class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    coresMin: 8
    ramMin: 80000
#On genotoul:
#/usr/local/bioinfo/src/RSEM/RSEM-1.2.30/rsem-calculate-expression
hints:
  SoftwareRequirement:
    packages:
      rsem-calculate-expression:
        version: [ "1.2.31" ]

inputs:

  - id: index
    type: File

  - id: bam
    type: File
    inputBinding:
      position: 2

  - id: pairedend
    type: ["null",boolean]
    inputBinding:
      position: 0
      prefix: --paired-end

  - id: strandspecific
    type: ["null",boolean]
    inputBinding:
      position: 0
      prefix: --strand-specific

  - id: rspd
    type: ["null",boolean]
    inputBinding:
      position: 0
      prefix: --estimate-rspd

  - id: threads
    type: ["null",int]
    inputBinding:
      prefix: -p
      position: 1
  
  - id: output_filename
    type: string
    inputBinding:
      position: 4

outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.output_filename + '.isoforms.results')


baseCommand: [rsem-calculate-expression]
arguments:
  - valueFrom: $(inputs.index.path + "/Homo_sapiens.GRCh37.75.gtf.inPrimary.gtf.cdna")
    position: 3
