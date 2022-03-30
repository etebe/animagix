# animagix-cli

This script aggregation provides the execution of the
argo workflow template which is deposited in the cluster. It will calculate
the Average Nucleotide Identity (ANI) of your local FASTA-files and returns
the results in JSON and CSV format.
If your files are not already in .tar.gz format, animagix will compress your directory.

## prerequisites:
- bash
- python3 with boto3 installed
```
python -m pip install boto3
```
- argo cli:
[ARGO CLI Quick Start](https://github.com/argoproj/argo-workflows/releases/tag/v3.3.1)

## How to:
#### 1. Edit these variables in the animagix shell-script:
- ARGO_SERVER in single quotes. You find this in your argo UI under "User".
- ARGO_TOKEN in single quotes. You find this in your argo UI under "User".
- ARGO_NAMESPACE without quotes. Provided by your cluster admin.
- BUCKETNAME in single quotes. Must have been created manually in advance.
- ENDPOINT in single quotes. Provided by your cluster admin.
- ACCESS_KEY in single quotes. You find this in your OpenStack Project.
- SECRET_KEY in single quotes. You find this in your OpenStack Project.

#### 2. Execute:
Consider that your current terminal will be engaged for time when the workflow is running.

From within the animagix directory, execute the animagix-cli like the following:
```
./animagix.sh myFastaFiles.tar.gz
or
./animagix.sh myFastaDir/
```
