<%include file="header.mako"/>
<%include file="search_boxes.mako"/>
<div class='philologic_response'>
 <div class='initial_report'>
 <p class='description'>
  <%
  start, end, n = f.link.page_interval(results_per_page, results, q["start"], q["end"])
  kwic_results = fetch_kwic(results, path, q, f.link.byte_query, start-1, end)
  r_status = "."
  if not results.done:
     r_status += " Still working.  Refresh for a more accurate count of the results."  
  %>
  Hits <span class="start">${start}</span> - <span class="end">${end}</span> of ${len(results)}${r_status}
  </p>
 </div>
 <%include file="show_frequency.mako"/>
 <div class="results_container">
 <% current_pos = start %>
  % for i in kwic_results:
   <div class="kwic_concordance">
   % if len(str(end)) > len(str(current_pos)):
    <% spaces = ' ' * (len(str(end)) - len(str(current_pos))) %>
    <span id="position" style="white-space:pre-wrap;">${current_pos}.${spaces}</span>
   % else:
    <span id="position">${current_pos}.</span>    
   % endif
   ${i}</div>
   <% current_pos += 1 %>
  % endfor
 </div>
 <div class="more">
 <%include file="pages.mako" args="start=start,results_per_page=results_per_page,q=q,results=results"/>
 <div style='clear:both;'></div>
 </div>
</div>
<%include file="footer.mako"/>
