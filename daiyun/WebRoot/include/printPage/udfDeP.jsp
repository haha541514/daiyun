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
     <style >
      .xuanz1{-webkit-transform: rotate(90deg);
  -moz-transform: rotate(90deg);
  filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=1);
  display:block;
  position:absolute;
  left:0px;
  top:30%;}
     .xuanz2{-webkit-transform: rotate(90deg);
  -moz-transform: rotate(90deg);
  filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=1);
  display:block;
  position:absolute;
  left:98%;
  top:30%;}
    </style>
    <!--[if !IE]><!--> 
      <style>
      .xuanz1{
       width:0px;
       left:12%;
       top:30%;}
    .xuanz2{
       width:0px;
       left:116%;
       top:30%;}
      </style>
      <!--<![endif]-->
  </head>
  
  <body style="margin:0px;">
    <s:iterator var="totalSize" value="#request.listWayBillsUDFDEP" status="ghindex">
    <s:set var="bean" value="#totalSize"/>
    <table align="center" border="0" cellspacing="0" cellpadding="0" style="margin-top:0.6cm;">
	 <tr><td style="width:10cm;" valign="top">
       <table align="center" cellpadding="0" cellspacing="0" border="0" style="width:9.8cm;height:14.6cm;border:1px #000 solid;">
       <tr style="font-size:12px;font-family:Arial, Helvetica, sans-serif;">
        <td style="width:10cm;clear:both">
         <div style="width:10cm;height:5cm;border-bottom:2px #000 solid; margin-left:0.2cm;margin-right:0.2cm;">
        
        <div style="float:left;width:4.5cm;height:5cm;word-wrap:break-word;" align="left">
        <br style="line-height:30%"/><b>PRODUCT:GM PACKET STANDARD</b>
         <br style="line-height:70%"/><br/><b>Deliver To:</b>
         <br/><b><s:property value="#bean.Hwhw_consigneename"/></b>
         <br/><b><s:property value="#bean.Hwhw_consigneeaddress1"/><s:if test="#Hwhw_consigneeaddress2!=null"><s:property value="#bean.Hwhw_consigneeaddress2"/></s:if></b><br/>
         <b><s:property value="#bean.Hwhw_consigneetelephone"/></b><br/>
         <b><s:property value="#bean.Hwhw_consigneecity"/></b><br/>
         <b><s:property value="#bean.Hwhw_consigneepostcode"/></b><br/>
         <b><s:property value="#bean.Dtdt_ename"/></b>
         </div>
        <div style="float:left;width:5.5cm;height:5cm;">
         <div style="width:5.4cm; height:2cm;border:1px #000 solid;TEXT-ALIGN: center;margin-top:0cm;" >     
         <table align="center" border="0" cellspacing="0" cellpadding="0"  style="width:5.2cm;height:1.8cm;margin-top:0.1cm;">
         <tr style="font-size:9px;font-family:Arial, Helvetica, sans-serif;">
         <td rowspan="2" style="border:1px #000 solid;border-right:none;">&nbsp;Wenn unzustellbar,<br/>&nbsp;zurühk an:<br/><br/>
         <b style="font-size:12px;" >&nbsp;Postfach 2007</b><br/><b style="font-size:11px;">&nbsp;36243 Niederaula</b></td>
         <td style="border:1px #000 solid;"><b style="font-size:12px;">&nbsp;Deutesche Post</b></td></tr>
         <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;"><td style="border:1px #000 solid;border-top:none;">
         <b style="font-size:11px;">&nbsp;&nbsp;Entgelt bezahlt</b>
         <br/>&nbsp;&nbsp;&nbsp;60544 Frankfurt<br/><center>(2378)</center></td></tr>
         </table></div>
        </div></div>
          </td></tr>
          <tr><td style="width:10cm;margin：0px;clear:both" align="center" valign="top" >
           <div style="float:left;margin-left:0.5cm;">
           <table align="center" border="0" cellspacing="0" cellpadding="0" style="width:8cm;clear:both;margin-top:0.5cm;"> 
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
           <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;"><td colspan="3">&nbsp;</td></tr>
           <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
           <td align="left" colspan="2" style="width:5.6cm;"><br/><%= 
           new SimpleDateFormat("dd-MMM-yyyy",Locale.ENGLISH).format(Calendar.getInstance().getTime())%>
           <span style="margin-left:2.8cm;">LK</span></td>
           <td ><br/><b style="font-size:9px;font-family:Arial, Helvetica, sans-serif;">(Customer Code)</b></td></tr>
           </table>
           </div>
           <div style="float:left;border-left:1px #000 solid;height:8cm;">
           <div style="position:relative;text-align:center;margin-top:1.4cm;">
           <span>
           <span class="xuanz1" style="font-size:12px;">REF:<s:property value='#bean.Cwcw_customerewbcode'/></span>
            <img src="barcode.br?hrsize=0mm&&ori=90&type=code128&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />" alt="条码" style="width: 0.8cm;height: 5cm;margin-left:0.4cm;" />
            <span class="xuanz2" style="font-size:12px;"><s:property value='#bean.Cwcw_serverewbcode' /></span></span></div></div>
          </td></tr>
       </table>
       </td></tr>
    </table>
    </s:iterator>
  </body>
</html>
