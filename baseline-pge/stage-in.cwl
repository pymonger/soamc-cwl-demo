#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: curlimages/curl
baseCommand: [curl]
inputs:
  input_url:
    type: string
    inputBinding:
      prefix: -O
  input_file:
    type: string
outputs:
  localized_file:
    type: File
    outputBinding:
      glob: $(inputs.input_file)
