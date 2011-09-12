function color_alternate(sel) {
    $(sel).find("tr").each(function(idx, elem) {
        if(idx % 2 == 1) {
            $(elem).css("background-color", "#eef");
        }
    });
}

$(function() {
    $("input#timestamp").datetimepicker({
        showTimezone: true,
        dateFormat: 'yy.mm.dd',
        timeFormat: 'h:mm tt z',
        timezone: '-0500'
    });

    color_alternate("table.alternated");
});
