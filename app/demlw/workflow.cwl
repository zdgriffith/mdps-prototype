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
      process:
        run: "#process"
        in:
          iff: iff 
        out: [iff]

  - class: CommandLineTool
    id: process
    baseCommand: ifflw
    requirements:
      InitialWorkDirRequirement:
        listing:
          - $(inputs.iff) 
      DockerRequirement:
        dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/demlw:1.0.7
    inputs:
      iff:
        type: File
        inputBinding:
          position: 0
          valueFrom: $(self.basename)
    outputs:
      iff:
        type: File
        outputSource: iff


