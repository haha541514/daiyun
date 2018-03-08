<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'xy.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	--></head>
  
  <body>
     <s:iterator var="totalSize" value="#request.listWayBillsBQ" status="pyindex">
		<s:set var="bean" value="#totalSize"/>
  <table align="center" style="width:21cm;"><tr><td align="left">
		<table width="339" height="404" align="center" cellpadding="0" cellspacing="0" style="border: 2px #000000 solid;height:9.5cm;width:9cm;font-size:13px;">
		  <tr><td><table width="330" height="250" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="166" height="59" align="left" valign="top" style="font-size:8px;">From:<br/><br/>
	<div align="left"> <b><span>
      <s:property value="#bean.Hwhw_shippername"/>
    </span></b></div>
	<div align="left" ><b><span style="width:100px;">
    <s:property value="#bean.Hwhw_shipperaddress1"/><br/>
 	<s:property value="#bean.Hwhw_shipperaddress2"/><br/>
   	<s:property value="#bean.Hwhw_shipperaddress3"/><br/>
   	&nbsp;&nbsp;&nbsp;<s:property value="#bean.Hwhw_shipperpostcode"/><br/>  	
    </span> </b></div>
	</td>
    <td width="162" rowspan="2" align="right" valign="middle"><img src="../Img/xy.png" width="160" height="80"/></td>
  </tr>
  <tr>
  	<td rowspan="2" valign="top" style="font-size:10px;font-family:Adobe Gothic Std B;"><div align="left"> <b><font><font style="font-size:14px;font-family:Times New Roman;">To:</font></font><br/><span>
      <s:property value="#bean.Hwhw_consigneename"/>
    </span></b></div>
	<div align="left" ><b><span style="width:100px;">
    <s:property value="#bean.Hwhw_consigneeaddress1"/><br/>
 	<s:property value="#bean.Hwhw_consigneeaddress2"/><br/>
   	<s:property value="#bean.Hwhw_consigneeaddress3"/><br/>
   	<s:property value="#bean.Hwhw_consigneecity"/>&nbsp;&nbsp;&nbsp;<s:property value="#bean.Hwhw_consigneepostcode"/><br/>  	
    </span> </b></div>
	<div align="left"><b> <span>
      <s:property value="#bean.Dtdt_ename"/>
    </span></b></div>	</td>
  </tr>
  <tr>
	 <td valign="top" style="padding-top:2px;" align="right" height="150">
	 <div align="center" style="font-size:14px; font-family:Adobe Gothic Std B;"><b>AIRMAIL</b></div>
	 	<table width="60" height="50" style="border:2px solid #000000; font-weight:bold;font-size:12px; text-align:center;margin-right:3px;" cellpadding="0" cellspacing="0">
                    <tr>
                      <td colspan="2" height="15" valign="top"><b style="font-size:10px;">(Insurance)</b></td>
                    </tr>
                    <tr>
                      <td><input name="checkbox" type="checkbox" /></td><td><input name="checkbox" type="checkbox" checked="checked"/></td>
                    </tr>
					<tr style="font-size:11px; font-family:Adobe Gothic Std B;">
						<td>Y</td><td>N</td>
					</tr>
                </table></td>
  </tr>
</table>
      <table width="325" align="center" cellpadding="1" cellspacing="1">
        <tr>
          <td valign="bottom"><table width="40" height="73" align="right" style="border:2px #000000 solid;text-align:center;font-weight:bold;" cellpadding="0" cellspacing="0">
              <tr>
                <td style="border-bottom:2px #000000 solid;">&nbsp;</td>
              </tr>
			  <tr><td style="border-top:2px #000000 solid;font-family:Adobe Gothic Std B;">R</td></tr>
          </table></td>
          <td valign="bottom" align="right"><table width="290" cellpadding="0" cellspacing="0" style="border:2px solid #000000; font-weight:bold;">
              <tr>
                      <td height="34" valign="middle" align="right" style="font-size:12px;font-family:Adobe Gothic Std B;"><span>
                        <s:property value="#bean.Cwcw_ewbcode"/>
                      </span>&nbsp;&nbsp;</td>
              </tr>
              <tr>
                <td height="35" valign="bottom" ><div align="right" style="margin-right:10px;margin-bottom:10px;"><img src="barcode.br?hrsize=0mm&ewbcode_type=&msg=<s:property value='#bean.Cwcw_ewbcode' />" width="212" style="width: 6.2cm;height: 0.4cm;" /></div></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td colspan="2"><table align="center" width="333" style="border:2px solid #000000;font-size:13px;text-align:center;" cellpadding="0" cellspacing="0">
              <tr>
                <td align="left" valign="middle" style="padding-left:38px;height:20px;font-family:Adobe Gothic Std B;">Ref&nbsp;&nbsp;No:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#bean.Cwcw_customerewbcode"/>d</td>
              </tr>
          </table></td>
        </tr>
      </table></td>
</tr>
</table>
</td>
<td align="right">
   	  <table align="center" cellpadding="0" cellspacing="0" style=" border-collapse: collapse; border: 2px #000000 solid;width: 9cm;height: 9.5cm;" >
        <tr>
          <td height="5" colspan="5" style="border: 2px #000000 solid;height: 1.2cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
              <div style="margin-left:0.3cm;">
                <div align="left" style="float: left;margin-top:6px;"> <b style="font-size:14">CUSTOMS</b><br/>
                    <b style="font-size:14">DECLARATION</b> </div>
                <div align="left" style="float: left; margin-top:7px; margin-left:1.1cm;"> <b style="font-size:12px">May be opened</b><br/>
                    <b style="font-size:12px">officially</b> </div>
                <div style="float: left; margin-top:8px;margin-left:30px;"> <b style="font-size:14">CN22</b><br/>
                </div>
              </div>
          </div></td>
        </tr>
        <tr>
          <td height="20" colspan="5" style="border: 2px #000000 solid;height: 1.2cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
              <div style="margin-left:0.3cm;">
                <div align="left" style="float: left;"> <b style="font-size:12px">Postal administration</b><br/>
                    <br/>
                </div>
              </div>
          </div></td>
        </tr>
        <tr>
          <td height="35" width="18" style="border: 2px #000000 solid;" valign="middle" align="center">
		  <input type="checkbox" checked="checked" style="width:12px;height:12px;"/></td>
          <td style="border: 2px #000000 solid;border-bottom:0px;padding-top:5px;" valign="top" align="left">&nbsp;<b style="font-size:12px;">Gift</b></td>
          <td width="18" style="border: 2px #000000 solid;" valign="middle" align="center">
		  <input type="checkbox" style="width:12px;height:12px; border-spacing:0px;"/></td>
          <td style="border: 2px #000000 solid;border-bottom:0px;padding-top:5px;" colspan="2" valign="top" align="left">&nbsp;&nbsp;&nbsp;<b style="font-size:12px;">Commercial sample </b></td>
        </tr>
        <tr>
          <td height="35" style="border: 2px #000000 solid;" valign="middle" align="center">
            <input name="checkbox2" type="checkbox" style="width:12px;height:12px; border-spacing:0px;"/>
          </td>
          <td style="border: 2px #000000 solid;border-top:0px;padding-top:5px;" valign="top" align="left">&nbsp;<b style="font-size:12px;">Documents</b></td>
          <td style="border: 2px #000000 solid;" valign="middle" align="center">
		  <input type="checkbox" style="width:12px;height:12px; border-spacing:0px;"/></td>
          <td style="border: 2px #000000 solid;border-top:0px;padding-top:5px;" colspan="2" valign="top" align="left">&nbsp;&nbsp;&nbsp;<b style="font-size:12px">Others<br/>&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:12px;">Tick one of more boxes</span></b></td>
        </tr>
        <tr>
          <td colspan="3" style="border: 2px #000000 solid;font-size:11px; width : 5cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
              <div align="left" style="margin-left:0.2cm;"> <b>Quantity and detailed discription of contents (1)</b> </div>
          </div></td>
          <td style="border: 2px #000000 solid;font-size:11px;width: 1.3cm;" align="center"><div style="font-family:Arial, Helvetica, sans-serif;">
              <div align="center"> <b>Weight</b><br/>
                  <b>(in kg)</b> </div>
          </div></td>
          <td style="border: 2px #000000 solid;font-size:11px;width: 2cm;font-family:Arial, Helvetica, sans-serif;" valign="top" align="right"><b>Value
            (3)&nbsp;&nbsp;</b> </td>
        </tr>
        <s:set var="totalPrice" value="0"  />
        <s:set var="totalPieces" value="0"  />
        <s:iterator var="cargoInfo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#bean.Cwcw_code, #bean.Cwcw_customerchargeweight)" status="sta">
          <tr>
            <td colspan="3" style="font-size:11px; border: 2px #000000 solid;width : 5cm; height: 1.1cm;" valign="top" align="left"><div style="font-family:Arial, Helvetica, sans-serif;"> &nbsp;Wireless Bicycle computer -368C </div></td>
            <td style="font-size:11px; border: 2px #000000 solid;" valign="top" align="center"><div style="font-family:Arial, Helvetica, sans-serif;">
                <div align="center"> <b>
                  <s:property value="#cargoInfo.Cicihscode"/>
                </b> </div>
            </div></td>
            <td style="font-size:12px; border: 2px #000000 solid;font-family:Arial, Helvetica, sans-serif;" valign="top" align="right"><b>
              <s:property value="#cargoInfo.Cicitotalprice" />
              USD </b> </td>
          </tr>
          <s:set var="setPrice"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicitotalprice)" />
          <s:set var="setPieces" value="@java.lang.Integer@parseInt(#cargoInfo.Cicipieces)" />
          <s:set var="totalPrice" value="#totalPrice+#setPrice"  />
          <s:set var="totalPieces" value="#totalPieces+#setPieces"  />
        </s:iterator>
        <tr>
          <td colspan="3" style="border: 2px #000000 solid;height: 1.1cm;width : 5cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
              <div align="left" style="margin-left:0.2cm;font-size: 9px;"> <b>For commercial iterms only<br/>
                if known,HS tariffnurmber(4) and<br />
                country of oright of goods(5)</b> </div>
          </div></td>
          <td rowspan="2" style="border: 2px #000000 solid;" align="center"><div style="font-family:Arial, Helvetica, sans-serif;font-size: 9px;">
              <div align="center"> <b>Total<br/>
                Weight</b><br/>
                <b>(In kg)</b><br/>
                <b>(6)</b> </div>
          </div></td>
          <td rowspan="2" style="border: 2px #000000 solid;font-size: 11px;font-family:Arial, Helvetica, sans-serif;" valign="top" align="right"><b>Total	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/>
            </b> <b>value(7)</b>&nbsp;&nbsp;<br/>
            <b><br/>
              <s:property value="#totalPrice" />
              USD </b> </td>
        </tr>
        <tr>
          <td colspan="3" style="border: 2px #000000 solid;font-size: 11px;font-family:Times New Roman, Helvetica, sans-serif;padding-right:40px;" align="right">
              HONG KONG         </td>
        </tr>
        <tr>
          <td colspan="6" style="font-size:7px; border: 2px #000000 solid;height: 1.3cm; width:9cm;"><div style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 5px;">
              <div align="left" style="margin-left:0.2cm;"> <b>I,the undersigned,whose name and address are given on the item,
                certify that particulars given in this declaration are correct and
                that this item dose not contain any dangerous article or artices 
                prohibired by legisation or by postal or customs regulations.<br/>
                Date
                and sender's signature(8) </b> <span style="margin-left:70px;"><b style="font-size:11px;">Ref No:</b></span> </div>
          </div></td>
        </tr>
      </table>
	  </td></tr></table>
	  </s:iterator>
  </body>
</html>
