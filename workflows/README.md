
## Setup

Install CWL Reference Executor
```console
python3 -m venv venv
./venv/bin/python3 -m pip install cwltool
```

Build the required docker images
```console
pushd workflow
./docker/build.sh
popd
```

### Run indivitual steps
The E2E workflow is not yet working, but you can run the individual `search` and `preprocess` workflows.


Search
```console
cwltool search/search_workflow.cwl search-test.inputs.yaml
```
which will write a search-results.json file to the current dir.


Preprocess
```console
cwltool preprocess/preprocess_workflow.cwl preprocess-test.inputs.yaml
```
which will download the files from `search-results.json` and split them into 6m files
writing the resulting filenames to `preprocess-results.json`



