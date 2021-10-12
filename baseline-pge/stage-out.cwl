#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: pymonger/aws-cli
requirements:
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.aws_creds)
baseCommand: [aws]
arguments: [
  "s3",
  "cp",
  "--recursive",
]
inputs:
  aws_creds:
    type: Directory
  dataset_dir:
    type: Directory
    inputBinding:
      position: 1
  base_dataset_url:
    type: string
    inputBinding:
      position: 2
outputs:
  stdout_file:
    type: stdout
  stderr_file:
    type: stderr
stdout: stdout_stage-out.txt
stderr: stderr_stage-out.txt
