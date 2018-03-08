<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修改密码</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/style/member.css"/>
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/UpdatePass.js" charset="gb2312"></script>
<style type="text/css">
/*plus_b绿色提示,plus_c红色警告
.step .formList .plus_c{width:210px;height:26px;line-height:26px;padding:0px 10px 0px 33px;background:url(../images/title06.gif) no-repeat;color:#a8a8a8;margin-top:6px;}
.step .formList .plus_b{width:230px;height:43px;line-height:18px;padding:4px 10px 3px 13px;background:url(../images/title05.gif) no-repeat;color:#a8a8a8;}
*/
</style>
<script>
var GtoUpdatePass = function(){
	if(ispassvalid){
		if(ispass1valid){
			$('#updatePass').attr({action:'${pageContext.request.contextPath}/order/updatePass'});
			$('#updatePass').submit();	
		}
	}

};
$(function(){
	var updateVal = $("input[name='updateValue']").val();
	if(updateVal != ''){
		$('#password1').hide();
		$('#password3').show();
	}

});

</script>
</head>
<body>
<div id="member">
<form action="" id="updatePass" method="post">
	<input name="stepvalue" id="stepvalue" value="#request.stepvalue" type="hidden"/>
	<input name="updateValue" id ="updateValue" value="${request.updateValue }" type="hidden"/>
  <div class="top">
    <div class="left"><img src="${pageContext.request.contextPath}/images/p_logo.jpg" /></div>
    <div class="right"><a href="${pageContext.request.contextPath }/daiyun.jsp">返回首页</a></div>
  </div>
  <div id="updatePass">
    <div class="register">
      <div id="password1" class="updatepass">
        <div class="step"></div>
        <ul class="formList">
          <!--  <li><span>用户名:</span>
            <input name="r_username" maxlength="20" id="r_username" class="text" type="text"/>
            <div class="" id="div_r_username" style="width: 260px;float:left;"></div>
          </li>-->
            <li><span>手机号:</span>
            <input name="r_phone" maxlength="20" id="r_phone" class="text" type="text"/>
            <div class="" id="div_r_phone" style="width: 260px;float:left;"></div>
          </li>
          <li><span>验证码:</span>
            <input disabled="disabled" name="r_code" maxlength="20" id="r_code" class="text code"  type="text"/>
            <div class="" id="div_r_code" style="position: absolute; top: 0; left: 40%;"></div>
            <button class="r_but" id="r_but" type="button" onclick="return sendMsg();">获取短信验证码</button>
          </li>
          <li>
          	<!-- 下一步 -->
            <button class="next_step" type="button" onclick="GotoNextPage();"></button>
          </li>
        </ul>
      </div>
      <div id="password2" class="updatepass" style="display: none;">
        <div class="step2"></div>
        <ul>
          <li><span>新密码:</span>
            <input name="r_newpass" maxlength="20" id="r_newpass" class="text" type="password"/>
            <div class="" id="div_r_newpass" style="width: 260px;float:left;"></div>
          
          </li>
          
          <li><span>确认密码:</span>
            <input name="" maxlength="20" id="r_confirmpass" class="text" type="password"/>
            <div class="" id="div_r_confirmpass"" style="width: 260px;float:left;"></div>
            
          </li>
          <li>
            <button class="next_step confirm" type="button" onclick="GtoUpdatePass();"></button>
          </li>
        </ul>
      </div>
      <!-- 成功修改密码界面 -->
       <div id="password3" class="updatepass" style="display: none;">
        <div class="step2"></div>
          <h3> <span >恭喜，<font color="#D32994"><%=session.getAttribute("Opname")%></font>重置密码成功</span></h3>
       
        <ul>
          <li>
            <button class="" type="button" onclick="window.location.href='${pageContext.request.contextPath}/order/userinfo'" style="margin-left:120px; margin-top:20px; width:160px; background:url(../images/m_success.png); height:45px;  border:none;"></button>
          </li>
        </ul>
      </div>
      
    </div>
  </div>
  <div style="clear:both;"></div>
  <div class="bottom">Copyright © 2012 深圳市代运物流网络有限公司<br />
    (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号</div>
    </form>
</div>




</body>
</html>
