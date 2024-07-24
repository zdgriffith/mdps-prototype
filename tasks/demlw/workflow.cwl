# vim: ft=yaml:
cwlVersion: v1.2
$graph:
  - class: Workflow
    id: main
    label: DemLW for IFF files
    inputs:
      l1b: File
    outputs:
      l1b: 
        type: File
        outputSource: demlw/l1b
    steps:
      demlw:
        run: "#demlw"
        in:
          l1b: l1b
        out: [l1b]

  - class: CommandLineTool
    id: demlw
    baseCommand: ["sh", "driver.sh"]
    stdout: stdout.txt
    stderr: stderr.txt
    requirements:
      # Write a driver script to copy the file form its source location to the output dir 
      # so viirsl1mend can mend it in place.
      InitialWorkDirRequirement:
        listing:
          - entryname: driver.sh
            entry: |-
              set -exv
              cp $(inputs.l1b.path) $(runtime.outdir)/$(inputs.l1b.basename)
              ifflw -v $(runtime.outdir)/$(inputs.l1b.basename) 
              find .
      DockerRequirement:
        dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/demlw:1.0.7
    inputs:
      l1b:
        type: File
    outputs:
      l1b:
        type: File
        outputBinding:
          glob: "IFF*"


