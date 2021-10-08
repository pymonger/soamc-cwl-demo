#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs:
  workflow_input_url: string
  workflow_input_file: string
  workflow_product_id: string
  workflow_min_sleep: int
  workflow_max_sleep: int

outputs:
  final_dataset_dir:
    type: Directory
    outputSource: run-pge/dataset_dir
  stdout_stage-in:
    type: File
    outputSource: stage-in/stdout_file
  stderr_stage-in:
    type: File
    outputSource: stage-in/stderr_file
  stdout_run-pge:
    type: File
    outputSource: run-pge/stdout_file
  stderr_run-pge:
    type: File
    outputSource: run-pge/stderr_file

steps:
  stage-in:
    run: stage-in.cwl
    in:
      input_url: workflow_input_url
      input_file: workflow_input_file
    out:
    - localized_file
    - stdout_file
    - stderr_file

  run-pge:
    run: run-pge.cwl
    in:
      input_file: stage-in/localized_file
      product_id: workflow_product_id
      min_sleep: workflow_min_sleep
      max_sleep: workflow_max_sleep
    out:
    - dataset_dir
    - stdout_file
    - stderr_file
