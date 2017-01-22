//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require theme/js/lib/tether/tether.min.js
//= require theme/js/lib/bootstrap/bootstrap.min.js
//= require theme/js/plugins.js
//= require theme/js/app.js
//= require theme/js/lib/match-height/jquery.matchHeight.min.js

// functions for first step of link ad
function reCaptchaVerify(response) {
  if (response === document.querySelector('.g-recaptcha-response').value) {
    $('#link-captcha').submit();
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

// functions for second step of link ad
function Countdown(e) {
    function o() {
        i(r);
        if (r === 0) {
            s();
            n.stop();
        }
        r--;
    }
    var t, n = this,
        r = e.seconds || 10,
        i = e.onUpdateStatus || function() {},
        s = e.onCounterEnd || function() {};
    this.start = function() {
        clearInterval(t);
        t = 0;
        r = e.seconds;
        t = setInterval(o, 1e3)
    };
    this.stop = function() {
        clearInterval(t);
    };
}

function startCountDown() {
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

$(document).ready(function() {
  if (location.href.match(/\/go\//)) {
    startCountDown();
  }
  ahoy.trackAll();
});