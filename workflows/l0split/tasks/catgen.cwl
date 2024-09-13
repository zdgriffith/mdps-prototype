# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["catgen", "--verbose"]
requirements:
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-images/l0split:2e5a088
inputs:
  pattern: string
    inputBinding:
      prefix: "-p"
  dirpath:
    type: Directory
outputs:
  outdir:
    type: Directory
    outputBinding:
      glob: .
