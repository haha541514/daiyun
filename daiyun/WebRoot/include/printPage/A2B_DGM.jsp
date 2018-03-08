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
    
    <title>A2B_DGM</title>
    
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
   <s:iterator var="totalSize" value="#request.listWayBillsA2BDGM" status="ghindex">
   <s:set var="bean" value="#totalSize"/>  
    <table align="center" border="0" cellspacing="0" cellpadding="0" style="margin-top:0.1cm;width:15cm;margin-left:0.16cm;padding-right:0.15cm;"><tr valign="top"><td>
    <table style="height:9.4cm;width:7.5cm;border:1px #000 solid;margin-top:0.2cm;"><tr valign="top">
    <td>
    <div style="height:1.5cm;text-align:left;">
    	<div style="height:0.4cm;text-align:left;">
    	<span style="font-size:13px;">Customer reference
    	</span>
    	</div>
    	<img src="barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg=<s:property value="@com.baiqian.web.util.StrUtil@repString(#bean.Cwcw_customerewbcode)" />" alt="条码" style="width:5.0cm;margin-left:1cm;height:0.8cm;" />
    	<div style="height:0.3cm;text-align:center"><span style="font-size:12px;"><b><s:property value='#bean.Cwcw_customerewbcode' /></b></span></div>
    </div>   
     <table align="center" border="0" cellspacing="0" cellpadding="0" style="width:7.3cm;border:1px #000 solid;clear:both;">
           <tr><td style="width:2.4cm;"></td><td style="width:2.9cm;"></td><td style="width:2cm;"></td></tr>
           <tr style="font-size:12px;font-family:Arial, Helvetica, sans-serif;"><td colspan="2" valign="top" align="left" style="5.3cm;"><b>CUSTOMS DECLARATION</b></td>
           <td style="width:2cm;text-align:right;" align="right"><b>CN22&nbsp;</b></td></tr>  
           <tr style="font-size:9px;font-family:Arial, Helvetica, sans-serif;"> 
           <td colspan="2" valign="top" style="width:5.3cm;border-bottom:1px #000 solid;">Postal administration(May be opened officially)</td>
           <td valign="top" align="right" style="width:2cm;border-bottom:1px #000 solid;text-align:right;">Important!</td></tr>
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
           <td style="width:2.4cm;" align="left"><input type="checkbox" />Gift</td>
           <td colspan="2" align="left" style="width:4.9cm;"><input type="checkbox" />Commercial sample</td></tr>
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
           <td style="width:2.4cm;border-bottom:1px #000 solid;" align="left">
           <input type="checkbox" />Documents</td>
           <td colspan="2" style="width:4.9cm;border-bottom:1px #000 solid;" align="left">
           <input type="checkbox" checked="checked"/>Others(Tick as appropriate)</td></tr>
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
           <td  align="left" colspan="2" style="width:5.3cm;"><b>Detailed description of Contents</b></td>
           <td style="width:2cm;"><b>&nbsp;Value</b></td></tr>
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
          <td colspan="3"><table align="center" border="0" cellspacing="0" cellpadding="0" style="width:7.3cm;height:2cm;border-bottom:1px #000 solid;">
          <s:set var="totalPrice" value="0"  />
          <s:set var="totalPieces" value="0"  /> 
          <s:set var="totalCicihscode" value="0" />
          <s:iterator var="cargoInfo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#bean.Cwcw_code, #bean.Cwcw_customerchargeweight)" status="sta">
           <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
           <td  align="left" style="width:5.3cm;border-right:1px #000 solid;">
           <b><s:property value="#cargoInfo.Cicipieces"/>*<s:property value="#cargoInfo.Ciciename"/></b></td>
           <td style="width:2cm;"><b>&nbsp;USD$&nbsp;<s:property value="@java.lang.Double@parseDouble(#cargoInfo.Cicitotalprice)" /></b></td></tr>
          <s:set var="setPrice"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicitotalprice)" />
         <s:set var="setPieces" value="@java.lang.Integer@parseInt(#cargoInfo.Cicipieces)" />
         <s:set var="totalPrice" value="#totalPrice+#setPrice" />
         <s:set var="totalPieces" value="#totalPieces+#setPieces"  />
         <s:set var="setCicihscode"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicihscode)" />
         <s:set var="totalCicihscode" value="#totalCicihscode+#setCicihscode"  />
         </s:iterator>
           </table></td></tr>
            <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
           <td style="width:2.4cm;height:0.8cm;border:1px #000 solid;border-left:none;border-top:none;" valign="top" align="center">
           &nbsp;&nbsp;Origin country<p style="text-align:center;"><b>CN</b></p></td>
           <td style="width:2.9cm;border-bottom:1px #000 solid;border-right:1px #000 solid;" valign="top" >
            &nbsp;&nbsp;Total Weight(kg)<p style="text-align:center;"><b><s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_customerchargeweight)"/></b></p></td>
           <td style="width:2cm;border-bottom:1px #000 solid;" valign="top" align="center">
           &nbsp;Total Value<br/><b>&nbsp;USD$&nbsp;<s:property value="@java.lang.Math@round(#totalPrice*100)/100.0" /></b></td></tr>
           <tr>
           <td colspan="3" style="border-bottom:1px #000 solid;" align="left">
           <font style="font-size:9px;font-family:Arial, Helvetica, sans-serif;">
            I, hereby undersigned whose name and address are given on the<br/>
            item certify that the particulars given in the declaration are correct<br/>
            and that this item does not contain any dangerous articles or<br/>
            articles prohibited by legislation or by postal or customs<br/>
            regulatrions.
           </font></td></tr>
            <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
           <td colspan="3" align="left">Date and Sender's signature</td></tr>
           <tr style="font-size:12px;font-family:Arial, Helvetica, sans-serif;">
           <td align="left" colspan="2" style="width:5.5cm;"><b><%= 
           new SimpleDateFormat("dd-MM-yyyy",Locale.ENGLISH).format(Calendar.getInstance().getTime())%></b>
           <span style="margin-left:2.8cm;"></span>
          
           </td>
           <td style="width:1.8cm;"><b>X40</b></td></tr>   
           <tr style="font-size:5px;font-family:Arial, Helvetica, sans-serif;"><td colspan="3">&nbsp;</td></tr>
           </table></td></tr></table>
    </td><td>
           <table style="width:7.5cm;height:9.4cm;border:1px #000 solid;border-left:none;margin-top:0.2cm;"><tr valign="top"><td> 
             <div style="width:7.5cm;height:2.4cm;">
           
         <table align="right" border="0" cellspacing="0" cellpadding="0"  style="width:5.2cm;height:1.8cm;margin-top:0.1cm;margin-left:50px;clear:both;">
         <tr valign="top" style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
         <td rowspan="2" style="border:1px #000 solid;border-right:none;">&nbsp;Wenn unzustellbar,<br/>&nbsp;zurück an:<br/><br/>
         <b style="font-size:12px;" >&nbsp;Postfach 2007</b><br/><b style="font-size:11px;">&nbsp;36243 Niederaula</b></td>
         <td style="border:1px #000 solid;"><b style="font-size:12px;">&nbsp;Deutsche Post</b></td></tr>
         <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;"><td style="border:1px #000 solid;border-top:none;">
         <b style="font-size:11px;">&nbsp;&nbsp;Entgelt bezahlt</b>
         <br/>&nbsp;&nbsp;&nbsp;60544 Frankfurt<br/><center>(2378)</center></td></tr>
         </table>
                 
         <div style="clear:both;"></div>
         <div style="margin-left:10px;font-size:12px;font-family:Arial, Helvetica, sans-serif;margin-top:0.3cm;">PACKET <br/>STANDARD</div>
         <div style="height:2cm;margin-top:0.5cm;margin-bottom:0.5cm;">&nbsp;</div>
         <div style="width:7.3cm;margin-left:0.2cm;margin-right:0.2cm;font-size:13px;font-family:Arial, Helvetica, sans-serif;">
         <span><b>TO:</b></span><s:property value="#bean.Hwhw_consigneename"/>
         <br/><s:property value="#bean.Hwhw_consigneeaddress1"/><s:if test="#Hwhw_consigneeaddress2!=null"><s:property value="#bean.Hwhw_consigneeaddress2"/></s:if><br/>
         <s:property value="#bean.Hwhw_consigneecity"/>,<s:property value="#bean.Dtdt_estatecode"/><br/>
         <s:property value="#bean.Hwhw_consigneepostcode"/><br/>
         <s:property value="#bean.Dtdt_ename"/></div></div>
           </td></tr></table></td>
    </tr></table>
    </s:iterator>
  </body>
</html>
