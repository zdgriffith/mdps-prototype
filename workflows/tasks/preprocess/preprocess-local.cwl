#!/usr/bin/env cwl-runner
# vim: ft=yaml:

cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["search"]
stdout: results.json

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
    
