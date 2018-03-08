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
     <s:iterator var="totalSize" value="#request.listWayBillsSGPY" status="pyindex">
		<s:set var="bean" value="#totalSize"/>
  <table align="center" style="width:18cm;margin-bottom:1cm;"><tr><td valign="top">
		<table width="339" height="329" align="center" cellpadding="0" cellspacing="0" style="border: 2px #000000 solid;height:8.2cm;width:7.6cm;font-size:13px;">
		  <tr><td><table align="center" cellpadding="0" cellspacing="0" style="width:7.4cm; height:5.7cm;">
  <tr>
    <td width="131" height="59" align="left" valign="top" style="font-size:8px;">From:<br/>
      <br/>
	<div align="left"> <b><span>
      <s:property value="#bean.Hwhw_shippername"/>
    </span></b></div>
	<div align="left" ><b><span style="width:100px;">
    <s:property value="#bean.Hwhw_shipperaddress1"/><br/>
 	<s:property value="#bean.Hwhw_shipperaddress2"/><br/>
   	<s:property value="#bean.Hwhw_shipperaddress3"/><br/>
   	&nbsp;&nbsp;&nbsp;<s:property value="#bean.Hwhw_shipperpostcode"/><br/>  	
    </span> </b></div>	</td>
    <td width="147" rowspan="2" align="right" valign="middle"><img src="../Img/xy.png" style="width:3.8cm;height:1.9cm;"/></td>
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
	 <td valign="top" style="padding-top:2px;" align="right">
	 <div align="center" style="font-size:12px; font-family:Adobe Gothic Std B;"><b>AIRMAIL</b></div>
	 	</td>
  </tr>
</table>
      <table  align="center" cellpadding="1" cellspacing="1" style="width:7.4cm;">
        <tr>
          <td valign="bottom"><table align="left" style="border:2px #000000 solid;text-align:center;font-weight:bold;width:0.9cm;height:1.6cm;" cellpadding="0" cellspacing="0">
              <tr>
                <td style="border-bottom:2px #000000 solid;">
				<s:if test="@kyle.leis.es.price.zone.dax.ZoneDemand@getHKZnvnameByDistrict('3501', #bean.Cwdt_code_signin)==null"> &nbsp; </s:if>
                <s:elseif test="(@kyle.leis.es.price.zone.dax.ZoneDemand@getHKZnvnameByDistrict('3501', #bean.Cwdt_code_signin)).equals('')">&nbsp;
				</s:elseif>
            	  <s:else>
                <s:property value="@kyle.leis.es.price.zone.dax.ZoneDemand@getHKZnvnameByDistrict('3501', #bean.Cwdt_code_signin)" />
            </s:else>			
				</td>
              </tr>
			  <tr><td style="border-top:2px #000000 solid;font-family:Adobe Gothic Std B;">NR</td></tr>
          </table></td>
          <td valign="bottom" align="right"><table cellpadding="0" cellspacing="0" style="border:2px solid #000000; font-weight:bold; width:6.4cm; height:1.6cm;">
              <tr>
                      <td valign="middle" align="left" style="font-size:12px;font-family:rial, Helvetica, sans-serif;"><span>
                        &nbsp;&nbsp;<s:property value="#bean.Cwcw_ewbcode"/>
                      </span>&nbsp;&nbsp;</td>
              </tr>
              <tr>
                <td  valign="bottom" ><div align="left" style="margin-right:2px;margin-bottom:2px;"><img src="barcode.br?hrsize=0mm&ewbcode_type=&msg=<s:property value='#bean.Cwcw_ewbcode' />" style="width: 5cm;height: 0.8cm;" /></div></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td colspan="2"><table align="center" style="border:2px solid #000000;font-size:11px;text-align:center; width:7.4cm;height:0.4cm;" cellpadding="0" cellspacing="0">
              <tr>
                <td align="left" valign="middle" style="height:20px;">【<s:property value="#bean.Ccoco_labelcode"/>】Ref&nbsp;&nbsp;No:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#bean.Cwcw_customerewbcode"/></td>
              </tr>
          </table></td>
        </tr>
      </table></td>
</tr>
</table>
</td></tr>
<tr>
<td valign="top"><table align="center" cellpadding="0" cellspacing="0" style=" border-collapse: collapse; border: 2px #000000 solid;width: 7.6cm;height: 8.2cm;" >
  <tr>
    <td height="5" colspan="5" style="border: 2px #000000 solid;height: 1cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
      <div style="margin-left:0.3cm;">
        <div align="left" style="float: left;margin-top:6px;"> <b style="font-size:12px;">CUSTOMS</b><br/>
              <b style="font-size:11px;">DECLARATION</b> </div>
        <div align="left" style="float: left; margin-top:7px; margin-left:0.5cm;font-size:12px;"> May be opened<br/>
          officially </div>
        <div style="float: left; margin-top:8px;margin-left:0.8cm;"> <b style="font-size:12px;">CN22</b><br/>
        </div>
      </div>
    </div></td>
  </tr>
  <tr>
    <td height="20" colspan="5" style="border: 2px #000000 solid;height: 1cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
      <div style="margin-left:0.3cm;">
        <div align="left" style="float: left;"> <b style="font-size:9px">Postal administration</b><br/>
              <br/>
        </div>
      </div>
    </div></td>
  </tr>
  <tr style="font-family:Arial, Helvetica, sans-serif;height:0.7cm;">
    <td style="border: 2px #000000 solid;" valign="middle" align="center"><input name="checkbox2" type="checkbox" style="width:10px;height:10px;" checked="checked"/></td>
    <td style="border: 2px #000000 solid;border-bottom:0px;padding-top:5px;font-size:9px;" valign="top" align="left">&nbsp;Gift</td>
    <td style="border: 2px #000000 solid;" valign="middle" align="center"><input name="checkbox2" type="checkbox" style="width:10px;height:10px; border-spacing:0px;"/></td>
    <td style="border: 2px #000000 solid;border-bottom:0px;padding-top:5px;font-size:9px;" colspan="2" valign="top" align="left">&nbsp;&nbsp;&nbsp;Commercial sample </td>
  </tr>
  <tr style="height:0.7cm;">
    <td style="border: 2px #000000 solid;" valign="middle" align="center"><input name="checkbox2" type="checkbox" style="width:10px;height:10px; border-spacing:0px;"/>    </td>
    <td style="border: 2px #000000 solid;border-top:0px;padding-top:5px;font-size:9px;" valign="top" align="left">&nbsp;Documents</td>
    <td style="border: 2px #000000 solid;" valign="middle" align="center"><input name="checkbox3" type="checkbox" style="width:10px;height:10px; border-spacing:0px;"/></td>
    <td style="border: 2px #000000 solid;border-top:0px;font-size:9px;" colspan="2" valign="top" align="left">&nbsp;&nbsp;&nbsp;Others<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;Tick one of more boxes</td>
  </tr>
  <tr>
    <td colspan="3" style="border: 2px #000000 solid;font-size:8px; width : 3.6cm;height:0.7cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
      <div align="left" style="margin-left:0.1cm;"> <b>Quantity and detailed discription<br/>
        of contents (1)</b> </div>
    </div></td>
    <td style="border: 2px #000000 solid;font-size:8px;width: 0.8cm;" align="center"><div style="font-family:Arial, Helvetica, sans-serif;">
      <div align="center"> <b>Weight</b><br/>
            <b>(in kg)</b> </div>
    </div></td>
    <td style="border: 2px #000000 solid;font-size:9px;width: 1.7cm;font-family:Arial, Helvetica, sans-serif;" valign="top" align="right"><b>Value
      (3)&nbsp;&nbsp;</b> </td>
  </tr>
  <s:set var="totalPrice" value="0"  />
  <s:set var="totalPieces" value="0"  />
  <s:set var="totalCicihscode" value="0"  />
  <s:iterator var="cargoInfo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#bean.Cwcw_code, #bean.Cwcw_customerchargeweight)" status="sta">
    <tr>
      <td colspan="3" style="font-size:8px; border: 2px #000000 solid; height: 1cm;" valign="top" align="left"><div style="font-family:Arial, Helvetica, sans-serif;margin-left:0.1cm;"> &nbsp;Wireless Bicycle computer -368C </div></td>
      <td style="font-size:11px; border: 2px #000000 solid;" valign="top" align="center"><div style="font-family:Arial, Helvetica, sans-serif;">
        <div align="center"> <b>
          <s:property value="@java.lang.Double@parseDouble(#cargoInfo.Cicihscode)"/>
        </b> </div>
      </div></td>
      <td style="font-size:9px; border: 2px #000000 solid;font-family:Arial, Helvetica, sans-serif;" valign="top" align="right"><b>
        <s:property value="#cargoInfo.Cicitotalprice" />
        USD </b> </td>
    </tr>
    <s:set var="setPrice"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicitotalprice)" />
    <s:set var="setPieces" value="@java.lang.Integer@parseInt(#cargoInfo.Cicipieces)" />
    <s:set var="totalPrice" value="#totalPrice+#setPrice"  />
    <s:set var="totalPieces" value="#totalPieces+#setPieces"  />
    <s:set var="setCicihscode"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicihscode)" />
    <s:set var="totalCicihscode" value="#totalCicihscode+#setCicihscode"  />
  </s:iterator>
  <tr>
    <td colspan="3" style="border: 2px #000000 solid;height: 1cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
      <div align="left" style="margin-left:0.1cm;font-size: 8px;"> <b>For commercial iterms only<br/>
        if known,HS tariffnurmber(4) and<br />
        country of oright of goods(5)</b> </div>
    </div></td>
    <td rowspan="2" style="border: 2px #000000 solid;" align="center"><div style="font-family:Arial, Helvetica, sans-serif;font-size: 8px;">
      <div align="center"> <b>Total<br/>
        Weight</b><br/>
        <b>(In kg)</b><br/>
        <b>(6)</b><br/><s:property value="#totalCicihscode"/> </div>
    </div></td>
    <td rowspan="2" style="border: 2px #000000 solid;font-size: 9px;font-family:Arial, Helvetica, sans-serif;" valign="top" align="right"><b>Total	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/>
      </b> <b>value(7)</b>&nbsp;&nbsp;<br/>
      <b><br/><br/>
        <s:property value="#totalPrice" />
        USD </b> </td>
  </tr>
  <tr>
    <td colspan="3" style="border: 2px #000000 solid;font-size: 11px;font-family:Times New Roman, Helvetica, sans-serif;padding-right:30px;height:0.5cm;" align="right"> HONG KONG </td>
  </tr>
  <tr>
    <td colspan="6" style="font-size:7px; border: 2px #000000 solid;height: 1.1cm; width:7.5cm;"><div style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 5px;">
      <div align="left" style="margin-left:0.1cm;"> <b>I,the undersigned,whose name and address are given on the item,
        certify that particulars given in this declaration are correct and
        that this item dose not contain any dangerous article or artices 
        prohibired by legisation or by postal or customs regulations.<br/>
        Date
        and sender's signature(8) </b></div>
    </div></td>
  </tr>
</table></td>
  </tr></table>
  </s:iterator>
  	<s:if test='(#ghindex.index+1) < #request.listWayBillsSGPY.size()'>
		<p style="page-break-after:always">&nbsp;</p>
	</s:if>
  </body>
</html>
