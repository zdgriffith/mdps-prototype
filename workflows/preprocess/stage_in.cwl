# vim: ft=yaml:
class: CommandLineTool
cwlVersion: v1.2
label: Download products
baseCommand: download 
arguments: 
  - "--outdir=$(runtime.outdir)"
  - "--output=$(runtime.outdir)/stage_in-results.json"
stdout: stdout.txt

requirements:
  NetworkAccess:
    networkAccess: true
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype:latest

inputs:
  stac_json:
    type: File
    inputBinding:
      position: 0
  asips_token:
    type: File?
    inputBinding:
      prefix: --token-file

outputs:
  stage_in_collection_file:
    outputBinding:
      glob: stage_in-results.json
    type: File
  stage_in_download_dir:
    outputBinding:
      glob: .
    type: Directory
