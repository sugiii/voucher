function setHistory() {
    otH = $('#table-history').DataTable({
        "columnDefs": [{
            "targets": 0,
            "width": "35%"
        }, {
            "targets": 1,
            "width": "45%"
        }, {
            "targets": 2,
            "width": "5%"
        }, {
            "targets": 3,
            "width": "5%"
        }, {
            "targets": 4,
            "width": "10%"
        }, {
            "targets": 5,
            "visible": false
        }],
        "ajax": {
            "url": 'msgforms/histload',
            "type": 'POST',
            "data": function(d) {
                return compData();
            }
        },
        "iDisplayLength": 50,
        'sDom': 't'
    })

    oTableH = $('#table-history').dataTable();

}

function dataFormLoad() {
    otH.ajax.reload(function() { bindEvent(); });
}