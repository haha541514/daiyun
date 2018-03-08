<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
<title>注册</title>
	<link rel="stylesheet" type="text/css" href="style/member.css"/>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery-validate.js"></script>
	<script type="text/javascript" src="js/register.js" charset="gb2312"></script>
	<script type="text/javascript" src="js/jquery.validate.extend.js" charset="gb2312"></script>
<style type="text/css">
.r_commInfo{ margin-left:120px; margin-top:20px; width:228px; background:url(../images/r_compInfo.png); height:45px;  border:none;}
</style>
<style type="text/css">
input.error{
    border: 1px solid #E6594E;
}
input.highlight{
    border: 1px solid #7abd54;
}
label.error,label.tip{
    height: 32px;
    line-height: 32px;
    font-size: 14px;
    text-align: left;
    margin-left: 5px;
    padding-left: 20px;
    color: red;
    background: url('images/m_no.png') no-repeat left center;
    font-size:14px;
}
label.tip{
    color: #aaa;
    background: url('images/m_notice.png') no-repeat left center;
     font-size:14px;
}
label.valid{
 	height: 32px;
    line-height: 32px;
    font-size: 14px;
    text-align: left;
    margin-left: 5px;
    padding-left: 20px;
    background: url('images/m_yes.png') no-repeat left center;
    width: 32px;
    font-size:14px;
}
</style>
<script type="text/javascript">
$().ready(function() {
	
	//姓名验证
	jQuery.validator.addMethod("isName", function(value, element) {
		var name = /^([\u4e00-\u9fa5]{1,20}|[a-zA-Z\.\s]{1,20})$/;
		return this.optional(element) || ( name.test(value));
	}, "姓名格式必须是英文或者中文");
	
	// 手机号码验证
	jQuery.validator.addMethod("isMobile", function(value, element) {
		var length = value.length;
		var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
		return this.optional(element) || (length == 11 && mobile.test(value));
	}, "请正确填写您的手机号码");
	//验证码校验,验证错误，firefox校验验证码60次，和循环有关。
	//stack overflow?
	/*jQuery.validator.addMethod("ISCODE", function(value, element) {
			var istruecode = false;
			$.ajax({
				url: "util/checkMobileValiteCode",
				type: "post",
				async: false,
         		data:{mobileValidateCode:$("#r_code").val()},     
          		success: function(msg) {   
          			console.log(msg); 
		              if( "N"== msg){
		                 istruecode = false;
		            }else if("Y" == msg){
		           		 istruecode = true;
		            }
          		} , error: function (XMLHttpRequest,textStatus,errorThrown) {
          		  	console.log(XMLHttpRequest.responseText);
          			console.log(XMLHttpRequest.status);
          			console.log(XMLHttpRequest.readyState);
          			console.log(textStatus);
          			istruecode = false;
          		}
			});	
		
		return  istruecode;
	}, "验证码错误");*/

	


  $("#register-form").validate({
  
    rules:{ 
      r_username: {
        required: true,
        minlength: 2,
        maxlength:20,
        remote : { //异步发送请求到服务器，验证userName
            type : "post",
             url : "checkUsername",
            data : {
                r_username : function() {
                      return $("#r_username").val();
                }
            },
         }
      },
      r_name: {
        required: true,
        minlength: 2,
        maxlength: 20,
        isName: true
      
      },
      r_password: {
        required: true,
        minlength: 5,
        maxlength:16
      },
      confirm_password: {
        required: true,
        minlength: 5,
        equalTo: "#r_password"
      },
      r_tel:{
       required : true,
       minlength : 11,
       isMobile : true,
       remote : { 
            type : "post",
            url : "checkPhone",
            data : {
                r_tel : function() {
                      return $("#r_tel").val();
                }
            },
         }
      },
      r_code : {//短信校验
     	required : true,
        digits : true,
        //ISCODE: true
        remote:{
        	type:"post",
        	url : "util/checkMobileValiteCodeEx",
        	data : {
        		mobileValidateCode : function(){
        			return $("#r_code").val();
        		}
        	},
        },	
    		  
      }
    },
    messages: {
      r_username: {
        required: "请输入用户名",
        minlength: "最少由2字母组成",
        maxlength: "最多由20字母组成",
        remote :  "用户名存在" ,// 返回false时的提示信息
      },
     r_name: {
        required: "请输入姓名",
        minlength: "用户名最少由2字母组成",
        maxlength: "用户名最多由20字母组成",
        isName: "必须是英文或者中文"
      },
      
      r_password: {
        required: "请输入密码",
        minlength: "长度不能小于 5 个字母",
        maxlength:"长度不能大于 16个字母"
      },
      confirm_password: {
        required: "请输入确认密码",
        minlength: "长度不能小于 5 个字母",
        equalTo: "两次密码输入不一致"
      },
      r_tel:{
      	required : "请输入手机号",
     	minlength : "手机不能小于11个字符",
      	isMobile : "请正确填写手机号码",
      	remote: "手机号已存在"
      },
      r_code : {
        required : "请输入验证码",
        digits : "验证码应该输入数字",
        //ISCODE: "验证码不正确"
        remote: "验证码不正确"
      }  
    },
     submitHandler: function(form) { 
     //注册提交必须是post
          // $("#register-form").attr("action","${pageContext.request.contextPath}/userRegister");
          // $("#register-form").submit();   
          	  
        //console.log('submit');  
        //var box= $('#comInfo');
        var che = document.getElementById('agree');
        console.log($('#agree').attr('checked'));
        var r_codeValue = $('#r_code').val();
        if(che.checked != true){
        	//console.log('adf');
        	alert('请接受代运网协议');
        	return ;
        }
        if(r_codeValue ==''){
        	alert('验证码为空');	
        	return ;
        }else{
	        $(form).attr("action","${pageContext.request.contextPath}/userRegister");
	        form.submit(); 	  
        } 
      } 
      
 });

    
});
$(function(){
	var isregister = $("input[name='isregister']").val();
	console.log("isregister "+isregister);
	if(isregister == '' || isregister == null){
	}else{
		//$('#leftregister').hide();
		$('#r_reg').hide();
		$('#commInfo').show();
	}
	
});
function companyInfo(){
	$('#register-form').attr('action','${pageContext.request.contextPath}/queryUser');
	$('#register-form').submit();
}
</script>


</head>
<body>
<div id="member">
  <div class="top">
    <div class="left"><img src="images/r_logo.jpg" /></div>
    <div class="right"><a href="${pageContext.request.contextPath }/daiyun.jsp">返回首页</a></div>
  </div>
   <form action="" id="register-form" method="post" >
  <div id="register">
    <div class="register">
      <div class="left" id= "leftregister">
        <ul>
  
          <li><span><strong>*</strong>登录名:</span>
            <input name="r_username" maxlength="20" id="r_username" class="text"  type="text" value="<s:property value='#request.username'/>"/>
          </li>
   
           
          <li><span><strong>*</strong>姓名:</span>
            <input name="r_name" maxlength="20" id="r_name" class="text"  type="text" value="<s:property value='#request.name'/>"/>
          </li>
           
          <li><span><strong>*</strong>登录密码:</span>
            <input name="r_password" maxlength="20" id="r_password" class="text"  type="password" value="<s:property value='#request.passWord'/>"/>
          </li>
          <li><span><strong>*</strong>确认密码:</span>
            <input name="confirm_password" maxlength="20" id="confirm_password" class="text"  type="password" value="<s:property value='#request.passWord'/>"/>
          </li>
          <li><span><strong>*</strong>手机号码:</span>
            <input name="r_tel" maxlength="20" id="r_tel" class="text"  type="text" value="<s:property value='#request.phone'/>"/>
			<label id="r_tel-error" for="r_tel" class="error" style="display: none;"></label>
          </li>
          <li><span><strong>*</strong>手机验证码:</span>
            <input disabled="disabled"  maxlength="10" id="r_code"  name="r_code" class="text code" type="text"/>
            <button class="r_but" id="r_but" type="button" onclick="return getPhoneCode();" >获取短信验证码</button>
		         
          </li>
            <li>
            	<input type="checkbox" checked="checked" id="agree" name="agree"  style="float: left;width: 10px;text-align: right;padding-right: 15px;margin-left: 30px;"/>
           	     &nbsp;<a target="_blank" href="${pageContext.request.contextPath }/sf/agreement.html"  style="">我接受《代运协议》</a>
          </li>
          <li><button class="r_reg" name="r_reg" id="r_reg" type="submit">
           
          </button>
           <button class="r_commInfo" id="commInfo" type="button" 
	      onclick="window.location.href='${pageContext.request.contextPath}/queryUser?opcode=${request.opcode}';" 
	      style="display:none;margin-left:120px; margin-top:20px; width:228px; background:url(images/r_compInfo.png); height:45px;  border:none;">
	      </button>
          </li>
        </ul>
      </div>
      <input type="hidden" name="opcode" id="opcode" value="${request.opcode}"/>
      	 <input type="hidden" name="isregister" id="isregister" value="${request.isregister}"/>
      <!--  
      <div id="companyInfo" class="left" style="display: none;">
      	
      	 
	      <button class="r_commInfo" id="commInfo" type="button" 
	      onclick="window.location.href='${pageContext.request.contextPath}/queryUser?opcode=${request.opcode}';" 
	      style="margin-left:120px; margin-top:20px; width:228px; background:url(images/r_compInfo.png); height:45px;  border:none;">
	      </button>
      </div> 
      -->
      <div class="right">
     <div class="enjoy">
     	<h3>会员尊享:</h3>
        <p>
        1、平台分配专属客服，服务更贴心；<br />
2、自助在线下单，操作方便快捷更舒心；<br />
3、账单清晰明了，在线支付实时更放心；<br />
4、货物轨迹自动更新，查件追踪更省心。
 <!-- 
<div class="QR_code"> <img src="images/QR_code.jpg" />
<span>微信号：888888</span>
<p>注册、差价、下单、追踪货件</p>
</div>-->
        </p>
     </div>
      </div>
    </div>
  </div>
 </form> 
  
  <div style="clear:both;"></div>
  <div class="bottom">Copyright © 2012 深圳市代运物流网络有限公司<br />
    (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号</div>
</div>




</body>
</html>
