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
     <s:iterator var="totalSize" value="#request.listWayBillsGH" status="ghindex">
     <s:set var="bean" value="#totalSize"/>
	 <table align="center" style="margin-top:0.5cm;">
		  <tr><td>	
<table align="center" style="border:1px dashed #999999; width:7.6cm; height:8.2cm;border-collapse: collapse;" cellpadding="0" cellspacing="0"><tr><td ><table  align="center" cellpadding="0" cellspacing="0" style="margin-bottom: 5px;marign-top:1px; border-collapse: collapse;font-size:13px;width:7.4cm;">
  <tr>
    <td align="left" width="150">
    <table style="border:1px #000000 solid;font-size:13px;text-align:center;margin-left:2px;padding-right:5px;margin-top:4px;" cellpadding="0" cellspacing="0">
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
            <s:if test="@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('HK_R'), #bean.Cwdt_code_signin)"> 5335 </s:if>
            <s:else>
              <s:property value="@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('HK_R'), #bean.Cwdt_code_signin)" />
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
    <td height="16" style="font-size:13px;" colspan="2"><div align="left"> <b>To:<span>
      <s:property value="#bean.Hwhw_consigneename"/>
    </span></b></div></td>
  </tr>
  <tr>
    <td colspan="2"><div align="left"  style="font-size:13px;"><span style="height:90px;">
      <s:property value="#bean.Hwhw_consigneeaddress1"/><br/>
      <s:property value="#bean.Hwhw_consigneeaddress2"/><br/>
      <s:property value="#bean.Hwhw_consigneeaddress3"/><br/>
      <s:property value="#bean.Hwhw_consigneecity"/>
      &nbsp;&nbsp;&nbsp;
      <s:property value="#bean.Hwhw_consigneepostcode"/>
      <br/>
    </span> </div></td>
  </tr>
  <tr>
    <td colspan="2" style="font-size:11px;height:18px;"><div align="left"><b> <span>
      <s:if test="#bean.Dtdt_ename != null && #bean.Dtdt_ename.length()>27">
        <s:property value="#bean.Dtdt_ename.substring(0,27)"/>
        <br/>
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
                <td valign="top"><table width="61" align="right" style="border:1px #000000 solid;text-align:center;font-weight:bold;" cellpadding="0" cellspacing="0">
      <tr>
        <td height="17" style="border-bottom:1px solid #000000;text-align:center;font-size:13px;">zone</td>
      </tr>
      <tr>
        <td height="17" style="font-size:13px;"><s:if test="@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('HK_R'), #bean.Cwdt_code_signin)==null "> &nbsp; </s:if>
        <s:elseif test="(@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('HK_R'), #bean.Cwdt_code_signin)).equals('')">&nbsp;</s:elseif>
        <s:else>
                <s:property value="@kyle.leis.es.price.zone.dax.ZoneDemand@getZnvnameByDistrict(@kyle.leis.es.price.zone.dax.ZoneDemand@getZfCodeByCity('HK_R'), #bean.Cwdt_code_signin)" />
      	</s:else></td>
      </tr>
    </table></td>
				<td rowspan="2" align="right" valign="top"><table width="209" height="78" cellpadding="0" cellspacing="0" style="border:1px solid #000000; font-weight:bold;marign-top:0px;">
                  <tr>
                    <td width="225" height="28" align="right"><table width="210" style="marign-top:0px; font-size:13px;font-weight:bold;text-align:left;" cellpadding="0" cellspacing="0">
                      <tr>
                        <td width="23" rowspan="2" style="font-size:25px;">R</td>
                        <td width="211" style="font-size:11px;">HONG&nbsp;&nbsp;KONG</td>
                      </tr>
                      <tr>
                        <td height="15" style="font-size:11px;"><span>
                          <s:property value="#bean.Cwcw_serverewbcode"/>
                        </span></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="25"><div align="left" style="margin-left:2px;"><img src="barcode.br?hrsize=0mm&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />"  
											style="width: 5.4cm;height: 0.8cm;" /></div></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="40" valign="bottom"><table width="61" height="38" align="center" cellpadding="0" cellspacing="0" style="border:1px solid #000000;font-size:13px;text-align:center;">
                    <tr>
                      <td width="60"  height="16" style="font-size:12px;">香港小包</td>
                    </tr>
                    <tr>
                      <td height="16" style="font-size:12px;">挂号</td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2"><table align="center"  style="border:1px solid #000000;font-size:13px;text-align:center;" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="280" style="font-size:11px;">【<s:property value="#bean.Ccoco_labelcode"/>】&nbsp;&nbsp;Ref&nbsp;&nbsp;No:&nbsp;&nbsp;<s:property value="#bean.Cwcw_customerewbcode"/></td>
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
</table></div>
</td></tr></table>
		<s:if test="#request.listWayBillsSGGH.size()==0 && #request.listWayBillsSGPY.size()==0 && #request.listWayBillsSWGH.size()==0 && #request.listWayBillsOTSR.size()==0">
      	<s:if test="(#ghindex.index+1) != #request.listWayBillsGH.size()">
      		<p style="page-break-after:always">&nbsp;</p>
      	</s:if>
      </s:if>
      <s:else>
      	<p style="page-break-after:always">&nbsp;</p>
      </s:else>			
  </s:iterator>
  </body>
</html>
