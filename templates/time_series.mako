<%include file="header.mako"/>
<a href="javascript:void(0)" class="show_search_form" title="Click to show the search form">Search form</a>
<a href="javascript:void(0)" class="close_search_box">X</a>
<%include file="search_boxes.mako"/>
<% title = "%s-%s" % (q['start_date'],q['end_date']) %>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(drawChart);
    function drawChart() {
        var data = google.visualization.arrayToDataTable(${frequencies});
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
        var options = {
          title: "${title}",
          hAxis: {title: 'Date', titleTextStyle: {color: 'black'}},
          vAxis: {title: 'Count', titleTextStyle: {color: 'black'}}
        }
        chart.draw(data, options);
    }
</script>
<div class="results_container">
<div class='time_series_report'>
 <p class='status'>Time Series for the term(s) "${q['q'].decode('utf_8')}"</p>
 <div id="chart_div" style="width: 900px; height: 500px;"></div>
</div>
</div>
<%include file="footer.mako"/>