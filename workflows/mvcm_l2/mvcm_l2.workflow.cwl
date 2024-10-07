# vim: ft=yaml:
cwlVersion: v1.2
class: Workflow
doc: |-
  Runs all the 6m L2 processing neccessary to product MVCM. This currently includes
  oisst2bin, viirsmend, IFF.

  Required inputs:
    - VIIRS 02MOD, 03MOD
    - GDAS, 1 before, 1 after target time
    - NISE
    - SST (OISST)

requirements:
  SubworkflowFeatureRequirement: {}
  NetworkAccess:
    networkAccess: true
  StepInputExpressionRequirement: {}

inputs:
  l1b: 
    type: string
  geo: 
    type: string
  gdas1: 
    type: string
  gdas2: 
    type: string
  nise: 
    type: string
  sst: 
    type: string
  stac_json:
    type:
      - string
      - File
  download_type:
    type: string
    default: "S3"
  unity_client_id:
    type: string
    default: "40c2s0ulbhp9i0fmaph3su9jch"

outputs:
  outfile:
    type: File 
    outputSource: process/outfile

steps:
  stage_in:
    run: "http://awslbdockstorestack-lb-1429770210.us-west-2.elb.amazonaws.com:9998/api/ga4gh/trs/v2/tools/%23workflow%2Fdockstore.org%2Fmike-gangl%2Funity-example-application/versions/8/PLAIN-CWL/descriptor/%2Fstage_in.cwl"
    in:
      download_type: download_type
      stac_json: stac_json
      unity_client_id: unity_client_id
    out: [stage_in_collection_file, stage_in_download_dir]

  process:
    run: tasks/process.cwl
    in:
      l1b: l1b
      geo: geo
      sst: sst
      nise: nise
      gdas1: gdas1
      gdas2: gdas2
      indir: stage_in/stage_in_download_dir
    out: [outfile]
