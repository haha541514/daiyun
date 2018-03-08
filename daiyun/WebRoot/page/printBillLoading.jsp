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
    
    <title>打印提货单</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<SCRIPT type="text/javascript">
	var bwcode="${bwcode}";
 	var raval= "${bwblabelcode}";
	if(bwcode != ""){
		console.log(bwcode);
		//window.open("${pageContext.request.contextPath}/PrintBillLoadingServlet.xsv?sign=s&bwcode="+bwcode,"_self");
	
	}
	
		
	//返回提货单页面
	function rturnHistory(){
		document.getElementById("myform").action="${pageContext.request.contextPath }/order/BillLoading";
		document.getElementById("myform").submit();
	}
</SCRIPT>
  </head>
  
  <body>
<form action="${pageContext.request.contextPath }/order/queryPrintedOrders?link=printed"  method="post" id="myform">
  		<center class="noprint">
			<input type="submit" id="allPrinter" value="  打 印   " onClick="window.print(false)" />
			<input type="button" id="allPrinter" value=" 返回提货单页面 " onClick="rturnHistory()"/>
		</center>
		<br/>
  		<center>
  <!--设置表头-->
  <thead style="display:table-header-group;font-weight:bold" >
     <div style="margin-left: 0cm;font-size: 14px;">
    
     <b>提单号：${bwblabelcode}</b></div>
       <img src="barcode.br?hrsize=0mm&ewbcode_type=BQ&msg='${bwblabelcode}'" width="250" height="63" 
					style="width: 9cm;height: 1.6cm;margin-left:0.2cm;"/>	
   
<tfoot style="display:table-footer-group; border:none;">&nbsp;</tfoot>
  </center>
</form>
</body>
</html>
