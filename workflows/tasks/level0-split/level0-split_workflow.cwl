#!/usr/bin/env cwl-runner
# vim: ft=yaml:

cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["ccsds"]
stdout: stdout.txt

hints:
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/level0-split:latest

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
    
