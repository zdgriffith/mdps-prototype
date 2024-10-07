# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["/software/run.py", "--verbose"]
arguments:
  - --l1b=$(inputs.indir.path)/$(inputs.l1b)
  - --geo=$(inputs.indir.path)/$(inputs.geo)
  - --gdas1=$(inputs.indir.path)/$(inputs.gdas1)
  - --gdas2=$(inputs.indir.path)/$(inputs.gdas2)
  - --nise=$(inputs.indir.path)/$(inputs.nise)
  - --sst=$(inputs.indir.path)/$(inputs.sst)
stdout: stdout.txt
stderr: stderr.txt
requirements:
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-images/mvcm_l2
inputs:
  l1b: 
    type: string
    inputBinding:
      prefix: --l1b
  geo: 
    type: string
    inputBinding:
      prefix: --geo
  gdas1: 
    type: string
    inputBinding:
      prefix: --gdas1
  gdas2: 
    type: string
    inputBinding:
      prefix: --gdas2
  nise: 
    type: string
    inputBinding:
      prefix: --nise
  sst: 
    type: string
    inputBinding:
      prefix: --sst
  indir:
    type: Directory
outputs:
  outfile:
    type: File
    outputBinding:
      glob: CLDMSK*.nc
