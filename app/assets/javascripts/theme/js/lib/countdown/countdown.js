
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