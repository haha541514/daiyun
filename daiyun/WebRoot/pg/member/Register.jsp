<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户注册</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  <link rel="stylesheet" type="text/css" href="<%=path%>/style/member.css"/>
  </head>
  
  <body>
<div id="member">
  <div class="top">
    <div class="left"><img src="images/r_logo.jpg" /></div>
    <div class="right"><a href="#">返回首页</a></div>
  </div>
  <div id="register">
    <div class="register">
      <div class="left">
        <ul>
          <li><span><strong>*</strong>用户名:</span>
            <input name="" maxlength="20" id="r_usename" class="text" data-validation-engine="validate[required,minSize[2]]" type="text">
          </li>
          <li><span><strong>*</strong>姓名:</span>
            <input name="" maxlength="20" id="r_name" class="text" data-validation-engine="validate[required,minSize[2]]" type="text">
          </li>
          <li><span><strong>*</strong>登录密码:</span>
            <input name="" maxlength="20" id="r_password" class="text" data-validation-engine="validate[required,minSize[2]]" type="text">
          </li>
          <li><span><strong>*</strong>确认密码:</span>
            <input name="" maxlength="20" id="r_con" class="text" data-validation-engine="validate[required,minSize[2]]" type="text">
          </li>
          <li><span><strong>*</strong>手机号码:</span>
            <input name="" maxlength="20" id="r_tel" class="text" data-validation-engine="validate[required,minSize[2]]" type="text">
          </li>
          <li><span><strong>*</strong>手机验证码:</span>
            <input name="" maxlength="20" id="r_code" class="text code" data-validation-engine="validate[required,minSize[2]]" type="text">
            <button class="r_but" type="submit" onclick="GotoSerachPage();">获取短信验证码</button>
          </li>
          <li><button class="r_reg" type="submit" onclick="GotoSerachPage();"></button></li>
        </ul>
      </div>
      <div class="right">
     <div class="enjoy">
     	<h3>会员尊享:</h3>
        <p>
        1、平台分配专属客服，服务更贴心；<br />
2、自助在线下单，操作方便快捷更舒心；<br />
3、账单清晰明了，在线支付实时更放心；<br />
4、货物轨迹自动更新，查件追踪更省心。

<div class="QR_code"><img src="images/QR_code.jpg" />
<span>微信号：888888</span>
<p>注册、差价、下单、追踪货件</p>
</div>
        </p>
     </div>
      </div>
    </div>
  </div>
  <div style="clear:both;"></div>
  <div class="bottom">Copyright © 2012 深圳市代运物流网络有限公司<br />
    (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号</div>
</div>
</body>
</html>
