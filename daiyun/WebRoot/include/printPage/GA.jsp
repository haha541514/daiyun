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
    
    <title>GA</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>  
  
  <body >
    <s:iterator var="totalSize" value="#request.listWayBillsGA" status="ghindex">
    <s:set var="bean" value="#totalSize"/>  
    <table align="center" border="0" cellspacing="0" cellpadding="0" style="margin-top:0.5cm;">
	 <tr><td style="width:9.8cm;height:13.9cm;border:2px #000 solid;" valign="top">
       <table align="center" cellpadding="0" cellspacing="0" border="0" >
          <tr><td>
		      
		     <div style="float:left;width:4.5cm;height:0.8cm;font-size:13px;font-family:Arial, Helvetica, sans-serif;margin-top:1cm;margin-left:0.5cm;"></div>
		     <div style="float:left;width:4.6cm;height:1.6cm;font-size:8px;font-family:Arial, Helvetica, sans-serif;margin-top:0.1cm;">
		    <img src="../images/GA.bmp"style="width:4.6cm; height: 1.6cm;" /> </div>
		 </td></tr>  
		 <tr><td>
		 <div> 
		   <div style="float:left;font-size:10px;font-family:Arial, Helvetica, sans-serif;width:7.5cm;height:2.8cm;margin-left:0.4cm;border:1px #000 solid;border-bottom:none;"> 
          <p style="border-bottom:1px #000 solid;"><b>Product GM PACKET PLUS</b> STANDARD</p>
          <b>Deliver To:</b><br/> 
          <s:property value="#bean.Hwhw_consigneename"/><br/>
          <s:property value="#bean.Hwhw_consigneeaddress1"/><s:if test="#Hwhw_consigneeaddress2!=null"><s:property value="#bean.Hwhw_consigneeaddress2"/></s:if><br/>
          <s:property value="#bean.Hwhw_consigneecity"/>,<s:property value="#bean.Dtdt_statecode"/><br/>
          <s:property value="#bean.Hwhw_consigneepostcode"/> 
          <br/><s:property value="#bean.Dtdt_ename"/>
          <br/><s:property value="#bean.Hwhw_consigneetelephone"/></div> 
          <div style="float:right;"><img src="../images/AUPO.bmp" style="height:2.6cm;width:1.5cm;"/></div></div> 
          <tr><td align="left">
          <table align="left" cellpadding="0" cellspacing="0" border="0" style="margin-left:0.4cm;width:8.6cm;border:1px #000 solid;">
          <tr><td colspan="2" >
        <table align="left" border="0" cellspacing="0" cellpadding="0" style="margin-top:0.1cm;margin-left:0.2cm;width:7.5cm;border:1px #000 solid;border-bottom:none;table-layout: fixed;">
           
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
           <td  align="left" colspan="2" style="width:5.7cm;height:0.7cm;"><b>Detailed discription of Contents</b></td>
           <td style="width:1.8cm;"><b>&nbsp;Value</b></td></tr>
           <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
          <td colspan="3"><table align="center" border="0" cellspacing="0" cellpadding="0" style="width:7.5cm;height:1.6cm;table-layout: fixed;">
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
           <td style="width:2.4cm;border-top:1px #000 solid;border-bottom:1px #000 solid;border-right:1px #000 solid;" valign="top" >
            &nbsp;&nbsp;Total Weight(kg)<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_customerchargeweight)"/></td>
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
           <td align="left" style="width:5.6cm;"><%= 
           new SimpleDateFormat("dd-MMM-yyyy",Locale.ENGLISH).format(Calendar.getInstance().getTime())%>
            </td><td> <span style="margin-left:2cm;">HM</span></td></tr>
           </table></td></tr>  
           <tr><td colspan="2" style="font-size:10px;text-align:center;border:1px #000 solid;border-left:none;border-right:none;"> 
           <b>DELIVERY CONFIRMATION</b>
           <img src="barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />" alt="条码" style="width: 5.3cm;height:1cm;" />
          <p style="font-size:13px;"><b><s:property value='#bean.Cwcw_serverewbcode' /></b></p></td></tr>
          <tr><td colspan="2" style="font-size:9px;text-align:left;"> 
           Remark:<br/><b style="margin-left:0.3cm;font-size:9px;"><s:property value='#bean.Cwcw_customerewbcode'/></b></td></tr>
       </table>
       </td></tr>
       
    </table>
      </td></tr>
    </table>
    </s:iterator>
  </body>
</html>
