<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>dhlGMn</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<style type="text/css">

.fStyle {		
		font-family:Calibri;
		font-size: 7px;
		line-height:1em;
		font-weight:500 ;
}
td{
text-align:left;
}
    </style>
	</head>
  
  <body>
     <s:iterator var="totalSize" value="#request.listWayBillsDHLGM" status="ghindex">
		<s:set var="bean" value="#totalSize"/>
		<table align="center" style="margin-top:0.5cm;"><tr><td style="width:9cm;">	
<div  style="width:6.8cm;">
  <table align="center"  cellpadding="0" cellspacing="0" style="width:6.7cm;cm;font-size:13px; border: 2px #000000 solid; margin-top:0.7cm;">
    <tr style="border:1px thin #000;">
      <td height="61" colspan="3" valign="top" style="font-size:13px;"  ><div  style=" width:6cm;margin-left:0.3cm; marign-right:0.2cm; margin-top:0.2cm;"><img src="barcode.br?hrsize=0mm&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />" alt="条码" style="width: 6cm;height: 1.4cm;" /> </div></td>
    </tr>
    <tr   align="center">
      <td colspan="3"  style="font-size:11px;" valign="top" ><div style=" height:0.4cm; text-align:center">
          <s:property value="#bean.Cwcw_serverewbcode"/>
      </div></td>
    </tr>
    <tr>
      <td valign="top" align="left"  ><div >
        <div style="float:left; width:0.5cm;margin-left:0.2cm;"><font style="font-size:14px;"><b>To:</b></font></div>
        <div style="float:left;width:5.7cm;font-size:10px;marign-right:0.2cm;margin-top:0.4cm;">
            <table width=100% >
              <tr >
                <td colspan="2"><s:property value="#bean.Hwhw_consigneename"/></td>
              </tr>
              <tr >
                <td colspan="2"><s:property value="#bean.Hwhw_consigneecompany"/></td>
              </tr>
              <tr >
                <td colspan="2"><s:property value="#bean.Hwhw_consigneeaddress1"/></td>
              </tr>
              <tr>
                <td colspan="2"><s:property value="#bean.Hwhw_consigneeaddress2"/></td>
              </tr>
              <tr >
                <td ><s:property value="#bean.Hwhw_consigneeaddress3"/></td>
                <td rowspan="2" valign="middle"><div style="width:0.8cm;height:0.8cm; float:right;border:1px double #000000; text-align:center;margin-right:0.2cm;margin-top:0px; font-size:14px; line-height:25px;"> <b>
                    <s:property value="#bean.Dtdt_hubcode"/>
                </b> </div></td>
              </tr>
              <tr>
                <td width="80%" ><s:property value="#bean.Dtdt_ename"/>
                    <s:property value="#bean.Hwhw_consigneecity"/></td>
              </tr>
              <tr style="height:0.6cm;">
                <td colspan="2"><b style="font-size:14px;">Tel:</b><span style="font-size:12px;">
                  <s:property value="#bean.Hwhw_consigneetelephone"/>
                </span> </td>
              </tr>
            </table>
        </div>
      </div></td>
    </tr>
    <tr>
      <td style="height:0.05cm;" valign="bottom">&nbsp;</td>
    </tr>
    <tr>
      <td height="24" align="left" ><div style=" margin-left:0.6cm; font-size:12px;">【

        <s:property value="#bean.Ccoco_labelcode"/>
        】&nbsp;&nbsp;<b>Ref&nbsp;&nbsp;No:</b>&nbsp;&nbsp;
              <s:property value="#bean.Cwcw_customerewbcode"/>
      </div></td>
    </tr>
    <tr>
      <td height="20" align="left" valign="top"><div style=" margin-left:0.7cm; font-size:12px;">
        <s:property value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@getDescription(#bean.Cwcw_code)" />
      </div></td>
    </tr>
  </table>
</div>
</td></tr></table>
 	<s:if test="#request.listWayBillsDHLGM.size()!=0">
      	<s:if test="(#ghindex.index+1) != #request.listWayBillsDHLGM.size()">
      		<p style="page-break-after:always">&nbsp;</p>
      	</s:if>
      </s:if>
  </s:iterator>
  </body>
</html>
