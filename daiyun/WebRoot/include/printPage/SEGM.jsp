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
    
    <title>HK</title>
    
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
    <s:iterator var="totalSize" value="#request.listWayBillsGMSE" status="ghindex">
    <s:set var="bean" value="#totalSize"/>
    <table align="center" border="0" cellspacing="0" cellpadding="0" style="margin-top:0.5cm;">
	 <tr><td style="width:10cm;" valign="top">
       <table align="center" cellpadding="0" cellspacing="0" border="0"><tr style="font-size:13px;font-family:Arial, Helvetica, sans-serif;clear:both;">
        <td style="width:10cm;clear:both">
        <div style="width:9cm;height:4.2cm;border-bottom:2px #000 solid;margin-left:0.5cm;">
        <div style="float:left;width:4cm;height:4.2cm;">
        <div style="width:4cm;height:4.2cm;word-wrap:break-word;font-size:12px;" align="left"><b>DGMHK</b>
         <br/><br/><b>Deliver To:</b>
         <br/><b><s:property value="#bean.Hwhw_consigneename"/></b>
         <br/><b><s:property value="#bean.Hwhw_consigneeaddress1"/><s:if test="#Hwhw_consigneeaddress2!=null"><s:property value="#bean.Hwhw_consigneeaddress2"/></s:if></b><br/>
         <b><s:property value="#bean.Hwhw_consigneetelephone"/></b><br/>
         <b><s:property value="#bean.Hwhw_consigneecity"/></b><br/>
         <b><s:property value="#bean.Hwhw_consigneepostcode"/></b><br/>
         <b><s:property value="#bean.Dtdt_ename"/></b>
         </div>
        </div>
        <div style="float:left;width:4.5cm;height:4.2cm;">   
         <div style="float:left;width:4.4cm;height:2.5cm;border:1px #000 solid;">
         <div  style="width:4.4cm;height:2.5cm;">
         <div style="float:left;width:2cm;height:2.5cm;font-size:9px;margin-left:1px;line-height:150%;" align="left">
         <b>PRIORITY</b>&nbsp;&nbsp;<span style="font-size:11px;font-weight:bold;">A</span><br/>
         <b style="font-size:6px;">if undeliverable return to:</b><br/>
         <b>Dept. 165-88</b><br/>
         <b>PO Box 4008</b><br/>
         <b>SE-202 26 Malmǒ</b><br/>
         <b>Sweden</b>
         </div>
         <div style="float:left;width:2.3cm;height:2.5cm;">
         <div style="width:2.2cm;height:2.3cm;border:1px #000 solid;margin:2px;">
         <div style="float:left;width:0.4cm;line-height:180%;">
         <br/>
         <img src="../images/ico.jpg" style="width:0.4cm;height:0.6cm;"/>
         </div>
         <div style="float:right;width:1.8cm;font-size:8px;line-height:180%;">
         POSTEN AB<br/>
        <span style="font-size:6px;">INTERNATIONAL MAIL</span>
        <br/><br/>
         <b style="font-size:16px;">PP</b><b style="font-size:9px;">Sweden</b></div>
         </div></div></div></div><br/>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b><s:property value='#bean.Cwcw_customerewbcode'/></b>
         </div></div>
          </td></tr>
          <tr><td style="width:10cm;margin：0px;clear:both" align="center" valign="top" >
           <table align="center" border="0" cellspacing="0" cellpadding="0" style="width:8cm;height:6cm;clear:both;">
           <tr><td style="width:2.4cm;"></td>
           <td style="width:3.5cm;"></td><td style="width:2.1cm;"></td></tr>
           <tr style="font-size:13px;font-family:Arial, Helvetica, sans-serif;">
           <td colspan="2" valign="top" align="left" style="width:5.9cm;"><b>CUSTOMS DECLARATION</b></td>
           <td valign="top" align="center" style="width:2.1cm;"><b>CN22</b></td></tr>
           <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
           <td colspan="2" valign="top" style="width:5.9cm;border-bottom:1px #000 solid;">Postal administration(May be opened officially)</td>
           <td valign="top" align="center" style="width:2.1cm;border-bottom:1px #000 solid;">Important!</td></tr>
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
           <td style="width:2.4cm;" align="left"><input type="checkbox" />Gift</td>
           <td colspan="2" align="left" style="width:5.6cm;"><input type="checkbox" />Commercial sample</td></tr>
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
           <td style="width:2.4cm;border-bottom:1px #000 solid;" align="left">
           <input type="checkbox" />Documents</td>
           <td colspan="2" style="width:5.6cm;border-bottom:1px #000 solid;" align="left">
           <input type="checkbox" checked="checked"/>Others(Tick as appropriate)</td></tr>
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
           <td  align="left" colspan="2" style="width:5.9cm;"><b>Detailed discription of Contents</b></td>
           <td style="width:2.1cm;"><b>&nbsp;Value</b></td></tr>
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
          <td colspan="3"><table align="center" border="0" cellspacing="0" cellpadding="0" style="width:8cm;height:2cm;table-layout: fixed;">
          <s:set var="totalPrice" value="0"  />
          <s:set var="totalPieces" value="0"  />
          <s:set var="totalCicihscode" value="0" />
          <s:iterator var="cargoInfo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#bean.Cwcw_code, #bean.Cwcw_customerchargeweight)" status="sta">
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
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
           <td style="width:3.5cm;border-top:1px #000 solid;border-bottom:1px #000 solid;border-right:1px #000 solid;" valign="top" align="center">
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
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;"><td style="height:2px;">&nbsp;</td></tr>
           </table>
          </td></tr>
           <tr style="font-size:12px;font-family:Arial, Helvetica, sans-serif;" align="center">
           <td align="center">
           <div style="width:9cm;height:2.5cm;margin-left:0.5cm;border-top:2px #000 solid;" align="center">
            <div style="width:7cm;height:1.5cm;">
            <div style="float:left;font-size:45px;width:1cm;"><b>R</b></div>
            <div style="float:left;height:1cm;width:6cm;border-top:2px #000 solid;border-bottom:2px #000 solid;font-size:14px;margin-top:0.2cm;" align="center" >
            <br style="line-height:60%"/><span style="font-size:16px;"><s:property value='#bean.Cwcw_serverewbcode' /></span></div>
           <img src="barcode.br?hrsize=0mm&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />" alt="条码" style="width:6cm;height: 1cm;margin-top:0.1cm;" /></div>
           </div></td></tr>
       </table>
       </td></tr>
    </table>
    <s:if test="!('C_GMSE'.equals(#request.bl)&&(#ghindex.index+1)==#request.listWayBillsGMSE.size())"> 
		<p style="page-break-after:always">&nbsp;</p>
	</s:if>
    </s:iterator>
  </body>
</html>
