//Script detects ad blocking extenions
//Script calls Google Ads server, which Adblock and Ghostery block by default.
//Based on code from https://github.com/georules/adblock-detect
(function(window, undefined) {

var adblocked = {};

function Adblocked() {
  this.scriptFile = "//pagead2.googlesyndication.com/pagead/show_ads.js";
}

Adblocked.prototype.isAdblocked = function() {
  if (typeof(window.google_ad_block) === "undefined") {
    return true;
  }
  else {
    return false;
  }
}

Adblocked.prototype.done = function(ctx) {
  ctx = (typeof(ctx) === "undefined") ? this : ctx 
  if (ctx.isAdblocked())  {
    adblocked.result = true
  }
  else {
    adblocked.result = false
  }
  var error = null;
  adblocked.userCallback(error, adblocked.result)
}

Adblocked.prototype.insert = function() {
  var head = document.getElementsByTagName('head')[0]
  adScript = document.createElement("script")
  adScript.setAttribute("type","text/javascript")
  adScript.setAttribute("src",this.scriptFile)
  head.appendChild(adScript)
  that = this
  adScript.onload = function() {that.done(that)};
  adScript.onerror = adScript.onload;
  return this
}

var checkAds = function(userCallback) {
  if (typeof(userCallback) !== "undefined") { 
    adblocked.userCallback = userCallback
  }
  var a = new Adblocked()
  // if it appears that ads are blocked already
  if (a.isAdblocked()) {
    a.insert() // attempt to load ads
  }
  // if ads have already loaded
  else {
    a.done()    
  }
}

adblocked = {
  check : checkAds,
  userCallback : function() {},
  result : "unknown"
}


// search adblock or ghostery
$(document).on('turbolinks:load', function() {
    var isAdblockActive = false;
    var metaVal = $("meta[name=view-action]").attr('content');
    if (metaVal == 'link-in' || metaVal == 'link-out') {
      adblocked.check(function(error, success) {
          if (success) {
            isAdblockActive = true;
          }
      })
    }

    $(document).on('submit','#link-captcha',function(e) {
      e.preventDefault();
      if (isAdblockActive) {
        $('#link-captcha').append('<input type="hidden" name="valid" value="0">')
      }
      this.submit();
    })
})

})(window)