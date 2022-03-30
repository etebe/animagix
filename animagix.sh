#!/usr/bin/bash

export ARGO_SERVER=''
export ARGO_TOKEN=''
export BUCKETNAME='ani'
export ENDPOINT=''
export ACCESS_KEY=''
export SECRET_KEY=''

export ID=$(date +%s)
export INPUT_FILE=$1

echo "STEP 0/3: check if file or directory..."
if [ -d $1 ]; then echo "compressing directory..."; tar -czf ./${ID}.tar.gz $1; export INPUT_FILE=${ID}.tar.gz; fi

echo "STEP 1/3: uploading..."
python3 ./transfer_scripts/upload.py $INPUT_FILE $BUCKETNAME $ENDPOINT $ACCESS_KEY $SECRET_KEY
 
export ARGO_HTTP1=true  
export ARGO_SECURE=true
export ARGO_BASE_HREF=
export KUBECONFIG=/dev/null

echo "STEP 2/3: executing workflow..."
argo submit --from workflowtemplate/ani-remote-wft-v1.4.7 -p input-file="${INPUT_FILE}" -p id="${ID}"

echo "STEP 3/3: downloading results..."
python3 ./transfer_scripts/download.py $ID $BUCKETNAME $ENDPOINT $ACCESS_KEY $SECRET_KEY

echo "animagix - Success!"
