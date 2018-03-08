<%@ page language="java" import="java.util.*,java.text.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>DGMUDF</title>
    
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
  <s:iterator var="totalSize" value="#request.listWayBillsDGMUDF" status="ghindex">
    <s:set var="bean" value="#totalSize"/>
    <table align="center" border="0" cellspacing="0" cellpadding="0" >
    <tr>
    	<td style="width:9.4cm;height:13.5cm;border:1px #000 solid;" valign="top">
    		<div style="float:left;width:2.6cm;height:0.9cm;margin-left:6mm;margin-top:2mm;font-size:9pt;font-family:Arial Narrow;">
    			PARCEL<BR/>DIRECT-US
    		</div>
    		<div style="float:left;width:8.6cm;height:0.6cm;margin-left:6mm;margin-top:22mm;font-size:11pt;font-family:Arial Narrow;">
    			Customer Ref:<s:property value="#bean.Cwcw_customerewbcode"/>
    		</div>
    		<div style="border:#000 0px solid;float:left;width:5.5cm;height:1.6cm;margin-left:26mm;margin-top:2mm;text-align:center;">
    		<b style="font-size:9pt;"><s:property value="@com.baiqian.web.util.StrUtil@splitString(#bean.Cwcw_serverewbcode)" /></b> 
    		<div style="float:left;width:5.0cm;height:1px;border-bottom:1px #000 solid;margin-left:2.5mm;"></div>        
    		<img src="barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg=<s:property value="#bean.Cwcw_serverewbcode"/><s:property value='#bean.way.Cwcw_serverewbcode' />" alt="条码" style="width:45mm;height:10mm;margin-top:1mm;" />
    		</div>
    		<div style="float:left;width:8.8cm;height:6.5cm;margin-left:6mm;margin-top:6mm;text-align:left;font-size:12pt;font-family:Arial Narrow;">
    			<s:property value="#bean.Hwhw_consigneename"/><br/>
    			<s:property value="#bean.Hwhw_consigneeaddress1"/><br/>
    			<s:property value="#bean.Hwhw_consigneeaddress2"/><br/>
    			<s:property value="#bean.Hwhw_consigneecity"/><br/>
    			<s:property value="#bean.Hwhw_consigneepostcode"/><br/>
    			<s:property value="#bean.Dtdt_ename"/>
    		</div>
    	</td>
    </tr>
    </table>
    </s:iterator>
  </body>
</html>
