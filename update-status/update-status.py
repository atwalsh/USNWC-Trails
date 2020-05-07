import os
import json

import requests
import pytz
from bs4 import BeautifulSoup
from flask import jsonify, Response
from datetime import datetime
from google.cloud import datastore

usnwc_url = 'https://usnwc.org/'
status_element_id = 'trail-status'
trails_closed_img = 'Trails-Closed.png'
trails_open_img = 'Trails_Open.png'
OPEN = True
CLOSED = False


def run(request):
    if json.loads(request.data)['AUTH_TOKEN'] != os.environ['CLOUD_SCHEDULER_AUTH_TOKEN']:
        return Response('Unauthorized', status=401)
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

    # Load USNWC website
    r = requests.get(usnwc_url)
    if r.status_code != 200:
        return _500()

    # Parse site
    site = BeautifulSoup(r.text, 'html.parser')
    try:
        status_img = site.find(
            id=status_element_id).img.attrs['src'].split('/')[-1]
    except AttributeError:
        return _500()

    # Get the current status
    if status_img == trails_closed_img:
        current_status = CLOSED
    elif status_img == trails_open_img:
        current_status = OPEN
    else:
        return _500()

    # Update status if required
    if most_recent_status != current_status:
        new_status = datastore.Entity(datastore_client.key(datastore_kind))
        new_status.update({
            'created': datetime.now(pytz.UTC),
            'status': current_status
        })
        datastore_client.put(new_status)
    return Response('Status updated', status=200)


def _500():
    return Response('Internal Server Error', status=500)
