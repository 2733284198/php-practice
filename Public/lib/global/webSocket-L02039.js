//初始化websocket连接
function init() {
	liveWebSocket();
	if (userName == '' || userName == null) {
		userName = "匿名";
	}
}

var timeWait = 10;       //评论的间隔时间
var timeWait2 = 10;      //评论重新赋值的时间
var maxLength = 30;     //评论字数的长度
var allow = 1;          //是否允许评论
var nowSend = 1;        //当前发送状态：1允许发送，0禁止发送;
var c = 0;              //判断重连的次数
var stopSpeak = $('<div class="stopSpeak">频道管理员已禁止发言</div>');

//websocket系列事件
function liveWebSocket() {

	c++;
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

	};
}

//和服务器建立websocket连接
function onOpen(evt) {
	var joinMsg = setJson(joinMsg, "type", "join");
	joinMsg = setJson(joinMsg, "userId", userId);
	joinMsg = setJson(joinMsg, "userName", userName);
	joinMsg = setJson(joinMsg, "userImage", userImage);
	joinMsg = setJson(joinMsg, "roomId", liveId);
	joinMsg = setJson(joinMsg, "content", "");
	joinMsg = setJson(joinMsg, "createTime", getCurrentTime(true));
	websocket.send(joinMsg);
	//console.log("打开");
}

//连接关闭，重连2次
function onClose(evt) {
	if (c == 0) {
		setTimeout(function () {
			liveWebSocket()
		}, 2000);
	}
	if (c == 1) {
		setTimeout(function () {
			liveWebSocket()
		}, 4000);
	}
	if (c == 2) {
		setTimeout(function () {
			liveWebSocket()
		}, 8000);
	}
	if (c == 3) {
		alert('连接已断开，请刷新网页');
	}
}

//websocket评论消息处理
function onMessage(evt) {
	var obj = toJson(evt.data);
	var type = obj.type;
	//console.log(evt.data);
	if (userName == "") {
		userName = "匿名";
	}
	switch (type) {
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
			console.log(obj.currentNum);
			break;
		case "say"://用户在直播间说话
			createCommentElement(obj, null, true);
			
			break;
		case "notice"://直播间的通知
			//顶部消息滚动
			$('.movetext').find('span').text(obj.content);
			moveText($('.movetext'));
			break;
		case "cmntLength"://评论字数的限制
			maxLength = Number(obj.content);
			break;
		case "cmntTime"://评论时间间隔的限制

			timeWait = Number(obj.content);
			timeWait2 = Number(obj.content);
			break;
		case "cmntAllow"://是否允许评论
			allow = Number(obj.content);
			isAllowComment();
			$('.stopSpeak').text(obj.message);
			break;
		default:
			//writeToScreen('<span style="color: blue;">RESPONSE: ' + evt.data + '</span>');
			break;
	}
}

//消息通知
function moveText(moveObj) {
	moveObj.animate({left: -($('.movetext').outerWidth(true))}, 10000, "linear", function () {
		$(this).css("left", "100%")
	})
}

//键盘抬起时，判断字数，只要输入文字就会调用
onKeyUp();
function onKeyUp() {
	$('#like-text').keyup(function () {
		if (allow == 1) {
			if (nowSend == 1) {
				if ($(this).val().length > maxLength) {
					$('#like-send').attr("disabled", true).css("background", "#ccc");
				} else {
					$('#like-send').removeAttr("disabled").css('background', '#3dc968');
				}
			}
		} else {
			$('#like-send').attr("disabled", true).css("background", "#ccc");
		}
	})
}

/**
 * 评论发布成功开始倒计时
 */
function startCountdown(obj) {
	if (timeWait == 0) {
		if ($('#like-text').val().length > maxLength) {
			obj.attr("disabled", true).css("background", "#ccc");
		} else {
			obj.removeAttr("disabled").css('background', '#3dc968');
		}
		timeWait = timeWait2;
		obj.text("发送");
		nowSend = 1;
	} else {
		obj.attr("disabled", true).css("background", "#ccc");
		obj.text("发送(" + timeWait + ")");

		timeWait--;
		setTimeout(function () {
			startCountdown(obj)
		}, 1000)
	}
}

/**
 * 是否允许评论
 * 如果是要关闭，那么按钮变灰
 * 如果是要开启，那么按钮变绿，但是如果字数超过规定字数则变灰
 */
function isAllowComment() {
	if (0 == Number(allow)) {
		$('#like-send').attr("disabled", true).css("background", "#ccc");
		$('.discuss').append(stopSpeak);
		$('.discuss').css("overflow", "hidden");
		$('#like-sign').attr("disabled", true);
	} else {
		$('.discuss').children('.stopSpeak').remove();
		$('.discuss').css("overflow", "auto");
		$('#like-sign').removeAttr("disabled");
		if ($('#like-text').val().length > maxLength) {
			$('#like-send').attr("disabled", true).css("background", "#ccc");
		} else {
			$('#like-send').removeAttr("disabled").css('background', '#3dc968');
		}
	}
}

/**
 * 点击发送按钮事件
 */
sendComment.click(function () {
	if (allow == 1) {
		var value = commentText.val();
		if (value.trim() == "") {
			commentText.val("");
			alert("请输入评论内容");
		} else {
			//去倒计时
			startCountdown($(this));

			//过滤
			value = value.replace(/</g, '&lt;');
			value = value.replace(/>/g, '&gt;');

			var commentMsg = setJson(commentMsg, "type", "say");
			commentMsg = setJson(commentMsg, "userId", userId);
			commentMsg = setJson(commentMsg, "userName", userName);
			commentMsg = setJson(commentMsg, "userImage", userImage);
			commentMsg = setJson(commentMsg, "roomId", liveId);
			commentMsg = setJson(commentMsg, "content", value);
			commentMsg = setJson(commentMsg, "createTime", getCurrentTime(true));
			websocket.send(commentMsg);

			nowSend = 0;
			//清空文字
			commentText.val("");
		}
	}
});
/***
 *  评论区表情按钮的点击事件;
 */
likeSign.click(function () {
	likeSignList.toggle();
	if (allow == 1) {
		if (nowSend == 1) {
			if ($('#like-text').val().length > maxLength) {
				$('#like-send').attr("disable", true).css("background", "#ccc");
			} else {
				$('#like-send').removeAttr("disable").css("background", "#3dc968");
			}
		}
	} else {
		$('#like-send').attr("disable", true).css("background", "#ccc");
	}
	return false;
});

/*
 *留言
 */
//
//加载更多评论;
function loadComments(timestamp, insertTop) {
	if (commentLoading) return;

	if (timestamp == null) timestamp = "";
	$('#slideUp2').css('display', 'block');
	commentLoading = true;
	// liveId  = '{{ live.id }}';
	$.get("/live/" + liveId + "/commentList?size=10&time=" + timestamp, function (result) {
		commentLoading = false;
		$('#slideUp2').css('display', 'none');
		onCommentLoaded(result, insertTop);
	}).fail(function (e) {
		$('#slideUp2').css('display', 'none');
		$('#commentWarn').css('display', 'block');
	});
}

//进入直播间像数据库取评论数据;
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
	var li = $('<li>' +
		'<div class="p_head">' +
		'<img class="discuss-media" src="/res/pub/user-default-w.png">' +
		'</div>' +
		'<div class="dis_right">' +
		'<h3><span class="comment-username">匿名</span><span>(<i class="time"></i><i class="trueTime" style="display: none;"></i>)</span></h3>' +
		'<p class="comment-detail">' +
		'</p>' +
		'</div>' +
		'</li>');

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
			data.html('送出了<img class="presented-giftImage" src="/res/home/images/shang.png" alt=""><span></span>');
		}
	}
	else {
		var content = comment.content;
		content = content.replace(/\[(\d\d\d)\]/g, "<img class='em' src='/res/pub/em/t$1.png' height='20px'>");

		var data = li.find(".comment-detail");
		data.html(content);
	}

	var time = li.find(".time");
	var trueTime = li.find(".trueTime");

	console.log(comment.createTime);
	time.text(getHumanTime(comment.createTime));
	trueTime.text(comment.createTime);

	var commentList = $("#commentList");
	if (insertTop)
		li.prependTo(commentList);
	else {
		li.appendTo(commentList);
		if (scroll)
			$('.discuss_body').stop().animate({"scrollTop":commentList.height()},500);
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
//
function getCurrentTime(needTime) {
	if (needTime == null) needTime = false;
	var now = new Date();
	var s = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
	if (needTime) s += " " + now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds();
	return s;
}
//更新评论时间。
    window.setInterval("upDateTime()",10000);
    function upDateTime(){
        var allComments = $("#commentList").find("li");
        if(allComments.length > 100){
            var removeNum = allComments.length-100;
            for(var j = 0; j<removeNum ; j++){
                $("#commentList li:eq("+ j +")").remove();
            }
        }
        var allTrueTime = $("li").find(".trueTime");
        for (var i=0;i<allTrueTime.length;i++){
            $(".time:eq("+i+")").text(getHumanTime($(".trueTime:eq("+i+")").text()));
        }
    }

//打赏界面效果;
/*
btnGift.on('click',function(){
	giftBox.find(giftList).show();
	giftBox.find(rankList).hide();
	giftBox.show();
});
btnRank.on('click',function(){
	giftBox.find(giftList).toggle();
	giftBox.find(rankList).toggle();
});
btnBack.on('click',function(){
	giftBox.hide();
});*/
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
			// alert(XMLHttpRequest.status);
			// alert(XMLHttpRequest.readyState);
			// alert(textStatus);
		}
	});

	$('.payfor_list input:text').focus(function () {
		$('.nav_footer').css("position", "static")
	});
	$('.payfor_list input:text').blur(function () {
		$('.nav_footer').css("position", "fixed")
	});

})


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

var commentLoading = false;
var commentTimestamp;
var commentTimestamp_2;
var scrollTopHeight = 0;

//表情
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

likeText.focus(function () {
	var tTop = $(this).offset().top;
	//$('.channels').css('position','static');
	$("body").animate({scrollTop: tTop - 100 + 'px'}, 200);
	likeSignList.hide();
});

var $li_l = $('.retroversion').find('li').length;

for (var i = 1; i < $li_l + 1; i++) {
	var now = i % 2;
	if (now == 0) {
		$('.retroversion').find('li').eq(i - 1).css("margin-left", "2%")
	}
}