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
     <s:iterator var="totalSize" value="#request.listWayBillsSWGH" status="ghindex">
		<s:set var="bean" value="#totalSize"/>
		<div style="float:left;margin-top:0.5cm;margin-left:0.5cm;">	
		<table align="left"><tr><td style="width:7.7cm;">
		<div style="float:left;">			
	<table align="left" cellpadding="0" cellspacing="0" style="height:8.2cm;width:7.6cm;font-size:13px;">
		  <tr><td width="298"><table align="center" cellpadding="0" cellspacing="0" style="width:7.6cm;">
  <tr>
    <td><table style="font-family:Arial, Helvetica, sans-serif;width:280px;"><tr>
<td align="left"><b style="font-size:13px;">PRIORITY A</b><br/><span style="font-size:8px;"><i>if underliverable return to:</i></span><br/><span style="font-size:11px;">Dept.0655-S01</span><br/>
<span style="font-size:11px;">PO Box 4318</span><br/><span style="font-size:11px;">SE-202 26 Malm<img style="width:8px;height:8px;" src="<%=basePath%>Img/font.jpg"/></span><br/>
<span style="font-size:10px;">Sweden</span>
</td>
<td align="right">
<table style="border:2px solid #000000;width:4.5cm;height:2.3cm;"><tr><td rowspan="2" style="width:1.2cm; padding-top:5px;" align="right" valign="top"><img src="<%=basePath%>Img/swgh.jpg"/></td>
<td valign="top" align="left"><span style="font-size:9px;">&nbsp;&nbsp;POSTEN AB<br/>&nbsp;&nbsp;INTERNATIONAL MAIL</span></td></tr><tr><td  style="font-size:30px;" align="left"><b>PP</b><span style="font-size:12px;">Sweden</span></td></tr></table>
</td></tr></table></td>
  </tr>
  <tr>
  	<td colspan="2" valign="top" ><div align="left"> <b><font><font style="font-size:14px;">To:</font></font><span style="font-size:16px;">
      <s:property value="#bean.Hwhw_consigneename"/>
    </span></b></div>
	<div align="left" style="margin-left:25px;"><span style="width:100px;font-size:14px;">
    <s:property value="#bean.Hwhw_consigneeaddress1"/><br/>
 	<s:property value="#bean.Hwhw_consigneeaddress2"/><br/>
   	<b>Tel:<span style="font-size:13px;"><s:property value="#bean.Hwhw_consigneetelephone"/></span></b><s:property value="#bean.Hwhw_consigneeaddress3"/><br/>
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
                      <td style="font-size:15px;"><b><s:property value="#bean.Dtdt_ename"/></b>&nbsp;</td>
                      <td style="font-size:13px;font-family:Adobe Gothic Std B;" align="right"><b>REGISTERED<br/>AIR MAIL&nbsp;&nbsp;&nbsp;</b></td>
                    </tr>
                  </table></td>
                </tr>
                <tr>
                  <td valign="bottom"><table align="left" style="border:2px solid #000000;text-align:center;font-weight:bold;width:0.9cm;height:1.9cm;" cellpadding="0" cellspacing="0">
                      <tr>
                        <td style="border-bottom:2px #000000 solid;"><s:if test="@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('SE_R'), #bean.Cwdt_code_signin)==null"> &nbsp; </s:if>
                            <s:elseif test="(@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('SE_R'), #bean.Cwdt_code_signin)).equals('')">&nbsp; </s:elseif>
                            <s:else>
                              <s:property value="@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('SE_R'), #bean.Cwdt_code_signin)" />
                            </s:else>                        </td>
                      </tr>
                      <tr>
                        <td style="border-top:2px #000000 solid;font-family:Adobe Gothic Std B;">R</td>
                      </tr>
                  </table></td>
                  <td valign="bottom" align="right"><table cellpadding="0" cellspacing="0" style="border:2px solid #000000; font-weight:bold; width:6.4cm; height:1.9cm;">
                      <tr>
                        <td align="center" style="font-size:12px;font-family:rial, Helvetica, sans-serif;">&nbsp;  </td>
                      </tr>
                      <tr>
                        <td  align="center" ><div align="center" style="margin-right:2px;margin-bottom:2px;"><img src="barcode.br?hrsize=0mm&ewbcode_type=&msg=<s:property value='#bean.Cwcw_ewbcode' />" style="width: 5.7cm;height: 0.9cm;" /></div></td>
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
<tr><td align="left">【<s:property value="#bean.Ccoco_labelcode"/> 】&nbsp;&nbsp;Ref&nbsp;&nbsp;No:&nbsp;&nbsp;
                  <s:property value="#bean.Cwcw_customerewbcode"/>
</td></tr>
<tr><td style="font-size:13px;" colspan="3" align="left">
	&nbsp;&nbsp;<s:property value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@getDescription(#bean.Cwcw_code)" />
</td></tr>
</table>
		</div></td></tr></table></div>
	<s:if test="#request.listWayBillsOTSR.size()==0">
		<s:if test="#request.listWayBillsBQ.size()==0 && #request.listWayBillsOTS.size()==0 && #request.listWayBillsPY.size()==0 && #request.listWayBillsGH.size()==0 && #request.listWayBillsSGGH.size()==0 && #request.listWayBillsSGPY.size()==0">
			<s:if test="(#ghindex.index+1)%6==0 && (#ghindex.index+1) != (#request.listWayBillsSWGH.size())">
			  	<p style="page-break-after:always">&nbsp;</p>
			 </s:if>
		</s:if>	
		<s:else>
			<s:if test="(#ghindex.index+1+(6-(#request.listWayBillsBQ.size()+#request.listWayBillsOTS.size()+#request.listWayBillsPY.size()+#request.listWayBillsGH.size()+#request.listWayBillsSGGH.size()+#request.listWayBillsSGPY.size())%6))%6==0 && (#ghindex.index+1) != (#request.listWayBillsSWGH.size())">
			  	<p style="page-break-after:always">&nbsp;</p>
			 </s:if>
		</s:else>		
	</s:if>
	<s:else>
		<s:if test="#request.listWayBillsBQ.size()==0 && #request.listWayBillsOTS.size()==0 &&  #request.listWayBillsPY.size()==0 && #request.listWayBillsGH.size()==0 && #request.listWayBillsSGGH.size()==0 && #request.listWayBillsSGPY.size()==0">
			<s:if test="(#ghindex.index+1)%6==0">
			  	<p style="page-break-after:always">&nbsp;</p>
			 </s:if>
		</s:if>	
		<s:else>
			<s:if test="(#ghindex.index+1+(6-(#request.listWayBillsBQ.size()+#request.listWayBillsOTS.size()+#request.listWayBillsPY.size()+#request.listWayBillsGH.size()+#request.listWayBillsSGGH.size()+#request.listWayBillsSGPY.size())%6))%6==0">
			  	<p style="page-break-after:always">&nbsp;</p>
			 </s:if>
		</s:else>	
	</s:else>
  </s:iterator>   
  </body>
</html>
