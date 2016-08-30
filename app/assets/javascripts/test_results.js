function setResult() {
    otR = $('#table-result').DataTable({
        "columnDefs": [{
            "targets": 0,
            "width": "30%"
        }, {
            "targets": 1,
            "width": "10%"
        }, {
            "targets": 2,
            "width": "10%"
        }, {
            "targets": 3,
            "width": "5%"
        }, {
            "targets": 4,
            "width": "5%"
        }, {
            "targets": 5,
            "width": "20%"
        }, {
            "targets": 6,
            "width": "10%"
        }],
        "iDisplayLength": 50,
        'sDom': 't'
    })

    oTableR = $('#table-result').dataTable();

}