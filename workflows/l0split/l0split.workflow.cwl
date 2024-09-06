# vim: ft=yaml:
cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

inputs:
  # Inputs for searching Unity catalog
  search_collection: string
  search_begin_time: string 
  search_end_time: string

outputs:
  outdir:
    type: Directory 
    outputSource: process/outdir

steps:
  catalog:
    run: tasks/cmr-search.cwl
    in:
      token_file: token_file
      search_collection: search_collection
      search_start_time: search_start_time
      search_stop_time: search_stop_time 
    out: [results]

  stage_in:
    run: "http://awslbdockstorestack-lb-1429770210.us-west-2.elb.amazonaws.com:9998/api/ga4gh/trs/v2/tools/%23workflow%2Fdockstore.org%2Fmike-gangl%2Funity-example-application/versions/8/PLAIN-CWL/descriptor/%2Fstage_in.cwl"
    in:
      stac_json: cmr-step/results
    out: [results, outdir]

  process:
    run: tasks/process.cwl
    in:
      indir: stage_in/outdir
    out: [outdir]


