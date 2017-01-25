// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

App.options = {
    
    init: function () {
        this.formSaveFunc();
    },

    formSaveFunc: function() {
        $('form').submit(function() {  
            //console.log('mandando...');
            var submitBtn = $(this).parent().find('.submitbtn');
            var defaultVal = submitBtn.html();
            var valuesToSubmit = $(this).serialize();

            submitBtn.html('<i class="fa fa-refresh fa-spin fa-fw"></i>');
            //console.log($(this).parent().find('.submitbtn'));
            $.ajax({
                type: "PUT",
                url: $(this).attr('action') + '.json', //sumbits it to the given url of the form
                data: valuesToSubmit,
                dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
            }).success(function(json){
                submitBtn.html(defaultVal);
                //console.log('Success', json);
            }).error(function(json){
                submitBtn.html('X');
                //console.log('Error', json);
            });
            return false; // prevents normal behaviour
        });
    }
};
