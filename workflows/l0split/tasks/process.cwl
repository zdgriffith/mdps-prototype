# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["level0split"]
stdout: stdout.txt
stderr: stderr.txt
inputs:
  indir: 
    type: Directory
    inputBinding:
      position: 0
  outdir:
    type: string?
    default: .
    inputBinding:
      prefix: --outdir
outputs:
  outdir:
    type: Directory
    outputBinding:
      glob: .
