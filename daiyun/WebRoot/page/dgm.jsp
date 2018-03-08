<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <script type="text/javascript" charset="UTF-8">
  var cwcode="${dgmCode}";
  var raval= "${raval}";
  if(cwcode!=''){ 
	  if(raval=='5'){
	  window.open("${pageContext.request.contextPath}/PrintPDFLableServlet.xsv?sign=s&cwcode="+cwcode,"_self");
	  }else{
	  window.open("${pageContext.request.contextPath}/PrintPDFLableServlet.xsv?sign=s&isnewv=N&cwcode="+cwcode,"_self");
	  }
  }
  
  
</script>
  <body>
		
  </body>
</html>
