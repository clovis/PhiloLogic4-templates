<script>
$(document).ready(function(){
    $("#toggle_frequency").click(function() {
        var field = $("#frequency_field").val();
        if (field != 'collocate') {
            toggle_frequency(field);   
        }
        else {
            toggle_collocation(field);
        }
    });
    $("#frequency_field").change(function() {
        var field = $("#frequency_field").val();
        if (field != 'collocate') {
            toggle_frequency(field);   
        }
        else {
            toggle_collocation(field);
        }
    });
    $(".hide_frequency").click(function() {
        hide_frequency();
    });
});

function toggle_frequency() {
    var field = $("#frequency_field").val();
    $(".loading").empty().hide();
    var spinner = '<img src="${db.locals['db_url']}/js/spinner-round.gif" alt="Loading..." />';
    if ($("#toggle_frequency").hasClass('show_frequency')) {
        $(".results_container").animate({
            "margin-right": "330px"},
            50);
        $("#freq").empty();
        $(".loading").append(spinner).show();
        $.getJSON("${db.locals['db_url']}/scripts/get_frequency.py?frequency_field=" + field + '&${q['q_string']}', function(data) {
            $(".loading").hide().empty();
            $.each(data, function(index, item) {
                if (item[0].length > 30) {
                    var url = '<a href="' + item[2] + '">' + item[0].slice(0,30) + '[...]</a>'
                } else {
                    var url = '<a href="' + item[2] + '">' + item[0] + '</a>'
                } 
                $("#freq").append('<p><li>' + url + '<span style="float:right;padding-right:20px;">' + item[1] + '</span></li></p>');
            });
        });
        $(".hide_frequency").show();
        $("#freq").show();
    }
}
function hide_frequency() {
    $(".hide_frequency").fadeOut();
    $("#freq").hide();
    $(".results_container").animate({
        "margin-right": "0px"},
        50);
}
function toggle_collocation(field) {
    $(".loading").empty().hide();
    var spinner = '<img src="${db.locals['db_url']}/js/spinner-round.gif" alt="Loading..." />';
    if ($("#toggle_frequency").hasClass('show_frequency')) {
        $(".results_container").animate({
            "margin-right": "330px"},
            50);
        $("#freq").empty();
        $(".loading").append(spinner).show();
        $.getJSON("${db.locals['db_url']}/scripts/get_collocate.py?${q['q_string']}", function(data) {
            $(".loading").hide().empty();
            $.each(data, function(index, item) {
                if (item[0].length > 30) {
                    var url = '<a href="' + item[2] + '">' + item[0].slice(0,30) + '[...]</a>'
                } else {
                    var url = '<a href="' + item[2] + '">' + item[0] + '</a>'
                } 
                $("#freq").append('<p><li>' + url + '<span style="float:right;padding-right:20px;">' + item[1] + '</span></li></p>');
            });
        });
        $(".hide_frequency").show();
        $("#freq").show();
    }
}
</script>
<div class="sidebar_display">
<span id="toggle_frequency" class="show_frequency">
<a href="javascript:void(0)">Click to show frequency by:</a>
</span>
<a href="javascript:void(0)" class="hide_frequency" style="display:none;">X</a>
<select id='frequency_field'>
% for facet in db.locals["metadata_fields"]:
    <option value='${facet}'>${facet}</option>
% endfor
    <option value='collocate'>collocate</option>
</select>
<div class="loading" style="display:none;"></div>
<div id="freq" class="frequency_table" style="display:none;"></div>
</div>