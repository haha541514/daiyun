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
    
    <title>PG</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
     <style >
     .xuanz4{-webkit-transform: rotate(-90deg); 
  -moz-transform: rotate(-90deg);
  filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=3);
  display:block;
  position:absolute;
  left:98%;
  top:30%;}
    </style>
    <!--[if !IE]><!--> 
      <style>
    .xuanz4{
       width:0px;
       left:116%;
       top:60%;}
      </style>
      <!--<![endif]-->
  </head>  
  
  <body >
    <s:iterator var="totalSize" value="#request.listWayBillsPG" status="ghindex">
    <s:set var="bean" value="#totalSize"/>  
    <table align="center" border="0" cellspacing="0" cellpadding="0" style="margin-top:0.5cm;">
	 <tr><td style="width:10cm;height:14.35cm;border:2px #000 solid;" valign="top">
       <table align="center" cellpadding="0" cellspacing="0" border="0" style="width:10cm;">
          <tr><td>
		     <div>
		     <div style="float:left;width:4.5cm;height:2cm;font-size:13px;font-family:Arial, Helvetica, sans-serif;margin-top:0.1cm;margin-left:0.5cm;text-align:center;"></div>
		     <div style="float:left;width:4.6cm;height:1.9cm;font-size:8px;font-family:Arial, Helvetica, sans-serif;margin-top:0.1cm;">
		     <div>  
		     <div style="float:left;border:1px #000 solid;width:2cm;height:1.6cm;text-align:center;padding-top:0.2cm;">Wenn unzustellbar,<br/>zurück an:<br/><br/>  
		     <b style="font-size:10px;">Postfach 2007</b><br/><b>36243 Niederaula</b></div>
		     <div style="float:left;border:1px #000 solid;border-left:none;width:2.5cm;height:1.8cm;text-align:center;">
		     <p style="border-bottom:1px #000 solid;"><b style="font-size:10px;">Deutsche Post</b></p>
		    <br/><br/><b style="font-size:9px;">Entgelt bezahlt</b><br/>
		     <span style="line-height:160%;">60544 Frankfurt</span><br/>
		     (2378)</div></div></div>
		     </div>  
		 </td></tr>        
          <tr><td align="left">
          <table align="left" cellpadding="0" cellspacing="0" border="0" style="margin-left:0.4cm;width:8.6cm;border:1px #000 solid;border-bottom:none;">
          <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;"><td style="width:5.3cm;"> 
          <span style="margin-left:0.2cm;">Product GM PACKET</span>
          </td>  
          <td>
          SCV:STANDARD
          </td></tr>
          <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
          <td colspan="2" style="border-top:1px #000 solid;"> 
          <div style="margin-left:0.2cm;height:3cm;">
          <b>Deliver To:</b><br/>
          <s:property value="#bean.Hwhw_consigneename"/>
          <br/><s:property value="#bean.Hwhw_consigneeaddress1"/><s:if test="#Hwhw_consigneeaddress2!=null"><s:property value="#bean.Hwhw_consigneeaddress2"/></s:if><br/>
          <s:property value="#bean.Hwhw_consigneecity"/>,<s:property value="#bean.Dtdt_statecode"/><br/>
          <s:property value="#bean.Hwhw_consigneepostcode"/><br/><s:property value="#bean.Dtdt_ename"/>
           <br/><s:property value="#bean.Hwhw_consigneetelephone"/></div></td>
          </tr>  
       </table>
       </td></tr>
       <tr><td align="left"> 
       <div style="width:9.7cm;border-top:1px #000 solid;margin-left:0.4cm;">
       <div style="float:left;border-left:1px #000 solid;">
           <table align="left" border="0" cellspacing="0" cellpadding="0" style="margin-top:0.1cm;margin-left:0.2cm;width:7.5cm;border:1px #000 solid;table-layout: fixed;">
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
           <td colspan="2" valign="top" align="left" style="width:5.7cm;"><b>CUSTOMS DECLARATION</b></td>
           <td valign="top"  style="width:1.8cm;text-align:center;"><b>CN22</b></td></tr> 
           <tr style="font-size:9px;font-family:Arial, Helvetica, sans-serif;"> 
           <td colspan="2" valign="top" style="width:5.7cm;border-bottom:1px #000 solid;">Postal administration(May be opened officially)</td>
           <td valign="top"  style="width:1.8cm;border-bottom:1px #000 solid;text-align:center;">Important!</td></tr>
           <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
           <td style="width:2.3cm;" align="left"><input type="checkbox" />Gift</td>
           <td colspan="2" align="left" style="width:5.2cm;"><input type="checkbox" />Commercial sample</td></tr>
           <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
           <td style="width:2.3cm;border-bottom:1px #000 solid;" align="left">
           <input type="checkbox" />Documents</td>
           <td colspan="2" style="width:5.2cm;border-bottom:1px #000 solid;" align="left">
           <input type="checkbox" checked="checked"/>Others(Tick as appropriate)</td></tr>
           <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
           <td  align="left" colspan="2" style="width:5.7cm;"><b>Detailed discription of Contents</b></td>
           <td style="width:1.8cm;"><b>&nbsp;Value</b></td></tr>
           <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
          <td colspan="3"><table align="center" border="0" cellspacing="0" cellpadding="0" style="width:7.5cm;height:2cm;table-layout: fixed;">
          <s:set var="totalPrice" value="0"  />
          <s:set var="totalPieces" value="0"  />
          <s:set var="totalCicihscode" value="0" />
          <s:iterator var="cargoInfo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#bean.Cwcw_code, #bean.Cwcw_customerchargeweight)" status="sta">
           <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
           <td  align="left" style="width:5.7cm;border-right:1px #000 solid;">
           <s:property value="#cargoInfo.Cicipieces"/>*<s:property value="#cargoInfo.Ciciename"/></td>
           <td style="width:1.8cm;">&nbsp;USD&nbsp;<s:property value="@java.lang.Double@parseDouble(#cargoInfo.Cicitotalprice)" /></td></tr>
          <s:set var="setPrice"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicitotalprice)" />
         <s:set var="setPieces" value="@java.lang.Integer@parseInt(#cargoInfo.Cicipieces)" />
         <s:set var="totalPrice" value="#totalPrice+#setPrice" />
         <s:set var="totalPieces" value="#totalPieces+#setPieces"  />
         <s:set var="setCicihscode"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicihscode)" />
         <s:set var="totalCicihscode" value="#totalCicihscode+#setCicihscode"  />
         </s:iterator>
           </table></td></tr>
           
           <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
           <td style="width:2.3cm;height:0.8cm;border:1px #000 solid;border-left:none;" valign="top" align="center">
           <br/>Origin HK</td>
           <td style="width:3.4cm;border-top:1px #000 solid;border-bottom:1px #000 solid;border-right:1px #000 solid;" valign="top" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total Weight(kg)<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_customerchargeweight)"/></td>
           <td style="width:1.8cm;border-top:1px #000 solid;border-bottom:1px #000 solid;" valign="top" align="center">
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
           <tr style="font-size:9px;font-family:Arial, Helvetica, sans-serif;">
           <td align="left" style="width:5.6cm;height:1cm;"><%= 
           new SimpleDateFormat("dd-MMM-yyyy",Locale.ENGLISH).format(Calendar.getInstance().getTime())%>
           </td><td> <span style="margin-left:2cm;">HM</span></td></tr>
       <tr><td colspan="3" style="font-size:12px;font-family:Arial, Helvetica, sans-serif;border-top:1px #000 solid;">
       Remark:<br/><b style="margin-left:0.3cm;"><s:property value='#bean.Cwcw_customerewbcode'/></b></td></tr>
           </table></div>
           <div style="float:left;">
           <div style="position:relative;text-align:center;margin-top:1.4cm;">
           <span>
            <img src="barcode.br?hrsize=0mm&&ori=90&type=code128&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />" alt="条码" style="width: 0.8cm;height: 5cm;margin-left:0.4cm;" />
            <span class="xuanz4" style="font-size:12px;"><s:property value='#bean.Cwcw_serverewbcode' /></span></span></div></div></div>
         </td></tr>
        <tr><td style="font-size:9px;"><div style="width:9.7cm;border:1px #000 solid;border-top:none;border-right:none;margin-left:0.4cm;">&nbsp;</div></td></tr>
   </table>
      </td></tr>
    </table>
    </s:iterator>
  </body>
</html>
