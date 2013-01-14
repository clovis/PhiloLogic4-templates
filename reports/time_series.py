#!/usr/bin env python
from __future__ import division
import sys
sys.path.append('..')
import functions as f
from functions.wsgi_handler import wsgi_response
from render_template import render_template
import json

def time_series(environ,start_response):
    db, dbname, path_components, q = wsgi_response(environ,start_response)
    hits = db.query(q["q"],q["method"],q["arg"],**q["metadata"])
    frequencies = generate_frequency(hits, q, db)
    return render_template(frequencies=frequencies,db=db,dbname=dbname,q=q,f=f, template_name='time_series.mako')

def generate_frequency(results, q, db):
    start = q['start_date']
    start = int(start[2:] + '00') ## round to the start of the century for now
    end = q['end_date']
    end = int(end[0] + (str(int(end[1]) + 1)) + '00') ## round to the beginning of the following century
    counts = {}
    for n in results:
        date = round_date(int(n["date"]))
        if not start <= date <= end :
            continue
        date = str(date)
        if date not in counts:
            counts[date] = 0
        counts[date] += 1
    

    table = []
    for k,v in sorted(counts.iteritems(),key=lambda x: x[0], reverse=False):
        q["metadata"]["date"] = '"%s"' % str(k).encode('utf-8', 'ignore')
        # Now build the url from q.
        url = f.link.make_query_link(q["q"],q["method"],q["arg"],**q["metadata"])                 
        table.append( (k,v) )

    table.insert(0, ('Date', 'Count'))
    return json.dumps(table)
    
def round_date(date):
    century = int(str(date)[:2] + '00')
    quarter = century + 25
    half = century + 50
    last_quarter = century + 75
    next_century = century + 100
    date_collection = [century, quarter, half, last_quarter, next_century]
    return min((abs(date - i), i) for i in date_collection)[1]
    
    