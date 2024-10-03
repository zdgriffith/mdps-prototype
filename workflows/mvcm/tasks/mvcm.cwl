# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
id: mvcm
baseCommand: run.py
stdout: stdout.txt
stderr: stderr.txt
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.l1b) 
      - $(inputs.nise) 
      - $(inputs.sst) 
      - $(inputs.gdas1) 
      - $(inputs.gdas2) 
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/mvcm:20240807-1
inputs:
  sat: 
    type: string
    inputBinding:
      position: 0
  granule: 
    type: string
    inputBinding:
      position: 1
  l1b:
    type: File
    inputBinding:
      position: 2
  nise:
    type: File
    inputBinding:
      position: 3
  sst:
    type: File
    inputBinding:
      position: 4
  gdas1:
    type: File
    inputBinding:
      position: 5
  gdas2:
    type: File
    inputBinding:
      position: 6
outputs:
  cldmsk_l2:
    type: File
    outputBinding:
      glob: "mvcm*"
