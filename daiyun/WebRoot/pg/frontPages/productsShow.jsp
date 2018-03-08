<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="kyle.leis.fs.authoritys.user.da.UserColumns" %>
<%@page import="kyle.common.util.jlang.DateFormatUtility"%>
<%@page import="kyle.common.util.jlang.StringUtility"%>
<%@page import="kyle.common.util.jlang.DateUtility"%>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="com.daiyun.dax.WebDemand" %>
<%@taglib uri = "/project" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
 path = request.getContextPath();
 basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String actionName=ActionContext.getContext().getName();
if(actionName.equals("qyByBlIdTool")) actionName="newCode";
List<List<String>> list=WebDemand.getId();
for(int i=0;i<list.get(0).size();i++){
	if(actionName.equals(list.get(1).get(i))){   
		session.setAttribute("actionName",actionName);
		session.setAttribute("ks",list.get(0).get(i)); 
	} 
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="<%=path%>/style/news_total.css"/>
    <link rel="stylesheet" type="text/css" href="<%=path%>/style/news_page.css"/>
    <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/banner.js"></script>
    <title>产品展示界面</title>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  
  </head>
  
  <body onload="changeTopmenu(2,660)">
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
      <div class="directory"> <span class="tit01"></span>
        <div class="nir">
          <ul id="left_menu">
           <s:iterator var="bean" value="@com.daiyun.dax.WebDemand@SMquery(#session.ks)"> 
            <li><a id="<s:property value="#bean.Gmgm_code"/>" href="<s:property value="#session.actionName"/>?code=<s:property value="#bean.Gmgm_code"/>"><s:property value="#bean.Gmgm_name"/></a></li>
          	</s:iterator>
          </ul>       
        </div>
      </div>
      <div class="contact"> <span class="tit"></span>
        <div class="nir"> <img src="images/contact01.jpg" />
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
      <div class="tit">${title}</div>
      <div class="nir">
      	<div class="new_page">
        	<div class="new_tit">
          <div class="article">
          ${content} 
            </div>
            <div class="prompt"><span>温馨提示:</span>本文代运网作者系，来源：中国●满洲里，其他转载请注明出处</div>
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
</div>
</body>
</html>
