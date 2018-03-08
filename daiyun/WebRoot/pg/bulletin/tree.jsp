<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'tree.jsp' starting page</title>
    	<script type="text/javascript" src="<%=path%>/js/jquery-1.4.2.js"></script>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script language="JavaScript" type="text/javascript">
$(document).ready(function(){
	$("#t1").click(function(){
	$("#mark").css("background","url(<%=path%>/m_images/icon12.png)  no-repeat");
	if(!$("#tt1 li").is(":hidden")){
	$("#mark").css("background","url(<%=path%>/m_images/icon11.png)  no-repeat");
	}
	$("#tt1 li").slideToggle("slow");
	});
	});
	$(document).ready(function(){
	$("#t2").click(function(){
	$("#mark2").css("background","url(<%=path%>/m_images/icon12.png)  no-repeat");
	if(!$("#tt2 li").is(":hidden")){
	$("#mark2").css("background","url(<%=path%>/m_images/icon11.png)  no-repeat");
	}
	$("#tt2 li").slideToggle("slow");
	});
	});
	</script>
  </head>
  
  <body>
   <div class="left">
      <div class="title_list">
        <div class="tit01" ><span id="mark"><a id="t1" href="javascript:void(0);"></a></span></div>
        <ul id ="tt1">
          <li ><span><a href="${pageContext.request.contextPath }/page/queryBulletin">新闻管理</a></span></li>    
          <li><span><a href="${pageContext.request.contextPath }/page/queryFirstItem">界面定制</a></span></li>
          <li><span><a href="${pageContext.request.contextPath }/page/queryUsersByCon">实名认证</a></span></li>
          <li><span><a href="${pageContext.request.contextPath }/page/queryCorporation">执照审核</a></span></li>
        </ul>
      </div><!--
      <div class="title_list">
        <div class="tit02"><span id="mark2"> <a id="t2"  href="javascript:void(0);"></a></span></div>
        <ul id ="tt2">
          <li><span><a href="${pageContext.request.contextPath }/page/queryBulletin">新闻管理</a></span></li>
          <li><span><a href="${pageContext.request.contextPath }/page/queryFirstItem">界面定制</a></span></li>
          <li><span><a href="${pageContext.request.contextPath }/page/queryUsersByCon">实名认证</a></span></li>
        </ul>
      </div>
    --></div>
  </body>
</html>
