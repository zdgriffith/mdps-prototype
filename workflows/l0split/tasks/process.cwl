# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["level0split"]
stdout: stdout.txt
stderr: stderr.txt
inputs:
  input: 
    type: File 
    inputBinding:
      position: 0
  output: 
    type: File 
    default: "catalog.json"
    inputBinding:
      prefix: "--output"
outputs:
  outdir:
    type: Directory
    outputBinding:
      glob: .
