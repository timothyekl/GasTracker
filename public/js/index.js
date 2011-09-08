$(function() {
    $("input#timestamp").datetimepicker({
        showTimezone: true,
        dateFormat: 'yy.mm.dd',
        timeFormat: 'h:mm tt z',
        timezone: '-0500'
    });

    $.ajax({
        dataType: 'html',
        error: function(jqXHR, textStatus, errorThrown) {
            $("div.sidebar").html("Error loading statistics.");
        },
        success: function(data, textStatus, jqXHR) {
            $("div.sidebar").html(data);
        },
        type: 'GET',
        url: 'stats'
    });
});
