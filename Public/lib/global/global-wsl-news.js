
//
	function init() {
		liveWebSocket();
		browserinfo();
		if (userName == '' || userName == null) {
			userName = "匿名";
		}
		console.log(11111111111);
	}
//
	function liveWebSocket() {
		websocket = new WebSocket(wsUri);
		websocket.onopen = function (evt) {
			onOpen(evt)
		};
		websocket.onclose = function (evt) {
			onClose(evt)
		};
		websocket.onmessage = function (evt) {
			onMessage(evt)
		};
		websocket.onerror = function (evt) {
			onError(evt)
		};
	}
//开
	function onOpen(evt) {}

//关
	function onClose(evt) {}

//评论消息处理
	function onMessage(evt) {
		var obj = toJson(evt.data);
		console.log(obj);
		var type = obj.type;
		if (userName == "") {
			userName = "匿名";
		}
		switch (type) {
			case "open":
				clientId = obj.clientId;
				console.log(clientId);
				break;
			case "num":
				$("#totalViewNum").text(obj.totalViewNum);
				break;
			case "join"://用户加入直播间
				timeWait = Number(obj.cmntTime);
				timeWait2 = Number(obj.cmntTime);
				maxLength = Number(obj.cmntLength);
				allow = Number(obj.cmntAllow);
				isAllowComment();
				$("#totalViewNum").text(obj.totalViewNum);

				var jsonArray=obj.cmntList;
	            $.each(jsonArray,function(i,item){
	            	createCommentElement(item, null, true);
	            });
				break;
			case "say":
				console.log(obj);
				createCommentElementByOther(obj, null, true);
				$('.content').scrollTop($('.la').height() + 600000);
				break;
			case "gift":
				createCommentElementByOther(obj, null, true);
				$('.content').scrollTop($('.la').height() + 600000);
				break;
			case "leave":
				//$("#"+obj.clientId).remove();
				setVal(obj);
				break;
			case "statistics":
				setVal(obj);
				break;
			default:
	//                writeToScreen('<span style="color: blue;">RESPONSE: ' + evt.data + '</span>');
				break;
		}
	}
	
	var sendComment= $("#like-send");
	var commentText= $("#like-text");
	
	var setwait=10;
    function setlatertime(obj) {
            if (setwait == 0) {
                obj.removeAttr("disabled").css('background','#3dc968');          
                obj.text("发送");
                setwait = 10;
            } else {
                obj.attr("disabled", true).css("background","#ccc");
                obj.text("发送(" + setwait + ")");
                setwait--;
                setTimeout(function() {
                    setlatertime(obj)
                },
                1000)
            }
    }


	sendComment.click(function (){
		var userId = "";
		var userImage = "";
	

		var value = commentText.val();
		if (value.trim() == "") {
			commentText.val("");
			alert("请输入评论内容");
			return false;
		}
		else
        {
            setlatertime($(this));
        }
		
		commentText.val("");

		var commentMsg = setJson(commentMsg, "clientId", clientId);
			commentMsg = setJson(commentMsg, "type", "say");
			commentMsg = setJson(commentMsg, "userId", userId);
			commentMsg = setJson(commentMsg, "userName", userName);
			commentMsg = setJson(commentMsg, "userImage", userImage);
			commentMsg = setJson(commentMsg, "roomId", liveId);
			commentMsg = setJson(commentMsg, "content", value);
			commentMsg = setJson(commentMsg, "createTime", getCurrentTime(true));
	
		$.post(
			"/message",
			{"data": commentMsg},
			function (data) {
				console.log(data);
			}, 'json'
		);
		return false;
	});
	
//添加或者修改json数据
	function setJson(jsonStr, name, value) {
		if (!jsonStr)jsonStr = "{}";
		var jsonObj = JSON.parse(jsonStr);
		jsonObj[name] = value;
		return JSON.stringify(jsonObj)
	}
	
	function toJson(str) {
		var json = eval('(' + str + ')');
		return json;
	}
	
	window.addEventListener("load", init, false);

	var $window = $(window);
	var $body = $(document.body);
	var likeSign, likeSignList, interactLike, likeSend, likeText;
	var commentLoading = false;
	var commentTimestamp;
	var commentTimestamp_2;
	var scrollTopHeight = 0;
	//var giftPresentedTimestamp = '{{ctime}}';
	//var cashPresentedTimestamp = '{{ctime}}';
	
	likeSign = $("#like-sign");
	likeSignList = $("#like-sign-list");
	likeSend = $("#like-send");
	likeText = $("#like-text");
	var _liked = false;
	//interactLike = $("#interact-like");
	
	
	var emotions = ['000', '002', '004', '006', '012', '013', '042', '063', '065', '066', '076', '078', '079', '089'];
	
	function initLikeEmotion() {
		var html = "";
		for (var i = 0; i < emotions.length; ++i) {
			html += '<a href="' + emotions[i] + '"><img src="/res/pub/em/t' + emotions[i] + '.png"></a>';
		}
		likeSignList.html(html);
	
		$("#like-sign-list a").click(function () {
			var link = $(this);
			var href = link.attr("href");
			var value = likeText.val() + "[" + href + "]";
			likeText.val(value);
			likeText.focus();
			likeTextChanging(value);
			return false;
		});
	}
	function likeTextChanging(value) {
		if (value.trim() != "") {
			likeSend.removeAttr("disabled");
		} else {
			likeSend.attr('disabled', "disabled");
		}
	}
	likeSign.click(function () {
		likeSignList.toggle();
	
		return false;
	});
	likeText.focus(function () {
		var tTop = $(this).offset().top;
		//$('.channels').css('position','static');
		$("body").animate({scrollTop: tTop - 100 + 'px'}, 200);
		likeSignList.hide();
	});
	
//计算content高度；
	var $lb_h = $('.live_banner').height();
	var $nav_h = $('.nav').height();
	var $ft_h = $('.nav_footer').height();
	var ct_h = $(window).height() - $lb_h - $nav_h - $ft_h + 10;

	var $li_l = $('.retroversion').find('li').length;

	for (var i = 1; i < $li_l + 1; i++) {
		var now = i % 2;
		if (now == 0) {
			$('.retroversion').find('li').eq(i - 1).css("margin-left", "2%")
		}
	}
	loadComments(null);
	//console.log('topcontent:'+$('.content').scrollTop());
	//console.log('contentheiht:'+$('.content').height());
	//console.log('commentListheiht:'+$('.commentList').height());
	$('.content').scrollTop($('.content').height());
	//console.log('aftop:'+$('.content').scrollTop());
	$('.discussbar .input').width($('.discussbar').width() - $('#like-send').width());
	$('.discussbar .input input').width($('.discussbar .input').width() - $('.like-sign').width() - 10);

<!--倒计时-->
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
			var HLS = "http://"+liveServerD+"/hls/" + id + ".m3u8";
			if(liveId=="L02367"){
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
	
		alert(state);
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
				alert(livelocationMrt);
				location.href = liveLocationBus;
				return false;
			}
		}
		var ch = $("#" + channel);
		var src1 = ch.data("src");
		var src = src1.replace(/(^\s*)|(\s*$)/g, "");
		var state = ch.data("state");
	
		var statisticsMsg = setJson(statisticsMsg, "clientId", clientId);
		statisticsMsg = setJson(statisticsMsg, "type", "statistics");
		statisticsMsg = setJson(statisticsMsg, "userId", userId);
		statisticsMsg = setJson(statisticsMsg, "userName", userName);
		statisticsMsg = setJson(statisticsMsg, "userImage", userImage);
		statisticsMsg = setJson(statisticsMsg, "roomId", liveId);
		statisticsMsg = setJson(statisticsMsg, "message", "play");
		statisticsMsg = setJson(statisticsMsg, "createTime", getCurrentTime(true));
		if (state != 3) {
			alert(1);
			if (src != "") {
				$.post(
					"/message",
					{"data": statisticsMsg},
					function (data) {
						console.log(data);
					}, 'json'
				);
				playLiveChannel(channel, src);
			} else {
				showDuration(channel);
			}
			return;
		}
	
		if (src != "") {
			$.post(
				"/message",
				{"data": statisticsMsg},
				function (data) {
					console.log(data);
				}, 'json'
			);
			playLiveChannel(channel, src);
		}
		else
			showDuration(channel);
	}
	
	function playLiveChannel(channel, src) {
		$.get("/live/"+liveId+"/play");
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
	
	
	/*
	 *留言
	 */
	//

	function loadComments(timestamp, insertTop) {
		if (commentLoading) return;
	
		if (timestamp == null) timestamp = "";
		$('#slideUp2').css('display', 'block');
		commentLoading = true;
		// liveId  = '{{ live.id }}';
		$.get("/live/"+liveId+"/commentList?size=10&time=" + timestamp, function (result) {
			commentLoading = false;
			$('#slideUp2').css('display', 'none');
			onCommentLoaded(result, insertTop);
		}).fail(function (e) {
			$('#slideUp2').css('display', 'none');
			$('#commentWarn').css('display', 'block');
		});
	}
	
	function onCommentLoaded(result, insertTop) {
		var comments = result;
		var len = comments.length;
	
		//取最新但返回条数为0，没有评论
		if (len == 0 && result.time == null) {
			$('#commentDone').css('display', 'block');
			setTimeout(function () {
				$('#commentDone').css('display', 'none');
			}, 2500);
			return;
		}
	
		//返回条数0，已全部加载
		if (len == 0) {
			$('#commentDone').css('display', 'block');
			setTimeout(function () {
				$('#commentDone').css('display', 'none');
			}, 2500);
			return;
		}
	
		if (insertTop) {
			for (var i = 0; i < len; ++i) {
				createCommentElement(comments[i], insertTop, false);
			}
		}
		else {
			for (var i = len - 1; i >= 0; --i) {
				if (i == 0) {
					commentTimestamp_2 = comments[i].createTime;
				}
				createCommentElement(comments[i], insertTop, true);
			}
		}
	
		commentTimestamp = comments[len - 1].createTime;
	
	
		commentLoading = false;
	}
	
	//添加用户新留言
	function createCommentElement(comment, insertTop, scroll) {
		if (insertTop == null) insertTop = false;
		if (scroll == null) scroll = false;
		var li = '<li>' +
			'<div class="p_head">' +
			'<img src="/res/pub/user-default-w.png">' +
			'</div>' +
			'<div class="dis_right">' +
			'<h3><span class="comment-username">匿名</span><span>(<i class="time">14:16:11</i>)</span></h3>' +
			'<p class="comment-detail">' +
			'在好课网可以免费创建和发布课程在好课网可以免费创建和发布课程在好课网可以免费创建和发布课程' +
			'</p>' +
			'</div>' +
			'</li>';
	
		li = $(li);
		li.attr("id", comment.id);
	
	
		if (comment.userImage != null && comment.userImage != "") {
			var imgsrc = comment.userImage.replace(/\/0/, "/96");
			var img = li.find("div img");
			img.attr("src", imgsrc);
		}
	
		var user = li.find(".comment-username");
	
		var name = comment.userName ? comment.userName : comment.username;
		user.text(name);
	
		if (comment.isPresented == 1) {
			var data = li.find(".comment-detail");
			if (comment.giftImage != null && comment.giftImage != "") {
				var giftImgsrc = comment.giftImage.replace(/\/0/, "/96");
				data.html('<p>送出了<img class="presented-giftImage" src="/res/home/images/shang.png" alt=""><span></span></p>');
			}
		}
		else {
			var content = comment.content;
			content = content.replace(/\[(\d\d\d)\]/g, "<img class='em' src='/res/pub/em/t$1.png' height='20px'>");
	
			var data = li.find(".comment-detail");
			data.html('<p>' + content + '</p>');
		}
	
		var time = li.find(".time");
		console.log(comment.createTime);
		time.text(getHumanTime(comment.createTime));
	
		var commentList = $("#commentList");
		if (insertTop)
			li.prependTo(commentList);
		else {
			li.appendTo(commentList);
			if (scroll)
				$('.discuss').scrollTop($('#commentList').height());
		}
		scrollTopHeight += li.height();
		return li;
	}
	
	//添加用户新留言,这里处理主要是处理新老模板的问题username和userName
	function createCommentElementByOther(comment, insertTop, scroll) {
		if (insertTop == null) insertTop = false;
		if (scroll == null) scroll = false;
		var li = '<li>' +
			'<div class="p_head">' +
			'<img src="/res/pub/user-default-w.png">' +
			'</div>' +
			'<div class="dis_right">' +
			'<h3><span class="comment-username">小李子</span><span>(<i class="time">14:16:11</i>)</span></h3>' +
			'<p class="comment-detail">' +
			'在好课网可以免费创建和发布课程在好课网可以免费创建和发布课程在好课网可以免费创建和发布课程' +
			'</p>' +
			'</div>' +
			'</li>';
	
		li = $(li);
		li.attr("id", comment.id);
	
	
		if (comment.userImage != null && comment.userImage != "") {
			var imgsrc = comment.userImage.replace(/\/0/, "/96");
			var img = li.find("div img");
			img.attr("src", imgsrc);
		}
	
		var user = li.find(".comment-username");
		user.text(comment.userName);
	
		if (comment.isPresented == 1) {
			var data = li.find(".comment-detail");
			if (comment.giftImage != null && comment.giftImage != "") {
				var giftImgsrc = comment.giftImage.replace(/\/0/, "/96");
				data.html('<p>送出了<img class="presented-giftImage" src="/res/home/images/shang.png" alt=""><span></span></p>');
			}
		}
		else {
			var content = comment.content;
			content = content.replace(/\[(\d\d\d)\]/g, "<img class='em' src='/res/pub/em/t$1.png' height='20px'>");
	
			var data = li.find(".comment-detail");
			data.html('<p>' + content + '</p>');
		}
	
		var time = li.find(".time");
		time.text(getHumanTime(comment.createTime));
	
		var commentList = $("#commentList");
		if (insertTop)
			li.prependTo(commentList);
		else {
			li.appendTo(commentList);
			if (scroll)
				$('.discuss').scrollTop($('#commentList').height());
		}
		scrollTopHeight += li.height();
		return li;
	}
	
	//评论时间处理
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
	
	function getCurrentTime(needTime) {
		if (needTime == null) needTime = false;
		var now = new Date();
		var s = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
		if (needTime) s += " " + now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds();
		return s;
	}
	
	//下拉刷新
	
	//第一步：下拉过程 
	function slideDownStep1(dist){  // dist 下滑的距离，用以拉长背景模拟拉伸效果 
	    var slideDown1 = document.getElementById("slideDown1"), 
	        slideDown2 = document.getElementById("slideDown2"); 
	    slideDown2.style.display = "none"; 
	    slideDown1.style.display = "block"; 
	} 
	//第二步：下拉，然后松开， 
	function slideDownStep2(){  
	    var slideDown1 = document.getElementById("slideDown1"), 
	        slideDown2 = document.getElementById("slideDown2"); 
	    slideDown1.style.display = "none";  
	    slideDown2.style.display = "block"; 
	    //刷新数据 
	    //location.reload(); 
	} 
	//第三步：刷新完成，回归之前状态 
	function slideDownStep3(){  
	    var slideDown1 = document.getElementById("slideDown1"), 
	        slideDown2 = document.getElementById("slideDown2"); 
	    slideDown1.style.display = "none"; 
	    slideDown2.style.display = "none"; 
	} 


	function k_touch(contentId) {
		var _start = 0,
			_end = 0;
		_content = document.getElementById(contentId);
		_content.addEventListener("touchstart", touchStart, false);
		_content.addEventListener("touchmove", touchMove, false);
		_content.addEventListener("touchend", touchEnd, false);
	
		function touchStart(event) {
			//var touch = event.touches[0]; //这种获取也可以，但已不推荐使用
	
			var touch = event.targetTouches[0];
	
			_start = touch.pageY;
		}
	
		function touchMove(event) {
			var touch = event.targetTouches[0];
			_end = (_start - touch.pageY);
	
			if ($('.content').scrollTop() < 30) {
				//下滑到顶部才执行操作
				slideDownStep1(_end);
			}
	
			//if(_end < 0){
			//下滑执行操作
			//slideDownStep1(_end);
			//}
		}
	
		function touchEnd(event) {
			if (_end < 0 && $('.content').scrollTop() < 30) {
				scrollTopHeight = 0;
				slideDownStep2(commentTimestamp);
				setTimeout(function () {
					$('.content').scrollTop(scrollTopHeight);
				}, 500);
	
				//加载成功则进入第三步
				setTimeout(function () {
					slideDownStep3();
				}, 2500);
			}
		}
	}
	
	//菜单
	$('.nav_list').find('li:eq(0)').on('click', function () {
		console.log($('.content').scrollTop());
		$('.content').scrollTop(scrollTopHeight);
		console.log("asdf" + $('.content').scrollTop());
		console.log(scrollTopHeight);
	})
	
	/*
	 *打赏
	 */
	$('.btn_areward').click(function () {
		var presentedMoney = $('#presentedMoney').val();
		if (presentedMoney <= 0 || isNaN(presentedMoney)) {
			alert("输入金额错误");
			return;
		}
		/* if(presentedMoney < 1){
		 alert("打赏金额最低为1元");
		 return;
		 } */
		var postData = {
			liveId: liveId,
			giftId: 0,
			money: presentedMoney,
			giftAmount: 0,
		};
		$.ajax({
			'type': 'POST',
			'url': "/dxwepay/giftPay",
			'data': postData,
			'dataType': 'html',//json
			'success': function (result) {
				/*if(result == 409){
				 alert("对不起，操作失败");
				 return;
				 }*/
				//$('.shade').fadeOut('fast');
				$('.close').click();
				$('.wechat_pay').html(result);
				$('.wechat_pay').css('display', 'block');
			},
			error: function (XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest.status);
				alert(XMLHttpRequest.readyState);
				alert(textStatus);
			}
		});
	
		$('.payfor_list input:text').focus(function () {
			$('.nav_footer').css("position", "static")
		});
		$('.payfor_list input:text').blur(function () {
			$('.nav_footer').css("position", "fixed")
		});
	
	})
	
	/**
	* 视频播放
	* @param video_name
	*/
	function onVideoPlay(id, videoName) {
	var src = ""+configOssimgPath+"/"+liveId+"/video/" + videoName + "/index.m3u8";
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
