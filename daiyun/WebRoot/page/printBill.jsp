<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <style media="print">
	.noprint {display:none;}
  </style>
  
	<script type="text/javascript" src="../jquery/jquery-1.3.2.js"></script>
    <base href="<%=basePath%>">
    
    <title>打印发票</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<SCRIPT type="text/javascript">
		
		//返回暂存页面
		function rturnHistory(){
			document.getElementById("myform").action="${pageContext.request.contextPath }/order/queryTransientOrders?link=transient";
			document.getElementById("myform").submit();
		}
	</SCRIPT>
  </head>
  
  <body>
<form action="${pageContext.request.contextPath }/order/queryPrintedOrders?link=printed"  method="post" id="myform">
  		<center class="noprint">
			<input type="submit" id="allPrinter" value="  打 印   " onClick="window.print(false)" />
			<input type="button" id="allPrinter" value=" 返回暂存页面 " onClick="rturnHistory()"/>
		</center>
		<br/>
  		<center>
  <!--设置表头-->
  <thead style="display:table-header-group;font-weight:bold" >
  <!-- dhlcn发票 -->
   <jsp:include page="../include/printPage/dhlcn.jsp" />
   
   <!-- fedex发票 -->
   <jsp:include page="../include/printPage/fedex.jsp" />
 
   <!-- STD发票(Proforma Invoice) -->
   <jsp:include page="../include/printPage/std.jsp" />
   
   
<tfoot style="display:table-footer-group; border:none;">&nbsp;</tfoot>
  </center>
</form>
</body>
</html>
