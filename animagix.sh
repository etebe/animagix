#!/usr/bin/bash

export ARGO_SERVER='workflows.edgar.biokube.org:443'
export ARGO_TOKEN='Bearer v2:eyJhbGciOiJSU0EtT0FFUC0yNTYiLCJlbmMiOiJBMjU2R0NNIiwiemlwIjoiREVGIn0.rq6WiflQ7EycD8MdBYBxdoeOSSfEY8EhVq55H7-bFuVmINoW--pbBqAmiXgextrZonUmi_Y5BSFF-X4qvEFKDnQ2tWsqoTmecA1CEHegVEtzFImOP_W1bBOGEEdv9IaGXGZVOPgU15Zc_C-tQVr6GajOslhu_D8EOMUEcs4VSMuyFBbAn0T_7UtxzSiKoSP-wq4SnaCzbfkkuaZS6oXLrYiGwK1vGe5WGQ13_O6xaoVbFlFV1Hc_CnqXaCh-IlCk10bpcT5cuMFM97GOLEv3xTLYwPw-U8j0TWzmv_HqnRa88cn3Vjj7oRo5TyrWItO9LaYypEn5IVmZYb3koiLLgw.JHBVM7JM-WJlC3rw.1KTitEwRxRpZxUj28C0Bv19v_IC7vVN6ta53DSCSKd1uvUsSIdhcFkKTXhwFN1zNnyLgTntwnpZHgvx5Rfg-T5RgDeHX49u6WuyEwCdoIEsWyw.ee5gUlp4p-fB-4rFuNbFLA' 
export ARGO_NAMESPACE=argowf
export BUCKETNAME='ani'
export ENDPOINT='https://s3.computational.bio.uni-giessen.de'
export ACCESS_KEY='3059dcfa9c374b5cbbb3b58fc9efd652'
export SECRET_KEY='913c95e43993482fa921e305b70d6562'

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