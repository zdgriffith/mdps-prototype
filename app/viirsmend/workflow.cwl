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
        outputSource: mend/l1b
    steps:
      mend:
        run: "#viirsmend"
        in:
          l1b: l1b
          geo: geo
        out: [l1b]

  - class: CommandLineTool
    id: viirsmend 
    baseCommand: viirsmend 
    requirements:
      InitialWorkDirRequirement:
        listing:
          - $(inputs.l1b) 
      DockerRequirement:
        dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/viirsmend:1.2.17
    inputs:
      l1b:
        type: File
        inputBinding:
          position: 0
          valueFrom: $(self.basename)
      geo:
        type: File
        inputBinding:
          position: 1
    outputs:
      l1b:
        type: File
        outputBinding:
          glob: "V??02???*.nc"


