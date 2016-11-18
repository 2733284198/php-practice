// JavaScript Document


//倒计时开始
var nowDate = new Date();
function initCountdown() {//alert("kaishi");

	var item=$(".counter");
	
	item.each(function() {//alert("each");
		var itemThis = $(this);
		var deviceId = itemThis.attr("id").substr(7);

		var downInfo = itemThis.data("ad");
		var upInfo = itemThis.data("ad2");
		var countDown = itemThis.data("state");
		var countUp = itemThis.data("state2");
		var myChannelDate = itemThis.data("time");//频道时间
		var liveDate =  new Date(Date.parse(myChannelDate.replace(/-/g,   "/")));

		console.debug("deviceId=" + deviceId+"downInfo=" + downInfo +"upInfo=" + upInfo+"countDown=" + countDown+"countUp=" + countUp+"myChannelDate=" + myChannelDate);

		var up=function (){//alert('up');
			$(".counter .info #span_"+deviceId).text(upInfo);

			(function($){//正计时
				var days=24*60*60,hours=60*60,minutes=60;
				$.fn.countUp=function(prop){
					var options=$.extend({callback:function(){},timestamp:0},prop);
					var left,d,h,m,s,positions;
					init(this,options);
					positions=this.find(".position");
					(function tick(){
						left=Math.floor(((new Date())-options.timestamp)/1000);
						if(left<0){
							left=0
						}
						d=Math.floor(left/days);
						updateDuo2(0,1,2,d);
						left-=d*days;
						h=Math.floor(left/hours);
						updateDuo(3,4,h);
						left-=h*hours;m=Math.floor(left/minutes);
						updateDuo(5,6,m);
						left-=m*minutes;
						s=left;
						updateDuo(7,8,s);
						options.callback(d,h,m,s);
						setTimeout(tick,1000)
					})();
					function updateDuo(minor,major,value){
						switchDigit(positions.eq(minor),Math.floor(value/10)%10);
						switchDigit(positions.eq(major),value%10)
					}
					function updateDuo2(first,minor,major,value){
						switchDigit(positions.eq(first),Math.floor(value/100)%10);
						switchDigit(positions.eq(minor),Math.floor(value/10)%10);
						switchDigit(positions.eq(major),value%10)
					}
					return this
				};
				function init(elem,options){
					elem.addClass("countdownHolder");
					$.each(["Days","Hours","Minutes","Seconds"],function(i){
						if(this=="Days"){
							$('<span class="count'+this+'">').html('<span class="position"><span class="digit static">0</span></span><span class="position"><span class="digit static">0</span></span><span class="position"><span class="digit static">0</span></span>').appendTo(elem)
						}
						else{
							$('<span class="count'+this+'">').html('<span class="position"><span class="digit static">0</span></span><span class="position"><span class="digit static">0</span></span>').appendTo(elem)
						};
						if(this!="Seconds"){
							elem.append('<span class="countDiv countDiv'+i+'"></span>')
						}
					})
				};
				function switchDigit(position,number){
					var digit=position.find(".digit");
					if(digit.is(":animated")){
						return false
					}
					if(position.data("digit")==number){
						return false
					}
					position.data("digit",number);
					var replacement=$("<span>",{
						"class":"digit",css:{top:"-2.1em",opacity:0},html:number});
						digit.before(replacement).removeClass("static").animate({top:"2.5em",opacity:0},"fast",function(){digit.remove()});
						replacement.delay(100).animate({top:0,opacity:1},"fast",function(){replacement.addClass("static")})
					}
				}
			)(jQuery);

			$('#countdown_'+deviceId).countUp({
				timestamp   : liveDate,
				callback    : function(days, hours, minutes, seconds){
					window.countinfo = {
						"days" : days,
						"hours": hours,
						"minutes": minutes,
						"seconds": seconds
					};
				}
			});
		};

		var down=function(){
			//alert('down');
			$(".counter .info #span_"+deviceId).text(downInfo);

			(function($){//倒计时
				var days=24*60*60,hours=60*60,minutes=60;
				$.fn.countdown=function(prop){
					var options=$.extend({
							callback:function(){},timestamp:0
						},prop);
						
					var left,d,h,m,s,positions;
					
					init(this,options);
					
					positions=this.find(".position");
					
					(function tick(){
						left=Math.floor((options.timestamp-(new Date()))/1000);
						if(left<0){
							left=0
						}
						d=Math.floor(left/days);
						updateDuo(0,1,d);
						left-=d*days;
						h=Math.floor(left/hours);
						updateDuo(2,3,h);
						left-=h*hours;
						m=Math.floor(left/minutes);
						updateDuo(4,5,m);
						left-=m*minutes;
						s=left;
						updateDuo(6,7,s);
						options.callback(d,h,m,s);
						setTimeout(tick,1000)
					})();
					
					function updateDuo(minor,major,value){
						switchDigit(positions.eq(minor),Math.floor(value/10)%10);
						switchDigit(positions.eq(major),value%10)
					};
					
					return this
				};
				
				function init(elem,options){
					elem.addClass("countdownHolder");
					$.each(["Days","Hours","Minutes","Seconds"],function(i){
						$('<span class="count'+this+'">').html('<span class="position"><span class="digit static">0</span></span><span class="position"><span class="digit static">0</span></span>').appendTo(elem);
						if(this!="Seconds"){
							elem.append('<span class="countDiv countDiv'+i+'"></span>');
						}
					})
				};
				
				function switchDigit(position,number){
					var digit=position.find(".digit");
					if(digit.is(":animated")){return false}
					if(position.data("digit")==number){return false}
					position.data("digit",number);
					var replacement=$("<span>",{"class":"digit",css:{top:"-2.1em",opacity:0},html:number});
					digit.before(replacement).removeClass("static").animate({top:"2.5em",opacity:0},"fast",function(){digit.remove()});
					replacement.delay(100).animate({top:0,opacity:1},"fast",function(){replacement.addClass("static")})
				}
			})(jQuery);

			$('#countdown_'+deviceId).countdown({
				timestamp   : liveDate,
				callback    : function(days, hours, minutes, seconds){
					window.countinfo = {
						"days" : days,
						"hours": hours,
						"minutes": minutes,
						"seconds": seconds
					};
				}
			});
		}

		if (countUp =="1" && countDown =="0") {//alert("zheng");
			up();
		}

		if(countUp =="0" && countDown =="1") {//alert("dao");
			down();
		}

		if(countDown =="1" && countUp =="1") {
			if (liveDate.getTime() < nowDate.getTime()) {//alert("ziup");
				up();
			}
			else {//alert("zidown");
				down();
			}
		}
	});
}

var $window = $(window);
var $body = $(document.body);

//抽奖环节开始
function initshowaward(){
	var url ="/lotto/"+liveId+"/showAward?time=" + new Date().getTime()  ;
	$.get(url, function(data) {
		for(var i in data)
		{
			$("#line").append("<li style='margin-top: 0px;'>恭喜：" + data[i].nickName + "抽中->" + data[i].name + "</li>");
		}
		if(i>6)
			$("#line").slideUp();
		
	}).fail(function(e) {
		//alert("get  error");
	});
}
(function($){
	$.fn.extend({
		"slideUp":function(value){

			var docthis = this;
			//默认参数
			value=$.extend({
				"li_h":"20",
				"time":1000,
				"movetime":1000
			},value)

			//向上滑动动画
			function autoani(){
				$("li:first",docthis).animate({"margin-top":-value.li_h},value.movetime,function(){
					$(this).css("margin-top",0).appendTo("#line");
				})
			}
			//自动间隔时间向上滑动
			var anifun = setInterval(autoani,value.time);

			//悬停时停止滑动，离开时继续执行
			$(docthis).children("li").hover(function(){
				clearInterval(anifun);			//清除自动滑动动画
			},function(){
				anifun = setInterval(autoani,value.time);	//继续执行动画
			})
		}
	})
})(jQuery);

var scrollContainer = Agent.ios ? $("#main") : $window;


//返回顶部和tab切换开始

function initScrolls() {
	var tabs = $("#tabs");
	var tabsOffset = tabs.offset().top;

	var adjustScroller = function () {
		var scrollTop = scrollContainer.scrollTop();
		if (scrollTop >= tabsOffset) {
			$body.addClass("tabs-fixed");
		} else {
			$body.removeClass("tabs-fixed");
		}
		if (scrollTop >= tabsOffset + 50) {
			$("#btn-gotop").show();
		} else {
			$("#btn-gotop").hide();
		}
	};

	var tabItems = tabs.find('a'); //$("#tabs a");
	tabItems.css({ width: (100 / tabItems.length) + '%' });
	tabItems.each(function() {
		$(this).click(function(e) {
			var page = $(this).data("page");
			setCurrentPage(page);
			setTimeout(adjustScroller, 100);
			e.preventDefault();
			return false;
		});
	});

	var tabs2 = tabs.clone(true);
	tabs2.attr("class", "tabs tabs2");
	tabs2.attr("id", "tabs2");
	$body.append(tabs2);

	scrollContainer.on("scroll", adjustScroller);
}



//直播判断开始

function initChannels() {
	window.channels = $('.channel');
	window.channelSwiper = $("#channel-swiper");
	window.videoContainer = $('#video-container');

	console.debug("channel count : " + channels.length);
	
	//计算视频宽高比
	var videoHeight = ($window.width() * 0.618) + 'px';
	channels.css({height: videoHeight});
	videoContainer.css({height: videoHeight });

	window.channelSwiperObj = new Swiper ('#channel-swiper', {
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
	
	$(".channel-tabs a").on('click',function(e){
		if (changing) return false;

		closeVideo();

		changing = true;
		var slideIndex = $(this).parent().index();
		channelSwiperObj.slideTo( slideIndex );
		changing = false;

		e.preventDefault();
		return false;
	});

	$(".channel-button").each(function() {
		$(this).click(function() {
			var channel = $(this).data("channel");
			onChannelPlay(channel);
		});
	});

	$(".channel").each(function() {
		var ch = $(this);
		var id = ch.attr("id");
		var ad = ch.data("ad");
		var HLS = "http://"+LiveServerDefault+"/hls/" + id + ".m3u8";
		ch.data("src", "");

		var state = ch.data("state");
		if (state != 3) {
			if (ad != null && ad != "") {
				ch.data("src", ad);
			}
			return;
		}

		$.get(HLS, function () {
			ch.data("src", HLS);
		}).fail(function() {
			if (ad != null && ad != "") {
				ch.data("src", ad);
			}
		});
	});

	refreshChannels();
}


function refreshChannels() {
	var now = new Date();
	var finishedCount = 0;
	var refreshInterval = 60000;
	channels.each(function(elementIndex, element) {
		var channel = $(this);
		var id = channel.attr("id");
		var state = channel.data("state");
		var time = channel.data("time");
		console.debug("channel " + id + " state = " + state + " time = " + time);

		var stateObj = $("#channel-state-" + id);

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
		} else if (diffH > 0){
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

	alert(state);
}


function getQueryString(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null) return unescape(r[2]); return null;
}

function checkWeixin() {
	var tokenParam = getQueryString("token");
	return (token == tokenParam);
}


function onChannelPlay(channel) {
	
	var token2 = token.replace(/(^\s*)|(\s*$)/g, "");
	if(token2!=null && token2.length!=0){
		if (!checkWeixin()) {
			alert(LocationMrt);
			location.href =LocationBus;
			return false;
		}
	}
	var ch = $("#" + channel);
	var src1 = ch.data("src");
	var src = src1.replace(/(^\s*)|(\s*$)/g, "");
	var state = ch.data("state");
	console.log('channel:'+channel);
	console.log('state:'+state);
	console.log('src:'+src);
	if (state != 3) {
		if (src != ""){
			playLiveChannel(channel, src);
		}else{
			showDuration(channel);
		}
		return;
	}

	if (src != "")
		playLiveChannel(channel, src);
	else
		showDuration(channel);
}

function playLiveChannel(channel, src) {
	$.get("/live/"+liveId+"/play");
	if (!!Agent.video.hls || Agent.android) {
		openVideo(src);
	} else {
		var swfPlayer = new SWFPlayer("video-container", "video-player", "100%", "100%", LiveServer);
		swfPlayer.reload(src);
	}
	channelSwiperObj.params.onlyExternal = true;
	channelSwiper.css({left: '-5000px'});
	videoContainer.css({visibility: 'visible'});
}

function closeVideo() {
	videoContainer.css({visibility: 'hidden'});
	channelSwiper.css({left:0});
	videoContainer.html('<video id="video-player" webkit-playsinline controls></video>');
}

function openVideo(src) {
	var v = document.getElementById("video-player");
	v.addEventListener("ended error stalled", function() {
		closeVideo();
	});

	v.src = src;
	v.play();
}



function initSideBar(gotopId) {
		gotopId.click(function() {
		goTop();
		return false;
	});
}



var signInfo = null;

function initSignInfo() {
	$.get("/member/signinfo?redirectUrl=" + location.href, function(data) {
		
		signInfo = data;
		if (Agent.weixin) {
			if (signInfo == null || signInfo.user == null) {
				if (signInfo.weixinOAuth2Url != null) {
					location.href = signInfo.weixinOAuth2Url;
				} else {
					location.href = "/auth/lazy?redirectUrl=" + escape(location.href);
				}
				return false;
			}
		}
	}).fail(function(e){
		
		signInfo = null;
	});
}

function initInteracts() {
	var liked = false;

	$("#interact-like").click(function() {
		if (liked) {
			alert("你已经赞过了哦");
			return false;
		}

		$.get("/live/" + liveId + "/like", function(result){
			liked = true;
			var likeCount = $("#like-count").text();
			likeCount = parseInt(likeCount) + 1;
			$("#like-count").html(likeCount);
			$("#like-tips").addClass("show");
			setTimeout(function() { $("#like-tips").removeClass("show"); }, 3200);
		});

	});

	$(".interact-comment").click(function() {
//            if (Agent.weixin) {
//                if (signInfo == null || signInfo.user == null) {
//                    if (signInfo.weixinOAuth2Url != null) {
//                        location.href = signInfo.weixinOAuth2Url;
//                    } else {
//                        location.href = "/auth/lazy?redirectUrl=" + escape(location.href);
//                    }
//                    return false;
//                }
//            }

		$("#video-player").addClass("hide");
		history.pushState({}, "评论", "liveId#comment");

		if (Agent.ios)
			$("#interacts").css({position:'absolute',top:$("#main")[0].scrollHeight + 'px'});

		$("#input").show();
		if(Agent.ios) {
			if (Agent.weixin)
				$("#editor").focus(); //Android focus issue: page scrolling
			else
				$("#nickname").focus();
		}
		setTimeout(function(){
			$(".input-wrap").addClass("show");
		}, 1);
	});

	$(".input-type-cancel").click(function() {
		//$("#editor").blur();
		window.history.back();

		//$("#input").hide();
		//$(".input-wrap").removeClass("show");
	});

	$(window).on('popstate', function() {
		var state = history.state;
		if (state == null) {
			$("#editor").blur();
			$("#input").hide();
			$(".input-wrap").removeClass("show");
			if (Agent.ios)
				$("#interacts").css({position:'fixed',top:'auto'});
			$("#video-player").removeClass("hide");
		}
	});

	initInputFaceList();

	$("#input-type-face").click(function() {
		$("#input-face-list").toggle();
	});


	$(".input-type-submit").click(function() {
		var nickname = $("#nickname").val();
		if (nickname.trim() == "") {
			nickname = "匿名";
		}


		var editor = $("#editor");
		var value = editor.val();
		if (value.trim() == "") {
			editor.val("");
			alert("请输入评论内容");
			return false;
		}

		var userId = 0;
		var username = nickname;
		var userImage = "/res/pub/user-default-w.png";

		if (Agent.weixin) {
			userId = UserId;
			username = UsernickName;
			userImage = UserImage;
		}

		var comment = {
			liveId: liveId,
			userId: userId,
			username: username,
			content: value,
			userImage: userImage
		};


		$.ajax({
			'headers': { 'Accept': 'application/json', 'Content-Type': 'application/json' },
			'type': 'POST',
			'url': "/live/" + liveId+"/commentCreate",
			'data': JSON.stringify(comment),
			'dataType': 'json',
			'success': function(result) {
				editor.val("");
				$("#input-face-list").hide();

				commentHint.removeClass("comment-null");

//                    if ($("#comments").data("loaded") == 1) {
//                        comment.createTime = getCurrentTime(true);
//                        createCommentElement(comment, true);
//                    }
				window.history.back();
				alert("感谢评论，您的评论已发送");
				$("#input").hide();
			}
		});
		return false;
	});

	$("#editor").on("focus", function() {
		$("#input-face-list").hide();
		/* if (signInfo == null || signInfo.user == null) {
		 if (signInfo.weixinOAuth2Url != null) {
		 location.href = signInfo.weixinOAuth2Url;
		 } else {
		 location.href = "/auth/lazy?redirectUrl=" + escape(location.href);
		 }
		 return false;
		 } */
	});
}

var _escaper = $('<div/>');
function escape(s) {
	return _escaper.text(s).html();
}

//表情栏
function initInputFaceList() {
	var editor = $("#editor");

	var emotions = ['000','002','004','006','012','013','042','063','065','066','076','078','079','089'];
	var html = "";
	for (var i = 0; i < emotions.length; ++i) {
		html += '<a href="'+ emotions[i] +'"><img src="/res/pub/em/t'+ emotions[i] +'.png" width="24"></a>';
	}
	$("#input-face-list").html(html);
	$("#input-face-list a").click(function() {
		var link = $(this);
		var href = link.attr("href");
		var value = editor.val() + "[" + href + "]";
		editor.val(value);

		return false;
	});
}

var curPage = "intros";


function setCurrentPage(newPage) {
	if (newPage != curPage) {
		$body.removeClass(curPage + '-active');
		$body.addClass(newPage + '-active');

		console.log(curPage + " => " + newPage);
		$("#" + curPage).hide();
		$("#" + newPage).show();
		curPage = newPage;

		var page = $("#" + curPage);
		var dataLoaded = page.data("loaded");
		if (dataLoaded == 0 && curPage == "photos") {
			page.data("loaded", 1);
			if (Agent.ios) {
				$("#photos img").lazyload({
					container: $("#main"),
					threshold : 200
				});
			} else {
				$("#photos img").lazyload({
					threshold : 200
				});
			}
		}

		if (dataLoaded == 0 && curPage == "videos") {
			page.data("loaded", 1);
			if (Agent.ios) {
				$("#videos img").lazyload({
					container: $("#main"),
					threshold : 200
				});
			} else {
				$("#videos img").lazyload({
					threshold : 200
				});
			}
		}

		if (dataLoaded == 0 && curPage == "comments") {
			page.data("loaded", 1);
			loadComments();
		}
	}
}

var commentLoading=false;
var commentTimestamp;
var commentTimestamp_2;
var commentTimestamp_2_state = 0;
var commentHint = $("#comment-hint");


$(".tab-comments").click(function(){
	$(".comment").remove();

	var html = "<li class='comment' id='comment-template'>"+
		"<a href='javascript:;'><img src='/res/pub/user-default-w.png'></a>"+
		"<dl>"+
		"<dt class='comment-user'>陆无双</dt>"+
		"<dd class='comment-like'><a href='javascript:;'><i class='fa fa-thumbs-o-up'></i><span>15</span></a></dd>"+
		"<dd class='comment-data'>你们本就是天生一对，地造一双，而今共偕连理，今后更需彼此宽容、互相照顾，祝福你们！ 愿你俩用爱去缠着对方，彼此互相体谅和关怀，共同分享今后的苦与乐。敬祝百年好合永结同心。</dd>"+
		"<dd class='comment-tool'> <span class='time'>8分钟前</span> <a class='reply'>回复</a> <a class='delte'>删除</a> </dd>"+
		"</dl>"+
		"</li>";

	$("#comment-body").html(html);

	commentHint.removeClass("comment-done");
	commentTimestamp_2_state = 1;
	loadComments(null);
});


function initComments() {
	$(".comment-hint .load a").click(function() {
		commentTimestamp_2_state = 2;
		if (commentLoading==false)
			loadComments(commentTimestamp);
	});
};

function loadComments(timestamp) {
	if (commentLoading) return;

	if (timestamp == null) timestamp = "";
	commentHint.removeClass("comment-load");
	commentHint.addClass("comment-wait");
	commentLoading=true;
	$.get("/live/"+liveId+"/commentList?size=30&time=" + timestamp, function(result){
		commentLoading=false;
		commentHint.removeClass("comment-wait");
		onCommentLoaded(result);
	}).fail(function(e){
		commentHint.data("done", 1);
		commentHint.addClass("comment-warn");
		commentHint.removeClass("comment-wait");
	});
};


//加载评论
function onCommentLoaded(result) {
	var comments = result;
	var len = comments.length;

	//取最新但返回条数为0，没有评论
	if (len == 0 && result.time == null) {
		commentHint.addClass("comment-done");
		commentHint.data("done", 1);
		return;
	}

	//返回条数0，已全部加载
	if (len == 0) {
		commentHint.addClass("comment-done");
		commentHint.data("done", 1);
		return;
	}

	for (var i = 0; i < len; ++i) {
		if( commentTimestamp_2_state == 1){
			if(i == 0){
				commentTimestamp_2 = comments[i].createTime;
			}
		}

		createCommentElement(comments[i]);
	}
	commentTimestamp = comments[len - 1].createTime;

	if (len < result.size) {
		//返回条数小于页大小,已全部加载
		commentHint.addClass("comment-done");
		commentHint.data("done", 1);
	} else {
		//还有未加载数据
		commentHint.addClass("comment-load");
		commentHint.data("done", 0);
	}
};

//设置刷新评论时间
function commentRefresh()
{
	if (commentTimestamp_2 == null) commentTimestamp_2 = "";
	var data = {
		size: 30,
		time: commentTimestamp_2
	};

	$.ajax({
		'headers': { 'Accept': 'application/json', 'Content-Type': 'application/json' },
		'type': 'POST',
		'url': "/live/"+liveId+"/commentList_new",
		'data': JSON.stringify(data),
		'dataType': 'json',
		'success': function(result) {

			if(result.errcode == 100){
				var len = result.data.length;
				for (var i = 0; i < len; ++i) {
					if(i == 0){
						commentTimestamp_2 = result.data[i].createTime;
					}
					createCommentElement(result.data[i], true);
				}
			}

		}
	});
}
setInterval('commentRefresh()',5000);


//创建评论
function createCommentElement(comment, insertTop) {
	if (insertTop == null) insertTop = false;
	var li = document.getElementById("comment-template");
	li = li.cloneNode(true);

	li = $(li);
	li.attr("id", comment.id);

	if (comment.userImage != null && comment.userImage != "") {
		var imgsrc = comment.userImage.replace(/\/0/, "/96");
		var img = li.find("a img");
		img.attr("src", imgsrc);
	}

	var user = li.find(".comment-user");
	user.text(comment.username);

	var content = comment.content;
	content = content.replace(/\[(\d\d\d)\]/g, "<img class='em' src='/res/pub/em/t$1.png' height='20px'>");

	var data = li.find(".comment-data");
	data.html(content);

	var time = li.find(".time");
	time.text(getHumanTime(comment.createTime));

	var commentList = $("#comment-list");
	if (insertTop)
		li.prependTo(commentList);
	else
		li.appendTo(commentList);
	return li;
}

//评论时间计算
function getHumanTime(time) {
	var now = new Date();
	time = time.replace(/-/g, "/");
	var ctm = new Date(Date.parse(time));

	var diff = now.getTime() - ctm.getTime();
	diff = Math.floor(diff / 1000);
	if (diff < 2) return "刚刚";

	if (diff < 60) return diff + "秒前";
	diff = Math.floor(diff / 60);
	if (diff < 60) return diff + "分钟前";
	diff = Math.floor(diff / 60);
	if (diff < 24) return diff + "小时前";
	diff = Math.floor(diff / 24);
	if (diff < 30) return diff + "天前";

	diff = Math.floor(diff / 30);
	var diffY = Math.floor(diff / 365);
	if (diff < 12) return diff + "月前";
	if (diffY > 0) return diff + "年前";
	return diff;
}

//获取当前时间
function getCurrentTime(needTime){
	if (needTime == null) needTime=false;
	var now=new Date();
	var s = now.getFullYear() +"-"+(now.getMonth()+1)+"-"+now.getDate();
	if (needTime) s += " "+now.getHours()+":"+now.getMinutes() +":"+now.getSeconds();
	return s;
}

//Avoid main scrolling at top or bottom 然而并没有什么用的禁止上下滑动
if (Agent.ios) {
	var content = document.querySelector('#main');
	var startY;

	content.addEventListener('touchstart', function (e) {
		startY = e.touches[0].clientY;
	});

	content.addEventListener('touchmove', function (e) {
		// 高位表示向上滚动
		// 底位表示向下滚动
		// 1容许 0禁止
		var status = '11';
		var ele = this;

		var currentY = e.touches[0].clientY;

		if (ele.scrollTop === 0) {
			// 如果内容小于容器则同时禁止上下滚动
			status = ele.offsetHeight >= ele.scrollHeight ? '00' : '01';
		} else if (ele.scrollTop + ele.offsetHeight >= ele.scrollHeight) {
			// 已经滚到底部了只能向上滚动
			status = '10';
		}

		if (status != '11') {
			// 判断当前的滚动方向
			var direction = currentY - startY > 0 ? '10' : '01';
			// 操作方向和当前允许状态求与运算，运算结果为0，就说明不允许该方向滚动，则禁止默认事件，阻止滚动
			if (!(parseInt(status, 2) & parseInt(direction, 2))) {
				//stopEvent(e);
				//console.log("touchmove stopped");
				e.preventDefault();
				e.stopPropagation();
				return false;
			}
		}
	});
}

//返回顶部滚动系数计算判断
function goTop(acceleration, time) {
	if (Agent.ios) {
		$("#main").animate({scrollTop: 0}, 500);
		return;
	}
	acceleration = acceleration || 0.1;
	time = time || 16;

	var x1 = 0;
	var y1 = 0;
	var x2 = 0;
	var y2 = 0;
	var x3 = 0;
	var y3 = 0;

	if (document.documentElement) {
		x1 = document.documentElement.scrollLeft || 0;
		y1 = document.documentElement.scrollTop || 0;
	}
	if (document.body) {
		x2 = document.body.scrollLeft || 0;
		y2 = document.body.scrollTop || 0;
	}
	var x3 = window.scrollX || 0;
	var y3 = window.scrollY || 0;

	// 滚动条到页面顶部的水平距离
	var x = Math.max(x1, Math.max(x2, x3));
	// 滚动条到页面顶部的垂直距离
	var y = Math.max(y1, Math.max(y2, y3));

	// 滚动距离 = 目前距离 / 速度, 因为距离原来越小, 速度是大于 1 的数, 所以滚动距离会越来越小
	var speed = 1 + acceleration;
	window.scrollTo(Math.floor(x / speed), Math.floor(y / speed));

	// 如果距离不为零, 继续调用迭代本函数
	if(x > 0 || y > 0) {
		var invokeFunction = "goTop(" + acceleration + ", " + time + ")";
		window.setTimeout(invokeFunction, time);
	}
}

/*
 * 	if(/iPhone|iPod|Android|iPad/.test(window.navigator.platform))
 fixed3();
 */


/*$(".tab-fellows").click(function(){
 window.location.href ="http://bao.pps123.cn/dyhuaqi";
 });*/