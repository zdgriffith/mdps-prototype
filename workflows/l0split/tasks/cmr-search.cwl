# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["search"]
stdout: collection.json
stderr: stderr.txt
inputs:
  token_file:
    type: File
    inputBinding:
      prefix: --token-file 
  cmr_collection: 
    type: string 
    inputBinding:
      prefix: --product
  cmr_start_time: 
    type: string
    inputBinding:
      prefix: --start
  cmr_stop_time: 
    type: string
    inputBinding:
      prefix: --stop
  cmr_satellite:
    type: string
    inputBinding:
      prefix: --satellite
outputs:
  results:
    type: File
    outputBinding: 
      glob: collection.json

