<%include file="header.mako"/>
  <div class='philologic_response'>
    <div class='philologic_cite'>
        <span class='title'>${obj.author}, <i>${obj.title}</i> Tome ${obj.volume}</span>
    </div>
    % if obj.philo_type == 'doc':
        <% results = navigate_doc(obj, db) %>
        % for i in results:
            <% 
            id = i.philo_id[:7]
            href = h.make_absolute_object_link(db,id)
            if i.type == "div2":
                spacing = "&nbsp;-&nbsp;"
            elif i.type == "div3":
                spacing = "&nbsp;&nbsp;&nbsp;-&nbsp;"       
            else:
                spacing = ""
            %>
            ${spacing}<a href="${href}">${i.head or "[%s]" % i.type}</a><br>
        % endfor
    % elif q['byte']:
        <div>
        ${navigate_object(obj, query_args=q['byte'])}
        </div>
    % else:
        <div>
        ${navigate_object(obj)}
        </div>
    % endif
    <div class='more'>
      
      % if obj.prev:
        <% 
        prev_id = obj.prev.split(" ")[:7]
        prev_url = h.make_absolute_object_link(db,prev_id)
        %>
        <a href='${prev_url}' class='previous'>Previous</a>
      % endif
      % if obj.next:
        <%
        next_id = obj.next.split(" ")[:7]
        next_url = h.make_absolute_object_link(db,next_id)
        %>
        <a href='${next_url}' class='next'>Next</a>
      % endif
      <div style='clear:both;'></div>
  </div>
<%include file="footer.mako"/>
