# E2E Workflows

![CLDMSK_L2_VIIRS](https://sipsdev.ssec.wisc.edu/~brucef/sipsprod/api/product/CLDMSK_L2_VIIRS.jpg?version=1.0&parameters={})

#### Requirements
```
pipx install cwltool
```

## Preprocess 6m (WIP)
Runs all the 6-minute granule processing steps. This includes:

* VIIRS L1
* iff
* demlw
* viirsmend (bowtie restoral)
* l1bscale

Yet to be added:

* oisst_2ncbin
* MVCM

### Requirements

##### Input L0 data
You can use `pdsfetch` to grab the necessary data
```sh
mkdir ../inputs
for name in 0000 0008 0011 0826VIIRSSCIENCE; do 
pdsfetch -o ../inputs/P159${name}-T.dat P159${name}-T 2024-07-01T00:05:00Z 2024-07-01T00:13:00Z
done
```

This workflow can be run using the `./run_process6m.sh` script.
