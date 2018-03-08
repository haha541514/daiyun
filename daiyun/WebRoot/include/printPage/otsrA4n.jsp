<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>ots</title>
    
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
  	<s:iterator var="listWayBillsOTS" value="#request.listWayBillsOTSR" status="staIndex">
	<s:set var="bean" value="#listWayBillsOTS" />
	<div style="float:left;height:8.2cm;margin-top:0.5cm;margin-left:0.5cm;">	
		<table align="left"><tr><td style="width:10cm;">
		<div style="float:left;">		
    <table align="left" cellpadding="0" cellspacing="0" style=" width:10cm;height:10cm; border-collapse: collapse; border: 2px #000000 solid;">
		<tr>
		    <td colspan="2"  align="center">
			  <div align="left" style="margin-bottom: 0.2cm; margin-top: 0.2cm; width:9.4cm">
				    <div style="margin-left: 4cm;font-size: 14px;"><b><s:property value="#bean.Cwcw_ewbcode"/></b></div>
			      <img src="barcode.br?hrsize=0mm&ewbcode_type=BQ&msg=<s:property value='#bean.Cwcw_ewbcode'/>" width="250" height="63" 
					style="width: 9cm;height: 1.6cm;margin-left:0.2cm;"/>		        </div>
			</td>
		</tr>
		<tr>
		    <td colspan="2" >
		    	<div style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 5px; float: left; margin-right: 0.3cm;">
					<div align="left" style="margin-left:0.2cm; font-size: 13px;" >
						<b>Product：<b style="font-size:12px;"><s:property value="#bean.Pkpk_sename" /></b></b>
					</div>
				</div>
		        <div align="left" style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 5px;float: left;margin-right: 0.3cm;">
					<div align="left" style="font-size: 13px;" >
						<b>Pieces：<b style="font-size:12px;"><s:property value="@java.lang.Integer@parseInt(#bean.Cwcw_pieces)"/></b></b>
		        	</div>
	        	</div>
	        	<div align="left" style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 5px;float: left;">
					<div align="left" style="font-size: 13px;" >
						<b>Weight：<b style="font-size:12px;"><s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_customerchargeweight)"/></b></b>
		        	</div>
		        </div>
		    </td>
		</tr>
		<!-- cw_customerewbcode -->
		<tr>
	        <td colspan="3" align="left">
		    	<div style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 5px;float: left; margin-right: 0.3cm;">
					<div align="left" style="margin-right:0.1cm; margin-left:0.2cm; font-size: 13px;" >
						<b>Reference No<b style="font-size:12px;"><s:property value="#bean.Cwcw_customerewbcode" /></b></b>
					</div>
				</div>
				<div align="left" style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 5px;float: left;margin-right: 0.3cm;">
					<div align="left" style="font-size: 13px;" >
						<b>Declare value：<b style="font-size:12px;"><s:property value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@sumCargovalue(#bean.Cwcw_code)"/></b></b></div>
	        	</div>
			</td>
		</tr>
		<!-- 商品-->
		<s:iterator var="cargo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryByCwCode(#bean.Cwcw_code)" status="sta">
		<tr>
        	<td colspan="3" width="310">
		        <div style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 2px;">
					<div align="left" style="margin-left:0.2cm;margin-right:0.1cm;margin-bottom :0.2cm;  font-size: 11px;" >
		        	[<s:property value="#cargo.Ciciename"/>]
					&nbsp;&nbsp;[<s:property value="#cargo.Ciciattacheinfo"/>]
					&nbsp;&nbsp;[<s:property value="#cargo.Ciciremark"/>]
					&nbsp;&nbsp;[<s:property value="#cargo.Cicipieces"/>]/
		        	</div>
		        </div>
			</td>
		</tr>
		</s:iterator>
		<tr>
		    <td colspan="2" >
			    <div style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 10px;">
					<div align="left" style="margin-left:0.2cm;margin-right:0.1cm; font-size: 11px;" >
						<b><s:if test='#bean.Hwhw_consigneename != "."'>
				    	Recipient:<b style="font-size:10px;"><s:property value="#bean.Hwhw_consigneename"/></b>
				    	</s:if>
				    	<br/>
				    	<b style="font-size:10px;"><s:property value="#bean.Hwhw_consigneecompany"/>&nbsp;&nbsp;&nbsp;<s:property value="#bean.Hwhw_consigneetelephone"/><br/>
				    	<s:if test='#bean.Hwhw_consigneeaddress1 != "."'>
				    		<s:property value="#bean.Hwhw_consigneeaddress1"/>
				    	</s:if>
				    	<s:if test='#bean.Hwhw_consigneeaddress2 != "."'>
				    		<s:property value="#bean.Hwhw_consigneeaddress2"/>
				    	</s:if>
				    	<s:if test='#bean.Hwhw_consigneeaddress3 != "."'>
				    		<s:property value="#bean.Hwhw_consigneeaddress3"/>
				    	</s:if><br/>
				    	<s:property value="#bean.Hwhw_consigneecity"/>
				    	<s:property value="#bean.Hwhw_consigneepostcode"/>
						<br />
				    	<s:property value="#bean.Dtdt_ename"/></b>
				    	</b>
						<br/><br/>
						<b><s:if test='#bean.Hwhw_consigneename != "."'>
				    	Sender:<b style="font-size:10px;"><s:property value="#bean.Hwhw_shippername"/></b>
				    	</s:if>&nbsp;&nbsp;
				    	<b style="font-size:10px;">
				    	<s:if test='#bean.Hwhw_consigneeaddress1 != "."'>
				    		<s:property value="#bean.Hwhw_shipperaddress1"/>&nbsp;&nbsp;
				    	</s:if>
				    	<s:if test='#bean.Hwhw_shipperaddress2 != "."'>
				    		<s:property value="#bean.Hwhw_shipperaddress2"/>&nbsp;&nbsp;
				    	</s:if>
				    	<s:if test='#bean.Hwhw_shipperaddress3 != "."'>
				    		<s:property value="#bean.Hwhw_shipperaddress3"/>&nbsp;&nbsp;
				    	</s:if>
				    	<s:property value="#bean.Hwhw_shippercompany"/></b>
				    	</b>
			    	</div>
		    	</div>
			</td>
		</tr>
		<tr>
		    <td width="90px">
		    	<div style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 2px;">
					<div align="left" style="margin-left:0.2cm;margin-right:0.1cm; font-size: 12px;" >
						<b><s:property value="#bean.Cwcw_customerewbcode"/></b>
		    		</div>
		    	</div>
		    </td>
		    <td width="130px">
			    <div style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 5px;margin-top:10px;">
					<div align="right" style="margin-left:0.5cm;margin-right:0.4cm; font-size: 12px;" >
						<b>&nbsp;
				 		   <!--s:property value="#bean.Chnchn_sname"/-->
				 		</b>
	 		  	 	</div>
				</div>
			</td>
		</tr>
	</table>			
	</div></td></tr></table></div>
	<s:if test="#request.listWayBillsBQ.size()==0 && #request.listWayBillsOTS.size()==0 && #request.listWayBillsPY.size()==0 && #request.listWayBillsGH.size()==0 && #request.listWayBillsSGGH.size()==0 && #request.listWayBillsSGPY.size()==0 && #request.listWayBillsSWGH.size()==0">
		<s:if test="(#staIndex.index+1)%6==0 && (#staIndex.index+1) != (#request.listWayBillsOTSR.size())">
			 <p style="page-break-after:always">&nbsp;</p>
		 </s:if>
	</s:if>	
	<s:else>
		<s:if test="(#staIndex.index+1+(6-(#request.listWayBillsBQ.size()+#request.listWayBillsOTS.size()+#request.listWayBillsPY.size()+#request.listWayBillsGH.size()+#request.listWayBillsSGGH.size()+#request.listWayBillsSGPY.size()+#request.listWayBillsSWGH.size())%6))%6==0 && (#staIndex.index+1) != (#request.listWayBillsOTSR.size())">
			  <p style="page-break-after:always">&nbsp;</p>
		 </s:if>
	</s:else>
</s:iterator>
  </body>
</html>
