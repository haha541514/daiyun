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
    
    <title>hunP</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
   <s:iterator var="totalSize" value="#request.listWayBillsHUNG" status="ghindex"> 
   <s:set var="bean" value="#totalSize"/> 
     <table align="center" border="0" cellspacing="0" cellpadding="0" style="margin-top:0.5cm;">
     	<tr valign="top">
     		<td style="width:9.9cm;">
    <table  border="0" cellspacing="0" cellpadding="0" style="width:9.9cm;height:14cm;">
    	<tr valign="top">
    		<td>
    			<div style="width:9.9cm;">  
    				<div style="float:left;height:1.2cm;width:5cm;"><img src="<%=basePath%>images/pzg.jpg" width="171" height="40"/></div>
    				<div style="float: left; height: 1.2cm; width: 4.5cm;"><img src="<%=basePath%>images/PNL_PB1.jpg" width="166" height="42"></div>
    			</div>
    			<p style="width:9.9cm;font-size:9px;-webkit-text-size-adjust:scale(0.8);font-family:Arial, Helvetica, sans-serif;">Return if undeliverable:H-102276,Postbus 7040,3109 AA Schiedam,Netherlands</p>  
    			<div style="clear:both;"></div>
     			<div style="padding-top:0.1cm;padding-left:0.2cm;font-size:13px;font-family:Arial, Helvetica, sans-serif;"><img src="<%=basePath%>images/huan.jpg" style="width:1cm;height:1cm;"/><span style="font-size:28px;margin-left:1.2cm;">R</span>&nbsp;&nbsp;<b>Registered/recommande</b></div>
     			<div style="width:8.8cm;height:1.5cm;margin-left:1cm;margin-bottom:0.1cm;">
     				<img src="barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg=<s:property value='#bean.Cwcw_serverewbcode' />" alt="条码" style="width: 8.3cm;height:1cm;" />
     				<p style="text-align:center;">
          			<s:property value="#bean.Cwcw_serverewbcode"/> 
      			</p>
     			</div> 
    
      <div style="float:left;width:5.5cm;border:1px #000 solid;">   
      		<table border="0" cellspacing="0" cellpadding="0" style="table-layout: fixed;">
      		<tr >
      			<td style="width:3.2cm;"></td>
      			<td style="width:1.1cm;"></td>
      			<td style="width:1.2cm;"></td>
      		</tr>
      		<tr>
      		<td colspan="3" style="border-bottom:1px #000 solid;">
      			<div style="width:5.5cm;font-size:11px;font-family:Arial, Helvetica, sans-serif;">
      			<div style="float:left;width:2.4cm;padding-top:0.1cm;height:0.9cm;border-bottom:1px #000 solid;">
      				<b>CUSTOMS<br/>DECLARATION</b>
      			</div>
      			<div style="float:left;width:3cm;height:0.9cm;font-size:9px;font-family:Arial, Helvetica, sans-serif;border-bottom:1px #000 solid;padding-bottom:0.1cm;">
      				<div style="float:left;width:1.4cm;height:0.9cm;">
      					<span>May be</span><br/>opened<br/>officially
      				</div>
      				<div style="float:left;width:1cm;height:0.4cm;padding-top:0.4cm;margin-left:0.5cm;font-size:13px;">
      					<b>CN 22</b>
      				</div>
      			</div>
      			</div>
      			<div style="width:5.5cm;font-size:11px;font-family:Arial, Helvetica, sans-serif;">
      				<div style="float:left;width:3.5cm;font-size:11px;padding-bottom:0.21cm;">
      					Designated Operator<br/><b>POSTNL</b>
      				</div>      
      				<div style="float:left;width:1.8cm;font-size:9px;">
      					<b style="border-left:1px #000 solid;">Important!</b><br/>
      					See instuctions<br/>on the back
      				</div>
      			</div> 
      			<div style="width:5.5cm;font-size:10px;font-family:Arial, Helvetica, sans-serif;">
      			 <table width="100%" border="0"  cellpadding='0' cellspacing='0' style="border-top:1px #000 solid;"> 
      			 <tr>
      			 	<td colspan="2" height="10px">&nbsp;</td>
      			 </tr>     			
      			 <tr >
      			 	<td align="left" width="40%">
        				<input type="checkbox" />Gift    			
        			</td>
        			<td align="right">
        				<input type="checkbox" />Commerical&nbsp;sample		
        			</td>
        		</tr>
        		 <tr >
        		 	<td align="left" >
        				<input type="checkbox" />Documents    			
        			</td>
        			<td align="right" >
        				<input type="checkbox" checked="checked"/>Other        			
        			</td>
        		 </tr>
        		 <tr height="10px">
        		 	<td colspan="2"  style="text-align:right"><span style="font-size:8px;">Tick one or more boxes</span></td>
        		 </tr>
        		 </table>
      			</div>
      		</td>
      		</tr>
      		
        	<tr style="font-size:9px;font-family:Arial, Helvetica, sans-serif;">
        		<td style="width:125px;border:1px #000 solid;border-top:none;border-left:none;">
        			Quantity and detailed<br/>description of Contents(1)
        		</td>
        		<td style="border-bottom:1px #000 solid;border-right:1px #000 solid;">
        			<b>Weight<br/>(in g)</b>
        		</td>
        			<td style="border-bottom:1px #000 solid;">
        		<b>Value(3)</b>
        		</td>
        	</tr>
        	<tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
          		<td colspan="3" style="margin:none;padding:none;border:none;">
          			<table align="center" border="0" cellspacing="0" cellpadding="0" style="width:5.5cm;height:1.7cm;table-layout: fixed;border-bottom:1px #000 solid;font-size:9px;font-family:Arial, Helvetica, sans-serif;">
          				<s:set var="totalPrice" value="0"  />
          				<s:set var="totalPieces" value="0"  /> 
          				<s:set var="totalCicihscode" value="0" />
          				<s:iterator var="cargoInfo" value="@com.baiqian.web.dax.CargoInfoDemand@queryAndweightByCwCode(#bean.Cwcw_code, #bean.Cwcw_customerchargeweight)" status="sta">
           					<tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
           						<td  align="left" style="width:3.15cm;border-right:1px #000 solid;">
           							<b><s:property value="#cargoInfo.Cicipieces"/> <s:property value="#cargoInfo.Ciciename"/></b>
           						</td>
           						<td style="width:1.05cm;">
           							<b><s:property value="@java.lang.Double@parseDouble(#cargoInfo.Ciciattacheinfo)*1000" /></b>
           						</td>
           						<td style="width:1.2cm;border-left:1px #000 solid;">
           							<b><s:property value="@java.lang.Double@parseDouble(#cargoInfo.Cicitotalprice)" /></b>
           						</td>
           					</tr>
          				<s:set var="setPrice"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicitotalprice)" />
         				<s:set var="setPieces" value="@java.lang.Integer@parseInt(#cargoInfo.Cicipieces)" />
         				<s:set var="totalPrice" value="#totalPrice+#setPrice" />
         				<s:set var="totalPieces" value="#totalPieces+#setPieces"  />
         				<s:set var="setCiciattacheinfo"  value="@java.lang.Double@parseDouble(#cargoInfo.Ciciattacheinfo)" />
         				<s:set var="totalCicihscode" value="#totalCicihscode+#setCiciattacheinfo"  />
         				<s:set var="setCicihscode" value="#cargoInfo.Cicihscode" />
         				</s:iterator>
           			</table>
          		</td>
          </tr>
          <tr valign="top" style="font-size:8px;font-family:Arial, Helvetica, sans-serif;height:38px;">
          		<td style="border-bottom:1px #000 solid;">
          			For commercial items only<br/>if known,HS tariff number(4)<br/>and country of origin of goods(5)
          		</td>
           		<td align="center" rowspan="2" style="border-left:1px #000 solid;border-bottom:1px #000 solid;text-align:center;">
           			Total<br/>weight<br/>(in g)<br/>(6)<br/>
           			<br/><b><s:property value="#totalCicihscode*1000"/></b>
           		</td>
           		<td align="center" rowspan="2" style="border-left:1px #000 solid;border-bottom:1px #000 solid;text-align:center;">
           			Total<br/>value(7)<br/>USD
           			<br/><br/><b><s:property value="#totalPrice" /></b>
           		</td>
          </tr>
          <tr valign="top" style="height:23px;font-size:8px;font-family:Arial, Helvetica, sans-serif;">
           		<td  style="border-bottom:1px #000 solid;">
           			<b><s:property value='#setCicihscode' /><br/><s:property value="#bean.Dtdt_ename"/></b>
           		</td>
          </tr>
         
 		  <tr valign="top" style="font-size:8px;font-family:Arial, Helvetica, sans-serif;">
           		<td colspan="3" style="height:1.8cm;">
              		I, the undersigned, whose name and address are <br/>
              		given on the item, certify that particulars given in <br/>
              		this declaration are correct and that this item does not<br/>
              		contain any dangerous article or artices prohibired by<br/>
              		legislation or by postal or customs regulations<br/>
              		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              		Date and sender's signature(8)
           		</td>
          </tr>
          <tr style="font-size:11px;font-family:Arial, Helvetica, sans-serif;">
             <td  align="left" style="height:0.54cm;">
             	<b>Date:
                 	<%= 
           				new SimpleDateFormat("dd/MM/yyyy").format(Calendar.getInstance().getTime())
                 	%>
                 </b>
             </td>
             <td colspan="2">
                    <b>BQC</b> 
             </td>
           </tr>
        </table>
     </div>
     
      <div style="float:left;width:4.1cm;height:4.7cm;margin-left:0.1cm;border:1px #000 solid;font-size:10px;font-family:Arial, Helvetica, sans-serif;">
          <b><s:property value="#bean.Hwhw_consigneename"/></b><br/>
         <br/><b><s:property value="#bean.Hwhw_consigneeaddress1"/><s:if test="#Hwhw_consigneeaddress2!=null"><s:property value="#bean.Hwhw_consigneeaddress2"/></s:if></b>
         <br/><s:property value="#bean.Hwhw_consigneepostcode"/>         
         <br/><s:property value="#bean.Hwhw_consigneecity"/>
         <br/>
         <br/><s:property value="#bean.Dtdt_ename"/>
         <br/>
         <br/>                      
         <br/><span style="padding-left:35px;"><font size="2" style="font-weight:bold"><s:property value="#bean.Dtdt_hubcode"/></font></span>
         
      </div> 
      <div style="float:left;width:4.1cm;height:4.65cm;margin-left:0.1cm;margin-top:0.1cm;border:1px #000 solid;font-size:10px;font-family:Arial, Helvetica, sans-serif;">
         <div style="margin-left:0.2cm;">
           	customer text<br/><br/>
           	<img  width="120" height="80" src="<%=basePath%>images/LOGO7.jpg" alt=""/><br/><br/>
           	<a href="http://www.1001000.cc">www.1001000.com</a><br/><br/>
          	<img src="barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg=<s:property value='#bean.Cwcw_customerewbcode' />" alt="条码" style="width: 3cm;height:0.58cm;" /><br/>
          	<div style="margin-top:5px;"><s:property value="#bean.Cwcw_customerewbcode"/></div>
      	 </div>
      </div> 
     
    </td>
    </tr>
    </table>
    </td>
    </tr>
    </table>
    </s:iterator>
  </body>
</html>
