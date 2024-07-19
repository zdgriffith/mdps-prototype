# VIIRS L1 OCG Application

**Work In Progress**

### TODO
1. Take STAC Catalog inputs
    * See example https://docs.ogc.org/bp/20-089r1.html#toc2
2. Write STAT Catlog outputs
3. Determine if #1 and #2 are necessary or if that's handled by the MDPS infrastructure
4. Get a SIPS accessible VIIRS L1 Docker image build
5. The scriptage doesn't work for the appropriate sized level-0 granles that 
   include 10s of context level-0 as run on the SIPS


## Running

Requires [cwltool](https://github.com/common-workflow-language/cwltool)
```console
pipx install cwltool
```

#### Create Inputs
This will require `pdsfetch` that can be found on `sipsdev`.
```console
mkdir inputs
for name in 0000 0008 0011 0826VIIRSSCIENCE; do
pdsfetch -o inputs/P159${name}.dat P159${name}-T 2024-07-01T00:06:00Z 2024-07-01T00:12:00Z
done
```

**NOTE**: It currently 

Create the input YAML file 
```console
cat << EOF > workflow-input.yaml
satellite: noaa20
sci: 
  class: File
  path: inputs/P1590826VIIRSSCIENCE.dat
diary: 
  class: File
  path: inputs/P1590011.dat
adcs: 
  class: File
  path: inputs/P1590008.dat
bus: 
  class: File
  path: inputs/P1590000.dat
EOF
```

#### Run the Workflow
```console
cwltool app/viirsl1/workflow.cwl workflow-input.yam
```


## Docker Image
The viirsl1 docker image is built from a software install in then DbRTN software
repository.

https://gitlab.ssec.wisc.edu/dbrtn/dbrtnull-sw/-/tree/main/software-build?ref_type=heads
