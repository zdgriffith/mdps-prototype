# vim: ft=yaml:
cwlVersion: v1.2
class: Workflow
id: viirsl1
label: NASA VIIRS Level-1 L1A, L1B, and GEO 

requirements:
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/viirsl1:v3.1.0

inputs:
  version:
    type: string
    default: "v3.1.0"
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
    outputSource: viirsl1-l1b/mod
  geom:
    type: File
    outputSource: viirsl1-geo/mod
  l1bi: 
    type: File
    outputSource: viirsl1-l1b/img
  geoi:
    type: File
    outputSource: viirsl1-geo/img
  l1bd: 
    type: File
    outputSource: viirsl1-l1b/dnb
  geod:
    type: File
    outputSource: viirsl1-geo/dnb

steps:
  viirsl1-l1a:
    run: l1a-step.cwl
    id: viirsl1-l1a
    in:
      version: version
      satellite: satellite
      sci: sci
      diary: diary
      adcs: adcs
      bus: bus
      soh: soh
    out: [l1a]

  viirsl1-l1b:
    run: l1b-step.cwl
    id: viirsl1-l1b
    in:
      version: version
      satellite: satellite
      l1a: viirsl1-l1a/l1a
    out: [mod, dnb, img, cdg]

  viirsl1-geo:
    run: geo-step.cwl
    id: viirsl1-geo
    in:
      version: version
      satellite: satellite
      l1a: viirsl1-l1a/l1a
    out: [mod, dnb, img]


