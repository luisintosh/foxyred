// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

App.adlink = {
    init: function () {
        startCountDown();
        ahoy.trackAll();
    },

    startCountDown: function () {
        if ( $('#link-out').length === 0 ) return;
        var myCounter = new Countdown({
            seconds: 5,
            onUpdateStatus: function(e) {
                $('#link-out').html(e);
            },
            onCounterEnd: function() {
                $('#link-out').html('Open link');
                $('#link-out').removeClass('disabled');
            }
        });
        myCounter.start();
    }
};

   
// functions for first step of link ad
function reCaptchaVerify(response) {
    if (response === document.querySelector('.g-recaptcha-response').value) {
        $('#adlink-captcha').submit();
        //console.log(true, $('#link-captcha'));
    }
}

function reCaptchaCallback() {
    if (!location.href.match(/\/go\//)) {
        grecaptcha.render('g-recaptcha', {
            'sitekey': $('#g-recaptcha').data('sitekey'),
            'callback': reCaptchaVerify
        });
    }
}
