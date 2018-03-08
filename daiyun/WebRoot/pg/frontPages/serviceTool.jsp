<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="com.daiyun.dax.WebDemand" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@taglib uri = "/project" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
    <base href="<%=basePath%>">
    
    <title>My JSP 'serverTool.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>  	
  	<div class="top">
        	<ul>
            	<s:iterator var="bean" value="@com.daiyun.dax.WebDemand@SMquery(#session.ks)"> 
            <li><a id="<s:property value="#bean.Gmgm_code"/>" href="<s:property value="#session.actionName"/>?code=<s:property value="#bean.Gmgm_code"/>"><s:property value="#bean.Gmgm_name"/></a></li>
          		</s:iterator>
			</ul>
        </div>
    	<img alt="服务专区" src="../images/left.jpg" width="230" height="380" border="0" usemap="#Map2" />
    <map name="Map2" id="Map2">
      <area shape="rect" coords="14,153,214,215" href="../chaxu/tousu.jsp" />
      <area shape="rect" coords="12,227,213,289" href="../chaxu/chax.jsp" />
      <area shape="rect" coords="11,302,214,367" href="../chaxu/wangdian.jsp" />
      <area shape="rect" coords="15,74,215,111" href="../chaxu/zhuyi.jsp" />
      <area shape="rect" coords="13,113,214,149" href="../chaxu/yonghu.jsp" />
      <area shape="rect" coords="17,34,213,73" href="../chaxu/tuoyung.jsp" />      
    </map> 
  </body>
</html>
