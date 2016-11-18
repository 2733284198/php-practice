<!--倒计时-->
var nowDate = new Date();
function initCountdown() {//alert("kaishi");

	var item = $(".counter");
	item.each(function () {//alert("each");
		var itemThis = $(this);
		var deviceId = itemThis.attr("id").substr(7);

		var downInfo = itemThis.data("ad");
		var upInfo = itemThis.data("ad2");
		var countDown = itemThis.data("state");
		var countUp = itemThis.data("state2");
		var myChannelDate = itemThis.data("time");//频道时间
		var liveDate = new Date(Date.parse(myChannelDate.replace(/-/g, "/")));

		console.debug("deviceId=" + deviceId + "downInfo=" + downInfo + "upInfo=" + upInfo + "countDown=" + countDown + "countUp=" + countUp + "myChannelDate=" + myChannelDate);

		var up = function () {//alert('up');
			$(".counter .info #span_" + deviceId).text(upInfo);

			(function ($) {//正计时
				var days = 24 * 60 * 60, hours = 60 * 60, minutes = 60;
				$.fn.countUp = function (prop) {
					var options = $.extend({
						callback: function () {
						}, timestamp: 0
					}, prop);
					var left, d, h, m, s, positions;
					init(this, options);
					positions = this.find(".position");
					(function tick() {
						left = Math.floor(((new Date()) - options.timestamp) / 1000);
						if (left < 0) {
							left = 0
						}
						d = Math.floor(left / days);
						updateDuo2(0, 1, 2, d);
						left -= d * days;
						h = Math.floor(left / hours);
						updateDuo(3, 4, h);
						left -= h * hours;
						m = Math.floor(left / minutes);
						updateDuo(5, 6, m);
						left -= m * minutes;
						s = left;
						updateDuo(7, 8, s);
						options.callback(d, h, m, s);
						setTimeout(tick, 1000)
					})();
					function updateDuo(minor, major, value) {
						switchDigit(positions.eq(minor), Math.floor(value / 10) % 10);
						switchDigit(positions.eq(major), value % 10)
					}

					function updateDuo2(first, minor, major, value) {
						switchDigit(positions.eq(first), Math.floor(value / 100) % 10);
						switchDigit(positions.eq(minor), Math.floor(value / 10) % 10);
						switchDigit(positions.eq(major), value % 10)
					}

					return this
				};
				function init(elem, options) {
					elem.addClass("countdownHolder");
					$.each(["Days", "Hours", "Minutes", "Seconds"], function (i) {
						if (this == "Days") {
							$('<span class="count' + this + '">').html('<span class="position"><span class="digit static">0</span></span><span class="position"><span class="digit static">0</span></span><span class="position"><span class="digit static">0</span></span>').appendTo(elem)
						}
						else {
							$('<span class="count' + this + '">').html('<span class="position"><span class="digit static">0</span></span><span class="position"><span class="digit static">0</span></span>').appendTo(elem)
						}
						;
						if (this != "Seconds") {
							elem.append('<span class="countDiv countDiv' + i + '"></span>')
						}
					})
				};
				function switchDigit(position, number) {
					var digit = position.find(".digit");
					if (digit.is(":animated")) {
						return false
					}
					if (position.data("digit") == number) {
						return false
					}
					position.data("digit", number);
					var replacement = $("<span>", {
						"class": "digit", css: {top: "-2.1em", opacity: 0}, html: number
					});
					digit.before(replacement).removeClass("static").animate({
						top: "2.5em",
						opacity: 0
					}, "fast", function () {
						digit.remove()
					});
					replacement.delay(100).animate({top: 0, opacity: 1}, "fast", function () {
						replacement.addClass("static")
					})
				}
			})(jQuery);

			$('#countdown_' + deviceId).countUp({
				timestamp: liveDate,
				callback: function (days, hours, minutes, seconds) {
					window.countinfo = {
						"days": days,
						"hours": hours,
						"minutes": minutes,
						"seconds": seconds
					};
				}
			});
		};

		var down = function () {
			//alert('down');
			$(".counter .info #span_" + deviceId).text(downInfo);

			(function ($) {//倒计时
				var days = 24 * 60 * 60, hours = 60 * 60, minutes = 60;
				$.fn.countdown = function (prop) {
					var options = $.extend({
						callback: function () {
						}, timestamp: 0
					}, prop);

					var left, d, h, m, s, positions;

					init(this, options);

					positions = this.find(".position");

					(function tick() {
						left = Math.floor((options.timestamp - (new Date())) / 1000);
						if (left < 0) {
							left = 0
						}
						d = Math.floor(left / days);
						updateDuo(0, 1, d);
						left -= d * days;
						h = Math.floor(left / hours);
						updateDuo(2, 3, h);
						left -= h * hours;
						m = Math.floor(left / minutes);
						updateDuo(4, 5, m);
						left -= m * minutes;
						s = left;
						updateDuo(6, 7, s);
						options.callback(d, h, m, s);
						setTimeout(tick, 1000)
					})();

					function updateDuo(minor, major, value) {
						switchDigit(positions.eq(minor), Math.floor(value / 10) % 10);
						switchDigit(positions.eq(major), value % 10)
					};

					return this
				};

				function init(elem, options) {
					elem.addClass("countdownHolder");
					$.each(["Days", "Hours", "Minutes", "Seconds"], function (i) {
						$('<span class="count' + this + '">').html('<span class="position"><span class="digit static">0</span></span><span class="position"><span class="digit static">0</span></span>').appendTo(elem);
						if (this != "Seconds") {
							elem.append('<span class="countDiv countDiv' + i + '"></span>');
						}
					})
				};

				function switchDigit(position, number) {
					var digit = position.find(".digit");
					if (digit.is(":animated")) {
						return false
					}
					if (position.data("digit") == number) {
						return false
					}
					position.data("digit", number);
					var replacement = $("<span>", {"class": "digit", css: {top: "-2.1em", opacity: 0}, html: number});
					digit.before(replacement).removeClass("static").animate({
						top: "2.5em",
						opacity: 0
					}, "fast", function () {
						digit.remove()
					});
					replacement.delay(100).animate({top: 0, opacity: 1}, "fast", function () {
						replacement.addClass("static")
					})
				}
			})(jQuery);

			$('#countdown_' + deviceId).countdown({
				timestamp: liveDate,
				callback: function (days, hours, minutes, seconds) {
					window.countinfo = {
						"days": days,
						"hours": hours,
						"minutes": minutes,
						"seconds": seconds
					};
				}
			});
		}

		if (countUp == "1" && countDown == "0") {//alert("zheng");
			up();
		}

		if (countUp == "0" && countDown == "1") {//alert("dao");
			down();
		}

		if (countDown == "1" && countUp == "1") {
			var nowDate = new Date();
			if (liveDate.getTime() < nowDate.getTime()) {
				up();
			}
			else {//alert("zidown");
				down();
			}
		}
	});
}

<!--频道相关-->
function initChannels() {
	window.channels = $('.channel');
	window.channelSwiper = $("#channel-swiper");
	window.videoContainer = $('#video-container');

	console.debug("channel count : " + channels.length);

	//        var videoHeight = ($window.width() * 0.618) + 'px';
	//        channels.css({height: videoHeight});
	//        videoContainer.css({height: videoHeight });

	window.channelSwiperObj = new Swiper('#channel-swiper', {
		nextButton: '.swiper-button-next',
		prevButton: '.swiper-button-prev',
		pagination: '.swiper-pagination',
		paginationClickable: false,
		onlyExternal: (channels.length == 1),
		preloadImages: false,
		lazyLoading: false
	});

	channelSwiperObj.on('slideChangeStart', function () {
		$(".channel-tabs li.active").removeClass('active');
		$(".channel-tabs li").eq(channelSwiperObj.activeIndex).addClass('active');
		channelSwiperObj.params.onlyExternal = false;
	});

	var changing = false;
	$(".channel-tabs a").on('click', function (e) {
		if (changing) return false;

		closeVideo();

		changing = true;
		var slideIndex = $(this).parent().index();
		channelSwiperObj.slideTo(slideIndex);
		changing = false;

		e.preventDefault();
		return false;
	});

	$(".channel-button").each(function () {
		$(this).click(function () {
			var channel = $(this).data("channel");
			onChannelPlay(channel);
		});
	});

	$(".channel").each(function () {
		var ch = $(this);
		var id = ch.attr("id");
		var ad = ch.data("ad");
		//            var HLS = "http://cdn1.amailive.com/hls/203.m3u8";
		var HLS = "http://" + liveServerD + "/hls/" + id + ".m3u8";
		if (liveId == "L02367") {
			HLS = "http://pubstream.amailive.com/live/601.m3u8";
		}
		ch.data("src", "");

		var state = ch.data("state");
		if (state != 3) {
			if (ad != null && ad != "") {
				ch.data("src", ad);
			}
			return;
		}

		//$.get(HLS, function () {
		//	ch.data("src", HLS);
		//}).fail(function () {
		//	if (ad != null && ad != "") {
		//		ch.data("src", ad);
		//	}
		//});
	});

	refreshChannels();
}


function refreshChannels() {
	var now = new Date();
	var finishedCount = 0;
	var refreshInterval = 60000;
	channels.each(function (elementIndex, element) {
		var channel = $(this);
		var id = channel.attr("id");
		var state = channel.data("state");
		var time = channel.data("time");
		console.debug("channel " + id + " state = " + state + " time = " + time);

		var stateObj = $("#channel-state-" + id);

		var nbtime = time.replace(/-/g, "/");
		var nbctm = new Date(Date.parse(nbtime));
		if (now.getTime() - nbctm.getTime() > 0) {
			$("#counter20001").hide();
			return;
		}

		//state finished
		if (state == 4) {
			finishedCount++;
			stateObj.data("state", 4);
			stateObj.html("直播已结束，您可以观看直播回放");
			console.debug("channel " + id + " finished");
			return;
		}

		//state started
		if (state == 3) {
			stateObj.data("duration", "");
			stateObj.html("");
			//refreshInterval = 5000;
			return;
		}

		//state prepareing

		time = time.replace(/-/g, "/");
		var ctm = new Date(Date.parse(time));
		var diff = ctm.getTime() - now.getTime();

		if (diff <= -3600000 * 5) {
			finishedCount++;
			stateObj.data("state", 4);
			stateObj.html("直播已结束，您可以观看直播回放");
			console.warn("channel " + id + " auto finished");
			return;
		} else if (diff < 0) {
			console.warn("channel " + id + " expired");
			return;
		}

		var diffD = Math.floor(diff / 86400000);
		diff = diff - diffD * 86400000;
		var diffH = Math.floor(diff / 3600000);
		diff = diff - diffH * 3600000;
		var diffM = Math.floor(diff / 60000);
		diff = diff - diffM * 60000;
		var diffS = Math.floor(diff / 1000);
		console.debug("channel " + id + " : " + diffD + " 天 " + diffH + " 小时 " + diffM + " 分钟 " + diffS + " 秒");

		var duration;
		if (diffD > 0) {
			duration = diffD + "天";
			if (diffD < 20 && diffH > 0) duration += diffH + "小时";
			stateObj.data("duration", duration);
			stateObj.html("距离直播还有" + duration);
			duration = diffD + "天";
			if (diffD < 20 && diffH > 0) duration += diffH + "小时";
			stateObj.data("duration", duration);
			stateObj.html("距离直播还有" + duration);
		} else if (diffH > 0) {
			duration = diffH + "小时";
			if (diffM > 0) duration += diffM + "分钟";
			stateObj.data("duration", duration);
			stateObj.html("距离直播还有" + duration);
		} else if (diffM >= 30) { //prepare time 30 minute
			duration = diffM + "分钟";
			stateObj.data("duration", duration);
			stateObj.html("距离直播还有" + duration);
		} else {
			stateObj.data("duration", "");
			stateObj.html(""); //直播准备中，敬请期待
			//refreshInterval = 5000;
		}
	});

	if (finishedCount == channels.length) return;
	startChannelTimer(refreshInterval);
	console.debug("channel timer start => " + refreshInterval);
}

var channelTimer = null;

function startChannelTimer(interval) {
	channelTimer = setTimeout(refreshChannels, interval);
}

function clearChannelTimer() {
	if (channelTimer != null) {
		clearTimeout(channelTimer);
		channelTimer = null;
	}
}

function showDuration(channel) {
	var stateObj = $("#channel-state-" + channel);
	var ss = stateObj.data("state");
	if (ss == 4) {
		alert("直播已结束，您可以观看直播回放");
		return;
	}
	var state = stateObj.data("duration");
	if (state != null && state != "") {
		state = state + "之后现场直播精彩呈现，敬请届时在线观看！";
	} else {
		state = "直播准备中，请耐心等待。";
	}

	// alert(state);
}


function getQueryString(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null) return unescape(r[2]);
	return null;
}

function checkWeixin() {
	var tokenParam = getQueryString("token");
	return (token == tokenParam);
}


function onChannelPlay(channel) {
	var token2 = token.replace(/(^\s*)|(\s*$)/g, "");
	if (token2 != null && token2.length != 0) {
		if (!checkWeixin()) {
			// alert(livelocationMrt);
			location.href = liveLocationBus;
			return false;
		}
	}
	var ch = $("#" + channel);
	var src1 = ch.data("src");
	var src = src1.replace(/(^\s*)|(\s*$)/g, "");
	var state = ch.data("state");
	src1 = "http://dnlhuigu.amailive.com/data/L02449/video/333/index.m3u8";
	src2 = "";
	$.get(src1, function (result) {
		playLiveChannel(channel, src1);
		console.log(1);
	}).error(function (e) {
		alert("活动尚未开始");
		//playLiveChannel(channel, src2);
		console.log(0);
	});
	return;

	showDuration(channel);
}

$("#video-play").click(function () {
	src = "http://image.amailive.com/data/L01751/video/L01751_201610152110521476537601/index.m3u8";
	playLiveChannel(20001, src);
});

function playLiveChannel(channel, src) {
	//$.get("/live/"+liveId+"/play");
	if (!!Agent.video.hls || Agent.android) {
		openVideo(src);
	} else {
		var swfPlayer = new SWFPlayer("video-container", "video-player", "100%", "100%", liveDefaultNub);
		swfPlayer.reload(src);
	}
	channelSwiperObj.params.onlyExternal = true;
	channelSwiper.css({left: '-5000px'});
	videoContainer.css({visibility: 'visible'});
}

function closeVideo() {
	videoContainer.css({visibility: 'hidden'});
	channelSwiper.css({left: 0});
	videoContainer.html('<video id="video-player" webkit-playsinline controls></video>');
}

function openVideo(src) {
	var v = document.getElementById("video-player");
	v.addEventListener("ended error stalled", function () {
		closeVideo();
	});

	v.src = src;
	v.play();
}

/**
 * 视频播放
 * @param video_name
 */
function onVideoPlay(id, videoName) {
	var src = "" + configOssimgPath + "/" + liveId + "/video/" + videoName + "/index.m3u8";
	if (!!Agent.video.hls || Agent.android) {
		openVideo(src);
	} else {
		var swfPlayer = new SWFPlayer("video-container", "video-player", "100%", "100%", liveDefaultNub);
		swfPlayer.reload(src);
	}
	$.post('/live/' + id + '/videoStatistics');
	channelSwiperObj.params.onlyExternal = true;
	channelSwiper.css({left: '-5000px'});
	videoContainer.css({visibility: 'visible'});
}
