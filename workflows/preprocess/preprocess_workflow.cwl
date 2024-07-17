cwlVersion: v1.2
class: Workflow
label: Download VIIRS Level-0
requirements:
  NetworkAccess:
    networkAccess: true
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype:latest

inputs:
  token:
    type: string
    inputBinding:
      prefix: --token
  searchdoc:
    type: File
    inputBinding:
      position: 0

outputs:
  results:
    type: File
    outputBinding:
      glob: results.json 
    
steps:
  in:
    
