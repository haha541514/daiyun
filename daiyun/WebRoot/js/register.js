/*************2016-12-07,Start by wukq******************/

var ismobilevalid = false;

//手机验证码
function getPhoneCode() {
	if ($("#r_but").html() == "获取短信验证码") {
		$("#r_code").val("");
	}
	if ($("#r_tel").val() == "") {
		//检查手机号是否为空
		ShowWrong($("#r_tel"), "请输入手机号码", "error");
		ismobilevalid = false;
		return false;
	}
	check_mobilebase();
	if(ismobilevalid){
		setTimeout(check_mobileIsUserd(),1000);
	}
		
	var location = (window.location+'').split('/');
	var basePath = location[0]+'//'+location[2]+'/'+location[3];
	if (ismobilevalid) {
		$.ajax( {
					type:"post",
					url : basePath+'/util/sendMobileValidateCode',
					async: false,
					data : {"tel" : $("#r_tel").val()},
					success:function(msg){
						if(msg == "号码格式错误"){
							
							ShowWrong($("#r_tel"), "号码格式错误", "error");
						}else {
							$('#r_but').css({color:'#F3F3F3',background:'#9F9E9D'});	
							//ShowCorrect($("#r_tel"), "发送成功", "error");
							$("#r_code").attr("disabled",false);//输入框可用
							updateTimeLabel(60,"0");
							//$('#r_but').css({color:'#FDFDFD',background:'#01B0EE'});
						}			
												
					
					}
						
				});
				
	}
	return false;
}

//手机号输入格式检测
function check_mobilebase() {

	var mobile = $.trim($("#r_tel").val());
	//var pat = /^1\d{10}$/;
	var pat = /(^1[3|4|5|6|7|8|9]\d{9}$)/;
	if (mobile == "") {
		ShowWrong($("#r_tel"), "请输入手机号码", "plus_c");
		ismobilevalid = false;
		return false;
	}
	if (!pat.test(mobile)) {
		ShowWrong($("#r_tel"), "手机号码格式不正确", "plus_c");
		ismobilevalid = false;
		return false;
	}
	var showObject = $("#div_strMobile");
	ismobilevalid = true;
}


/**检查手机是否用过**/
function check_mobileIsUserd(){
	var location = (window.location+'').split('/');
	var basePath = location[0]+'//'+location[2]+'/'+location[3];
	$.ajax( {
		type:"post",
		url : basePath+'/checkPhone',
		async: false,
		data : {"r_tel" : $("#r_tel").val()},
		success:function(msg){
			if(msg == "false"){
				ismobilevalid = false;
				ShowWrong($("#r_tel"), "手机号重复", "error");
			}else {
				ismobilevalid = true;
			}			
									
		
		}
			
	});
}

/**修改时间lable*/
function updateTimeLabel(time, message) {
	var btn = jQuery("#r_code");//setInterval javaScript方法
	var hander = setInterval(function() {
		if (time == 0) {
			clearInterval(hander);
			hander = null;
			$("#r_but").attr("disabled",false);
			$("#r_but").html("获取短信验证码");
			$('#r_but').css({color:'#FDFDFD',background:'#01B0EE'});
		} else {
			$("#r_but").attr("disabled",true);
			var times = "" + (time--) + "秒后点击重新发送";
			$("#r_but").html(times);
			
		}
	}, 1000);
}

//验证码发送
function sendMsg() {
	$("#obtain").html("验证码发送中");
	$.ajax( {
		type : "post",
		url : "util/sendMobileValidateCode",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		data : {
			tel : $("#number_01").val()
		},
		success : function(data) {
			$("#obtain").html(data);
			setTimeout("$('#obtain').html('没收到?,点我重新发送。')", 30000);
		}
	});
}
//验证码校验
function checkVlidateCode() {
	var bool = true;
	if ($("#validateCode").val() == "") {
		return false;
	}
	$.ajax( {
		type : "Post",
		url : "util/checkMobileValiteCode",
		async : false,
		data : {
			mobileValidateCode : $("#validateCode").val()
		},
		success : function(data) {
			if (data == 'N') {
				bool = false;
			}
		}
	});
	return bool;
}
function ShowCorrect(obj, message, className){
	 var ErrorObject = $("#"+$(obj).attr("id")+"-error");
	 ErrorObject.css("display","inline");
	 ErrorObject.html(message); 
}

 function ShowWrong(obj, message, className){
	  //改写这个方法，用jqueryValidate生成的label,background: url('images/m_no.png')
	 //<label id="r_code-error" class="error" for="r_code" style="display: inline;">请输入用户名</label>
	 var ErrorObject = $("#"+$(obj).attr("id")+"-error");
	 ErrorObject.css("display","inline");
	 //ErrorObject.attr("background","url('${pageContext.request.contextPath}/images/m_no.png')");
	 ErrorObject.html(message); 
}
 //ShowWrong(jQuery("#strMobile"), "请输入手机号码", "plus_c");
 function ShowWrong(obj, message, className) {
	    var showObject = jQuery("#div_" + jQuery(obj).attr("id"));
	    showObject.show();
	    showObject.html("<div class=\"" + className + "\">" + message + "</div>");
	    jQuery("#div_mathcode").hide();

	}
/**************2016-12-07,End********************/
