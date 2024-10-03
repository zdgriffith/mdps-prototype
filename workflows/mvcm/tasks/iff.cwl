# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
id: iff
baseCommand: /opt/iff/bin/viirs-iff
stdout: stdout.txt
stderr: stderr.txt
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/iff:2.7.3
inputs:
  output_type:
    type: string
    label: Type of output data; one of hdf, nc
    default: nc
    inputBinding:
      prefix: --output-type
  band_type:
    label: Type of band to process; one of m, d, i
    type: string
    default: m
    inputBinding:
      prefix: --band_type
  geo:
    type: File 
    inputBinding:
      position: 1
  l1b:
    type: File 
    inputBinding:
      position: 2
outputs:
  iff:
    type: File
    outputBinding: 
      glob: "IFF???_*"
