window.App = window.App || {};
App.init = function () {
    for(var key in App) {
        if ($('.'+key).length > 0) {
            App[key].init();
        }
    }
};

///////////////////////////////////////////
//            TURBOLINKS START           //
$(document).on('turbolinks:load', function() {
    App.init();
})
.ready(function(){
    App.userpanel.start();
});