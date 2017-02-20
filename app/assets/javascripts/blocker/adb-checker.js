// https://antiblock.org/?p=v3
// When the cookie has 5 characters, it means that it has no adblock enabled

$(document).ready(function() {
    
    (function(f, k) {
        var true_hash = Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, 5);
        window.document.cookie = "BID=" + true_hash + "; path=/";

        function g(a) {
            a && rcfc.nextFunction()
        }
        var h = f.document,
            l = ["i", "u"];
        g.prototype = {
            rand: function(a) {
                return Math.floor(Math.random() * a)
            },
            getElementBy: function(a, c) {
                return a ? h.getElementById(a) : h.getElementsByTagName(c)
            },
            getStyle: function(a) {
                var c = h.defaultView;
                return c && c.getComputedStyle ? c.getComputedStyle(a, null) : a.currentStyle
            },
            deferExecution: function(a) {
                setTimeout(a, 2E3)
            },
            insert: function(a, c) {
                var e = h.createElement("span"),
                    d = h.body,
                    b = d.childNodes.length,
                    m = d.style,
                    f = 0,
                    g = 0;
                if ("rcfc" == c) {
                    e.setAttribute("id", c);
                    m.margin = m.padding = 0;
                    m.height = "100%";
                    for (b = this.rand(b); f < b; f++) 1 == d.childNodes[f].nodeType && (g = Math.max(g,
                        parseFloat(this.getStyle(d.childNodes[f]).zIndex) || 0));
                    g && (e.style.zIndex = g + 1);
                    b++
                }
                e.innerHTML = a;
                d.insertBefore(e, d.childNodes[b - 1])
            },
            displayMessage: function(a) {
                var true_hash = Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, 6);
                document.cookie = "BID=" + true_hash + "; path=/";
            },
            i: function() {
                for (var a = "Home_AdSpan,ad_bg,ad_bs_area,ad_sec,annoying_ad,gtAD,super_ad,ad,ads,adsense"
                        .split(","), c = a.length, e = "", d = this, b = 0, f = "abisuq".charAt(d.rand(5)); b <
                    c; b++) d.getElementBy(a[b]) || (e += "<" + f + ' id="' + a[b] + '"></' + f + ">");
                d.insert(e);
                d.deferExecution(function() {
                    for (b = 0; b < c; b++)
                        if (null == d.getElementBy(a[b]).offsetParent || "none" == d.getStyle(d.getElementBy(
                                a[b])).display) return d.displayMessage("#" + a[b] + "(" + b + ")");
                    d.nextFunction()
                })
            },
            u: function() {
                var a =
                    "-ad-unit.,/ads/default_,/footerad.,/layer-advert-,/oas_ads.,/special_ads/ad,/topads_,_ad_choices_,_gads_footer.,_static/ads/"
                    .split(","),
                    c = this,
                    e = c.getElementBy(0, "img"),
                    d, b;
                e[0] !== k && e[0].src !== k && (d = new Image, d.onload = function() {
                    b = this;
                    b.onload = null;
                    b.onerror = function() {
                        l = null;
                        c.displayMessage(b.src)
                    };
                    b.src = e[0].src + "#" + a.join("")
                }, d.src = e[0].src);
                c.deferExecution(function() {
                    c.nextFunction()
                })
            },
            nextFunction: function() {
                var a = l[0];
                a !== k && (l.shift(), this[a]())
            }
        };
        f.rcfc = rcfc = new g;
        h.addEventListener ? f.addEventListener("load", g, !1) : f.attachEvent("onload", g)
    })(window);
});