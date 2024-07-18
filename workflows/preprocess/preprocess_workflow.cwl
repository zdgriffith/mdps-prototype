# vim: ft=yaml:
cwlVersion: v1.2
class: Workflow
label: Download VIIRS Level-0

requirements:
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true
  StepInputExpressionRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  stage_in:
    type:
      fields:
        stac_json:
          - string
          - File
        asips_token:
          - File
          - "null"
      type: record

outputs:
  processed_files:
    outputSource: process/process_collection_file
    type: File
    
steps:
  stage_in:
    run: stage_in.cwl
    in:
      stac_json:
        source: stage_in 
        valueFrom: $(self.stac_json)
      asips_token: 
        source: stage_in
        valueFrom: $(self.asips_token)
    out:
    - stage_in_collection_file
    - stage_in_download_dir
        
  process:
    run: process.cwl
    in: 
      inputdir: stage_in/stage_in_download_dir
    out:
      - process_collection_file
      - process_output_dir
