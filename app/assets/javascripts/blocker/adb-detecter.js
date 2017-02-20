/**
 * Search adblock, ghostery or UC Browser adblock
 * Save a cookie with a different value
 * If the cookie has a string with 10 chars it means 
 * that the browser doesn't have adblock
 */

// if Turbolinks enabled
$(document).on('turbolinks:load', function() {
    
    // check only on link views
    if ($("meta[name=view-action]").attr('content') == 'link-in') {
        // insert ad checker container
        $(document.body).append('<div id="amzn_assoc_ad_div_xf8_0" style="display:none;"></div>');
        // amazon tags
        amzn_assoc_ad_type = "banner";
        amzn_assoc_marketplace = "amazon";
        amzn_assoc_region = "US";
        amzn_assoc_placement = "xf8";
        amzn_assoc_campaigns = "mp3";
        amzn_assoc_banner_type = "rotating";
        amzn_assoc_p = "41";
        amzn_assoc_width = "88";
        amzn_assoc_height = "31";
        amzn_assoc_tracking_id = "amazon";
        amzn_assoc_linkid = "dda6adcfcf144543050b86ea11aa009d";

        // disable alert of write on document
        var defaultWriteFunc = document.write;
        document.write = function(a) {};

        // call to script
        $.getScript('https://z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US')
            .done(function() {
                //console.log('Adb no detected!');
                document.write = defaultWriteFunc;
                $('#amzn_assoc_ad_div_xf8_0').remove();
                var true_hash = Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, 10);
                window.document.cookie = "ABID=" + true_hash + "; path=/";
            })
            .fail(function() {
                //console.log('Adb detected!');
                document.write = defaultWriteFunc;
                $('#amzn_assoc_ad_div_xf8_0').remove();
                var true_hash = Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, 9);
                window.document.cookie = "ABID=" + true_hash + "; path=/";
            });
    }
    
});