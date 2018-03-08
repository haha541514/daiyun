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
    
    <title>biaoqian</title>
    
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
  <s:iterator var="totalSize" value="#request.listWayBillsFL" status="ghindex">
    <s:set var="bean" value="#totalSize"/>
    <div style="width:7.9cm;">
   <table align="center" border="0" cellspacing="0" cellpadding="0" style="margin-left:0.5cm;margin-right:0.5cm;"> 
      <tr><td  valign="top" style="width:7cm;height:8.3cm;border:1px #000 solid;">
      <table><tr>
      <td colspan="2" style="width:7cm;">&nbsp;</td></tr>
      <tr><td>
      <div style="width:2.8cm;border:1px #000 solid;font-size:7px;font-family:Arial Narrow;margin-left:0.1cm;">
        If Undelivered, Please return to :Rpx Limited
        C/O Baiqian Limited
        Rm 9, 2/F., Block A,
        Vigor Ind Bldg., 14-20 Cheung Tat Rd., Tsing Yi, Hong Kong 
      </div></td>
      <td><div style="width:3cm;border:1px #000 solid;margin-left:0.5cm;"> 
      <div style="float:left;font-size:7px;font-family:Arial Narrow;width:1.95cm;"><div style="border-bottom:1px #000 solid;font-size:7px;font-family:Arial Narrow;">PRIORITAIRE / PRIORITY </div>
      <div>En cas de non distribution :LA  POSTE  99002 PARIS INTER
      </div></div><div style="float:left;font-size:7px;font-family:Arial Narrow;width:1cm;border-left:1px #000 solid;">PORT PAYÉ
       Aut. : N° 1060 A
       FRANCE
       LA POSTE 
      </div></div></td></tr>  
      <tr><td></td>
      <td><div style="width:4cm;border:1px #000 solid;margin-top:0.3cm;text-align: center;"><div style="height:0.6cm;">
       <img src="barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />" alt="条码" style="width: 3.5cm;height: 0.4cm;margin-top:0.1cm;margin-left:0.2cm;" /></div>
      <div style="border-top:1px #000 solid;text-align: center;"><b style="font-size:10px;font-family:Arial Narrow;"><s:property value='#bean.Cwcw_serverewbcode' /></b></div></div></td></tr>
      <tr><td colspan="2"><div style="width:5.3cm;border:1px #000 solid;font-size:10px;font-family:Arial Narrow;margin-left:0.8cm;margin-top:0.3cm;"><span style="margin-left:1.8cm;">
      Delivery address：</span>
      <br/><b><s:property value="#bean.Hwhw_consigneename"/></b><br/>
           <b><s:property value="#bean.Hwhw_consigneecompany"/></b>
         <br/><b><s:property value="#bean.Hwhw_consigneeaddress1"/><s:if test="#Hwhw_consigneeaddress2!=null"><s:property value="#bean.Hwhw_consigneeaddress2"/></s:if></b><br/>
         <b><s:property value="#bean.Hwhw_consigneetelephone"/></b>
         <br/><b><s:property value="#bean.Dtdt_ename"/></b></div></td></tr>
         <tr style="border-bottom:2px #000 solid;"><td></td><td  style="font-size:10px;font-family:Arial Narrow;">
         <span style="margin-left:0.6cm;">REF:<s:property value='#bean.Cwcw_customerewbcode'/></span></td></tr>
         <tr><td colspan="2" style="width:7cm;font-size:7px;">&nbsp;</td></tr>
      </table>
      </td></tr>
    </table>
    </div>
    </s:iterator>
  </body>
</html>
