<script type="text/javascript">
function monkeyPatchAutocomplete() {
    //taken from http://stackoverflow.com/questions/2435964/jqueryui-how-can-i-custom-format-the-autocomplete-plug-in-results    
    $.ui.autocomplete.prototype._renderItem = function( ul, item) {
        // This regex took some fiddling but should match beginning of string and
        // any match preceded by a string: this is useful for sql matches.
        var re = new RegExp('((^' + this.term + ')|( ' + this.term + '))', "gi") ; 
        var t = item.label.replace(re,"<span style='font-weight:bold;color:Red;'>" + 
                "$&" + 
                "</span>");
        return $( "<li></li>" )
            .data( "item.autocomplete", item )
            .append( "<a>" + t + "</a>" )
            .appendTo( ul );
    };
}

var pathname = window.location.pathname.replace('dispatcher.py/', '');

function autocomplete_metadata(metadata, field) {
    $("#" + field).autocomplete({
        source: pathname + "scripts/metadata_list.py?field=" + field,
        minLength: 2,
        dataType: "json"
    });
}

var fields = ${repr(db.locals['metadata_fields'])}


$(document).ready(function(){
    
    var pathname = window.location.pathname.replace('dispatcher.py/', '');
    var db_path = window.location.hostname + pathname;
    var q_string = window.location.search.substr(1);
    
    
    $(".show_search_form").tooltip({ position: { my: "left+10 center", at: "right" } });
    $(".show_search_form").click(function() {
        link = $(this).text()
        $(".close_search_box").toggle()
        $(".form_body").slideToggle()
    });
    $(".close_search_box").click(function(){
        $(this).toggle()
        $(".form_body").slideToggle()
    })
    
    monkeyPatchAutocomplete();    
    
    $("#q").autocomplete({
        source: pathname + "scripts/term_list.py",
        minLength: 2,
        "dataType": "json"
    });
    for (i in fields) {
        var  metadata = $("#" + fields[i]).val();
        var field = fields[i];
        autocomplete_metadata(metadata, field)
    }
    //    The following is to display the right options when using the back button
    if ($("#report option[value='concordance']").attr('checked')) {
        $("#frequency").hide()
        $("#collocation").hide()
        $("#results_per_page").show()
    }
    if ($("#report option[value='kwic']").attr('checked')) {
        $("#frequency").hide()
        $("#collocation").hide()
        $("#results_per_page").show()
    }
    if ($("#report option[value='collocation']").attr('checked')) {
        $("#frequency").hide()
        $("#results_per_page").hide()
        $("#collocation").show()
    }
    if ($("#report option[value='frequency']").attr('checked')) {
        $("#collocation").hide()
        $("#results_per_page").hide()
        $("#frequency").show()
    }
    if ($("#report option[value='relevance']").attr('checked')) {
        $("#frequency").hide()
        $("#collocation").hide()
        $("#results_per_page").show()
    }
    
    //  This is for displaying the full bibliography on mouse hover
    //  in kwic reports
    var config = {    
        over: showBiblio, 
        timeout: 100,  
        out: hideBiblio   
    };
    $(".kwic_biblio").hoverIntent(config)

    //  This will show more context in concordance searches
    $(".more_context").click(function() {
        var context_link = $(this).text();
        if (context_link == 'More') {
            $(this).siblings('.philologic_context').children('.begin_concordance').show()
            $(this).siblings('.philologic_context').children('.end_concordance').show()
            $(this).empty().fadeIn(100).append('Less')
        } 
        else {
            $(this).siblings('.philologic_context').children('.begin_concordance').hide()
            $(this).siblings('.philologic_context').children('.end_concordance').hide()
            $(this).empty().fadeIn(100).append('More')
        }
    });
    
    //  This will prefill the search form with the current query
    var val_list = q_string.split('&');
    for (var i = 0; i < val_list.length; i++) {
        var key_value = val_list[i].split('=');
        var my_value = decodeURIComponent((key_value[1]+'').replace(/\+/g, '%20'));
        if (my_value) {
            if (key_value[0] == 'pagenum' || key_value[0] == 'report' || key_value[0] == 'field' || key_value[0] == 'word_num' || key_value[0] == 'method') {
                $('input[name=' + key_value[0] + '][value=' + my_value + ']').attr("checked", true);
            }
            else if (my_value == 'relative') {
                $('#' + key_value[0]).attr('checked', true);
            }
            else if (key_value[0] == 'arg') {
                $('input[name="arg"]').val(my_value)
            }
            else {
                $('#' + key_value[0]).val(my_value);
            }
        }
    }
    
    showHide($('input[name=report]:checked', '#search').val());
    
    $('#report').change(function() {
        var report = $('input[name=report]:checked', '#search').val();
        showHide(report);
    });
    
    
    //  Clear search form
    $("#reset").click(function() {
        $("#q").empty();
        $("#arg").empty();
        for (i in fields) {
            var field = $("#" + i);
            $(field).empty();
        }
        $("#method1").attr('checked', true).button("refresh");
        $("#report1").attr('checked', true).button("refresh");
        $("#pagenum1").attr('checked', true).button("refresh");
        showHide('concordance');
    });
    
    //  This is to select the right option when clicking on the input box  
    $("#arg1").focus(function() {
        $("#method1").attr('checked', true).button("refresh");
    });
    $("#arg2").focus(function() {
        $("#method2").attr('checked', true).button("refresh");
    });
    $("#arg3").focus(function() {
        $("#method3").attr('checked', true).button("refresh");
    });
    
    //    This will display the sidebar for various frequency reports
    $("#toggle_frequency").click(function() {
        toggle_frequency(q_string, db_path, pathname);
    });
    $("#frequency_field").change(function() {
        toggle_frequency(q_string, db_path, pathname);
    });
    $(".hide_frequency").click(function() {
        hide_frequency();
    });
    
    //  jQueryUI theming
    $( "#button" )
            .button()
            .click(function( event ) {
                $(".form_body").slideUp();
            });
    $("#reset").button();
    $("#report, #page_num, #word_num, #field, #method").buttonset()
    
});

function showHide(value) {
    if (value == 'frequency') {
        $("#search_elements").hide()
        $("#collocation").hide()
        $("#results_per_page").hide()
        $("#frequency, #method").show()
        $("#search_elements").fadeIn('fast')
    }
    if (value == 'collocation') {
        $("#search_elements").hide()
        $("#frequency").hide()
        $("#results_per_page").hide()
        $("#method").hide()
        $("#collocation").show()
        $("#search_elements").fadeIn('fast')
    }
    if (value == 'concordance' || value == 'kwic') {
        $("#search_elements").hide()
        $("#frequency").hide()
        $("#collocation").hide()
        $("#results_per_page, #method").show()
        $("#search_elements").fadeIn('fast')
    }
    if (value == 'relevance') {
        $("#search_elements").hide()
        $("#frequency").hide()
        $("#collocation").hide()
        $("#method").hide()
        $("#results_per_page").show()
        $("#search_elements").fadeIn('fast')
    }
}

// These functions are for the kwic bibliography which is shortened by default
function showBiblio() {
    $(this).css('background', 'LightGray')
    $(this).children("#full_biblio").css('position', 'absolute').css('text-decoration', 'underline')
    $(this).children("#full_biblio").css('background', 'LightGray')
    $(this).children("#full_biblio").css('display', 'inline')
}

function hideBiblio() {
    $(this).css('background', 'white')
    $(this).children("#full_biblio").hide(200)
}

//    These functions are for the sidebar frequencies
function toggle_frequency(q_string, db_url, pathname) {
    var field =  $("#frequency_field").val();
    if (field != 'collocate') {
        var script_call = "http://" + db_url + "scripts/get_frequency.py?" + q_string + "&frequency_field=" + field;
    } else {
        var script_call = "http://" + db_url + "scripts/get_collocate.py?" + q_string
    }
    $(".loading").empty().hide();
    var spinner = '<img src="http://' + db_url + '/js/spinner-round.gif" alt="Loading..." />';
    if ($("#toggle_frequency").hasClass('show_frequency')) {
        $(".results_container").animate({
            "margin-right": "330px"},
            50);
        $("#freq").empty();
        $(".loading").append(spinner).show();
        $.getJSON(script_call, function(data) {
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

</script>