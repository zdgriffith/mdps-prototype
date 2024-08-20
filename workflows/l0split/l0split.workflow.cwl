# vim: ft=yaml:
cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

inputs:
  token_file: File
  cmr_collection: string
  cmr_start_time: string 
  cmr_stop_time: string
  cmr_satellite: string

outputs:
  outdir:
    type: Directory 
    outputSource: process/outdir

steps:
  cmr-step:
    run: tasks/cmr-search.cwl
    in:
      token_file: token_file
      cmr_collection: cmr_collection
      cmr_start_time: cmr_start_time
      cmr_stop_time: cmr_stop_time 
      cmr_satellite: cmr_satellite
    out: [results]

  stage_in:
    run: tasks/stage_in.cwl
    in:
      token_file: token_file
      stac_json: cmr-step/results
    out: [results, outdir]

  process:
    run: tasks/process.cwl
    in:
      indir: stage_in/outdir
    out: [outdir]


