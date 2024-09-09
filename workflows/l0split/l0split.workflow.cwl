# vim: ft=yaml:
cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

inputs:
  stac_json: string
  unity_client_id: 
    type: string
    default: "40c2s0ulbhp9i0fmaph3su9jch"

outputs:
  outdir:
    type: Directory 
    outputSource: process/outdir

steps:

  stage_in:
    run: "http://awslbdockstorestack-lb-1429770210.us-west-2.elb.amazonaws.com:9998/api/ga4gh/trs/v2/tools/%23workflow%2Fdockstore.org%2Fmike-gangl%2Funity-example-application/versions/8/PLAIN-CWL/descriptor/%2Fstage_in.cwl"
    in:
      stac_json: stac_json
      unity_client_id: unity_client_id
    out: [stage_in_collection_file, stage_in_download_dir]

  process:
    run: tasks/process.cwl
    in:
      indir: stage_in/outdir
    out: [outdir]


