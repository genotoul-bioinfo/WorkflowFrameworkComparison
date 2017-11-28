cwlVersion: v1.0
class: CommandLineTool
id: cutadapt
label: cutadapt
doc: cutadapt removes adapter sequences from high-throughput sequencing reads.

baseCommand: cutadapt
      
requirements:
  - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      cutadapt:
        version: ["1.15"]

inputs:

# General options
  file-R1:
    type: File
    doc: File containing sequencing reads (forward or single-end reads).
    inputBinding:
      position: 1
  file-R2:
    type: File?
    doc: File containing seuquencing reads (reverse, only paired-end reads).
    inputBinding:
      position: 2
  format:
    type: string?
    doc: |
      Input file format; can be either 'fasta', 'fastq' or 'sra-fastq'.
      Ignored when reading csfasta/qual files. Default auto-detect from file 
      name extension.
    inputBinding:
      prefix: --format=
      separate: false

# Filtering of processed reads:

  minimum-length:
    type: int
    default: 0
    doc: |
      Discard trimmed reads that are shorter than LENGTH. Reads that are too 
      short even before adapter removal are also discarded. In colorspace, an 
      initial primer is not counted. Default 0
    inputBinding:
      prefix: --minimum-length=
      separate: false



outputs:
  output-file-R1:
    type: File?
    outputBinding:
      glob: $(inputs.output-R1)

arguments:
  - valueFrom: $(inputs.file-R1.nameroot)
    prefix: --output
    position: 21
