<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="kyle.leis.fs.authoritys.user.da.UserColumns" %>
<%@page import="kyle.common.util.jlang.DateFormatUtility"%>
<%@page import="kyle.common.util.jlang.StringUtility"%>
<%@page import="kyle.common.util.jlang.DateUtility"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@taglib uri = "/project" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path %>/js/banner.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=path %>/style/news_total.css"/>
    <link rel="stylesheet" type="text/css" href="<%=path %>/style/news_page.css"/>
    <link rel="stylesheet" type="text/css" href="<%=path %>/style/total.css"/>
    <title>货物追踪</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<SCRIPT type="text/javascript">
//轨迹查询验证
function checkTrackForm() {
	var queryCode = document.getElementById("queryCode").value;
	if (checkNull(queryCode)) {
		alert("运单号不为能空，请输入运单号!");
		return false;
	}
	document.queryTrackForm.submit();
}

function changeValidateCode(obj) 
		{
	    //获取当前的时间作为参数，无具体意义




	    var timenow = new Date().getTime();
	    //每次请求需要一个不同的参数，否则可能会返回同样的验证码
	    //可能和浏览器的缓存机制有关系
	    obj.src="util/ValidateImage?d="+timenow;
   	 	}
   	 	function clearInfo()
    	{
	    document.getElementById("userName").value = "";
	    document.getElementById("password").value = "";
	    document.getElementById("validateCode").value = "";	    
		}

function init(index){
$("#left_menu li:eq(0)").css("background-color","d3eef9");
changeTopmenu(index);
}
</SCRIPT>


  </head>
  
<body onload="init(1)">
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left"></div>
      <div class="right"><span><a href="<%=path%>/login.jsp">登录</a></span> | <span><a href="<%=path%>/register.jsp">注册</a></span> | <span><a href="${pageContext.request.contextPath }/op/recharge.jsp">充值</a></span> | <span><a href="#">English</a></span></div>
      
      </div>
      <div class="logo">
        <div class="left"><img src="../images/logo.jpg" /></div>
        <div class="right"><img src="../images/tel.jpg" /></div>
      </div>
      <div class="nav">
      <jsp:include page="../include/main_menu.jsp"></jsp:include>
        <div class="nav_last"><a href="${pageContext.request.contextPath }/userinfo"><img src="${pageContext.request.contextPath }/images/my_nav.jpg"></a></div>
      </div>
    </div>
    <div class="banner_bg">
      <div class="banner">
        <ul class="nav_img">
          <li><a href=""><img src="../images/banner.jpg" alt=""></a></li>
          <li><a href=""><img src="../images/banner.jpg" alt=""></a></li>
          <li><a href=""><img src="../images/banner.jpg" alt=""></a></li>
        </ul>
        <ul class="nav_banner">
          <li ><a title="" href=""></a></li>
          <li><a title="" href=""></a></li>
          <li><a title="" href=""></a></li>
        </ul>
      </div>
    </div>
  </div>
  <div id="page">
    <div class="left">
      <div class="directory"> <span class="tit01"></span>
        <div class="nir">
          <ul id="left_menu">
            <li><a href="<%=path%>/track/searchTrack.jsp">货物追踪</a></li>
            <li><a href="<%=path%>/track/airportQuery.jsp">机场三字码查询</a></li>
            <li><a href="#">海关编码查询</a></li>
          </ul>
        </div>
      </div>
      <div class="contact"> <span class="tit"></span>
        <div class="nir"> <img src="../images/contact01.jpg" />
          <p> 总  机：（86-755）88888888<br />
            &nbsp;&nbsp;&nbsp; （86-755）88888888<br />
            传  真： 0752-88888888<br />
            地  址：*************************<br />
            &nbsp;&nbsp;&nbsp;&nbsp;**************<br />
          </p>
        </div>
      </div>
    </div>
    <div class="right">
      <div class="track">
        <div class="tit">货物追踪</div>
        <div class="nir">
        <form name="queryTrackForm" id="queryTrackFrom" action="page/queryTrack" method="post">  
          <div class="track_left">
            <textarea name="queryCode" id="queryCode" class="input_3" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}" style="color: rgb(153, 153, 153);">请在此输入您的订单号/代理单号/跟踪号，最多支持五个订单号的查询。输入多个订单号，请用“,”分隔 。</textarea>
            <input name="validateCode" value="验证码" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}"  style="color: rgb(153, 153, 153);" />
            <span><img src="util/ValidateImage?d=<%= new Date().getTime() %>" onClick="changeValidateCode(this)" style="float:left;margin-left:-10px;margin-top:2.5px;width:40px;height:20px" /></span>
            <button class="check_but" type="submit" onclick="return checkTrackForm();"></button>
          </div>
          </form>
          <div class="track_center">最近查询记录</div>
          <div class="track_right" id="clearlist">清空列表</div>
        </div>
      </div>
      <div class="result">
      <div class="tit">追踪结果</div>
      <div class="nir"></div>
      </div>
      <div class="result">
      <div class="tit">实时状态</div>
      <div class="nir"></div>
      </div>
    </div>
  </div>
  <div class="clear"></div>
  <div id="bottom">
    <div class="copyright">
      <div class="nir">
        <div class="left"> Copyright © 2012 深圳市代运物流网络有限公司<br />
          (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号 </div>
        <div class="right"><img src="images/tel2.jpg" /></div>
      </div>
    </div>
    <div class="bottom_nav"> <a href="#">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
</div>
</body>
</html>
