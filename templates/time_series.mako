<%include file="header.mako"/>
<a href="javascript:void(0)" class="show_search_form" title="Click to show the search form">Search form</a>
<a href="javascript:void(0)" class="close_search_box">X</a>
<%include file="search_boxes.mako"/>
<% title = "%s-%s" % (q['start_date'],q['end_date']) %>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
google.load("visualization", "1", {packages:["corechart"]});
$(document).ready(function(){
    var mydata = eval($("#relative_time").val());
    google.setOnLoadCallback(drawChart(mydata, "Rate per 10000 words"));
    $('#absolute_time').click(function() {
        var mydata = eval($(this).val());
        $("#chart").empty();
        google.setOnLoadCallback(drawChart(mydata,"Count"));
    });
    $('#relative_time').click(function() {
        var mydata = eval($(this).val());
        $("#chart").empty();
        google.setOnLoadCallback(drawChart(mydata,"Rate per 10000 words"));
    });
});
function drawChart(mydata, count_type) {
    var data = google.visualization.arrayToDataTable(mydata);
    var chart = new google.visualization.ColumnChart(document.getElementById('chart'));
    var options = {
      title: "${title}",
      hAxis: {title: 'Date', titleTextStyle: {color: 'black'}},
      vAxis: {title: count_type, titleTextStyle: {color: 'black'}}
    }
    chart.draw(data, options);
}
</script>
<div class="results_container">
<div class='time_series_report'>
 <p class='status'>Time Series for the term(s) "${q['q'].decode('utf_8')}"</p>
 <div id="time_series_buttons">
 <input type="radio" name="freq_type" id="relative_time" value='${relative_frequencies}' checked="checked"><label for="relative_time">Relative frequency</label>
 <input type="radio" name="freq_type" id="absolute_time" value='${frequencies}'><label for="absolute_time">Absolute frequency</label>
 </div>
 <div id="chart" style="width: 900px; height: 500px;"></div>
</div>
</div>
<%include file="footer.mako"/>