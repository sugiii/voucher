// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function restoreRow(nRow) {
    var aData = oTable.fnGetData(nRow);
    var jqTds = $('>td', nRow);

    for (var i = 0, iLen = jqTds.length; i < iLen; i++) {
        oTable.fnUpdate(aData[i], nRow, i, false);
    }

    oTable.fnDraw();
}

function editRow(nRow) {
    var aData = oTable.fnGetData(nRow);
    var jqTds = $('>td', nRow);
    jqTds[1].innerHTML = '<input type="text" style="width:100%;" value="' + aData[1] + '">';
    //jqTds[2].innerHTML = '<input type="text" style="width:100%;" value="' + aData[2] + '">';
    jqTds[3].innerHTML = '<input type="text" style="width:100%;" value="' + aData[3] + '">';
    jqTds[4].innerHTML = '<input type="text" style="width:100%;" value="' + aData[4] + '">';
    jqTds[5].innerHTML = '<input type="text" style="width:100%;" value="' + aData[5] + '">';
    jqTds[6].innerHTML = '<a class="edit" style="width:100%;" href="/">Done</a>';
    bindEvent();
}

function saveRow(nRow) {
    var aData = oTable.fnGetData(nRow);
    var jqInputs = $('input', nRow);

    oTable.fnUpdate(jqInputs[0].value, nRow, 1);
    //oTable.fnUpdate(jqInputs[1].value, nRow, 2);
    oTable.fnUpdate(jqInputs[1].value, nRow, 3);
    oTable.fnUpdate(jqInputs[2].value, nRow, 4);
    oTable.fnUpdate(jqInputs[3].value, nRow, 5);
    oTable.fnUpdate('<input type="checkbox" name="select" value="">', nRow, 6);
    if (aData[7] == '0') {
        oTable.fnUpdate('2', nRow, 7);
    }
    oTable.fnDraw();
    bindEvent();
}

function editValRow(nRow) {
    var aData = oTable.fnGetData(nRow);
    var jqTds = $('>td', nRow);
    //jqTds[1].innerHTML = '<input type="text" style="width:100%;" value="' + aData[1] + '">';
    jqTds[2].innerHTML = '<input type="text" style="width:100%;" value="' + aData[2] + '">';
    //jqTds[3].innerHTML = '<input type="text" style="width:100%;" value="' + aData[3] + '">';
    //jqTds[4].innerHTML = '<input type="text" style="width:100%;" value="' + aData[4] + '">';
    //jqTds[5].innerHTML = '<input type="text" style="width:100%;" value="' + aData[5] + '">';
    jqTds[6].innerHTML = '<a class="edit_val" style="width:100%;" href="/">Done</a>';
    bindEvent();
}

function saveValRow(nRow) {
    var aData = oTable.fnGetData(nRow);
    var jqInputs = $('input', nRow);

    //oTable.fnUpdate(jqInputs[0].value, nRow, 1);
    oTable.fnUpdate(jqInputs[0].value, nRow, 2);
    //oTable.fnUpdate(jqInputs[1].value, nRow, 3);
    //oTable.fnUpdate(jqInputs[2].value, nRow, 4);
    //oTable.fnUpdate(jqInputs[3].value, nRow, 5);
    oTable.fnUpdate('<input type="checkbox" name="select" value="">', nRow, 6);
    oTable.fnUpdate('3', nRow, 7);
    oTable.fnDraw();
    bindEvent();
}

var nEditing;
var oTable, ot;

function insertTestData(json_data) {
    data = json_data['data'];
    for (i = 0; i < data.length; i++) {
        var aData = oTable.fnGetData(i);
        oTable.fnUpdate(data[i][1], data[i][0] - 1, 2, false);
    }

    oTable.fnDraw();
}

function bindEvent() {
    $('#table-history a.sel_test').on('click', function(e) {
        e.preventDefault();

        var comp = new Array(0);
        comp.push($(':radio[name="comp"]:checked').val());
        comp.push($(':radio[name="port"]:checked').val());
        comp.push($('#trcode').val());

        var nRow = $(this).parents('tr')[0];
        aData = oTableH.fnGetData(nRow);

        $.ajax({
            url: "msgforms/load_testdata",
            type: "POST",
            data: {
                'tc_id': aData[5],
            },
            dataType: "json"
        }).done(function(data) {
            insertTestData(data);
        })
    });

    $('#table-msgform a.edit').on('click', function(e) {
        e.preventDefault();

        /* Get the row as a parent of the link that was clicked on */
        var nRow = $(this).parents('tr')[0];

        if (nEditing !== null && nEditing != nRow) {
            restoreRow(nEditing);
            editRow(nRow);
            nEditing = nRow;
        } else if (nEditing == nRow && this.innerHTML == "Done") {
            /* Editing this row and want to save it */
            saveRow(nEditing);
            nEditing = null;
        } else {
            /* No edit in progress - let's start one */
            editRow(nRow);
            nEditing = nRow;
        }
    });

    $('#table-msgform a.edit_val').on('click', function(e) {
        e.preventDefault();
        /* Get the row as a parent of the link that was clicked on */
        var nRow = $(this).parents('tr')[0];

        if (nEditing !== null && nEditing != nRow) {
            restoreRow(nEditing);
            editValRow(nRow);
            nEditing = nRow;
        } else if (nEditing == nRow && this.innerHTML == "Done") {
            /* Editing this row and want to save it */
            saveValRow(nEditing);
            nEditing = null;
        } else {
            /* No edit in progress - let's start one */
            editValRow(nRow);
            nEditing = nRow;
        }
    });

    $('#edit').click(function(e) {
        e.preventDefault();

        /* Get the row as a parent of the link that was clicked on */
        //var nRow = $(this).parents('tr')[0];
        $("input:checked", oTable.fnGetNodes()).each(function() {
            var nrow = oTable.fnGetPosition($(this).closest('tr')[0]);
            var nRow = oTable.fnGetNodes(nrow);
            if (nEditing !== null && nEditing != nRow) {
                restoreRow(nEditing);
                editRow(nRow);
                nEditing = nRow;
            } else if (nEditing == nRow) {
                /* Editing this row and want to save it */
                saveRow(nEditing);
                nEditing = null;
            } else {
                /* No edit in progress - let's start one */
                editRow(nRow);
                nEditing = nRow;
            }
        });
    });

    $('#edit_val').click(function(e) {
        e.preventDefault();

        /* Get the row as a parent of the link that was clicked on */
        //var nRow = $(this).parents('tr')[0];
        $("input:checked", oTable.fnGetNodes()).each(function() {
            var nrow = oTable.fnGetPosition($(this).closest('tr')[0]);
            var nRow = oTable.fnGetNodes(nrow);
            if (nEditing !== null && nEditing != nRow) {
                restoreRow(nEditing);
                editValRow(nRow);
                nEditing = nRow;
            } else if (nEditing == nRow) {
                /* Editing this row and want to save it */
                saveValRow(nEditing);
                nEditing = null;
            } else {
                /* No edit in progress - let's start one */
                editValRow(nRow);
                nEditing = nRow;
            }
        });
    });

    $('#delete').click(function(e) {
        e.preventDefault();

        var comp = new Array(0);
        comp.push($(':radio[name="comp"]:checked').val());
        comp.push($(':radio[name="port"]:checked').val());
        comp.push($('#trcode').val());

        var row;
        $("input:checked", oTable.fnGetNodes()).each(function() {
            var nrow = oTable.fnGetPosition($(this).closest('tr')[0]);
            row = ot.row(nrow).data();
            oTable.fnDeleteRow(nrow);
            $.ajax({
                url: "msgforms/delete",
                type: "POST",
                data: {
                    'msg': row,
                    'comp': comp
                },
                dataType: "json"
            })
        });

    });
}

function checkInput() {
    if ($(':radio[name="comp"]:checked').val() == null) {
        alert('Comp radio is not checked');
        return false;
    }

    if ($(':radio[name="port"]:checked').val() == null) {
        alert("Port radio is not checked");
        return false;
    }

    if ($('#trcode').val() == '') {
        alert('Trcode input box is empty');
        return false;
    }

    var mods = ot.rows().data().toArray();
    var res = new Array(0);

    mods.forEach(function(e) {
        if (e[8] != '0') {
            res.push(e);
        }
    }, this);

    if (res.length == 0) {
        alert('No data changed in data grid');
        return false;
    }

    return true;
}

function msgFormLoad() {
    ot.ajax.reload(function() { bindEvent(); });
}

function compData() {
    var comp = new Array(0);
    comp.push($(':radio[name="comp"]:checked').val());
    comp.push($(':radio[name="port"]:checked').val());
    comp.push($('#trcode').val());
    return { 'comp': comp };
}

$(document).ready(function() {
    ot = $('#table-msgform').DataTable({
        "columnDefs": [{
            "targets": 7,
            "visible": false
        }, {
            "targets": 0,
            "width": "5%"
        }, {
            "targets": 1,
            "width": "20%"
        }, {
            "targets": 2,
            "width": "30%"
        }, {
            "targets": 3,
            "width": "5%"
        }, {
            "targets": 4,
            "width": "5%"
        }, {
            "targets": 5,
            "width": "30%"
        }, {
            "targets": 6,
            "width": "5%"
        }],
        "ajax": {
            "url": 'msgforms/load',
            "type": 'POST',
            "data": function(d) {
                return compData();
            }
        },
        "iDisplayLength": 50,
        'sDom': 't'
    })

    oTable = $('#table-msgform').dataTable();

    setHistory();
    setResult();

    nEditing = null;
    //<input type="checkbox" name="select" value="">
    $('#new').click(function(e) {
        e.preventDefault();
        var last_row = ot.row(':last').data();
        index = 1
        if (last_row != null) {
            index = parseInt(last_row[0]) + 1;
        }
        var aiNew = oTable.fnAddData([index, '', '', '', '', '',
            '<a class="edit" style="width:100%;" href="/">Done</a>', '1'
        ]);
        var nRow = oTable.fnGetNodes(aiNew[0]);
        editRow(nRow);
        nEditing = nRow;
    });

    $('#save').click(function(e) {
        e.preventDefault();

        if (!checkInput())
            return;

        var comp = new Array(0);
        comp.push($(':radio[name="comp"]:checked').val());
        comp.push($(':radio[name="port"]:checked').val());
        comp.push($('#trcode').val());

        var tc = new Array(0);
        tc.push($('#tc_name').val());
        tc.push($('#tc_desc').val());
        tc.push($('#tc_rltb').val());

        var mods = ot.rows().data().toArray();
        var res = new Array(0);

        mods.forEach(function(e) {
            if (e[7] != '0') {
                res.push(e);
            }
        }, this);

        request = $.ajax({
            url: "msgforms/save",
            type: "POST",
            data: {
                'msg': res,
                'comp': comp,
                'tc': tc
            },
            dataType: "json"
        })
    });

    $('#save_test').click(function(e) {
        e.preventDefault();

        if (!checkInput())
            return;

        var comp = new Array(0);
        comp.push($(':radio[name="comp"]:checked').val());
        comp.push($(':radio[name="port"]:checked').val());
        comp.push($('#trcode').val());

        var tc = new Array(0);
        tc.push($('#tc_name').val());
        tc.push($('#tc_desc').val());
        tc.push($('#tc_rltb').val());

        var mods = ot.rows().data().toArray();

        request = $.ajax({
            url: "msgforms/save_test",
            type: "POST",
            data: {
                'msg': mods,
                'comp': comp,
                'tc': tc
            },
            dataType: "json"
        })
    });

    $('#send_msg').click(function(e) {
        e.preventDefault();

        if (!checkInput())
            return;

        var comp = new Array(0);
        comp.push($(':radio[name="comp"]:checked').val());
        comp.push($(':radio[name="port"]:checked').val());
        comp.push($('#trcode').val());

        var tc = new Array(0);
        tc.push($('#tc_name').val());
        tc.push($('#tc_desc').val());
        tc.push($('#tc_rltb').val());

        var mods = ot.rows().data().toArray();

        request = $.ajax({
            url: "msgforms/send_msg",
            type: "POST",
            data: {
                'msg': mods,
                'comp': comp,
                'tc': tc
            },
            dataType: "json"
        })
    });

    $('#load').on('click', function(e) {
        e.preventDefault();

        msgFormLoad();
        dataFormLoad();
    });

    dataFormLoad();

});