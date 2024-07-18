# vim: ft=yaml:
class: CommandLineTool
cwlVersion: v1.2
label: Split 2h Time-based Level-0 files into 6m Level-0 files
baseCommand: search 
stdout: search-results.json

requirements:
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/search:latest
  NetworkAccess:
    networkAccess: true

inputs:
  search_json:
    type: File
    inputBinding:
      position: 0
  asips_token:
    type: File?
    inputBinding:
      prefix: --token-file

outputs:
  search_collection_file:
    outputBinding:
      glob: search-results.json
    type: File
