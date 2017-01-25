window.App = window.App || {};
App.init = function () {
    for(var key in App) {
        if ($('.'+key).length > 0) {
            App[key].init();
        }
        if ($('.userpanel').length > 0) {
            App.userpanel.init();
        }
    }
};

///////////////////////////////////////////
//            TURBOLINKS START           //
$(document).on('turbolinks:load', function() {
    App.init();
});