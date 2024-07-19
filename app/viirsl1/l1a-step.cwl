# vim: ft=yaml:
cwlVersion: v1.2
class: CommandLineTool
id: viirsl1-l1a
baseCommand: [run_ocssw_viirsl1]
arguments: ["--satellite=$(inputs.satellite)", "--swdir=/opt/viirsl1/v3.1.0", "l1a"]
stdout: stdout.txt
stderr: stderr.txt
# FIXME: Necessary to map 101 to success because incomplete scans cause it to exit 101 because
#        we have not provided inputs with full context.
successCodes: [0, 101]

requirements:
  DockerRequirement:
    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/viirsl1:v3.1.0

inputs:
  satellite: 
    type: string
  granlen:
    type: int
    label: granule length in minuts
    default: 6
    inputBinding:
      prefix: --granule-len
  sci:
    type: File
    label: VIIRS Science
    inputBinding:
      position: 0
  diary:
    type: File
    label: DIARY APID 11 
    inputBinding:
      position: 1
  adcs:
    type: File
    label: ADCS APID 8, or SOH APID 30 for N21
    inputBinding:
      position: 2
  bus:
    type: File
    label: Critical BUS APID 0, or SOH APID 37 for N21
    inputBinding:
      position: 3
  soh:
    type: File?
    label: Required SOH APID 34 for N21
    inputBinding:
      prefix: -g

outputs:
  l1a:
    type: File
    outputBinding:
      glob: "V*L1A_*.nc"
  stdout:
    type: File
    outputBinding:
      glob: stdout.txt
