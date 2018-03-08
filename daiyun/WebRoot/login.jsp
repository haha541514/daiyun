<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="kyle.common.util.jlang.DateFormatUtility"%>
<%@page import="kyle.common.util.jlang.StringUtility"%>
<%@page import="kyle.common.util.jlang.DateUtility"%>
<%@page import="java.util.Date"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>用户登陆</title>
		<link rel="stylesheet" type="text/css" href="style/member.css" />
		<script type="text/javascript" src="js/jquery-1.4.2.js"></script>
		<script type="text/javascript" src="js/jquery-validate.js"></script>
	


<script type="text/javascript">

	$(function(){
		$('#username').trigger('focus');//默认时文本框获取焦点
		
  	$('#sub').click(function(){
  		//$('#sub').css('backgroundImage','${pageContext.request.contextPath}/images/m_logining.png');
  		document.getElementById("sub").style.backgroundImage="url(${pageContext.request.contextPath}/images/m_logining.png)";
		 var defaults={
			tip_required:'用户名不能为空', 
			tip_username:'用户名错误',
			tip_passrequired: '密码不能为空',
			//tip_password:'密码错误或者验证码错误',
			tip_password:'用户名或者密码错误',
			tip_validateRequired:'验证码不能为空'
	 	}	
	 	
    	//非空
    	var username = $('#username').val();
    	var password = $('#userpssword').val();
    	var validate = $('#validateCode').val();
    	if(username.length == 0 || password.length == 0 || validate.length == 0){
    		if(username.length == 0){
    		if($('#errormsg').length){
			}else{
    		    var user_html="<span id='errormsg' style='font-size:12px;color:red;'><br/>"+defaults.tip_username+"</span>"
    		    $('#username').after(user_html);
    		   }
    		}
    		if(password.length == 0){
    		if($('#errpassword').length){
    			}else{
    				var pass_html="<span id='errpassword' style='font-size:12px;color:red;'><br/>"+defaults.tip_passrequired+"</span>"
    				$('#userpssword').after(pass_html);
    			}
    		}
    		if(validate.length == 0){
    		if($('#errvalidate').length){
    			}else{
    				var pass_html="<span id='errvalidate' style='font-size:12px;color:red;'><br/><br/>"+defaults.tip_validateRequired+"</span>"
    				$('#validateCode').next().after(pass_html);
    			}
    		}
    		
    	}else{
    	$.ajax({
			url: 'userlogin',
			timeout : 30000, //超时时间设置，单位毫秒

			data: $('#myform').serialize(),
			type: 'post',
			success: function(msg){
				if(msg == '1'){
					location.href = 'userinfo';
				}else if(msg == 'nouser'){
					document.getElementById("sub").style.backgroundImage="url(${pageContext.request.contextPath}/images/m_login.png)";
					if($('#errormsg').length){
					}else{
						var pass_html="<span id='errormsg' style='font-size:12px;color:red;'><br/>"+defaults.tip_username+"</span>"
    					$('#username').after(pass_html);
    					$('#userpssword').val('');
    					$('#validateCode').val('');
    					GetImgVerificationCode();
    				}
				}else if(msg == 'errorPassword'){
					document.getElementById("sub").style.backgroundImage="url(${pageContext.request.contextPath}/images/m_login.png)";
					if($('#errpassword').length){
					}else{
						document.getElementById("sub").style.backgroundImage="url(${pageContext.request.contextPath}/images/m_login.png)";
						var pass_html="<span id='errpassword' style='font-size:12px;color:red;'><br/>"+defaults.tip_password+"</span>"
    					$('#userpssword').after(pass_html);
    					$('#userpssword').val('');
    					$('#validateCode').val('');
    					GetImgVerificationCode();
    					
    				}
				}else if(msg == 'invalidFunciton'){
						document.getElementById("sub").style.backgroundImage="url(${pageContext.request.contextPath}/images/m_login.png)";
						alert('无效的用户职能');
						GetImgVerificationCode();
				
    			}else if(msg == 'checking'){
    					document.getElementById("sub").style.backgroundImage="url(${pageContext.request.contextPath}/images/m_login.png)";
						alert('登录失败，我司正在审核');
						
						GetImgVerificationCode();
						
    			}
				
			},
			　complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数


　　　					if(status=='timeout'){//超时,status还有success,error等值的情况
 　　　　　				ajaxTimeoutTest.abort();
　　　　　				alert('超时');
　　　　				}
　				　}
			});	
		}
	 });
	 	
	 	$('body').keydown(function(e) {
             if (e.keyCode == '13') {//keyCode=13是回车键
             	//$("#sub").click();
             	//settimeout(function(){},1500);
             	setTimeout($('#sub').click(),1500);//这是延迟时间
             	
             }
         });
         
	})
	
 
 	$(function(){
 		$('#userpssword').val('');
    	$('#validateCode').val('');
    					
		$("#username").blur(function(){
		
			var username = $('#username').val();
			if(username.length != 0){
				if($('#errormsg').length){
					$('#errormsg').remove();
				}
				
			}
			
		});
		
		$("#userpssword").blur(function(){
		
			var password = $('#userpssword').val();
			if(password.length != 0){
				if($('#errpassword').length){
					$('#errpassword').remove();
				}
			}
			
		});
		$("#userpssword").blur(function(){
		
			var password = $('#userpssword').val();
			if(password.length != 0){
				if($('#errpassword').length){
					$('#errpassword').remove();
				}
			}
			
		});
		$("#validateCode").blur(function(){
		
			var validate = $('#validateCode').val();
			if(validate.length != 0){
				if($('#errvalidate').length){
					$('#errvalidate').remove();
				}
			}
			
		});
	})
	
		function GetImgVerificationCode(){
			 var timenow = new Date().getTime();
			$("#validateCodeImg").attr("src","util/ValidateImage?d="+timenow);
		}
		function changeValidateCode(obj) {
		    //获取当前的时间作为参数，无具体意义
		    var timenow = new Date().getTime();
		    //每次请求需要一个不同的参数，否则可能会返回同样的验证码
		    //可能和浏览器的缓存机制有关系
		    obj.src="util/ValidateImage?d="+timenow;
	   	 }
   	 	
	
   
    	
    		
</script>
</head>

	<body>
		<form action="" id="myform" name="myform" method="post">
			<div id="member">
				<div class="top">
					<div class="left">
						<img src="images/m_logo.jpg" />
					</div>
					<div class="right">
						<a href="${pageContext.request.contextPath }/daiyun.jsp">返回首页</a>
					</div>
				</div>
				<div class="member_bg">
					<div class="member_bg2">
						<div class="member">
							<div class="title">
								<h3>
									客户登录
								</h3>
								<span>已经注册代运账户，请登录；VIP会员走货更优惠！</span>
							</div>
							<ul>
								<li class="name">
									<input placeholder="用户名|手机号|邮箱" class="Name" name="username"	id="username" type="text" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}" style="color: rgb(102, 102, 102);">
								</li>
								
								<li class="password">
									<input  class="Pssword"  placeholder="请输入您的密码" name="userpssword" id="userpssword" type="password" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}" style="color: rgb(102, 102, 102);">
								</li>
								
								<li>
	            					<input  id="validateCode" name="validateCode" placeholder="验证码" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}"  style="color: rgb(153, 153, 153); padding-left:5px; background:#FFF; border:1px solid #dddddd; width:120px; height:28px; line-height:28px; float:left;" />
									<span ><img id="validateCodeImg" src="util/ValidateImage?d=<%= new Date().getTime() %>" onClick="changeValidateCode(this)" style="float:right;margin-right:80px;width:40px;padding-left:5px; background:#FFF; border:1px solid #dddddd; height:28px; line-height:28px; float:left;" /></span>
								</li>
								
								<br/><br/>
								
								<li class="button">
									<button class="Button" type="button" id="sub"></button>
								</li>
								<li class="no">
									<a href="${pageContext.request.contextPath }/register.jsp">立即注册</a> |
									<a href="${pageContext.request.contextPath }/sf/UpdatePass.jsp">忘记密码？</a>
								</li>
							</ul>
							


							<!--  
							你也可以用以下快捷方式登录
							<div class="way">
								<a title="QQ" href="#" target="_blank"><img
										src="images/login_qq.jpg" />
								</a>
								<a title="微信" href="#" target="_blank"><img
										src="images/login_weixin.jpg" />
								</a>
							</div>-->
						</div>
					</div>
				</div>
				<div class="bottom">
					Copyright © 2012 深圳市代运物流网络有限公司


					<br />
					(AT) 2008-2010 All Rights Reserved 粤ICP备0503210号


				</div>
			</div>
		</form>

	</body>
</html>
