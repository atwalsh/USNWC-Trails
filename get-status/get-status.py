import json
from flask import Response
from google.cloud import datastore
import pendulum

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

    headers = {'Access-Control-Allow-Origin': '*',
               'Content-Type': 'application/json'}
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
    _status = 'open' if most_recent_status == OPEN else 'closed'
    _since = pendulum.instance(most_recent_status_created).to_iso8601_string()
    return Response(
        json.dumps({'status': _status, 'since': _since}),
        status=200,
        headers=headers
    )


def _500():
    return Response('Internal Server Error', status=500)
