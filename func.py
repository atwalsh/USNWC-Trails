import requests
from bs4 import BeautifulSoup
from flask import jsonify


usnwc_url = 'https://usnwc.org/'
status_element_id = 'trail-status'
trails_closed_img = 'Trails-Closed.png'
trails_open_img = 'Trails_Open.png'
OPEN = 'open'
CLOSED = 'closed'


def run(request):
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

    # Check trail status
    if status_img == trails_closed_img:
        return jsonify({'status': CLOSED})
    elif status_img == trails_open_img:
        return jsonify({'status': OPEN})
    else:
        return _500()


def _500():
    return 'Internal Server Error', 500
