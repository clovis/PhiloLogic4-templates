<%include file="header.mako"/>
<a href="javascript:void(0)" class="show_search_form" title="Click to show the search form">Search form</a>
<a href="javascript:void(0)" class="close_search_box">X</a>
<%include file="search_boxes.mako"/>
<script>
$(document).ready(function() {
    $("#form").submit(function() {
        $(".form_body").slideUp()
        $(this).fadeOut(100).empty().append('Show search form').fadeIn(100)
        $("#form").submit();
    }
});
</script>
<div class="results_container">
<div class='philologic_response'>
 <p class='description'>Bibliography Report: ${len(results)} results.</p>
 <div class='bibliographic_results'>
 <ol class='philologic_cite_list'>
 % for i in results:
  <li class='philologic_occurrence'>
##  <input type="checkbox" name="philo_id" value="${i.philo_id}">
  % if i.type == 'doc':
  <span class='philologic_cite'>${f.cite.make_doc_cite(i)}</span>
  % else:
  <span class='philologic_cite'>${f.cite.make_div_cite(i)}</span>
  % endif
  </li>
 % endfor
 </ol>
</div>
</div>
</div>
<%include file="footer.mako"/>
