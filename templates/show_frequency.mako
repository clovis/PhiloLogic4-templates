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