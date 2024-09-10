# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["level0split", "--verbose"]
stdout: stdout.txt
stderr: stderr.txt
requirements:
  DockerRequirement:
    dockerPull: 195353574769.dkr.ecr.us-west-2.amazonaws.com/test-asips-docker:8f5727d
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
