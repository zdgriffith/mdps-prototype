# vim: ft=yaml:
cwlVersion: v1.2
$graph:
  - class: Workflow
    id: main
    inputs:
      outfn: string
      sensor_tag: string
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
      satellite: 
        label: one of snpp, noaa20, noaa21
        type: string
        inputBinding:
          position: 0
      outfn: 
        type: string
        inputBinding:
          prefix: -o
      sensor_tag:
        type: string
        default: viirs-nasa
        inputBinding:
          position: 1
      band_type:
        label: Type of band to process; one of svi, svm, dnb
        type: string
        inputBinding:
          position: 2
      date: 
        label: Begin date as YYYYMMDD
        type: string
        inputBinding:
          position: 3
      start_time: 
        label: Begin time as HHMMSS
        type: string
        inputBinding:
          position: 4
      end_time: 
        label: End time as HHMMSS
        type: string
        inputBinding:
          position: 5
      inputs:
        label: L1b and GEO inputs
        type: 
          items: File
        inputBinding:
          itemSeparator: " "
          position: 6
    outputs:
      iff:
        type: File
        outputSource: iff


