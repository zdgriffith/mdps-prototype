# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["level0split", "--verbose", "-o", "catalog-output.json"]
stdout: stdout.txt
stderr: stderr.txt
requirements:
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/l0split:latest
inputs:
  input:
    type: File
    inputBinding:
      position: 0
  indir:
    type: Directory
outputs:
  outdir:
    type: Directory
    outputBinding:
      glob: .
