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
    
    <title>xjbpy</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	--></head>
  
  <body>
     <s:iterator var="totalSize" value="#request.listWayBillsSGGH" status="ghindex">
		<s:set var="bean" value="#totalSize"/>
		<table align="center" style="margin-top:0.5cm;"><tr><td style="width:9cm;" valign="top">
<table align="center" cellpadding="0" cellspacing="0" style=" border-collapse: collapse;width: 7.6cm;height: 8.2cm;" >
  <tr>
    <td height="5" colspan="5" valign="bottom" style="border-bottom: 2px #000000 solid;height: 0.8cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
      <div>
        <div align="left" style="float: left;"> <b style="font-size:12px;">CUSTOMS</b><br/>
              <b style="font-size:11px;">DECLARATION</b> </div>
        <div align="left" style="float: left; margin-top:14px; font-size:12px;margin-left:15px;"> May be opened
          officially </div>
        <div style="float:right;margin-top:14px;"> <b style="font-size:12px;">CN22</b><br/>
        </div>
      </div>
    </div></td>
  </tr>
  <tr>
    <td height="20" colspan="5" style="border: 2px #000000 solid;height: 0.7cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
      <div style="margin-left:0.3cm;float: left;font-size:12px">
        Postal administration
      </div>
	  <div style="float:right;clear:left;">
	  	<b style="font-size:9px">Tick as appropriate</b>
	  </div>
    </div></td>
  </tr>
  <tr style="font-family:Arial, Helvetica, sans-serif;height:0.6cm;">
    <td style="border: 2px #000000 solid;width:0.7cm;" valign="middle" align="center">×</td>
    <td style="border: 2px #000000 solid;border-bottom:0px;padding-top:5px;font-size:9px;" valign="top" align="left">&nbsp;Gift</td>
    <td style="border: 2px #000000 solid;width:0.7cm;" valign="middle" align="center">&nbsp;</td>
    <td style="border: 2px #000000 solid;border-bottom:0px;padding-top:5px;font-size:9px;" colspan="2" valign="top" align="left">&nbsp;&nbsp;Commercial sample </td>
  </tr>
  <tr style="height:0.5cm;">
    <td style="border: 2px #000000 solid;" valign="middle" align="center">&nbsp;</td>
    <td style="border: 2px #000000 solid;border-top:0px;font-size:9px;" valign="bottom" align="left">&nbsp;Documents</td>
    <td style="border: 2px #000000 solid;" valign="middle" align="center">&nbsp;</td>
    <td style="border: 2px #000000 solid;border-top:0px;font-size:9px;" colspan="2" valign="bottom" align="left">&nbsp;&nbsp;&nbsp;Others</td>
  </tr>
  <tr>
    <td colspan="3" style="border: 2px #000000 solid;font-size:9px; width : 3.6cm;height:0.7cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
      <div align="left"> <b>Quantity and detailed<br/>discription of contents</b> </div>
    </div></td>
    <td style="border: 2px #000000 solid;font-size:8px;width: 1cm;" align="center"><div style="font-family:Arial, Helvetica, sans-serif;">
      <div align="center"> <b>Weight</b><br/>
            <b>(in kg)</b> </div>
    </div></td>
    <td style="border: 2px #000000 solid;font-size:9px;width: 1.5cm;font-family:Arial, Helvetica, sans-serif;" valign="top" align="left"><b>Value
      &nbsp;&nbsp;</b> </td>
  </tr>
  <s:set var="totalPrice" value="0"  />
  <s:set var="totalPieces" value="0"  />
  <s:set var="totalCicihscode" value="0"  />
  <s:iterator var="cargoInfo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#bean.Cwcw_code, #bean.Cwcw_customerchargeweight)" status="sta">
    <tr>
      <td colspan="3" style="font-size:9px; border: 2px #000000 solid; height: 1cm;" valign="top" align="left"><div style="font-family:Arial, Helvetica, sans-serif;"><s:property value="#cargoInfo.Ciciename"/></div></td>
      <td style="font-size:11px; border: 2px #000000 solid;" valign="top" align="center"><div style="font-family:Arial, Helvetica, sans-serif;">
        <div align="center"> <b>
          <s:property value="@java.lang.Double@parseDouble(#cargoInfo.Cicihscode)"/>
        </b> </div>
      </div></td>
      <td style="font-size:9px; border: 2px #000000 solid;font-family:Arial, Helvetica, sans-serif;" valign="top" align="right"><b>
        <s:property value="#cargoInfo.Cicitotalprice" />
       </b> </td>
    </tr>
    <s:set var="setPrice"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicitotalprice)" />
    <s:set var="setPieces" value="@java.lang.Integer@parseInt(#cargoInfo.Cicipieces)" />
    <s:set var="totalPrice" value="#totalPrice+#setPrice"  />
    <s:set var="totalPieces" value="#totalPieces+#setPieces"  />
    <s:set var="setCicihscode"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicihscode)" />
    <s:set var="totalCicihscode" value="#totalCicihscode+#setCicihscode"  />
  </s:iterator>
  <tr>
    <td colspan="3" style="border: 2px #000000 solid;height: 1cm;" valign="top"><div style="font-family:Arial, Helvetica, sans-serif;">
      <div align="left" style="margin-left:0.1cm;font-size: 9px;"> <b>For commercial iterms only<br/>
        if known,HS tariffnurmber and<br />
        country of oright of goods</b> </div>
    </div></td>
    <td style="border: 2px #000000 solid;" align="center"><div style="font-family:Arial, Helvetica, sans-serif;font-size: 8px;">
      <div align="center"> <b>Total<br/>
        Weight</b><br/>
        <b>(In kg)</b><br/>
        <s:property value="#totalCicihscode"/> </div>
    </div></td>
    <td style="border: 2px #000000 solid;font-size: 9px;font-family:Arial, Helvetica, sans-serif;" valign="top" align="left"><div><b>Total	<br/>value</b></div><div align="right">USD <br/>
      <b><s:property value="#totalPrice" /></b> </div></td>
  </tr>

  <tr>
    <td colspan="6" style="font-size:8px; border: 2px #000000 solid;height: 1.1cm; width:7.5cm;"><div style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 5px;">
      <div align="left" style="margin-left:0.1cm;"> <b>I,the undersigned,whose name and address are given on the item,
        certify that particulars given in this declaration are correct and
        that this item dose not contain any dangerous article or artices 
        prohibired by legisation or by postal or customs regulations.<br/>
        Date
        and sender's signature </b></div>
    </div></td>
  </tr>
</table>
<p style="page-break-after:always">&nbsp;</p>
	<table width="300" height="329" align="center" cellpadding="0" cellspacing="0" style="height:8.2cm;width:7.6cm;font-size:13px;">
		  <tr><td width="298"><table align="center" cellpadding="0" cellspacing="0" style="width:7.6cm;">
  <tr>
    <td width="145" height="59" align="left" valign="top" style="font-size:10px;">
		IF UNELIVED,PLEASE<br/>
		RETURN TO: c/o ATC CHANGI<br/> AIRFREIGHT CENTRE<br/>
		P.O.BOX 946,SINGAPORE 918115<br/><b>R-852- 333592</b>		</td>
    <td width="144" align="left" valign="middle"><img src="<%=basePath%>Img/xjb.png" style="width:3.8cm;height:1.9cm;"/></td>
  </tr>
  <tr>
  	<td colspan="2" valign="top" ><div align="left"> <b><font><font style="font-size:14px;">To:</font></font><span style="font-size:16px;">
      <s:property value="#bean.Hwhw_consigneename"/>
    </span></b></div>
	<div align="left" style="margin-left:25px;"><span style="width:100px;font-size:14px;">
    <s:property value="#bean.Hwhw_consigneeaddress1"/><br/>
 	<s:property value="#bean.Hwhw_consigneeaddress2"/><br/>
	<b>Tel:<span style="font-size:13px;"><s:property value="#bean.Hwhw_consigneetelephone"/></span></b>
   	<s:property value="#bean.Hwhw_consigneeaddress3"/><br/>	
   	<s:property value="#bean.Hwhw_consigneecity"/>&nbsp;&nbsp;&nbsp;<s:property value="#bean.Hwhw_consigneepostcode"/><br/>  	
    </span></div>	</td>
  </tr>
</table>
              </td>
</tr>
<tr><td valign="bottom">
	<table  align="center" cellpadding="1" cellspacing="1" style="width:7.4cm;">
                <tr>
                  <td colspan="2"><table style="width:7.4cm;height:0.8cm;">
                    <tr>
                      <td style="font-size:19px;"><b><s:property value="#bean.Dtdt_ename"/></b>&nbsp;</td>
                      <td style="font-size:13px;font-family:Adobe Gothic Std B;" align="right"><b>REGISTERED<br/>AIR MAIL&nbsp;&nbsp;&nbsp;</b></td>
                    </tr>
                  </table></td>
                </tr>
                <tr>
                  <td valign="bottom"><table align="left" style="border:2px solid #000000;text-align:center;font-weight:bold;width:0.9cm;height:1.9cm;" cellpadding="0" cellspacing="0">
                      <tr>
                        <td style="border-bottom:2px #000000 solid;"><s:if test="@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('SG_R'), #bean.Cwdt_code_signin)==null"> &nbsp; </s:if>
                            <s:elseif test="(@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('SG_R'), #bean.Cwdt_code_signin)).equals('')">&nbsp; </s:elseif>
                            <s:else>
                              <s:property value="@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('SG_R'), #bean.Cwdt_code_signin)" />
                            </s:else>                        </td>
                      </tr>
                      <tr>
                        <td style="border-top:2px #000000 solid;font-family:Adobe Gothic Std B;">R</td>
                      </tr>
                  </table></td>
                  <td valign="bottom" align="right"><table cellpadding="0" cellspacing="0" style="border:2px solid #000000; font-weight:bold; width:6.4cm; height:1.9cm;">
                      <tr>
                        <td align="center" style="font-size:12px;font-family:rial, Helvetica, sans-serif;"> SINGAPORE </td>
                      </tr>
                      <tr>
                        <td  align="center" ><div align="center" style="margin-right:2px;margin-bottom:2px;"><img src="barcode.br?hrsize=0mm&ewbcode_type=&msg=<s:property value='#bean.Cwcw_ewbcode' />" style="width: 5cm;height: 0.8cm;" /></div></td>
                      </tr>
                      <tr>
                        <td align="center" style="font-size:13px;"><b>
                          <s:property value="#bean.Cwcw_serverewbcode"/>
                        </b></td>
                      </tr>
                  </table></td>
                </tr>
              </table>
</td></tr>
<tr><td align="left">【 <s:property value="#bean.Ccoco_labelcode"/> 】&nbsp;&nbsp;Ref&nbsp;&nbsp;No:&nbsp;&nbsp;
                  <s:property value="#bean.Cwcw_customerewbcode"/>
</td></tr>
<tr><td style="font-size:13px;" colspan="3" align="left">
	&nbsp;&nbsp;<s:property value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@getDescription(#bean.Cwcw_code)" />
</td></tr>
</table>
</td></tr></table>
		
	<s:if test="#request.listWayBillsSGPY.size()==0 && #request.listWayBillsSWGH.size()==0 && #request.listWayBillsOTSR.size()==0">
      	<s:if test="(#ghindex.index+1) != #request.listWayBillsSGGH.size()">
      		<p style="page-break-after:always">&nbsp;</p>
      	</s:if>
      </s:if>
      <s:else>
      	<p style="page-break-after:always">&nbsp;</p>
      </s:else>
  </s:iterator>
  </body>
</html>
