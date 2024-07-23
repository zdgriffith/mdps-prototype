# SITC MDPS Prototype
Code, notes, and other artifacts related to implementing a workflow in MDPS (Unity) for
the purposes of prototyping SITC utility of the system.


## Application Tasks (`./tasks`)
This directory contains sub-workflows that make up the end-to-end workflow. They are 
intended to be simply workflows containing containerized versions of parts of the 
entire workflow while not getting wrapped up in the entire Application Package spec,
e.g., STAC catlog input and output.

These tasks will be used as subworkflows to the overall workflow that will end up 
being the Application Package.



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
