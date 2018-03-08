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
    
    <title>sdhlGM</title>

  </head>
  
  <body>
  <s:iterator var="totalSize" value="#request.listWayBillsSDHLGM" status="ghindex">
    <s:set var="bean" value="#totalSize"/>
    <table align="center" border="0" cellspacing="0" cellpadding="0"  style="margin-top:0.5cm;">
    <tr><td style="width:9.8cm;margin-left:0.1cm;margin-right:0.1cm;" valign="top">
       <table align="center" cellpadding="0" cellspacing="0" border="0" style="width:9.8cm;height:14cm;border:1px #000 solid;"><tr style="font-size:12px;font-family:Arial, Helvetica, sans-serif;">
        <td style="width:9.8cm;clear:both" valign="top">
          <div style="width:9.8cm;height:3.5cm;border-bottom:1px #000 solid;margin:0;"><div style="float:left;width:3cm;heigth:3.5cm;margin:0;">
           <div style="width:3cm;heigth:3.5cm;margin:0;">
           <img src="../images/back.jpg" style="width:3cm;height:3.5cm;border:none;"></div></div>
          <div style="float:left;width:5cm;height:3cm;margin-top:0.5cm;margin-left:1.1cm;">
          <table align="center" border="0" cellspacing="0"  cellpadding="0"><tr><td>
          <table align="center" border="0" cellspacing="0"  cellpadding="0" style="width:2cm;height:2.5cm;">
          <tr ><td style="width:2cm;height:1.25cm;font-size:20pt;font-family:Arial Narrow;border:1px #000 solid;text-align:center;">
          <s:property value="#bean.label.Ple1"/>
          </td>
          </tr>
          <tr><td rowspan="3" style="width:2cm;height:1.25cm;font-size:20pt;font-family:Arial Narrow;border:1px #000 solid;border-top:none;text-align:center;">
          <s:property value="#bean.label.Ple2"/></td></tr>
          </table>
          </td><td><table align="center" border="0" cellspacing="0"  cellpadding="0" style="width:2.5cm;height:2.5cm;">
          <tr><td colspan="2" align="center" style="height:1.77cm;font-size:8pt;font-family:Arial;border:1px #000 solid;border-left:none;text-align:center;">
          US Postage<br/>PAID<br/>Global Mail eVs</td></tr>
          <tr><td align="center" rowspan="2" style="width:1.2cm;height:0.7cm;font-size:12pt;font-family:Arial;border:1px #000 solid;border-top:none;border-left:none;text-align:center;">
          <s:property value="#bean.label.Ple3"/></td>
          <td style="width:1.2cm;height:0.35cm;font-size:6pt;font-family:Arial;border:1px #000 solid;border-top:none;border-left:none;text-align:center;">
          <s:property value="#bean.label.Ple4"/></td></tr>
          <tr><td style="width:1.2cm;height:0.35cm;font-size:6pt;font-family:Arial;border:1px #000 solid;border-top:none;border-left:none;text-align:center;">
          <s:property value="#bean.label.Ple5"/>-<s:property value="#bean.label.Ple6"/></td></tr>
          </table>
          </td></tr></table>
          </div></div>
          <div style="margin-left:0.3cm;margin-bottom:0.3cm;width:9.4cm;font-size:11pt;font-family:Arial;"><br/>Liberty Seamless Enterprises, Inc.<br/>
             102 E. Railroad Ave.<br/>
             Knoxville, Pa  16928
             <br/><br/>
             <p style="text-align:right;"><s:property value='#bean.way.Cwcw_customerewbcode'/></p>
          </div>
          <div style="margin-left:1cm;margin-bottom:1cm;font-size:11pt;font-family:Arial;">
           <s:property value="#bean.way.Hwhw_consigneename"/><br/>
           <s:property value="#bean.way.Hwhw_consigneeaddress1"/><br/>
           <s:property value="#bean.way.Hwhw_consigneeaddress2"/><br/>
           <s:property value="#bean.way.Hwhw_consigneecity"/>,&nbsp;<s:property value="#bean.way.Dtdt_statecode"/>,&nbsp;<s:property value="#bean.way.Hwhw_consigneepostcode"/>
          </div>
          <div style="width:9.4cm;height:3.8cm;border-top:0.1cm #000 solid;border-bottom:0.1cm #000 solid;margin-left:0.2cm;text-align:center;">
           <table align="center" cellpadding="0" cellspacing="0" border="0" style="margin-top:0.15cm;"><tr>
           <td valign="top" style="width:9.4cm;font-size:12pt;font-family:Arial;text-align:center;">
           <b>USPS TRACKING # eVS</b><br/>  
           <!--<img src="barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg=420<s:property value="#bean.way.Hwhw_consigneepostcode"/><s:property value='#bean.way.Cwcw_serverewbcode' />" alt="条码" style="width:8cm;height:2cm;margin-top:0.3cm;margin-bottom:0.3cm;" /><br/> -->
          <!-- 这种标签的条码是这种格式 GS1-128 ，原来的是这种格式  GS128   -->
          
          <img src="barcode.br?msg=420<s:property value='#bean.way.Hwhw_consigneepostcode'/>H<s:property value='#bean.way.Cwcw_serverewbcode' />&type=EAN128&mw=0.25&height=10&hrp=none" alt="条码" style="width:8cm;height:2cm;margin-top:0.3cm;margin-bottom:0.3cm;"/><br>
           <b style="font-size:11pt;"><s:property value="@com.baiqian.web.util.StrUtil@splitString(#bean.way.Cwcw_serverewbcode)" /></b>
           </td></tr> 
           </table>   
          </div>
         <br style="line-height:80%;"/>
        </td></tr></table>
    </td></tr></table>
    </s:iterator>
  </body>
</html>
