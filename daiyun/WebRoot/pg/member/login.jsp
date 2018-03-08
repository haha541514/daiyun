<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="<%=path%>/style/member.css"/>

  </head>
  
  <body>
<div id="member">
  <div class="top">
    <div class="left"><img src="<%=path%>/images/m_logo.jpg" /></div>
    <div class="right"><a href="<%=path%>/daiyun.jsp">返回首页</a></div>
  </div>
  <div class="member_bg">
    <div class="member_bg2">
      <div class="member">
        <div class="title">
          <h3>客户登录</h3>
          <span>已经注册代运账户，请登录；VIP会员走货更优惠！</span> </div>
        <ul>
          <li class="name">
            <input value="请输入用户名" class="Name" name="username" id="username" type="text" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}"  style="color: rgb(102, 102, 102);">
          </li>
          <li class="password">
            <input value="请输入密码" class="Pssword" name="userpssword" id="userpssword" type="text"onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}"  style="color: rgb(102, 102, 102);">
          </li>
          <li class="button">
            <button class="Button" type="submit" onclick="GotoSerachPage();"></button>
          </li>
          <li class="no"><a href="<%=path%>/member/Register.jsp">立即注册</a> | <a href="#">忘记密码？</a></li>
        </ul>
        你也可以用以下快捷方式登录
        <div class="way">
        <a title="QQ" href="#" target="_blank"><img src="images/login_qq.jpg" /></a>
        <a title="微信" href="#" target="_blank"><img src="images/login_weixin.jpg" /></a>
        </div>
      </div>
    </div>
  </div>
  <div class="bottom">Copyright © 2012 深圳市代运物流网络有限公司<br />
(AT) 2008-2010 All Rights Reserved 粤ICP备0503210号</div>
</div>
</body>
</html>
