cwlVersion: v1.0
class: CommandLineTool
id: cutadapt
label: cutadapt
doc: cutadapt removes adapter sequences from high-throughput sequencing reads.

# This is an example with few parameters.

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
  fileR1:
    type: File
    doc: File containing sequencing reads (forward or single-end reads).
    inputBinding:
      position: 30
  fileR2:
    type: File?
    doc: File containing seuquencing reads (reverse, only paired-end reads).
    inputBinding:
      position: 32
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
  reads1_cutadapt:
    type: File
    outputBinding:
      glob: $(inputs.fileR1.nameroot).cutadapt.fastq

  reads2_cutadapt:
    type: File?
    outputBinding:
      glob: |
        ${ if (inputs.fileR2 ) {
             return inputs.fileR2.nameroot + '.cutadapt.fastq';
           } else {
             return null;
           }
         }

arguments:
  - valueFrom: $(inputs.fileR1.nameroot).cutadapt.fastq
    prefix: --output
    position: 20
    
  - valueFrom:  |
      ${
        if ( inputs.fileR2) {
          return "-p" + inputs.fileR2.nameroot+'.cutadapt.fastq';
        } else {
          return null;
        }
      }
    shellQuote: False 
    position: 21    
