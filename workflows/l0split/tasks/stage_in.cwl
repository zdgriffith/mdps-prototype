# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["download"]
stdout: stdout.txt
stderr: stderr.txt
inputs:
  token_file:
    type: File
    inputBinding:
      prefix: --token-file
  stac_json:
    type: File
    inputBinding:
      position: 1
  outdir:
    type: string?
    default: .
    inputBinding:
      prefix: --outdir
outputs:
  results:
    type: File
    outputBinding:
      glob: catalog.json
  outdir:
    type: Directory
    outputBinding:
      glob: .
