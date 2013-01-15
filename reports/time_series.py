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
    start = int(q['start_date'])
    end = int(q['end_date'])
    counts = {}
    for n in results:
        try:
            if q["year_interval"] == "25":
                date = round_quarter(int(n["date"]))
            else:
                date = round_decade(int(n["date"]))
        except ValueError: ## No valid date
            continue
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
    
def round_quarter(date):
    century = int(str(date)[:2] + '00')
    quarter = century + 25
    half = century + 50
    last_quarter = century + 75
    next_century = century + 100
    date_collection = [century, quarter, half, last_quarter, next_century]
    return min((abs(date - i), i) for i in date_collection)[1]

def round_decade(date):
    decade_before = int(str(date)[:3] + '0')
    decade_after = int(str(date)[:2] + str(int(str(date)[2]) + 1) + '0')
    date_collection = [decade_before, decade_after]
    return min((abs(date - i), i) for i in date_collection)[1]
    
    