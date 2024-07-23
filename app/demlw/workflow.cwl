# vim: ft=yaml:
cwlVersion: v1.2
$graph:
  - class: Workflow
    label: DemLW for IFF files
    id: main
    inputs:
      l1b: File
      datadir: Directory
    outputs:
      l1b: 
        type: File
        outputSource: process/l1b
    steps:
      process:
        run: "#process"
        in:
          l1b: l1b
          datadir: datadir
        out: [l1b]

  - class: CommandLineTool
    id: process
    baseCommand: ifflw
    requirements:
      InitialWorkDirRequirement:
        listing:
          - $(inputs.l1b) 
      DockerRequirement:
        dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/demlw:1.0.7
      EnvVarRequirement:
        envDef:
          DEMLW_DIR: $(inputs.datadir)
    inputs:
      l1b:
        type: File
        inputBinding:
          position: 0
          valueFrom: $(self.basename)
      datadir:
        type: Directory
    outputs:
      l1b:
        type: File
        outputBinding:
          glob: "IFF???.*"


