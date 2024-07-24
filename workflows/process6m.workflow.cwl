# vim: ft=yaml:
cwlVersion: v1.2
class: Workflow
id: CLDMSK_L2 

requirements:
  SubworkflowFeatureRequirement: {}

inputs:
  satellite: 
    type: string
  sci: File
  diary: File
  adcs: File
  bus: File
  demlw_datadir: Directory

outputs:
  geom: 
    type: File
    outputSource: viirsl1/geom
  l1bm: 
    type: File
    outputSource: l1bscale/l1bm 

steps:
  viirsl1:
    run: ../tasks/viirsl1/workflow.cwl
    in:
      satellite: satellite
      sci: sci
      diary: diary
      adcs: adcs
      bus: bus
    out: [l1bm, geom]

  viirsmend:
    run: ../tasks/viirsmend/workflow.cwl
    in:
      l1b: viirsl1/l1bm
      geo: viirsl1/geom
    out: [l1b]

  l1bscale:
    run: ../tasks/viirs_l1bscale/workflow.cwl
    in:
      satellite: satellite
      l1bm: viirsmend/l1b
    out: [l1bm]

  iff:
    run: ../tasks/iff/workflow.cwl
    in:
      output_type: 
        default: hdf
      l1b: l1bscale/l1bm
      geo: viirsl1/geom
    out: [iff]

  demlw:
    run: ../tasks/demlw/workflow.cwl
    in:
      l1b: iff/iff
      datadir: demlw_datadir
    out: [l1b]


