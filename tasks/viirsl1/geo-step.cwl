# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
id: viirsl1-geo
baseCommand: [viirsl1]
arguments: ["$(inputs.satellite)", "geo"]

stdout: stdout.txt
stderr: stderr.txt

inputs:
  version:
    type: string
  satellite: 
    type: string
  l1a:
    type: File
    label: L1A file
    inputBinding:
      position: 0

outputs:
  stdout:
    type: File
    outputBinding:
      glob: stdout.txt
  stderr:
    type: File
    outputBinding:
      glob: stderr.txt
  mod:
    type: File
    outputBinding:
      glob: "V??03MOD.A*.nc"
  dnb:
    type: File
    outputBinding:
      glob: "V??03DNB.A*.nc"
  img:
    type: File
    outputBinding:
      glob: "V??03IMG.A*.nc"
