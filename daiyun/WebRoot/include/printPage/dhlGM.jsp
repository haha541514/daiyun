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
		font-weight:500 ;
}
td{
text-align:left;
}
    </style>
</head> 
  
<body bgcolor="white">
     <s:iterator var="totalSize" value="#request.listWayBillsDHLGM" status="ghindex">
		<s:set var="bean" value="#totalSize"/>
		<div class="noprint" style="margin-top:0.5cm;"></div>
		<table  align="center"><tr><td style="width:8.6cm; " valign="top">
		<table align="center"  cellpadding="0" cellspacing="0" style="width:6.7cm;cm;font-size:13px; border: 2px #000000 solid; margin-top:0.7cm;">
	<tr style="border:1px thin #000;"><td height="61" colspan="3" valign="top" style="font-size:13px;"  ><div  style=" width:6cm;margin-left:0.3cm; marign-right:0.2cm; margin-top:0.2cm;"><img src="barcode.br?hrsize=0mm&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />" style="width: 6cm;height: 1.4cm;" />		

		        			</div>	</td>
</tr>
<tr   align="center">
                  <td colspan="3"  style="font-size:11px;" valign="top" ><div style=" height:0.4cm; text-align:center"> <s:property value="#bean.Cwcw_serverewbcode"/></div></td>
               
</tr>
		  <tr>
		    <td valign="top" align="left"  ><div ><div style="float:left; width:0.5cm;margin-left:0.2cm;"><font style="font-size:14px;"><b>To:</b></font></div>
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
					<td rowspan="2" valign="middle"><div style="width:0.8cm;height:0.8cm; float:right;border:1px double #000000; text-align:center;margin-right:0.2cm;margin-top:0px; font-size:14px; line-height:25px;"> <b> <s:property value="#bean.Dtdt_hubcode"/>
					</b>
				    </div></td>
				</tr>
				<tr>
					<td width="80%" ><s:property value="#bean.Dtdt_ename"/><s:property value="#bean.Hwhw_consigneecity"/></td>
					
				</tr>
				<tr style="height:0.6cm;">
					<td colspan="2"><b style="font-size:14px;">Tel:</b><span style="font-size:12px;"><s:property value="#bean.Hwhw_consigneetelephone"/></span>	</td>
				</tr>
			</table>
				</div>
			</div></td>
		  </tr>
<tr><td style="height:0.05cm;" valign="bottom">&nbsp;</td>
</tr>
<tr><td height="24" align="left" ><div style=" margin-left:0.6cm; font-size:12px;">【 
  <s:property value="#bean.Ccoco_labelcode"/>】&nbsp;&nbsp;<b>Ref&nbsp;&nbsp;No:</b>&nbsp;&nbsp;
                  <s:property value="#bean.Cwcw_customerewbcode"/></div></td>
</tr>
<tr><td height="20" align="left" valign="top"><div style=" margin-left:0.7cm; font-size:12px;"><s:property value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@getDescription(#bean.Cwcw_code)" /></div></td>
</tr>

</table>
		<p style="page-break-after:always">&nbsp;</p>
	
<table  align="center" cellpadding="0" cellspacing="0" border="0" style=" border-collapse: collapse;width:7.9cm;height:8.4cm;" >
          <tr style="height:1.5cm;">
            <td height="5" colspan="3" style=" border-bottom: 1px #000000 solid;"><div style="font-family:Arial, Helvetica, sans-serif;">
                <div style="margin-left:0.2cm;">
                  <div style="width:6.5cm;float:left;line-height:13px;"><font size="-3"  face="Arial Unicode MS" >ZOLLINHALTSERKLÄRUNG</font><font class="fStyle">&nbsp;Kann amtlich geöffnet werden.<br>
                  </font><font size="-3" face="Arial Unicode MS">DÉCLARATION EN DOUANE</font><font class="fStyle">&nbsp;Peut être ouvert d'office. </font></div>
                  <div style="float:left;clear:right;width:0.9cm;font-size:21px; font-family:Myriad Pro Cond; letter-spacing:-1px;"><b>CN&nbsp;22</b></div>
                  <div style="width:2.3cm; float:left;line-height:11px;margin-top:3px;"><font class="fStyle"> Postverwaltung<br>
                    Administration des postes</font></div>
                  <div style="width:1.9cm; text-align:left; font-family:Calibri; font-size:12px;float:left; margin-top:3px; " ><b>Deutsche Post</b></div>
				  <div style="float:left;"><img src="<%=basePath%>/images/DHLGlobeMail.jpg" alt="11" width="35" height="21" ></div>
                  <div style="width:2.3cm; float:right;line-height:10px;" ><font class="fStyle" > <b>Wichtig!Important!</b><br>
                    Hinweise auf der Ruckseite<br>
                    Voir instructions au verso </font></div>
                </div>
            </div></td>
          </tr>
          <tr>
            <td height="8" colspan="3" style="border-bottom: 1px #000000 solid;height:0.7cm;"><div style="margin-left:0.2cm;">
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  style="margin-top:-1px;">
                  <tr>
                    <td width="20"><table width="3" height="14" align="left" cellpadding="0" cellspacing="0" style="border:1px solid #000000;width:14px;height:14px;">
                      <tr><td width="1">
                      </table></td>
                    <td width="38"><font class="fStyle" style="line-height: 1em;font-size:8px;">Geschenk<br>
                    Cadeau</font></td>
                    <td width="20"><table width="3" height="14" align="left" cellpadding="0" cellspacing="0" style="border:1px solid #000000;width:14px;height:14px;">
                      <tr><td width="1">
                      </table></td>
                    <td width="47"><font class="fStyle" style="line-height: 1em;font-size:8px;">Dokumente<br>
                    Documents</font></td>
                   <td width="20"><table width="3" height="14" align="left" cellpadding="0" cellspacing="0" style="border:1px solid #000000;width:14px;height:14px;">
                      <tr><td width="1">
                      </table></td>
                    <td width="87" ><font class="fStyle" style="line-height: 1em;font-size:8px;">Warenmuster<br>
                    Echantillon commercial</font></td>
                    <td width="20"><table cellpadding="0" cellspacing="0" style="border:1px solid #000000;width:12px;height:12px;"><tr><td style="line-height:11px;">×</td></tr></table></td>
                    <td width="41"><font class="fStyle" style="line-height: 1em;font-size:8px;">Sonstige<br>
                    Autre</font></td>
                  </tr>
                </table>
              <div  style="margin-top:0px;"><font class="fStyle" style="font-size:8px;">Bitte ein oder mehrere Kästchen ankreuzen. Coucher la ou les cases appropriées.</font></div>
            </div></td>
          </tr>
          <tr valign="top">
            <td  style="border-bottom: 1px #000000 solid;border-left:0px;font-size:11px; width:4.7cm; "><div>
                <div align="left" style="margin-left:0.2cm; line-height:1em;width:4.6cm;"><font class="fStyle" style="font-size:8px;">Anzahl und detaillierte Beschreibung des Inhalts(1)<br>Quantité et description detaillée du contenu</font> </div>
            </div></td>
            <td  style="border: 1px #000000 solid;font-size:11px;width: 1.7cm;"><div align="left" style="margin-left:0.1cm;font-size:10px;width:1.6cm;"> <font class="fStyle" style="font-size:8px;">Gewicht(in kg)(2)<br>
              Poids (en kg)</font> </div></td>
            <td  style="border: 1px #000000 solid;border-right:0px;font-size:11px;width: 1.3cm;"><div >
                <div align="left" style="margin-left:0.1cm;width:1.1cm;"><font class="fStyle" style="font-size:8px;">Wert(3)<br>
                  Valeur</font> </div>
            </div></td>
          </tr>

          <s:set var="bean" value="#totalSize"/>
            <tr valign="top" >
              <td  style="font-size:11px; border-bottom: 1px #000000 solid;height:0.1cm; margin-top:0px;"><div style="height:1cm;margin-left:0.2cm;"><div style="width:4cm; float:left;"><s:iterator var="cargoInfo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#bean.Cwcw_code, #bean.Cwcw_customerchargeweight)" status="sta">
			  <div align="left" style="width:4cm; float:left;"> <font class="fStyle" style="font-size:12px; ">
                <b>  <s:property value="#cargoInfo.Ciciename"/>
                &nbsp;&nbsp;
                <s:property value="#cargoInfo.Ciciattacheinfo"/>
                &nbsp;&nbsp;
                <s:property value="#cargoInfo.Ciciremark"/>
              </b></font> </div>
			  </s:iterator>
			  </div>
             </div></td>
              <td style="font-size:11px; border: 1px #000000 solid;"><s:iterator var="cargoInfo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#bean.Cwcw_code, #bean.Cwcw_customerchargeweight)" status="sta">
			  <div style="margin-left:0.1cm;"><font class="fStyle" style="font-size:11px;">
                 <b><s:property value="#cargoInfo.Cicihscode"/></b>
              </font></div>
			  </s:iterator>			  </td>
              <td style="font-size:12px; border:1px #000000 solid;border-right:0px;"><s:set var="totalPrice" value="0" />
			  <s:set var="ckcode"  value="." />       
                    <s:iterator var="cargoInfo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#bean.Cwcw_code, #bean.Cwcw_customerchargeweight)" status="sta">
					<div align="left" style="font-size:10px;"> <font class="fStyle" style="font-size:12px;"> <b>
					 <s:property value="#cargoInfo.Ckckcode"/><s:property value="#cargoInfo.Cicitotalprice" /></b></font></div>
				 <s:set var="ckcode"  value="#cargoInfo.Ckckcode" />       	 
   			 <s:set var="setPrice"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicitotalprice)" />       
            <s:set var="setPieces" value="@java.lang.Integer@parseInt(#cargoInfo.Cicipieces)" />        
            <s:set var="totalPrice" value="#totalPrice+#setPrice"  />
            <s:set var="totalPieces" value="#totalPieces+#setPieces"  />					
</s:iterator>              </td>
            </tr>
            
        

          <tr>
            <td valign="top" style="border: 1px #000000 solid;border-left:0px;"><div align="left" style="margin-left:0.2cm;width:4.6cm;"><font class="fStyle" style="font-size:8px;"><b>Nur fur Handelswaren<br>
Pour les envois commerciaux seulement</b><br>
(Falls bekannt)Zolltarifnr.nach dem HS(4) und Ursprungsland per Waren (5)<br>
N° tarifaire du SH et pays d'origine des marchandises(si connus)</font></div></td>
            <td valign="top"  style="border: 1px #000000 solid;"><div style="margin-left:0.1cm; font-size:10px;width:1.6cm;"><font class="fStyle" style="font-size:8px;">Gesamtgewicht <b>(in kg)&nbsp;</b> <b>(6)</b><br>
              Poids total (en kg)</font></div></td>
            <td  valign="top"  style="border: 1px #000000 solid;border-right:0px;font-size: 11px;"><div style="font-family:Arial, Helvetica, sans-serif;">
                <div align="left" style="margin-left:0.1cm;font-size:10px;"> <font class="fStyle" style="font-size:8px;"> Gesamtwert (7)<br>
                  Valeur totale </font></div>
            </div></td>
          </tr>
          <tr >
            <td style="border: 1px #000000 solid;border-left:0px;font-size: 11px; height:0.25cm;"><div align="left" style="margin-left:0.2cm;width:4.6cm; font-size:10px;height:0.2cm;" class="fstyle"><font class="fStyle" style="font-size:8px;">CHINA/RPC</font></div></td>
            <td style="border: 1px #000000 solid; "><div style="margin-left:0.1cm;"><font class="fStyle" style="font-size:12px;">
              <b>  <s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_customerchargeweight)"/></b>
            </font></div></td>
            <td style="border: 1px #000000 solid;border-right:0px; "><div style="margin-left:0.1cm;"><font class="fStyle" style="font-size:12px;">
              <b>  <s:property value="#ckcode" /><s:property value="#totalPrice" /></b>
            </font></div></td>
          </tr>
          <tr>
            <td colspan="3" valign="top" style="font-size:11px; border: 0;height: auto; width:7.9cm;"><div align="left" style="margin-left:0.2cm; margin-top:0.1cm;  font-size:10px;backround-color:red; width:7.7cm;height:100%; "> <font class="fStyle" style="font-size:8px;">Ich, der/die Unterzeichnende, dessen/deren Name und Adresse auf der Sendung angeführt sind, bestätige,dass die in der vorliegenden Zollinhaltserklärung angegebenen Daten korrekt sind und dass diese Sendung keine gefährlichen, gesetzlich oder auf Grund postalischer oder zollrechtlicher Regelungen verbotenen Gegenstände enthält. Ich übergebe insbesondere keine Güter, deren Versand, Beförderung oder Lagerung gemäß den AGB von Deutsche Post ausgeschlossen ist.<br>
            Je, soussigné dont le nom et l'addresse figurent sur l'envoi, certifie que les renseignements donnés dans la présente déclaration sont exacts et que cet envoi ne contient aucun objet dangereux ou interdit par la législation ou la réglementation postale ou l'entreposage est exclu par les Conditions générales de Deutsche Post.<br>
                         <div style=" line-height:-1px;">&nbsp;</div>
                         <font style=" font-size:8px;">Datum und Unterschrift des Absenders (8)/Date et signature de l'expéditeur:</font></font> </div>
                <div align="left" style="margin-left:0.2cm;marign-top:0.2cm;margin-bottom:0.1cm;border-bottom:dashed 1px #000; width:7.7cm;height:0.4cm;" >
				<font class="fStyle">
				<table style="width:7.7cm;height:0.4cm;" >
				<tr>
					<td style="font-size:10px;"><s:property value="#bean.Hwhw_shippername"/></td>
					<td valign="bottom" style="font-size:13px;width:0.5cm; line-height:12px;"><b>LK</b></td>
					<td style="font-size:10px;text-align:right;width:2.8cm;"><s:property value="#bean.Hwhw_customerlabelprintdate.substring(0,19)"/><br></td>
				</tr>
				</table>
			
				</font>				</div>				</td>
          </tr>
        </table>
</td></tr></table>
	<s:if test="#request.listWayBillsDHLGM.size()!=0">
      	<s:if test="(#ghindex.index+1) != #request.listWayBillsDHLGM.size()">
      		<p style="page-break-after:always">&nbsp;</p>
      	</s:if>
      </s:if>

  </s:iterator>
</body>
</html>
