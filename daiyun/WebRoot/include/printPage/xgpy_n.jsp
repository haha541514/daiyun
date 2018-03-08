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
      <s:iterator var="totalSize" value="#request.listWayBillsPY" status="pyindex">
      <s:set var="bean" value="#totalSize"/>
	  <table align="center" style="margin-top:0.5cm;">
		  <tr><td>	
<div>
<table align="center" cellpadding="0" cellspacing="0" style="border:1px dashed #999999;margin-top:0px; width:7.6cm; height:8.2cm;border-collapse: collapse;">
  <tr><td width="299" ><table  align="center" cellpadding="0" cellspacing="0" style="margin-bottom: 5px;marign-top:1px; border-collapse: collapse;font-size:13px;width:7.4cm;">
  <tr>
    <td align="left" width="150"><table style="border:1px #000000 solid;font-size:13px;text-align:center;margin-left:2px;padding-right:5px;margin-top:4px;" cellpadding="0" cellspacing="0">
      <tr>
        <td width="130"  height="40" style="font-size:10px;"> IF UNDELIVERED PLEASE<br/>
          RETURN TO KEA BOX<br/>
          68203 HONG KONG </td>
      </tr>
    </table></td>
    <td align="right"><table width="142" style="border:1px #000000 solid;font-size:13px;text-align:center;padding-left:2px;margin-right:2px;margin-top:4px;" cellpadding="0" cellspacing="0">
      <tr>
        <td width="90" height="40" style=" border-right:1px solid #000000;padding-left:2px;padding-right:2px;font-size:10px;">POSTAGE&nbsp;PAID<br/>
          &nbsp;&nbsp;HONG&nbsp;KONG<br/>
          &nbsp;&nbsp;&nbsp;POST&nbsp;PAYE</td>
        <td width="42" style="padding-left:2px;padding-right:2px;font-size:10px;">PERMIT<br/>
          NO.<br/>
          <strong>
            <s:if test="@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('HK_NR'), #bean.Cwdt_code_signin)==null"> 5335 </s:if>
            <s:else>
              <s:property value="@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('HK_NR'), #bean.Cwdt_code_signin)" />
            </s:else>
          </strong></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td valign="top" style="padding-top:2px;" align="left"><table width="142" height="28" cellpadding="0" cellspacing="0" style="border:1px solid #000000;margin-left:0px; font-weight:bold;font-size:12px; text-align:center;">
      <tr>
        <td style="font-size:10px;padding-right:2px;">BY&nbsp; AIR&nbsp;MAIL</td>
      </tr>
      <tr>
        <td style="font-size:10px;padding-right:2px;">航&nbsp;PARAVION&nbsp;空</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="16" style="font-size:13px;" colspan="2"><div align="left"> <b>To:<span style="font-size:10px;">
	<s:property value="#bean.Hwhw_consigneename"/>
    </span></b></div></td>
  </tr>
  <tr>
    <td colspan="2"><div align="left"  style="font-size:11px;"><span>
    <s:property value="#bean.Hwhw_consigneeaddress1"/><br/>
 	<s:property value="#bean.Hwhw_consigneeaddress2"/><br/>
   	<s:property value="#bean.Hwhw_consigneeaddress3"/><br/>
   	<s:property value="#bean.Hwhw_consigneecity"/>&nbsp;&nbsp;&nbsp;<s:property value="#bean.Hwhw_consigneepostcode"/><br/>  	
    </span> </div></td>
  </tr>
  <tr>
    <td colspan="2" style="font-size:11px;height:18px;"><div align="left"><b> <span>
    <s:if test="#bean.Dtdt_ename != null && #bean.Dtdt_ename.length()>27">
    	<s:property value="#bean.Dtdt_ename.substring(0,27)"/><br/>
    	<s:property value="#bean.Dtdt_ename.substring(28,#bean.Dtdt_ename.length())"/>  
    </s:if>
    <s:else>
      <s:property value="#bean.Dtdt_ename"/> 
     </s:else> 
    </span></b></div></td>
  </tr>
  <tr>
    <td height="16" style="font-size:13px;" colspan="2"><div align="left"> <b>Tel:<span>
      <s:property value="#bean.Hwhw_consigneetelephone"/>
    </span></b></div></td>
  </tr>
</table>
  <table width="275" height="135"  align="center" cellpadding="1" cellspacing="1">
              <tr>
               <td height="40" valign="top" align="left" ><table width="61" height="38" cellpadding="0" cellspacing="0" style="border:1px solid #000000;font-size:13px;text-align:center;">
      <tr>
        <td height="16" style="border-bottom:1px solid #000000;text-align:center;font-size:13px;">zone</td>
      </tr>
      <tr>
        <td height="16" style="font-size:13px;"><s:if test="@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('HK_NR'), #bean.Cwdt_code_signin)==null "> &nbsp; </s:if>
        <s:elseif test="(@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('HK_NR'), #bean.Cwdt_code_signin)).equals('')">&nbsp;</s:elseif>
        <s:else>
                <s:property value="@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('HK_NR'), #bean.Cwdt_code_signin)" />
      	</s:else></td>
      </tr>
    </table></td>
				<td rowspan="2" valign="top" align="right"><table width="211" height="79" cellpadding="0" cellspacing="0" style="border:1px solid #000000; font-weight:bold;">
              <tr>
                <td width="211" height="35" align="center" valign="bottom"><table width="200" style=" font-size:13px;font-weight:bold;text-align:center;" cellpadding="0" cellspacing="0">
                    <tr>
                      <td height="15"><span>
                        <s:property value="#bean.Cwcw_ewbcode"/>
                      </span></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td height="38" valign="top"><div align="center"><img src="barcode.br?hrsize=0mm&ewbcode_type=&msg=<s:property value='#bean.Cwcw_ewbcode' />" width="212" 
											style="width: 5.2cm;height: 0.9cm;" /></div></td>
              </tr>
          </table></td>
              </tr>
              <tr>
                <td height="40" valign="top" ><table width="61" height="38" cellpadding="0" cellspacing="0" style="border:1px solid #000000;font-size:13px;text-align:center;">
                    <tr>
                      <td width="60"  height="16" style="font-size:12px;">香港小包</td>
                    </tr>
                    <tr>
                      <td height="16" style="font-size:12px;">平邮</td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2"><table align="center"  style="border:1px solid #000000;font-size:13px;text-align:center;" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="280" style="font-size:11px;text-align:left;">【<s:property value="#bean.Ccoco_labelcode"/>】&nbsp;&nbsp;Ref&nbsp;&nbsp;No:&nbsp;&nbsp;<s:property value="#bean.Cwcw_customerewbcode"/></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2"><table align="center"  style="border:1px solid #000000;font-size:13px;text-align:center;" cellpadding="0" cellspacing="0">
                    <tr height="18" style="font-size:11px;">
                      <td width="67">&nbsp;</td>
                      <td width="67">&nbsp;</td>
                      
                      <td width="170" align="right"><s:date name="date" format="MM/dd hh:mm:ss"/></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
				<td style="font-size:11px;" height="16" colspan="3" align="left">
				<s:property value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@getDescription(#bean.Cwcw_code)" /></td>
			</tr>
        </table>
	</td></tr>	
</table> </div>
</td></tr></table>
		<s:if test="#request.listWayBillsGH.size()==0 && #request.listWayBillsSGGH.size()==0 && #request.listWayBillsSGPY.size()==0 && #request.listWayBillsSWGH.size()==0 && #request.listWayBillsOTSR.size()==0">
      	<s:if test="(#pyindex.index+1) != #request.listWayBillsPY.size()">
      		<p style="page-break-after:always">&nbsp;</p>
      	</s:if>
      </s:if>
      <s:else>
      	<p style="page-break-after:always">&nbsp;</p>
      </s:else>		
	</s:iterator>
  </body>
</html>
