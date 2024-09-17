# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["catgen", "--verbose", "--include-metadata-for-mdps"]
arguments: ["--file-pattern=$(inputs.indir.path)/$(inputs.pattern)"]
stdout: stdout.txt
stderr: stderr.txt
requirements:
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-images/l0split
inputs:
  indir: Directory
  pattern: string
outputs:
  outdir:
    type: Directory
    outputBinding:
      glob: .
