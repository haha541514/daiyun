<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
     <base href="<%=basePath%>">
    <title>My JSP 'main_menu.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body >

         <ul  id="menu_ul" >
            <li class="first" ><a href="<%=path%>/daiyun.jsp">首页</a></li>
          	<s:set var="DhKey" value="@com.daiyun.dax.WebDemand@getId()[0]"/>
	        <s:set var="DhValue" value="@com.daiyun.dax.WebDemand@getId()[1]"/>
	        <s:iterator var="v" value="#DhKey" status="st">
         <li class="hover">
      	 	<a id="bt<s:property value='#DhValue[#st.count-1]'/>" href="<%=basePath%>item/<s:property value='#DhValue[#st.count-1]'/>?code=<s:property value="@com.daiyun.dax.WebDemand@SMFNquery(#DhKey[#st.count-1])" />">
      		<s:property value="@com.daiyun.dax.WebDemand@FMquery(#DhKey[#st.count-1])" /></a>
       	    <!-- <ul>  
          	 <s:iterator var="bean" value="@com.daiyun.pgweb.dax.WebDemand@SMquery(#DhKey[#st.count-1])"> 
           	<li><a href="item/<s:property value='#DhValue[#st.count-1]'/>?code=<s:property value="#bean.Gmgm_code"/>"><s:property value="#bean.Gmgm_name"/></a></li>
          	</s:iterator>        	 
       		</ul>-->
       </li>         
  	</s:iterator>
        </ul>
        
  </body>
</html>
