#!/usr/bin/env cwl-runner

cwlVersion: v1.1
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: pymonger/baseline-pge:latest
baseCommand: [/home/ops/verdi/ops/baseline_pge/dumby_landsat_cwl_fail.sh]
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.input_file)
inputs:
  product_id:
    type: string
    inputBinding:
      position: 1
  min_sleep:
    type: int
    inputBinding:
      position: 2
  max_sleep:
    type: int
    inputBinding:
      position: 3
  input_file:
    type: File
    inputBinding:
      position: 4
outputs:
  dataset_dir:
    type: Directory
    outputBinding:
      glob: "dumby-product-*"
  #stdout_file:
  #  type: stdout
  #stderr_file:
  #  type: stderr
#stdout: stdout_run-pge.txt
#stderr: stderr_run-pge.txt
