# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["/software/run.py", "--verbose"]
stdout: stdout.txt
stderr: stderr.txt
requirements:
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-images/mvcm_l2
inputs:
  indir: 
    type: Directory
    inputBinding:
      prefix: --indir
outputs:
  outfile:
    type: File
    outputBinding:
      glob: CLDMSK*.nc
