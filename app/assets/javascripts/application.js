// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require ahoy
//= require theme/js/lib/tether/tether.min.js
//= require theme/js/lib/bootstrap/bootstrap.min.js
//= require theme/js/plugins.js
//= require theme/js/app.js
//= require theme/js/lib/match-height/jquery.matchHeight.min.js
//= require theme/js/lib/bootstrap-sweetalert/sweetalert.min.js
//= require theme/js/lib/clipboard.js/dist/clipboard.min.js
//= require theme/js/lib/bootstrap-table/bootstrap-table.js
//= require theme/js/lib/bootstrap-table/bootstrap-table-export.min.js
//= require theme/js/lib/bootstrap-table/tableExport.min.js
//= require theme/js/lib/charts-c3js/c3.min.js
//= require theme/js/lib/d3/d3.min.js


// Clipboard copy init
new Clipboard('.btn-copy');

$(document).on('click', '.btn-copy', function(e) {
    var self = $(this);
    self.addClass('animated tada');
    setTimeout(function() {
        self.removeClass('animated tada');
    }, 1000);
});


// Disabling URL Tracking Codes
var addthis_config = addthis_config||{};
addthis_config.data_track_clickback = false;
addthis_config.data_track_addressbar = false;


// effects on #new_link
$(document).on('focusin', '.shortlink-form input', function (e) {
    $(this).closest('.form-group').addClass('expand');

// effects on #new_link
}).on('focusout', '.shortlink-form input', function (e) {
    $(this).closest('.form-group').removeClass('expand');

// when submit form
}).on('submit', '#new_link', function (e) {
    e.preventDefault();

    var linkurl = $('#link_url').val();
    $('#link_url').val('');

    var submitbtn = $('#new_link button[type="submit"]').html();
    $('#new_link button[type="submit"]').html('<i class="fa fa-cog fa-spin fa-fw"></i>');

    var html = [
        '<div id="new_link_actions">',
        '<button class="btn btn-lg btn-danger btn-copy" data-clipboard-text="{{ url }}"><i class="font-icon font-icon-heart"></i> Copy</button>',
        '<button class="btn btn-lg btn-primary share_link"><i class="fa fa-share"></i> Share</button>',
        '<div style="display:none"><div class="addthis_toolbox"><span class="custom_images"><a class="addthis_button_more" addthis:url="{{ url }}"></a></span></div></div>',
        '</div>'
    ].join('');

    $.ajax({
        url: '/links.json',
        type: 'post',
        data: {link: {url: linkurl}},
        dataType: 'json',
        success: function (result,status,xhr) {
            swal({
                title: result.short_url,
                text: html.replace(/\{\{ url \}\}/g, result.short_url),
                type: 'success',
                confirmButtonClass: 'btn-success btn-sm',
                confirmButtontText: 'OK',
                html: true
            });

            addthis.toolbox('.addthis_toolbox');
            $('#new_link').find('input[type="submit"]').removeAttr('disabled');
            $('#new_link button[type="submit"]').html(submitbtn);

            $('#table-links').bootstrapTable('refresh');
        },
        error: function (result,status,xhr) {
            swal('Error!', 'Uh oh! We have a problem.', 'error');
            $('#new_link').find('input[type="submit"]').removeAttr('disabled');
            $('#new_link button[type="submit"]').html(submitbtn);
            //console.log(result);
        }
    });

// when user click on share button
}).on('click', '#new_link_actions .share_link', function (e) {
    $('#new_link_actions .addthis_button_more').click();
});
