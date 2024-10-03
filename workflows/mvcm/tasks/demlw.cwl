# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
id: demlw
baseCommand: ["sh", "driver.sh"]
stdout: stdout.txt
stderr: stderr.txt
requirements:
  # Write a driver script to copy the file from its source location to the output dir 
  # so viirsl1mend can mend it in place.
  InitialWorkDirRequirement:
    listing:
      - entryname: driver.sh
        entry: |-
          set -exv
          cp $(inputs.download_dir)/$(inputs.l1b) $(runtime.outdir)/$(inputs.l1b)
          ifflw -v $(runtime.outdir)/$(inputs.l1b) 
          find .
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/demlw:1.0.7
inputs:
  download_dir:
    type: Directory
  l1b:
    type: string
outputs:
  demlw_l1b:
    type: File
    outputBinding:
      glob: "IFF*"
