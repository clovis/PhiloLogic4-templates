<%include file="header.mako"/>
<script>	  	
$(document).ready(function(){	  	
    $(".form_body").show();
    $("#form_separation").hide();
});	  	
</script>
<span class="show_search_form">Search form</span>
<%include file="search_boxes.mako"/>
<%include file="footer.mako"/>
