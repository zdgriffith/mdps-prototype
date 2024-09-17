# vim: ft=yaml:
cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}
  NetworkAccess:
    networkAccess: true
  StepInputExpressionRequirement: {}

inputs:
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
  datadir:
    type: Directory
    outputSource: process/outdir
  # catdir:
  #   type: Directory
  #   outputSource: catgen/outdir
  outdir:
    type: File
    outputSource: stage_out/stage_out_results

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
      input: stage_in/stage_in_download_dir
    out: [outdir]

  # catgen:
  #   run: tasks/catgen.cwl
  #   in:
  #     indir: process/outdir
  #     pattern:
  #       valueFrom: "*.PDS"
  #   out: [outdir]

  stage_out:
    run: "http://awslbdockstorestack-lb-1429770210.us-west-2.elb.amazonaws.com:9998/api/ga4gh/trs/v2/tools/%23workflow%2Fdockstore.org%2Fmike-gangl%2Funity-example-application/versions/8/PLAIN-CWL/descriptor/%2Fstage_out.cwl"
    in:
      output_dir: process/outdir
      staging_bucket:
        valueFrom: "asips-int-unity-data"
      collection_id:
        valueFrom: "urn:nasa:unity:asips:int:P1590011-6T___1"
    out: [failed_features, stage_out_results, successful_features]
