#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

# Download from https://github.com/common-workflow-language/workflows/blob/master/tools/fastqc.cwl
# Remove Docker requirement, add SoftwareRequirement

hints:
  SoftwareRequirement:
    packages:
      fastqc:
        version: [ "0.11.2" ]
        
inputs:
  fastqFile:
    type: File # No reason to accept multiple files as no overall report is generated
    inputBinding:
      position: 1

baseCommand: [fastqc, --outdir, ., --extract]
outputs:
  zippedFile:
    type: File
    outputBinding:
      glob: '*.zip'
  report:
    type: Directory
    outputBinding:
      glob: .
