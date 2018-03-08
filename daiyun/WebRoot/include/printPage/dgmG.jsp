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
    
    <title>dgmP</title>
    
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
   <s:iterator var="totalSize" value="#request.listWayBillsDGMG" status="ghindex"> 
   <s:set var="bean" value="#totalSize"/>
     <table align="center" border="0" cellspacing="0" cellpadding="0" style="margin-top:0.1cm;width:15cm;margin-left:0.16cm;padding-right:0.15cm;"><tr valign="top"><td>
    <table style="height:9.4cm;width:7.5cm;border:1px #000 solid;margin-top:0.2cm;"><tr valign="top"><td>
    <div style="height:1.5cm;text-align:center;"><img src="barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg=<s:property value='#bean.Cwcw_customerewbcode' />" alt="条码" style="width: 5.2cm;height:1cm;" />
    <p style="font-size:13px;"><b><s:property value='#bean.Cwcw_customerewbcode' /></b></p></div>    
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
           <td  align="left" colspan="2" style="width:5.3cm;"><b>Detailed discription of Contents</b></td>
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
           <span style="margin-left:2.8cm;"></span></td>
           <td style="width:1.8cm;"><b>BQC (MH)</b></td></tr>   
           <tr style="font-size:5px;font-family:Arial, Helvetica, sans-serif;"><td colspan="3">&nbsp;</td></tr>
           </table></td></tr></table>
    </td><td>
           <table style="width:7.5cm;height:9.4cm;border:1px #000 solid;border-left:none;margin-top:0.2cm;"><tr valign="top"><td> 
             <div style="width:7.5cm;height:2.4cm;">
         <s:if test="\"DE\".equals(#bean.Dtdt_hubcode)">
         <table align="right" border="0" cellspacing="0" cellpadding="0"  style="width:5.2cm;height:1.8cm;margin-top:0.1cm;margin-left:50px;clear:both;">
         <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;">
         <td rowspan="2" style="border:1px #000 solid;border-right:none;">&nbsp;Wenn unzustellbar,<br/>&nbsp;zurühk an:<br/><br/>
         <b style="font-size:12px;" >&nbsp;Postfach 2007</b><br/><b style="font-size:11px;">&nbsp;36243 Niederaula</b></td>
         <td style="border:1px #000 solid;"><b style="font-size:12px;">&nbsp;Deutsche Post</b></td></tr>
         <tr style="font-size:10px;font-family:Arial, Helvetica, sans-serif;"><td style="border:1px #000 solid;border-top:none;">
         <b style="font-size:11px;">&nbsp;&nbsp;Entgelt bezahlt</b>
         <br/>&nbsp;&nbsp;&nbsp;60544 Frankfurt<br/><center>(2378)</center></td></tr>
         </table></s:if> 
         <s:elseif test="\"IT\".equals(#bean.Dtdt_hubcode)">
		     <div style="height:1.8cm; font-size:8px;font-family:Arial, Helvetica, sans-serif;margin-top:0.1cm;margin-left:105px;"><div style="width:4.53cm;border:1px #000 solid;border-bottom:none;"><b style="line-height:180%;">&nbsp;</b></div>  
		     <div style="float:left;border:1px #000 solid;width:2.25cm;text-align:center;height:1.37cm;"> 
		     En cas de non remise<br/>prière de retourner à<br/><b>Postfach 2007<br>36243 Niederaula<br/>ALLEMAGNE</b>  
		     </div> 
		     <div style="float:left;border:1px #000 solid;border-left:none;width:2.25cm;height:1.37cm;text-align:center;">
		     <p style="border-bottom:1px #000 solid;"><b>Deutsche Post</b></p>
		     <b>Port payé</b><br/>60544 frankfurt<br/>Allemagne
		     <p style="border-top:1px #000 solid;">Luftpost/Prioritaire</p></div></div>
         </s:elseif>
         <s:else>
           	     <div style="height:1.8cm;font-size:8px;font-family:Arial, Helvetica, sans-serif;margin-top:0.1cm;margin-left:105px;"><div style="width:4.53cm;border:1px #000 solid;border-bottom:none;text-align:center;"><b style="font-size:9px;">PRIORITAIRE</b></div>  
		     <div style="float:left;border:1px #000 solid;width:2.25cm;text-align:center;height:1.37cm;"> 
		     En cas de non remise<br/>prière de retourner à<br/><b>Postfach 2007<br>36243 Niederaula<br/>ALLEMAGNE</b>  
		     </div> 
		     <div style="float:left;border:1px #000 solid;border-left:none;width:2.25cm;height:1.37cm;text-align:center;">
		     <p style="border-bottom:1px #000 solid;"><b>Deutsche Post</b></p>
		     <b>Port payé</b><br/>60544 frankfurt<br/>Allemagne
		     <p style="border-top:1px #000 solid;">Luftpost/Prioritaire</p></div></div>
         </s:else>
         <div style="clear:both;"></div>
         <s:if test="\"DE\".equals(#bean.Dtdt_hubcode)">
         		<div style="width:7.5cm;height:3.8cm;">  
         		<div style="margin-left:10px;font-size:12px;font-family:Arial, Helvetica, sans-serif;margin-top:0.3cm;">PACKET PLUS <br/>STANDARD</div>
         		<div style="height:2cm;margin-top:0.2cm;margin-bottom:0.5cm;font-size:15px;font-family:Arial, Helvetica, sans-serif;text-align:left;">
          		<div style="float:left;height:1.2cm;width:0.8cm;margin-left:0.4cm;margin-top:0.4cm;" ><b style="font-size:45px;">R</b></div> 
           		<div style="float:left;height:1.6cm;width: 4.4cm;margin-left:0.3cm;">
            	<p style="border-bottom:1px #000 solid;width:5.3cm;text-align:center;"><b><s:property value="@com.baiqian.web.util.StrUtil@splitString2(#bean.Cwcw_serverewbcode)" /></b></p>
          		<img src="barcode.br?hrsize=0mm&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />" alt="条码" style="width: 5.3cm;height:0.9cm;margin-top:0.1cm;" /></div>
            	<div style="clear:both;"></div><div style="margin-top:none;margin-left:1.6cm;font-weight:bold;"><i><b>EINSCHREIBEN EINWURF</b></i></div>
          		</div> 
       	  		</div>
       	  </s:if>       	  		
       	  <s:else>
       	  	 	<div style="width:7.5cm;height:3.5cm;">           
         		<div style="margin-left:10px;font-size:12px;font-family:Arial, Helvetica, sans-serif;margin-top:0.3cm;">PACKET PLUS <br/>STANDARD</div>
         		<div style="height:2cm;margin-top:0.2cm;margin-bottom:0.5cm;font-size:15px;font-family:Arial, Helvetica, sans-serif;text-align:left;">
          		<div style="float:left;height:1.2cm;width:0.8cm;margin-left:0.4cm;margin-top:0.4cm;" ><b style="font-size:45px;">R</b></div> 
           		<div style="float:left;height:1.6cm;width: 4.4cm;margin-left:0.3cm;">
            	<p style="border-bottom:1px #000 solid;width:5.3cm;text-align:center;"><b><s:property value="@com.baiqian.web.util.StrUtil@splitString2(#bean.Cwcw_serverewbcode)" /></b></p>
          		<img src="barcode.br?hrsize=0mm&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />" alt="条码" style="width: 5.3cm;height:0.9cm;margin-top:0.1cm;" /></div>
            	<div style="clear:both;"></div>
            	<div style="margin-left:1.6cm;font-size:13px;font-family:Arial, Helvetica, sans-serif;margin-top:0.0cm;font-weight:bold;">RECOMMANDÉ</div>
          		</div> 
       	  		</div>
       	  </s:else>
         
          <div style="clear:both;"></div>
         <div style="width:7.3cm;margin-left:0.2cm;margin-right:0.2cm;font-size:13px;font-family:Arial, Helvetica, sans-serif;">
         <s:property value="#bean.Hwhw_consigneename"/>
         <br/><s:property value="#bean.Hwhw_consigneeaddress1"/><s:if test="#Hwhw_consigneeaddress2!=null"><s:property value="#bean.Hwhw_consigneeaddress2"/></s:if><br/>
         <s:property value="#bean.Hwhw_consigneecity"/>,<s:property value="#bean.Dtdt_estatecode"/><br/>
         <s:property value="#bean.Hwhw_consigneepostcode"/><br/>
         <s:property value="#bean.Dtdt_ename"/></div></div>
           </td></tr></table></td>
    </tr></table>
    </s:iterator>
  </body>
</html>
