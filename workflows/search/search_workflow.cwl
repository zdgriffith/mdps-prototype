# vim: ft=yaml:
cwlVersion: v1.2
class: Workflow
label: Search for ASIPS products 

requirements:
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true
  StepInputExpressionRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  process:
    type:
      fields:
        search_json:
          - File
        asips_token:
          - File
          - "null"
      type: record

outputs:
  results:
    outputSource: process/search_collection_file
    type: File
    
steps:
  process:
    run: process.cwl
    in: 
      search_json:
        source: process 
        valueFrom: $(self.search_json)
      asips_token:
        source: process 
        valueFrom: $(self.asips_token)
    out:
      - search_collection_file
