import json
import os
import boto3
from datetime import datetime

def lambda_handler(event, context):
    date = datetime.now()
    req = json.loads(json.dumps(event))

    if "componente" in req:
        componente = req['componente']
    else:
        return {
            'statusCode': 400,
            'body': "Componente params not found" 
        }    
    
    if "versao" in req:
        versao = req['versao']
    else:
        return {
            'statusCode': 400,
            'body': "Versao params not found" 
        }
   
    if "responsavel" in req:
        responsavel = req['responsavel']
    else:
        return {
            'statusCode': 400,
            'body': "Responsavel params not found" 
        }

    if "status" in req:
        status = req['status']
    else:
        return {
            'statusCode': 400,
            'body': "Status params not found" 
        }

    resp = {"componente": componente, "versao": versao, "responsavel": responsavel, "status": status, "data": date}
    name = componente + "/" + versao + ".json"
    bucket = os.environ.get('S3_BUCKET')
    s3 = boto3.resource('s3')
    obj =  s3.Object(bucket, name)
    obj.put(Body=bytes(json.dumps(resp, default=dateconverter).encode('UTF-8')))

    return {
        'statusCode': 200,
        'body': "Saved"
    }

def dateconverter(o):
    if isinstance(o, datetime):
        return o.__str__()