// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require theme/js/lib/bootstrap-table/bootstrap-table.js
//= require theme/js/lib/bootstrap-table/bootstrap-table-export.min.js
//= require theme/js/lib/bootstrap-table/tableExport.min.js

// Date hack
Date.prototype.yyyymmdd = function() {
  var mm = this.getMonth() + 1; // getMonth() is zero-based
  var dd = this.getDate();

  return [this.getFullYear(),
          (mm>9 ? '' : '0') + mm,
          (dd>9 ? '' : '0') + dd
         ].join('-');
};

// table
var $table = $('#table-links');

function initTable() {
    $table.bootstrapTable({
        columns: [
            {
                field: 'short_url',
                title: 'Short url',
                align: 'center',
                formatter: shortFormatter
            },
            {
                field: 'created_at',
                title: 'Created on',
                sortable: true,
                editable: true,
                align: 'center',
                formatter: createdFormatter
            },
            {
                field: 'hits',
                title: 'Views',
                sortable: true,
                editable: true,
                align: 'center'
            },
            {
                field: 'actions',
                title: 'Actions',
                align: 'center',
                events: operateEvents,
                formatter: operateFormatter
            }
        ]
    });
}

function responseHandler(res) {
    /*$.each(res.rows, function (i, row) {
        row.state = $.inArray(row.id, selections) !== -1;
    });*/
    return res;
}

function shortFormatter(value, row, index) {
    return [
        '<a href="{{ url }}" target="_blank" class="link-tag">',
        value,
        '</a>',
        '<br>',
        '<p class="originalurl-tag" title="{{ original_url }}" data-toggle="tooltip" data-placement="bottom">{{ original_url }}</p>'
    ].join('')
    .replace(/\{\{ url \}\}/g, row.short_url)
    .replace(/\{\{ original_url \}\}/g, row.original_url);
}

function createdFormatter(value, row, index) {
    return new Date(value).yyyymmdd();
}

function operateFormatter(value, row, index) {
    return [
        '<div class="col">',
        '<button class="btn btn-danger btn-sm btn-copy" data-clipboard-text="{{ url }}"><i class="font-icon font-icon-heart"></i> Copy</button>',
        '</div>',
        '<div class="col">',
        '<span class="addthis_toolbox"><span class="custom_images"><a class="btn btn-sm btn-primary addthis_button_more" addthis:url="{{ url }}"><i class="fa fa-share"></i> Share</a></span></span>',
        '</div>',
        '<div class="col">',
        '<a class="btn btn-sm btn-secondary-outline delete" href="{{ delete_url }}"><i class="fa fa-trash-o"></i> Delete</a>',
        '</div>'
    ].join('')
    .replace(/\{\{ url \}\}/g, row.short_url)
    .replace(/\{\{ delete_url \}\}/g, row.delete_url);
}

window.operateEvents = {
    'click .delete': function (e, value, row, index) {
        e.preventDefault();
        swal({
                title: "Are you sure?",
                text: "You will not be able to recover this short link!",
                type: "warning",
                showCancelButton: true,
                confirmButtonClass: "btn-danger",
                confirmButtonText: "Yes, delete it!",
                closeOnConfirm: false
            },
            function(){
                swal("Deleted!", "Your short link has been deleted.", "success");
                $table.bootstrapTable('remove', {
                    field: 'short_url',
                    values: [row.short_url]
                });
                $.ajax({
                    url: row.delete_url + '.json',
                    type: 'DELETE',
                    error: function (xhr,status,error) {
                        alert('Error: Could not delete this item');
                    }
                });
            });
        return false;
    }
};

$table.on('post-body.bs.table', function(name, args) {
    $('[data-toggle="tooltip"]').tooltip();
    addthis.toolbox('.addthis_toolbox');
});

$(document).ready(function() {
    initTable();
});