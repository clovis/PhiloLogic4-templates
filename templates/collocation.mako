<%include file="header.mako"/>
<a href="javascript:void(0)" class="show_search_form" title="Click to show the search form">Search form</a>
<a href="javascript:void(0)" class="close_search_box">X</a>
<%include file="search_boxes.mako"/>
 <p class='description'>Collocation Report for "${q['q'].decode('utf-8', 'ignore')}"</p>
 <span style="padding-left:50px">Displaying the top 100 collocates: The 100 most common words are being filtered from this report.</span>
 <div class="results_container">
 <div class='philologic_collocation'>
  <% colloc_results = fetch_collocation(results, path, q) %>
   <table class="philologic_table">
     <colgroup span="3"></colgroup>
     <tr>
      <th class="table_header">within ${q['word_num']} words on either side</th>
      <th class="table_header">within ${q['word_num']} words to left</th>
      <th class="table_header">within ${q['word_num']} words to right</th>
     </tr>

    % for all, left, right in colloc_results[:100]:
	    <tr><td class="table_column"><a href="${link(q, all[0], 'all', all[1])}">${all[0]}</a> (${all[1]})</td>
	    <td class="table_column"><a href="${link(q, left[0], 'left', left[1])}">${left[0]}</a> (${left[1]})</td>
	    <td class="table_column"><a href="${link(q, right[0], 'right', right[1])}">${right[0]}</a> (${right[1]})</td></tr>
    % endfor
   </table>
 </div>
</div>
<%include file="footer.mako"/>
