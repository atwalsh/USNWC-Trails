import json
from flask import jsonify, Response
from google.cloud import datastore

OPEN = True
CLOSED = False


def run(request):
    if request.method == 'OPTIONS':
        # Allows GET requests from any origin with the Content-Type
        # header and caches preflight response for an 3600s
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Max-Age': '3600'
        }

        return Response('', status=204, headers=headers)
    
    headers = {'Access-Control-Allow-Origin': '*', 'Content-Type': 'application/json'}
    # Set up datastore
    datastore_client = datastore.Client()
    datastore_kind = 'Status'
    # Query for the most recent status
    query = datastore_client.query(kind=datastore_kind)
    # Only get the most recent status entity
    query.order = ['-created']
    result = list(query.fetch(limit=1))
    if not result:
        return _500()
    most_recent_status = result[0]['status']
    most_recent_status_created = result[0]['created']
    if most_recent_status == OPEN:
        return json.dumps({'status': 'open', 'since': str(most_recent_status_created)}), 200, headers
    else:
        return json.dumps({'status': 'closed', 'since': str(most_recent_status_created)}), 200, headers


def _500():
    return Response('Internal Server Error', status=500)
