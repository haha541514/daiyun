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
    
    <title>swiss</title>
    
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
  <s:iterator var="totalSize" value="#request.listWayBillsORSWISS" status="ghindex">
    <s:set var="bean" value="#totalSize"/>
    <table align="center" border="0" cellspacing="0" cellpadding="0" style="margin-left:0.1cm;margin-right:0.1cm;margin-top:0.35cm;border:2px #000 solid;table-layout:fixed">
      <tr><td style="width:10cm;heigt:14.5cm;table-layout:fixed">
       <table align="center" cellpadding="0" cellspacing="0" border="0" >
         <tr><td>
           <div style="width:9.6cm;heigth:2.5cm;margin-left:0.2cm;margin-right: 0.2cm;">
             <div style="float:left;width:3.8cm;height:2.5cm;">
              <div>
              <img src="${pageContext.request.contextPath}/images/swisslogo.jpg" style="margin:0px;height:1.5cm;width:3.8cm;padding: 0px;display:block"/>
              </div>
             </div>  
             <div style="float:left;width:5.8cm;height:2.5cm;"> 
               <img src="${pageContext.request.contextPath}/images/ppiII.jpg" style="margin:0px;height:2.5cm;width:5.8cm;padding: 0px;display:block"/>
             </div>
           </div> 
         </td></tr>
         <tr>
         <td style="font-size:12px;font-family:Arial, Helvetica, sans-serif;">
         <div style="float:left;width:8.2cm;height:2.4cm;margin-left:0.2cm;">
         <b>To:</b><b style="margin-left: 0.4cm;"><s:property value="#bean.Hwhw_consigneename"/></b><br/>
         <b style="margin-left: 0.8cm;"><s:property value="#bean.Hwhw_consigneecompany"/></b><br/>
          <b style="margin-left: 0.8cm;"><s:property value="#bean.Hwhw_consigneeaddress1"/>
          <s:if test="#Hwhw_consigneeaddress2!=null"><s:property value="#bean.Hwhw_consigneeaddress2"/></s:if>
          <s:if test="#Hwhw_consigneeaddress3!=null"><s:property value="#bean.Hwhw_consigneeaddress3"/></s:if></b><br/>
         <b style="margin-left: 0.8cm;"><s:property value="#bean.Dtdt_ename"/>&nbsp;<s:property value="#bean.Hwhw_consigneepostcode"/></b><br>
         <b style="margin-left: 0.8cm;"><s:property value="#bean.Hwhw_consigneetelephone"/></b>
         </div>
         <div style="float:left;width:1.2cm;height:2.4cm;">
         <div style="margin-top:60px;"><b style="font-size:20px;font-family:Arial, Helvetica, sans-serif;">No.1</b></div></div>
         </td></tr>
         <tr><td>
         <div style="width:9.4cm;height:2cm;margin-left:0.2cm;margin-right: 0.2cm;border:2px #000 solid;">
         <div style="float:left;width:2.1cm;height:2cm;">
         <div style="width:2.5cm;height:1.3cm;">
         <p style="line-height:370%;"><b style="font-size:55pt;font-family:Arial;margin-left:0.8cm;">R</b></p></div>
          <img src="${pageContext.request.contextPath}/images/swisslogo.jpg" style="margin-left:0.8cm;height:0.5cm;width:1.5cm;padding: 0px;display:block"/> 
         </div>
         <div style="float:left;width:6.9cm;height:2cm;">
         <p style="font-family:Arial;font-size:6pt;margin-left:1cm;line-height:80%;">Asendia Hong Kong</p>
         <img src="barcode.br?hrsize=0mm&type=code39&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />&res=2400" alt="条码" style="width:5.6cm;height: 1cm;margin-top:0.1cm;margin-left:1cm;line-height:70%;" />
         <br/><b style="font-size:12px;font-family:Arial, Helvetica, sans-serif;margin-left:1cm;"><s:property value='#bean.Cwcw_serverewbcode' /></b></div>
         </div></td></tr>  
         <tr><td style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
         <div style="float:left;heitht:0.6cm;">
         <p style="margin-top:3px;"><b style="margin-left:1cm;">Ref:&nbsp;&nbsp;<s:property value='#bean.Cwcw_customerewbcode' /></b></p></div>
             <div style="float:right;margin-right:0.4cm;"><img src="barcode.br?hrsize=0mm&type=code39&ewbcode_type=&msg=<s:property value='#bean.Cwcw_customerewbcode' />&res=2400" alt="条码" style="width: 4.5cm;height: 0.5cm;margin-top:0.1cm;" /></div>
         </td></tr>
         <tr><td> 
           <table align="center" border="0" cellspacing="0" cellpadding="0" style="width:8cm;">
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
          <td colspan="3"><table align="center" border="0" cellspacing="0" cellpadding="0" style="width:8cm;height:1.5cm;">
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
           <td style="width:2.4cm;height:0.8cm;border:1px #000 solid;border-left:none;" valign="top">
           <br/>Origin HK</td>
           <td style="width:3.5cm;border-top:1px #000 solid;border-bottom:1px #000 solid;border-right:1px #000 solid;" valign="top" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total Weight(kg)<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_customerchargeweight)"/></td>
           <td style="width:2.1cm;border-top:1px #000 solid;border-bottom:1px #000 solid;" valign="top" >
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
           new SimpleDateFormat("dd-MMM-yyyy",Locale.ENGLISH).format(Calendar.getInstance().getTime())%></td>
           <td ><b>(Customer Code)</b>
         </td></tr>
           </table>
         </td></tr>
       </table> 
      </td></tr>
    </table> 
    </s:iterator>
  </body>
</html>
