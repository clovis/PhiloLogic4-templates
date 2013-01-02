<div class='form_body'>
<form id="search" action="${db.locals['db_url'] + "/dispatcher.py/"}">
<div id="report" class="report">
 <input type="radio" name="report" id="report1" value='concordance' checked="checked"><label for="report1">Concordance</label>
 <input type="radio" name="report" id="report2" value='relevance'><label for="report2">Ranked relevance</label>
 <input type="radio" name="report" id="report3" value='kwic'><label for="report3">KWIC</label>
 <input type="radio" name="report" id="report4" value='collocation'><label for="report4">Collocation</label>
 <input type="radio" name="report" id="report5" value='frequency'><label for="report5">Frequency Table</label>
 </div>
 <div id="search_elements">
 <table>
 <tr class="table_row" ><td class="first_column">Query Terms:</td><td class="second_column"><input type='text' name='q' id='q' class="search_box"></input>
 </td></tr>
 <tr><td></td>
 <td><span id='method'>
 <input type="radio" name="method" id="method1" value='proxy' checked="checked"><label for="method1">Within</label>
 <input type='text' name='arg' id='arg1' style="margin-left:15px !important;width:30px; text-align: center;"></input>
 <span style="padding-left:5px;">words</span>
 <br><input type="radio" name="method" id="method2" value='phrase'><label for="method2">Exactly</label>
 <input type='text' name='arg' id='arg2' style="margin-left:11px !important;width:30px; text-align: center;"></input>
 <span style="padding-left:5px;">words</span>
 <br><input type="radio" name="method" id="method3" value='sentence'><label for="method3">Within</label>
 <input type='text' name='arg' id='arg3' style="margin-left:15px !important;width:30px; text-align: center;"></input>
 <span style="padding-left:5px;">sentences</span>
 </span></td></tr>
% for facet in db.locals["metadata_fields"]:
    <tr class="table_row"><td class="first_column">${facet}:</td><td><input type='text' name='${facet}' id="${facet}" class="search_box"></input></td></tr>
% endfor
 </table>
<table> 
 <tr class="table_row" id="collocation"><td class="first_column">Within </td><td><span id='word_num'>
 <input type="radio" name="word_num" id="wordnum1" value="1"><label for="wordnum1">1</label>
 <input type="radio" name="word_num" id="wordnum2" value="2"><label for="wordnum2">2</label>
 <input type="radio" name="word_num" id="wordnum3" value="3"><label for="wordnum3">3</label>
 <input type="radio" name="word_num" id="wordnum4" value="4"><label for="wordnum4">4</label>
 <input type="radio" name="word_num" id="wordnum5" value="5" checked="checked"><label for="wordnum5">5</label>
 <input type="radio" name="word_num" id="wordnum6" value='6'><label for="wordnum6">6</label>
 <input type="radio" name="word_num" id="wordnum7" value='7'><label for="wordnum7">7</label>
 <input type="radio" name="word_num" id="wordnum8" value='8'><label for="wordnum8">8</label>
 <input type="radio" name="word_num" id="wordnum9" value="9"><label for="wordnum9">9</label>
 <input type="radio" name="word_num" id="wordnum10" value="10"><label for="wordnum10">10</label>
 </span> words</td></tr>
 
 <tr class="table_row" id="frequency"><td class="first_column">Frequency by:</td><td><span id='field'>
% for pos, facet in enumerate(db.locals["metadata_fields"]):
    % if pos == 0:
        <input type="radio" name="field" id="field${pos}" value='${facet}' checked='checked'><label for="field${pos}">${facet}</label>
    % else:
        <input type="radio" name="field" id="field${pos}" value='${facet}'><label for="field${pos}">${facet}</label>
    % endif
% endfor
</span>
<input type="checkbox" name="rate" id="rate" value="relative"/>per 10,000
</td></tr>

<tr class="table_row" id="results_per_page"><td class="first_column">Results per page:</td><td><span id='page_num'>
 <input type="radio" name="pagenum" id="pagenum1" value='20' checked="checked"><label for="pagenum1">20</label>
 <input type="radio" name="pagenum" id="pagenum2" value='50'><label for="pagenum2">50</label>
 <input type="radio" name="pagenum" id="pagenum3" value='100'><label for="pagenum3">100</label>
 </span></td></tr>
 <tr class="table_row"><td class="first_column"><input id="button" type='submit'/></td>
 <td><button type="reset" id="reset">Clear form</button></td></tr>
</table>
</div>
</form>
</div>