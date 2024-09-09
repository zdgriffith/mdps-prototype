# vim: ft=yaml:
cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

inputs:
  stac_json: string
  input_unity_dapa_client: 
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
      stac_json: cmr-step/results
      input_unity_dapa_client: "40c2s0ulbhp9i0fmaph3su9jch"
    out: [results, outdir]

  process:
    run: tasks/process.cwl
    in:
      indir: stage_in/outdir
    out: [outdir]


