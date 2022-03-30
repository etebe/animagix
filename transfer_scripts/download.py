import boto3
import sys
import os

identity = sys.argv[1]
bucketname = sys.argv[2]
endpoint = sys.argv[3]
access_key = sys.argv[4]
secret_key = sys.argv[5]

if not os.path.isdir('../results'):
    os.mkdir('../results')

s3 = boto3.resource(
    service_name='s3',
    aws_access_key_id=access_key,
    aws_secret_access_key=secret_key,
    endpoint_url=endpoint,
)

s3.Bucket(bucketname).download_file('res/' + 'output_' + identity + '_json.tar.gz',
    '../results/output_' + identity + '_json.tar.gz')
s3.Bucket(bucketname).download_file('res/' + 'output_' + identity + '_csv.tar.gz',
    '../results/output_' + identity + '_csv.tar.gz')