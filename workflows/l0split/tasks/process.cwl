# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["level0split", "--verbose"]
stdout: stdout.txt
stderr: stderr.txt
requirements:
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-images/l0split:787ad6b
inputs:
  input:
    type: Directory
    inputBinding:
      position: 0
outputs:
  outdir:
    type: Directory
    outputBinding:
      glob: .
