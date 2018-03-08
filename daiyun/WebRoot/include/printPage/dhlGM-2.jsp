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
	-->
		<style type="text/css">

.fStyle {		
		font-family:Calibri;
		font-size: 7px;
		line-height:1em;
		font-weight:400 ;
}
td{
text-align:left;
}
    </style>
	</head>
  
  <body>
     <s:iterator var="totalSize" value="#request.listWayBillsBQ" status="ghindex">
		<s:set var="bean" value="#totalSize"/>
		<div class="noprint" style="margin-top:0.5cm;"></div>
		<table align="center"><tr><td style="width:9cm;" valign="top">
<table align="center" cellpadding="0" cellspacing="0" border="1" style=" border-collapse: collapse;width:7.9cm;height:8.7cm;" >
          <tr>
            <td  colspan="3" style="border:0;height: 0.5cm;" align="left"><div >
                <div style="margin-left:0.2cm;margin-bottom:0.1cm;font-size:8px;">Bitte Ort und Bestimmungsland immer in GroBbuchstaben angeben </div>
            </div></td>
          </tr>
          <tr style="height:1.5cm;">
            <td height="5" colspan="3" style=" border-bottom: 2px #000000 solid;border-top:1px #ccc solid; "><div style="font-family:Arial, Helvetica, sans-serif;">
                <div style="margin-left:0.2cm;">
                  <div style="width:6.7cm;float:left;line-height:13px;"><font size="-3"  face="Arial Unicode MS" >ZOLLINHALTSERKL?RUNG</font><font class="fStyle">Kann amtlich ge?ffnet werden.<br>
                  </font><font size="-3" face="Arial Unicode MS">D¨¦CLARATION EN DOUANE</font><font class="fStyle">Peut ¨ºtre ouvert d'office. </font></div>
                  <div style="float:left;clear:right;width:0.9cm;font-size:20px; font-family:Myriad Pro Cond; letter-spacing:-1px;">CN&nbsp;22</div>
                  <div style="width:2.4cm; float:left;line-height:11px;margin-top:3px;"><font class="fStyle"> Postverwaltung<br>
                    Administration des postes</font></div>
                  <div style="width:2.5cm; font-family:Myriad Pro Cond; font-size:9px;float:left; " ><img src="<%=basePath%>/images/DHLGlobeMail.jpg" alt="11" width="107" height="24"  style="width:2.7cm;" ></div>
                  <div style="width:2.6cm; float:right;line-height:10px;" ><font class="fStyle"> <b>Wichtig!Important!</b><br>
                    Hinweise auf der Ruckseite<br>
                    Voir instructions au verso </font></div>
                </div>
            </div></td>
          </tr>
          <tr>
            <td height="10" colspan="3" style="border-bottom: 2px #000000 solid;height:0.8cm;"><div style="margin-left:0.2cm;">
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  style="margin-top:-1px;">
                  <tr>
                    <td width="20"><input name="checkbox" type="checkbox"/></td>
                    <td><font class="fStyle" style="line-height: 1em;">&nbsp;Geschenk<br>
                      &nbsp;Cadeau</font></td>
                    <td width="20"><input name="checkbox2" type="checkbox"/></td>
                    <td ><font class="fStyle" style="line-height: 1em;">&nbsp;Dokumente<br>
                      &nbsp;Documents</font></td>
                    <td width="20"><input name="checkbox2" type="checkbox"/></td>
                    <td ><font class="fStyle" style="line-height: 1em;">&nbsp;Warenmuster<br>
                      &nbsp;Echantillon commercial</font></td>
                    <td width="20"><input name="checkbox2" type="checkbox"/></td>
                    <td ><font class="fStyle" style="line-height: 1em;">&nbsp;Sonstige<br>
                      &nbsp;Autre</font></td>
                  </tr>
                </table>
              <div  style="margin-top:-1px;"><font class="fStyle">Bitte ein oder mehrere K?stchen ankreuzen. Coucher la ou les cases appropri¨¦es.</font></div>
            </div></td>
          </tr>
          <tr valign="top">
            <td  style="border-bottom: 2px #000000 solid;border-left:0px;font-size:11px; width:5.1cm; "><div>
                <div align="left" style="margin-left:0.2cm; line-height:1em;width:5cm;"><font class="fStyle">Anzahl und detaillierte Beschreibung des Inhalts(1)<br>Quantit¨¦ et description detaill¨¦e du contenu</font> </div>
            </div></td>
            <td  style="border: 2px #000000 solid;font-size:11px;width: 1.5cm;"><div align="left" style="margin-left:0.1cm;font-size:10px;width:1.4cm;"> <font class="fStyle">Gewicht(in kg)(2)<br>
              Poids (en kg)</font> </div></td>
            <td  style="border: 2px #000000 solid;border-right:0px;font-size:11px;width: 1.3cm;"><div >
                <div align="left" style="margin-left:0.1cm;width:1.1cm;"><font class="fStyle">Wert(3)<br>
                  Valeur</font> </div>
            </div></td>
          </tr>
          <s:set var="bean" value="#totalSize"/>
          <s:iterator var="cargoInfo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#bean.Cwcw_code, #bean.Cwcw_customerchargeweight)" status="sta">
            <tr  valign="top">
              <td  style="font-size:11px; border-bottom: 2px #000000 solid;height:0.5cm;"><div align="left" style="margin-left:0.2cm;"> <font class="fStyle">
                  <s:property value="#cargoInfo.Ciciename"/>
                &nbsp;&nbsp;
                <s:property value="#cargoInfo.Ciciattacheinfo"/>
                &nbsp;&nbsp;
                <s:property value="#cargoInfo.Ciciremark"/>
              </font> </div></td>
              <td valign="top" style="font-size:11px; border: 2px #000000 solid;"><div style="margin-left:0.1cm;width:1.2cm;"><font class="fStyle">
                  <s:property value="#cargoInfo.Cicihscode"/>
              </font></div></td>
              <td valign="top" style="font-size:12px; border: 2px #000000 solid;border-right:0px;"><div style="font-family:Myriad Pro Cond;">
                  <div align="left" style="margin-left:0.1cm;font-size:10px;"></div>
              </div></td>
            </tr>
            <s:set var="setPrice"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicitotalprice)" />
            <s:set var="setPieces" value="@java.lang.Integer@parseInt(#cargoInfo.Cicipieces)" />
            <s:set var="totalPrice" value="#totalPrice+#setPrice"  />
            <s:set var="totalPieces" value="#totalPieces+#setPieces"  />
          </s:iterator>
          <tr>
            <td valign="top" style="border: 2px #000000 solid;border-left:0px;"><div align="left" style="margin-left:0.2cm;back-ground:red;"><font class="fStyle"><b>Nur fur Handelswaren<br>
Pour les envois commerciaux seulement</b><br>
(Falls bekannt)Zolltarifnr.nach dem HS(4) und Ursprungsland per Waren (5)<br>
N¡ã tarifaire du SH et pays d'origine des marchandi-<br>
ses(si connus)</font></div></td>
            <td valign="top"  style="border: 2px #000000 solid;"><div style="margin-left:0.1cm; font-size:10px;width:1.4cm;"><font class="fStyle">Gesamtgewicht <b>(in kg)&nbsp;</b> <b>(6)</b><br>
              Poids total (en kg)</font></div></td>
            <td  valign="top"  style="border: 2px #000000 solid;border-right:0px;font-size: 11px;"><div style="font-family:Arial, Helvetica, sans-serif;">
                <div align="left" style="margin-left:0.1cm;font-size:10px;"> <font class="fStyle"> Gesamtwert (7)<br>
                  Valeur totale </font></div>
            </div></td>
          </tr>
          <tr valign="top">
            <td style="border: 2px #000000 solid;border-left:0px;font-size: 11px; height:0.3cm;"><div align="left" style="margin-left:0.2cm; font-size:10px;height:0.5cm;">CH/NA/RPC</div></td>
            <td style="border: 2px #000000 solid; "><div style="margin-left:0.1cm;"><font class="fStyle">
                <s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_customerchargeweight)"/>
            </font></div></td>
            <td style="border: 2px #000000 solid;border-right:0px; "><div style="margin-left:0.1cm;"><font class="fstyle">
                <s:property value="#totalPrice" />
            </font></div></td>
          </tr>
          <tr>
            <td colspan="3" valign="top" style="font-size:11px; border: 0; width:7.9cm;"><div align="left" style="margin-left:0.2cm; margin-top:0.1cm;  font-size:10px;backround-color:red; width:7.7cm;"> <font class="fStyle">Ich, der/die Unterzeichnende, dessen/deren Name und Adresse auf der Sendung angef¨¹hrt sind, best?tige,dass die in der vorliegenden Zollinhaltserkl?rung angegebenen Daten korrekt sind und dass diese Sendung keine gef?hrlichen, gesetzlich oder auf Grund postalischer oder zollrechtlicher Regelungen verbotenen Gegenst?nde enth?lt. Ich ¨¹bergebe insbesondere keine G¨¹ter, deren Versand, Bef?rderung oder Lagerung gem?? den AGB von Deutsche Post ausgeschlossen ist.<br>
                        <div style=" line-height:-1px;">&nbsp;</div>
						 Je, soussign¨¦ dont le nom et l'addresse figurent sur l'envoi, certifie que les renseignements donn¨¦s dans la pr¨¦sente d¨¦claration sont exacts et que cet envoi ne contient aucun objet dangereux ou interdit par la l¨¦gislation ou la r¨¦glementation postale ou l'entreposage est exclu par les Conditions g¨¦n¨¦rales de Deutsche Post.<br>
                         <div style=" line-height:-1px;">&nbsp;</div>
                         <font style=" font-size:8px;">Datum und Unterschrift des Absenders (8)/Date et signature de l'exp¨¦diteur:</font> </div>
                <div align="left" style="margin-left:0.2cm;border-bottom:dashed 1px #000; width:7.7cm;background-color:red;height:0.01cm;" ></div></td>
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
<tr><td align="left">¡¾ <s:property value="#bean.Ccoco_labelcode"/> ¡¿&nbsp;&nbsp;Ref&nbsp;&nbsp;No:&nbsp;&nbsp;
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
