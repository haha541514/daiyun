<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>ppl</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
	.ddcode{
		 -webkit-transform: rotate(-90deg);
		 -moz-transform: rotate(-90deg); 
 		  
		 }
	</style>	
  </head>
  
  <body style="position:relative;">
     <s:iterator var="totalSize" value="#request.listUSDHLGM" status="ghindex">
		<s:set var="bean" value="#totalSize"/>
		  
   <table  style="border:1px solid #121000;width:8.89cm;height:6.35cm;" cellpadding="0" cellspacing="0">
   	<tr>
   		<td style="width:6.5cm;height:2.5cm;font-family:Arial;padding-top:30px;" align="left" valign="top" >
   			<div style="font-size:13px;margin-left:20px;">
   				<b style="font-size:20px;">Deliver To:</b><br/>
   				<s:property value="#bean.Hwhw_consigneename"/><br/>
   				<s:property value="#bean.Hwhw_consigneeaddress1"/><br/>
   				<s:property value="#bean.Hwhw_consigneeaddress2"/><br/>
   				<s:property value="#bean.Hwhw_consigneecity"/><br/>
   				<s:property value="#bean.Hwhw_consigneepostcode"/><br/>
   				<s:property value="#bean.Dtdt_ename"/><br/>
   				<s:property value="#bean.Hwhw_consigneetelephone"/><br/>
   				<br/>
   				<s:property value='#bean.Cwcw_customerewbcode' />				
   			</div>
   		</td>
   		<td  align="left" valign="top" style="height:2.5cm;padding-top:10px;">
   		<div style="width:2.39cm;height:5.5cm;">
   		<div style="float:left;width:1.6cm;height;5.5cm;"><img src="barcode.br?hrsize=0mm&&ori=90&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />"  style="height:5.5cm;width: 1.6cm;" /></div>
		<div class="ieOrOther" style="float:left;font-family:Arial;font-size:16px;">
	     <p class="ddcode">*<s:property value='#bean.Cwcw_serverewbcode' />*</p></div>
		</div></td>
   	</tr>
   </table>
	<s:if test="#request.listUSDHLGM.size()!=0">
      	<s:if test="(#ghindex.index+1) != #request.listUSDHLGM.size()">
      		<p style="page-break-after:always">&nbsp;</p>
      	</s:if>
      </s:if>

  </s:iterator>    
   
   
   
  </body>
</html>
