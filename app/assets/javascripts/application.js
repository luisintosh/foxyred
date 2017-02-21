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
//= require jquery2
//= require jquery_ujs
//= require blocker/adb-detecter
//= require ahoy
//= require theme/js/lib/tether/tether.min
//= require theme/js/lib/bootstrap/bootstrap.min
//= require theme/js/plugins
//= require theme/js/app
//= require theme/js/lib/match-height/jquery.matchHeight.min
//= require theme/js/lib/bootstrap-sweetalert/sweetalert.min
//= require theme/js/lib/clipboard.js/dist/clipboard.min
//= require theme/js/lib/bootstrap-table/bootstrap-table
//= require theme/js/lib/bootstrap-table/bootstrap-table-export.min
//= require theme/js/lib/bootstrap-table/tableExport.min
//= require theme/js/lib/charts-c3js/c3.min
//= require theme/js/lib/d3/d3.min
//= require theme/js/lib/summernote/summernote.min
//= require theme/js/lib/countdown/countdown
//= require turbolinks
//= require app.init
//= require_directory .

// Disabling URL Tracking Codes
var addthis_config = addthis_config||{};
addthis_config.data_track_clickback = false;
addthis_config.data_track_addressbar = false;

// Date hack
Date.prototype.yyyymmdd = function() {
    var mm = this.getMonth() + 1; // getMonth() is zero-based
    var dd = this.getDate();

    return [this.getFullYear(),
            (mm>9 ? '' : '0') + mm,
            (dd>9 ? '' : '0') + dd
            ].join('-');
};

