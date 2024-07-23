# vim: ft=yaml:
cwlVersion: v1.2
class: Workflow
id: viirsl1
label: NASA VIIRS Level-1 L1A, L1B, and GEO 

requirements:
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/viirsl1:v3.1.0

inputs:
  satellite: 
    type: string
  sci: File
  diary: File
  adcs: File
  bus: File
  soh: File?

outputs:
  l1bm: 
    type: File
    outputSource: l1b/mod
  geom:
    type: File
    outputSource: geo/mod
  l1bi: 
    type: File
    outputSource: l1b/img
  geoi:
    type: File
    outputSource: geo/img
  l1bd: 
    type: File
    outputSource: l1b/dnb
  geod:
    type: File
    outputSource: geo/dnb

steps:
  l1a:
    run: l1a-step.cwl
    in:
      satellite: satellite
      sci: sci
      diary: diary
      adcs: adcs
      bus: bus
      soh: soh
    out: [l1a]

  l1b:
    run: l1b-step.cwl
    in:
      satellite: satellite
      l1a: l1a/l1a
    out: [mod, dnb, img, cdg]

  geo:
    run: geo-step.cwl
    in:
      satellite: satellite
      l1a: l1a/l1a
    out: [mod, dnb, img]


