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
    
    <title>HKGM</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head> 
  
  <body style="margin:0px;">
    <s:iterator var="totalSize" value="#request.listWayBillsGMHK" status="ghindex">
    <s:set var="bean" value="#totalSize"/>
    <table align="center" border="0" cellspacing="0" cellpadding="0" style="margin-top:0.6cm;">
	 <tr><td style="width:10cm;" valign="top">
       <table align="center" cellpadding="0" cellspacing="0" border="0" style="width:9.8cm;height:14.5cm;">
       <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
        <td style="width:9.8cm;clear:both">
        <div style="width:9.8cm;height:4.2cm;border-bottom:2px #000 solid; margin-left:0.3cm;margin-right:0.3cm;">
        <div style="float:left;width:4.2cm;height:4.2cm;word-wrap:break-word;font-size:12px;" align="left">
        <b>DGMHK</b>
         <br/><br/><b>Deliver To:</b>
         <br/><b><s:property value="#bean.Hwhw_consigneename"/></b>
         <br/><b><s:property value="#bean.Hwhw_consigneeaddress1"/><s:if test="#Hwhw_consigneeaddress2!=null"><s:property value="#bean.Hwhw_consigneeaddress2"/></s:if></b><br/>
         <b><s:property value="#bean.Hwhw_consigneetelephone"/></b><br/>
         <b><s:property value="#bean.Hwhw_consigneecity"/></b><br/>
         <b><s:property value="#bean.Hwhw_consigneepostcode"/></b><br/>
         <b><s:property value="#bean.Dtdt_ename"/></b>
         </div>
        <div style="float:left;width:5.2cm;height:4.2cm;">      
         <table align="center" border="0" cellspacing="0" cellpadding="0" style="width:5.2cm;height:1.8cm;">
         <tr style="font-size:9px;font-family:Arial, Helvetica, sans-serif;">
         <td style="height:1.8cm;width:2.5cm;"><b>AIRMAIL<br/>Unit A,7/F<br/>No.100 Texaco Road
         <br/>Tsuen Wan<br/>Hong Kong</b></td>
         <td style="height:1.8cm;border:1px #000 solid;width:1.8cm;">
         <b> POSTAGE PAID<br/>&nbsp;HONG KONG<br/>&nbsp;&nbsp;PORT PAYE</b></td>
         <td style="height:1.8cm;width:0.8cm;border:1px #000 solid;border-left:none;">
         <b>Permit<br/>&nbsp;&nbsp;No.<br/>&nbsp;2206</b></td></tr></table>
         <br/><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value='#bean.Cwcw_customerewbcode'/></b></div></div>
          </td></tr>
          <tr><td style="width:10cm;margin：0px;clear:both" align="center" valign="top" >
           <table align="center" border="0" cellspacing="0" cellpadding="0" style="width:8cm;">
           <tr><td style="width:2.4cm;"></td>
           <td style="width:3.5cm;"></td><td style="width:2.1cm;"></td></tr>
           <tr style="font-size:13px;font-family:Arial, Helvetica, sans-serif;">
           <td colspan="2" valign="top" align="left" style="width:5.9cm;"><b>CUSTOMS DECLARATION</b></td>
           <td valign="top" align="center" style="width:2.1cm;"><b>CN22</b></td></tr>
           <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
           <td colspan="2" valign="top" style="width:5.9cm;border-bottom:1px #000 solid;">Postal administration(May be opened officially)</td>
           <td valign="top" align="center" style="width:2.1cm;border-bottom:1px #000 solid;">Important!</td></tr>
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
           <td style="width:2.4cm;" align="left"><input type="checkbox" />&nbsp;Gift</td>
           <td colspan="2" align="left" style="width:5.6cm;"><input type="checkbox" />Commercial sample</td></tr>
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
           <td style="width:2.4cm;border-bottom:1px #000 solid;" align="left">
           <input type="checkbox" />Documents</td>
           <td colspan="2" style="width:5.6cm;border-bottom:1px #000 solid;" align="left">
           <input type="checkbox"  checked="checked"/>Others(Tick as appropriate)</td></tr>
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
           <td  align="left" colspan="2" style="width:5.9cm;"><b>Detailed discription of Contents</b></td>
           <td style="width:2.1cm;"><b>&nbsp;Value</b></td></tr>
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
          <td colspan="3"><table align="center" border="0" cellspacing="0" cellpadding="0" style="width:8cm;height:2cm;table-layout: fixed;">
          <s:set var="totalPrice" value="0"  />
          <s:set var="totalPieces" value="0"  />
          <s:set var="totalCicihscode" value="0" />
          <s:iterator var="cargoInfo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#bean.Cwcw_code, #bean.Cwcw_customerchargeweight)" status="sta">
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;height:0.4cm;">
           <td  align="left" style="width:5.9cm;border-right:1px #000 solid;">
           <s:property value="#cargoInfo.Cicipieces"/>*<s:property value="#cargoInfo.Ciciename"/></td>
           <td style="width:2.1cm;">&nbsp;USD&nbsp;<s:property value="@java.lang.Double@parseDouble(#cargoInfo.Cicitotalprice)" /></td></tr>
          <s:set var="setPrice"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicitotalprice)" />
         <s:set var="setPieces" value="@java.lang.Integer@parseInt(#cargoInfo.Cicipieces)" />
         <s:set var="totalPrice" value="#totalPrice+#setPrice" />
         <s:set var="totalPieces" value="#totalPieces+#setPieces"  />
         <s:set var="setCicihscode"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicihscode)" />
         <s:set var="totalCicihscode" value="#totalCicihscode+#setCicihscode"  />
         </s:iterator>
           </table></td></tr>
           
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
           <td style="width:2.4cm;height:0.8cm;border:1px #000 solid;border-left:none;" valign="top" align="center">
           <br/>Origin HK</td>
           <td style="width:3.5cm;border-top:1px #000 solid;border-bottom:1px #000 solid;border-right:1px #000 solid;" valign="top" >
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total Weight(kg)<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_customerchargeweight)"/></td>
           <td style="width:2.1cm;border-top:1px #000 solid;border-bottom:1px #000 solid;" valign="top" align="center">
           &nbsp;Total Value<br/>&nbsp;USD&nbsp;<s:property value="@java.lang.Double@parseDouble(#totalPrice)" /></td></tr>
           <tr>
           <td colspan="3" style="border-bottom:1px #000 solid;" align="left">
           <font style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
            I,the undersigned,whose name and address are given on the item,<br/>
            certify that the particulars given in this declaration are correct and <br/>
            that this item does not contain dangerous article or articles<br/>
            prohibited by legislation or by postal or customs regulations.
           </font></td></tr>
           <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
           <td colspan="3" align="left">Date and Sender's signature</td></tr>
           <tr style="font-size:9px;font-family:Arial, Helvetica, sans-serif;"><td colspan="3">&nbsp;</td></tr>
           <tr style="font-size:9px;font-family:Arial, Helvetica, sans-serif;">
           <td align="left" colspan="2" style="width:5.6cm;"><%= 
           new SimpleDateFormat("dd-MMM-yyyy",Locale.ENGLISH).format(Calendar.getInstance().getTime())%>
            <span style="margin-left:2.8cm;">MH</span></td>
           <td ><b>(Customer Code)</b></td></tr>
            <tr style="line-height:70%;"><td>&nbsp;</td></tr>
           </table>
          </td></tr>
           <tr style="font-size:12px;font-family:Arial, Helvetica, sans-serif;">
           <td align="center">
           <div style="width:9.8cm;height:2.5cm;border-top:2px #000 solid;" align="center">
           <div style="width:7cm;height:2.5cm;" align="center"> 
           <div style="float:left;width:1cm;height:1cm;border-bottom:2px #000 solid;"><b style="font-size:33px;">R</b></div>
           <div style="float:right;width:6cm;height:1cm;border-bottom:2px #000 solid;">
           <br style="line-height:50%"/><span style="font-size:13px;">HONG&nbsp;KONG</span><br/>
           <span style="font-size:13px;"><s:property value='#bean.Cwcw_serverewbcode' /></span>
           </div><img src="barcode.br?hrsize=0mm&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />" alt="条码" style="width: 7cm;height: 1cm;margin-top:0.2cm;" />
           </div></div></td></tr>
       </table>
       </td></tr>
    </table>
	<s:if test="!('C_GMHK'.equals(#request.bl)&&(#ghindex.index+1)==#request.listWayBillsGMHK.size())"> 
		<p style="page-break-after:always">&nbsp;</p>
	</s:if>
    </s:iterator>
  </body>
</html>
