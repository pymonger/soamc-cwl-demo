#!/usr/bin/env cwl-runner

cwlVersion: v1.1
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: curlimages/curl
requirements:
  NetworkAccess:
    networkAccess: true
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
  stdout_file:
    type: stdout
  stderr_file:
    type: stderr
stdout: stdout_stage-in.txt
stderr: stderr_stage-in.txt
