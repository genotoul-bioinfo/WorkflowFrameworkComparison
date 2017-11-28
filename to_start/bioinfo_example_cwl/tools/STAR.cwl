#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [STAR]

doc: "STAR: Alignment"

hints:
   SoftwareRequirement:
    packages:
      STAR :
        version: [ "STAR_2.4.0i" ]
        
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    coresMin: 8
    ramMin: 80000
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.index)

inputs:

  index: Directory

  fastq1:
    type: File
    inputBinding:
      position: 1
      prefix: --readFilesIn

  fastq2:
    type: File
    inputBinding:
      position: 2

  twopassMode:
    type: string?
    inputBinding:
      position: 3
      prefix: --twopassMode

  outReadsUnmapped:
    type: string?
    inputBinding:
      prefix: --outReadsUnmapped
      position: 4

  chimSegmentMin:
    type: int?
    inputBinding:
      prefix: --chimSegmentMin
      position: 5

  chimJunctionOverhangMin:
    type: int?
    inputBinding:
      prefix: --chimJunctionOverhangMin
      position: 6

  alignSJDBoverhangMin:
    type: int?
    inputBinding:
      prefix: --alignSJDBoverhangMin
      position: 7

  alignMatesGapMax:
    type: int?
    inputBinding:
      prefix: --alignMatesGapMax
      position: 8

  alignIntronMax:
    type: int?
    inputBinding:
      prefix: --alignIntronMax
      position: 9
      
  chimSegmentReadGapMax:
    type: string?
    inputBinding:
      prefix: --chimSegmentReadGapMax
      position: 10
    
  chim2:
    type: int?
    inputBinding:
      position: 11

  alignSJstitchMismatchNmax:
    type: int?
    inputBinding:
      prefix: --alignSJstitchMismatchNmax
      position: 12
      
  align2:
    type: int?
    inputBinding:
      position: 13
      
  align3:
    type: int?
    inputBinding:
      position: 14
      
  align4:
    type: int?
    inputBinding:
      position: 15

  runThreadN:
    type: int?
    inputBinding:
      prefix: --runThreadN
      position: 16
      
  limitBAMsortRAM:
    type: string?
    inputBinding:
      prefix: --limitBAMsortRAM
      position: 17
      
  outSAMtype:
    type: string?
    inputBinding:
      prefix: --outSAMtype
      position: 18

  outSAMsecond:
    type: string?
    inputBinding:
      position: 19

  readFilesCommand:
    type: string?
    inputBinding:
      prefix: --readFilesCommand
      position: 20

outputs:

  output:
    type:
      type: array
      items: File
    outputBinding:
      glob: "*.bam"

arguments:
  - valueFrom: $(inputs.index)
    prefix: --genomeDir
    position: 0
    
  - valueFrom: $(inputs.fastq1.nameroot)
    prefix: --outFileNamePrefix
    position: 21
