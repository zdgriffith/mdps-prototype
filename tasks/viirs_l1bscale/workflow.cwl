# vim: ft=yaml:
cwlVersion: v1.2
$graph:
  - class: Workflow
    id: main
    inputs:
      satellite: string
      l1bm: File
    outputs:
      l1bm: 
        type: File
        outputSource: l1bscale/l1bm
    steps:
      l1bscale:
        run: "#l1bscale"
        in:
          satellite: satellite
          l1bm: l1bm
        out: [l1bm]

  - class: CommandLineTool
    id: l1bscale
    baseCommand: VIIRS_L1BSCALE.exe
    arguments: ["$(inputs.l1bm)", "/opt/viirs_l1bscale/dist/$(inputs.satellite)_scale_factors.txt"]
    stdout: stdout.txt
    stderr: stderr.txt
    requirements:
      InitialWorkDirRequirement:
        listing:
          - $(inputs.l1bm) 
      DockerRequirement:
        dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/viirs_l1bscale:20230719-1
    inputs:
      satellite:
        type: string
      l1bm:
        type: File
        inputBinding:
          position: 0
          valueFrom: $(self.basename)
    outputs:
      l1bm:
        type: File
        outputBinding:
          glob: "*.nc"


