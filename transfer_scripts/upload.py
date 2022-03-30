import boto3
import sys


filename = sys.argv[1]
bucketname = sys.argv[2]
endpoint = sys.argv[3]
access_key = sys.argv[4]
secret_key = sys.argv[5]

data = open(filename, 'rb')

s3 = boto3.resource(
    service_name='s3',
    aws_access_key_id=access_key,
    aws_secret_access_key=secret_key,
    endpoint_url=endpoint,
)

s3.Bucket(bucketname).put_object(Key='data/' + filename, Body=data)

data.close()