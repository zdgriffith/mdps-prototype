# vim: ft=yaml:
class: CommandLineTool
cwlVersion: v1.2
label: Split 2h Time-based Level-0 files into 6m Level-0 files
baseCommand: level0split
arguments: 
  - "--outdir=$(runtime.outdir)"
  - "--output=$(runtime.outdir)/process-results.json"
stdout: stdout.txt

requirements:
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/preprocess:latest
  NetworkAccess:
    networkAccess: true

inputs:
  inputdir:
    type: Directory 
    inputBinding:
      position: 0

outputs:
  process_collection_file:
    outputBinding:
      glob: process-results.json
    type: File
  process_output_dir:
    outputBinding:
      glob: .
    type: Directory
