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
    
    <title>DEGM</title> 
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style>
   .xuanz{-webkit-transform: rotate(90deg);
       -moz-transform: rotate(90deg);
       filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=1);
       display:block;
       position:absolute;
       left:0;
       top:0;}
      </style>
      <!--[if !IE]><!--> 
      <style>
    .xuanz{
       width:0px;}
      </style>
      <!--<![endif]-->
  </head>
  
  <body>
    <s:iterator var="totalSize" value="#request.listWayBillsUDFOR" status="ghindex">
    <s:set var="bean" value="#totalSize"/>
    <table align="center" border="0" cellspacing="0" cellpadding="0" style="margin-top:0.5cm;">
	 <tr><td style="width:10cm;" valign="top">
       <table align="center" cellpadding="0" cellspacing="0" border="0" style="width:10cm;height:14.5cm;border:1px #000 solid;">
       <tr style="font-size:12px;font-family:Arial, Helvetica, sans-serif;">
        <td style="width:10cm;clear:both">
         <div style="width:10cm;height:5cm;border-bottom:2px #000 solid; margin-left:0.2cm;margin-right:0.2cm;">
        <div style="float:left;width:4.5cm;height:5cm;word-wrap:break-word;" align="left">
        <br style="line-height:30%"/><b>PRODUCT:GM PACKET PLUS  STANDARD</b>
         <br style="line-height:70%"/><br/><b>Deliver To:</b>
         <br/><b><s:property value="#bean.Hwhw_consigneename"/></b>
         <br/><b><s:property value="#bean.Hwhw_consigneeaddress1"/><s:if test="#Hwhw_consigneeaddress2!=null"><s:property value="#bean.Hwhw_consigneeaddress2"/></s:if></b><br/>
         <b><s:property value="#bean.Hwhw_consigneetelephone"/></b><br/>
         <b><s:property value="#bean.Hwhw_consigneecity"/></b><br/>
         <b><s:property value="#bean.Hwhw_consigneepostcode"/></b><br/>
         <b><s:property value="#bean.Dtdt_ename"/></b>
         </div>
        <div style="float:left;width:5.5cm;height:5cm;">
         <div style="width:5.4cm;height:2cm;TEXT-ALIGN: center;" >     
         <table align="center" border="0" cellspacing="0" cellpadding="0"  style="width:5.2cm;height:1.8cm;margin-top:0.1cm;">
         <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
         <td colspan="2" style="border:1px #000 solid;text-align:center;"><b>PRIORITAIRE</b></td>
       </tr>
       <tr style="font-size:9px;font-family:Arial, Helvetica, sans-serif;">
       <td style="width:2.7cm;border:1px #000 solid;border-top:none;text-align:center;">En cas de non remise <br/>prière de retourner à<br/>
       <b style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">Postfach 2007<br/>36243 Niederaula<br/>ALLEMAGNE</b></td>
       <td style="border-bottom:1px #000 solid;border-right:1px #000 solid;text-align:center;"><br/><b style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">Deutsche Post</b>
       <br style="line-height:30%;"/>Port payé<br/>60554 Frankfurt<br/>Allemagne</td></tr>
         </table></div>
       </div></div>
          </td></tr>
          <tr><td style="width:10cm;margin：0px;clear:both" align="center" valign="top" >
          <div style="float:left;margin-left:0.5cm;">
           <table align="center" border="0" cellspacing="0" cellpadding="0" style="width:8cm;clear:both;">
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
          <td colspan="3"><table align="center" border="0" cellspacing="0" cellpadding="0" style="width:8cm;height:2cm;">
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
           <td style="width:3.5cm;border-top:1px #000 solid;border-bottom:1px #000 solid;border-right:1px #000 solid;" valign="top" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total Weight(kg)<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_customerchargeweight)"/></td>
           <td style="width:2.1cm;border-top:1px #000 solid;border-bottom:1px #000 solid;" valign="top" align="center">
           &nbsp;Total Value<br/>&nbsp;USD&nbsp;<s:property value="@java.lang.Math@round(#totalPrice*100)/100.0" /></td></tr>
           <tr>
           <td colspan="3" style="border-bottom:1px #000 solid;" align="left">
           <font style="font-size:9px;font-family:Arial, Helvetica, sans-serif;">
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
           <span style="margin-left:2.8cm;">LK</span></td>
           <td ><b>(Customer Code)</b></td></tr>
           </table>
            <br style="line-height:30%;"/>
           </div>
        <div style="float:left;border-left:1px #000 solid;height:7cm;">
            <div style="position:relative;text-align:center;margin-top:2.5cm;">
           <span class="xuanz" style="font-size:12px;margin-left:0.8cm;">REF:<s:property value='#bean.Cwcw_customerewbcode'/></span></div></div>
          </td></tr>
           <tr style="font-size:12px;font-family:Arial, Helvetica, sans-serif;">
           <td align="center">
         <div style="width:9.4cm;margin-left:0.3cm;border-top:2px #000 solid;" align="center">
           <div style="float:left;height:1.8cm;width:1.2cm;margin-top:0.2cm;" ><b style="font-size:65px;">&nbsp;&nbsp;R</b></div>
           <div style="float:left;height:1.8cm;width: 6cm;margin-top:0.15cm;margin-left:1.2cm;">
            <div style="border-bottom:1px #000 solid;width:5.2cm;"><b><s:property value='#bean.Cwcw_serverewbcode' /></b></div>
           <img src="barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />" alt="条码" style="width: 5.2cm;height: 1.1cm;margin-top:0.15cm;" /></div>
          </div><div style="margin-left:0cm;margin-top:0cm;" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EINSCHREIBEN<br/><span style="line-height:30%;">&nbsp;</span></div></td></tr>
       </table>
       </td></tr>
    </table>
    </s:iterator>
  </body>
</html>
