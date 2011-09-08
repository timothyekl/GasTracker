$(function() {
    $("input#timestamp").datetimepicker({
        showTimezone: true,
        dateFormat: 'yy.mm.dd',
        timeFormat: 'h:mm tt z',
        timezone: '-0500'
    });
});
