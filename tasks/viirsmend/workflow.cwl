# vim: ft=yaml:
cwlVersion: v1.2
$graph:
  - class: Workflow
    id: main
    inputs:
      l1b: File
      geo: File
    outputs:
      l1b: 
        type: File
        outputSource: viirsmend/l1b
    steps:
      viirsmend:
        run: "#viirsmend"
        in:
          l1b: l1b
          geo: geo
        out: [l1b]

  - class: CommandLineTool
    id: viirsmend 
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
              exec viirsl1mend $(runtime.outdir)/$(inputs.l1b.basename) $(inputs.geo.path)
      DockerRequirement:
        dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/viirsmend:1.2.17
    inputs:
      l1b:
        type: File
      geo:
        type: File
        inputBinding:
          position: 1
    outputs:
      l1b:
        type: File
        outputBinding:
          glob: "V??02???*.nc"


