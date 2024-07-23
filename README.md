# SITC MDPS Prototype
Code, notes, and other artifacts related to implementing a workflow in MDPS (Unity) for
the purposes of prototyping SITC utility of the system.

The end goal is to implement a pipeline that produces a CLDMSK_M3 product for NOAA20.

![CLDMSK_M3](https://sipsdev.ssec.wisc.edu/~brucef/sipsprod/api/product/CLDMSK_L3_VIIRS.svg?version=1.0dev0&parameters={})

The approximate pipeline

![CLDMSK_L0_to_M3](./artifacts/CLDMSK_L0_to_M3_chain.svg)


## Application Tasks (`./tasks`)
This directory contains sub-workflows that make up the end-to-end workflow. They are 
intended to be simply workflows containing containerized versions of parts of the 
entire workflow while not getting wrapped up in the entire Application Package spec,
e.g., STAC catlog input and output.

These tasks will be used as subworkflows to the overall workflow that will end up 
being the Application Package.


## Applicaiton Workflows (`./workflows`)
I expect these will eventually become the OGC Application packages.

Currently, there's just the WIP [process6m](./workflows/process6m.workflow.cwl) workflow.


# References:
* [MDPS/Unity Overview](https://unity-sds.gitbook.io/docs/mdps-overview)
* Examples 
  * [SBG Example Unity Workflows](https://github.com/unity-sds/sbg-workflows/)
  * [Unity Example Application](https://github.com/unity-sds/unity-example-application)
* [Dockstore](https://dockstore.org)
* [Common Workflow Language](https://www.commonwl.org/)
  * [v1.2 Spec](https://www.commonwl.org/v1.2/)
  * [Command Line Tool Reference](https://www.commonwl.org/v1.2/CommandLineTool.html)
  * [Workflow Reference](https://www.commonwl.org/v1.2/Workflow.html)
