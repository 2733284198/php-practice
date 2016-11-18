window.Agent = (function (window, document) {
	var Agent = {};
	var classes = [];
	var ua = navigator.userAgent.toLowerCase();
	var features = {
		android: 'android', 
		ios: 'iphone|ipad',
		weixin: 'micromessenger',
		laiwang: 'aliapp\\(lw'
	};
	
	for(var n in features) {
		var pat = new RegExp(features[n]); 
		Agent[n] = pat.test(ua);
		if (Agent[n]) classes.push(n);
	}
	
	Agent.video = (function() {
        var bool = false, elem = document.createElement('video');

        try {
            if (bool = !!elem.canPlayType) {
                bool      = new Boolean(bool);
                bool.ogg  = elem.canPlayType('video/ogg; codecs="theora"')      .replace(/^no$/,'');
				bool.h264 = elem.canPlayType('video/mp4; codecs="avc1.42E01E"') .replace(/^no$/,'');
				bool.webm = elem.canPlayType('video/webm; codecs="vp8, vorbis"').replace(/^no$/,'');
				
				bool.hls  = elem.canPlayType('application/vnd.apple.mpegURL').replace(/^no$/,'');
            }
        } catch(e) { }
		if (bool) {
			classes.push('video'); classes.push(bool.hls?'hls':'no-hls');
		} else
			classes.push('no-video');
        return bool;
    })();
	
	var html = document.documentElement;
	html.className = html.className.replace(/(^|\s)no-js(\s|$)/, '$1$2') + "js " + classes.join(' ');
	
	return Agent;
})(this, this.document);