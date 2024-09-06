# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["unity_client", "search"]
stdout: stdout.txt
stderr: stderr.txt
inputs:
  search_collections: 
    type: array 
    items: string
    inputBinding:
      itemSeparator: " "
  search_start_time: 
    type: string
    inputBinding:
      prefix: --start
  search_stop_time: 
    type: string
    inputBinding:
      prefix: --stop
  search_satellite:
    type: string
    inputBinding:
      prefix: --satellite
outputs:
  results:
    type: File
    outputBinding: 
      glob: collection.json

