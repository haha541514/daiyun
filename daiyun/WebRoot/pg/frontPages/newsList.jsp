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
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path %>/js/banner.js"></script>
     <link rel="stylesheet" type="text/css" href="<%=path %>/style/news_total.css"/>
    <link rel="stylesheet" type="text/css" href="<%=path %>/style/news_page.css"/>
    <title>新闻列表</title>
  </head>
 <body onload="changeTopmenu(3,600)">
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left"></div>
        <div class="right"><span><a href="<%=path%>/login.jsp">登录</a></span> | <span><a href="<%=path%>/register.jsp">注册</a></span> | <span><a href="${pageContext.request.contextPath }/op/recharge.jsp">充值</a></span> | <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="<%=path%>/images/logo.jpg" /></div>
        <div class="right"><img src="<%=path%>/images/tel.jpg" /></div>
      </div>
      <div class="nav">
        <jsp:include page="../include/main_menu.jsp"></jsp:include>
        <div class="nav_last"><a href="${pageContext.request.contextPath }/userinfo"><img src="${pageContext.request.contextPath }/images/my_nav.jpg"></a></div>
      </div>
    </div>
    <div class="banner_bg">
      <div class="banner">
        <ul class="nav_img">
          <li><a href=""><img src="<%=path%>/images/banner.jpg" alt=""></a></li>
          <li><a href=""><img src="<%=path%>/images/banner.jpg" alt=""></a></li>
          <li><a href=""><img src="<%=path%>/images/banner.jpg" alt=""></a></li>
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
      <div class="directory"> <span class="tit"></span>
        <div class="nir">
          <ul>
            <li><s:set var="newnum" value="@com.daiyun.dax.WebDemand@STquery('D0101')"/>
            <a href="<%=basePath%>item/newCode?code=<s:property value="#newnum"/>&tiltle=通知公告">通知公告</a></li>
            <li><s:set var="newnum" value="@com.daiyun.dax.WebDemand@STquery('D0102')"/>
            <a href="<%=basePath%>item/newCode?code=<s:property value="#newnum"/>&tiltle=物流资讯">物流资讯</a></li>
            <li><s:set var="newnum" value="@com.daiyun.dax.WebDemand@STquery('D0103')"/>
            <a href="<%=basePath%>item/newCode?code=<s:property value="#newnum"/>&tiltle=邮寄经验">邮寄经验</a></li>
          </ul>
        </div>
      </div>
      <div class="contact"> <span class="tit"></span>
        <div class="nir"> <img src="<%=path%>/images/contact01.jpg" />
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
      <div class="tit"><s:property value="#request.tiltle"/>
      <s:if test="#request.tiltle==null">新闻资讯</s:if>
      </div>
      <div class="nir">
        <div class="news">
          <ul>
            <s:set var="objBulletin" value="#request.objBulletin"></s:set>
	   <s:iterator var="objBkBulletin" value="#request.listBkBulletin">
	    <li><a href="qyByBlIdTool?gmcode=<s:property value="#request.gmcode"/>&pf=newsDetails&blId=<s:property value="#objBkBulletin.Blblid"/>"><s:property value="#objBkBulletin.Blblheading"/></a><span><s:property value="#objBkBulletin.Blblmodifydate"/></span></li>
	  </s:iterator>
          </ul>
        </div>  
        <div class="pagelist">
        <ul>
       <li><p:pager url="newCode" />
	 <s:set var="Page" value="#request.objPageConfig"></s:set></li>
	 </ul>
        </div>
      </div>
    </div>
  </div>
  <div class="clear"></div>
  <div id="bottom">
    <div class="copyright">
      <div class="nir">
        <div class="left"> Copyright © 2012 深圳市代运物流网络有限公司<br />
          (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号 </div>
        <div class="right"><img src="<%=path%>/images/tel2.jpg" /></div>
      </div>
    </div>
    <div class="bottom_nav"> <a href="<%=path%>/daiyun.jsp">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
</div>
</body>
</html>
