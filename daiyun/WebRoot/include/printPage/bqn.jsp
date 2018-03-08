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
    
    <title>bq</title>
    
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
    <s:iterator var="totalSize" value="#request.listWayBillsBQ" status="stas">
		<s:set var="bean" value="#totalSize"/>
		<table align="center" style="margin-top:0.5cm;">
		  <tr><td>	
<div >
		<table align="center" cellpadding="0" cellspacing="0" style="width:7.6cm;border-collapse: collapse; border: 2px #000000 solid;" >
			    <tr>
			    	<td colspan="3" style="border: 2px #000000 solid;" align="center">
					<!-- 收件人信息 -->
				    	<table border="0" cellpadding="0" cellspacing="2" width="7.6cm" height="8.2cm">
							<tr>
				        		<td colspan="2"  width="88">
					        		<div style="font-family:Arial, Helvetica, sans-serif;">
										<div align="left" style="margin-left:0.2cm; margin-top: 1cm;">
					        	<%--<b><s:property value="#bean.Cwcw_customerewbcode"/></b>
					        	--%>		<b><s:property value="#bean.Cwcw_ewbcode"/></b>					        		
										</div>
					    			</div>							</td>
							</tr>
							<tr>
				        		<td>
									<div style="font-family:Arial, Helvetica, sans-serif;">
										<div align="left" style="margin-left:0.2cm;">
				        	<%--<b><s:property value="#bean.Ccoco_labelcode"/>&nbsp;&nbsp;<s:property value="#bean.Chnchn_sname"/></b>
				        --%>
				        					<b><s:property value="#bean.Cwcw_customerewbcode"/></b>										</div>
				    				</div>				        		</td>
			          		</tr>
							<!-- 商品 -->
								<s:iterator var="cargo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryByCwCode(#bean.Cwcw_code)" status="sta">
			      	 		<tr>
								<td colspan="2" width="310">
									<div style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 5px;">
										<div align="left" style="margin-left:0.2cm;margin-right:0.1cm;margin-bottom :0.5cm;  font-size: 11px;" >
											[<s:property value="#cargo.Ciciename"/>]
											&nbsp;&nbsp;[<s:property value="#cargo.Ciciattacheinfo"/>]
											&nbsp;&nbsp;[<s:property value="#cargo.Ciciremark"/>]
											&nbsp;&nbsp;[<s:property value="#cargo.Cicipieces"/>]/										</div>
									</div>								</td>
							</tr>
							</s:iterator>
							<tr>
								<td colspan="2">
									<div align="left" style="margin-left:0.2cm;">
										<b style="font-size:12px">To Name：</b><span style="font-size:10px;"><s:property value="#bean.Hwhw_consigneename"/></span>									</div>								</td>
							</tr>
							<tr>
						        <td colspan="2">
						        	<div align="left" style="margin-left:0.2cm;">
						        	<b style="font-size:12px">To Address：</b><span style="font-size:10px;"><s:property value="#bean.Hwhw_consigneeaddress1"/>
						        	<s:property value="#bean.Hwhw_consigneeaddress2"/>
						        	<s:property value="#bean.Hwhw_consigneecity"/>
						        	<s:property value="#bean.Hwhw_consigneeaddress3"/>
						        	</span>						        	</div>						        </td>
							</tr>
				       		<tr>
				        		<td colspan="2" >
					        		<div align="left" style="margin-left:0.2cm;">
					        			<b style="font-size:12px">Zipcode：</b><span style="font-size:10px;"><s:property value="#bean.Hwhw_consigneepostcode"/></span>					        		</div>				        		</td>
							</tr>
							<tr>
								<td colspan="2">
									<div align="left" style="margin-left:0.2cm;">
										<b style="font-size:12px">Country：</b><span style="font-size:10px;"><s:property value="#bean.Dtdt_ename"/></span>									</div>								</td>
							</tr>
							<tr>
				        		<td colspan="2">
				        			<div align="left" style="margin-left:0.2cm;">
				        				<b style="font-size:12px">To Tel：</b><span style="font-size:10px;"><s:property value="#bean.Hwhw_consigneetelephone"/></span>				        			</div>								</td>
							</tr>
							<tr>
				        		<td colspan="2">
				        			<div align="left" style="margin-left:0.1cm; margin-bottom: 0.1cm; margin-top: 0.1cm;">
						    <%--<div style="margin-left: 2.5cm;font-size: 14px;"><b><s:property value="#bean.Cwcw_ewbcode"/></b></div>
						    --%>
						    			<img src="barcode.br?hrsize=0mm&ewbcode_type=BQ&msg=<s:property value='#bean.Cwcw_ewbcode' />" 
											style="width: 7cm;height: 1.8cm;" />				        			</div>				        		</td>
			          		</tr>
				    	</table>		    		</td>
			  	</tr>
		  </table>
		  </div>
</td></tr></table>
			<s:if test="#request.listWayBillsOTS.size()==0 && #request.listWayBillsPY.size()==0 && #request.listWayBillsGH.size()==0 && #request.listWayBillsSGGH.size()==0 && #request.listWayBillsSGPY.size()==0 &&#request.listWayBillsSWGH.size()==0 &&#request.listWayBillsOTSR.size()==0">
      	<s:if test="(#stas.index+1) != #request.listWayBillsBQ.size()">
      		<p style="page-break-after:always">&nbsp;</p>
      	</s:if>
      </s:if>
      <s:else>
      	<p style="page-break-after:always">&nbsp;</p>
      </s:else>		
	</s:iterator>
  </body>
</html>
