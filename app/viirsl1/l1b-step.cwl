# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
id: viirsl1-l1b
baseCommand: [run_ocssw_viirsl1]
arguments: ["--satellite=$(inputs.satellite)", "--swdir=/opt/viirsl1/v3.1.0", "l1b"]

stdout: stdout.txt
stderr: stderr.txt

requirements:
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/viirsl1:v3.1.0

inputs:
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
  cdg:
    type: File
    outputBinding:
      glob: "V??02CDG.A*.nc"
  mod:
    type: File
    outputBinding:
      glob: "V??02MOD.A*.nc"
  dnb:
    type: File
    outputBinding:
      glob: "V??02DNB.A*.nc"
  img:
    type: File
    outputBinding:
      glob: "V??02IMG.A*.nc"
