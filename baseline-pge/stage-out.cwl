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

# the following baseCommand and arguments work on docker but not singularity
#baseCommand: [aws]
#arguments: [
#  "s3",
#  "cp",
#  "--recursive",
#]

# the following baseCommand and arguments work on both docker and singularity
baseCommand: [sh]
arguments:
- -c
- if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi &&
  aws s3 cp --recursive $(inputs.dataset_dir.path) $(inputs.base_dataset_url)

inputs:
  aws_creds:
    type: Directory
  dataset_dir:
    type: Directory
    # uncomment these if using baseCommand: [aws]
    #inputBinding:
    #  position: 1
  base_dataset_url:
    type: string
    # uncomment these if using baseCommand: [aws]
    #inputBinding:
    #  position: 2
outputs:
  stdout_file:
    type: stdout
  stderr_file:
    type: stderr
stdout: stdout_stage-out.txt
stderr: stderr_stage-out.txt
