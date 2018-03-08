<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <style media="print">
	.noprint {display:none;}
  </style>
<script type="text/javascript" src="../js/jquery-1.4.2.js"></script>
    <base href="<%=basePath%>">
    <title>fedex</title>
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
 
 	<s:iterator var="bean" value="#request.listForDHLCN" status="dhlIndex">
   <div style="margin-top: 3.3cm;">&nbsp;</div>
  <table width="1022" height="416" cellpadding="0" cellspacing="0" style=" border-collapse: collapse; border: 0px #000000 solid;">
   <tr>
      <td colspan="4" style="border: 2px #000000 solid;border-bottom:0px; margin-left: 0.2cm;height: 0.6cm;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
				<b style="font-size:18">Sender:</b><br/>
				</div>
			</div>
		 </div>	
      </td>
      <td colspan="4" rowspan="3" style="border: 2px #000000 solid;background-color: #A8A4A5" align="center">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="width: auto;">
				<div align="center" style="float: left;">
				<b style="font-size:40; margin-left: 3.7cm;">Commerical</b><br/>
				<b style="font-size:40; margin-left: 3.7cm;">Invoice</b>
				</div>
			</div>
		 </div>	
	  </td>
    </tr>
	<tr>
      <td height="17" colspan="4" style="border: 2px #000000 solid;border-top:0px;border-bottom:0px; height: 2cm;">
  		<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="margin-top: 0.1cm;">
				<font style="font-size: 13"><s:property value="#bean.Hwshippercompany"/></font><br />
				</div>
				<div align="left" style="margin-top: 0.1cm;">
				<font style="font-size: 13"><s:property value="#bean.Hwshippername"/></font><br />
				</div>
				<div align="left" style="margin-top: 0.1cm;">
				<font style="font-size: 13"><s:property value="#bean.Hwshipperaddress1"/></font>
      			</div>
				<div align="left" style="margin-top: 0.1cm;">
				<font style="font-size: 13"><s:property value="#bean.Hwshipperaddress2"/></font>
      			</div>
				<div align="left" style="margin-top: 0.1cm;">
				<font style="font-size: 13"><s:property value="#bean.Hwshipperaddress3"/></font>
      			</div>
				<div align="left" style="margin-top: 0.1cm;">
				<font style="font-size: 13"><s:property value="#bean.Cocode_Cwcus"/></font>
      			</div>
				<div align="left" style="margin-top: 0.1cm;">
				<font style="font-size: 13"><s:property value="#bean.Hwshipperaccount"/></font>
      			</div>
   		    </div>
      </div>
      </td>
    </tr>
	 <tr>
      <td height="17" colspan="4" style="border: 2px #000000 solid;border-top:0px; height: 0.6cm;">
  		<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;"> 
					<b style="font-size:14">Phone:</b>  
      			</div>
      			<div align="left" style="float: left;margin-left:0.3cm;width:4cm;"> 
					<font style="font-size: 13"><s:property value="#bean.Hwshippertelephone"/></font>
      			</div>
      			<div align="left" style="float: left;margin-left: 0.5cm;"> 
					<b style="font-size:14">Fax:</b>
      			</div>
      			<div align="left" style="float: left;margin-left:0.3cm;"> 
				<font style="font-size: 13"><s:property value="#bean.Hwshipperfax"/></font>
      			</div>
   		    </div>
      	</div>
      </td>
    </tr>
	
     
    <tr>
      <td colspan="4" rowspan="3" style="border: 2px #000000 solid; margin-left: 0.2cm">
      <table width="485" height="89" border="0">
        <tr>
        
          <td>
	          <div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Receiver:</b><br/>
					</div>
				</div>
			 </div>
          </td>
        </tr>
        <tr>
          <td>
			<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="margin-top: 0.1cm;">
				<font style="font-size: 13"><s:property value="#bean.Hwconsigneecompany"/></font><br />
				</div>
				<div align="left" style="margin-top: 0.1cm;">
				<font style="font-size: 13"><s:property value="#bean.Hwconsigneename"/></font><br />
				</div>
				<div align="left" style="margin-top: 0.1cm;">
				<font style="font-size: 13"><s:property value="#bean.Hwconsigneeaddress1"/></font>
      			</div>
				<div align="left" style="margin-top: 0.1cm;">
				<font style="font-size: 13"><s:property value="#bean.Hwconsigneeaddress2"/></font>
      			</div>
				<div align="left" style="margin-top: 0.1cm;">
				<font style="font-size: 13"><s:property value="#bean.Hwconsigneeaddress3"/></font>
      			</div>
				<div align="left" style="margin-top: 0.1cm;">
				<font style="font-size: 13"><s:property value="#bean.HwConsigneecity"/></font>
      			</div>
				<div align="left" style="margin-top: 0.1cm;">
				<font style="font-size: 13"><s:property value="#bean.Hwconsigneeaccount"/></font>
      			</div>
   		    </div>
      </div>
		 </td>
        </tr>
        <tr>
          <td >
			<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;"> 
					<b style="font-size:14">Phone:</b>  
      			</div>
      			<div align="left" style="float: left;margin-left:0.3cm;width: 4cm;"> 
					<font style="font-size: 13"><s:property value="#bean.Hwconsigneetelephone"/></font>
      			</div>
      			<div align="left" style="float: left;margin-left: 0.5cm;"> 
					<b style="font-size:14">Fax:</b>
      			</div>
      			<div align="left" style="float: left;margin-left:0.3cm;"> 
					<font style="font-size: 13"><s:property value="#bean.Hwconsigneefax"/> </font>
      			</div>
   		    </div>
      	</div>	
		</td>
        </tr>
      </table>
      </td>
      <td colspan="4" style="border: 2px #000000 solid; margin-left: 0.2cm ; height: 1cm;" >
      	 <div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Date:</b><br/>
					</div>
	      			<div align="left" style="float: left;margin-left:0.3cm;"> 
					<font style="font-size: 13">
					<s:property value="(#bean.Hwsignoutdate).substring(8,10)"/>.<s:property value="(#bean.Hwsignoutdate).substring(5,7)"/>.<s:property value="(#bean.Hwsignoutdate).substring(0,4)"/>
					</font>
	      			</div>
				</div>
		</div>
	</td>
    </tr>
    <tr>
      <td colspan="4" style="border: 2px #000000 solid; margin-left: 0.2cm;height: 1cm;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Invoice Number:</b><br/>
					</div>
					<!-- 没值 -->
	      			<div align="left" style="float: left;margin-left:0.3cm;"> 
						&nbsp;
	      			</div>
				</div>
		</div>
      </td>
    </tr>
    <tr>
      <td height="23" colspan="4" style="border: 2px #000000 solid; margin-left: 0.2cm;height: 2cm;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Shipment Reference:</b><br/>
					</div>
	      			<div align="left" style="float: left;margin-left:0.3cm;"> 
						<font style="font-size:15"><s:property value="#bean.Cwcustomerewbcode"/></font>  
	      			</div>
				</div>
		</div>
      </td>
    </tr>
    
    <tr>
      <td colspan="4" rowspan="2" style="border: 2px #000000 solid; margin-left: 0.2cm;height: 4cm;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Bill to Third Party:</b><br/>
					</div><br/>
					<div style="height: 3.4cm;">
						<b style="font-size:12">&nbsp;</b><br/>
					</div>
				</div>
		</div>
      </td>
      <td colspan="4" style="border: 2px #000000 solid; margin-left: 0.2cm">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">Comments:</b><br/>
				</div>
				<div align="left" style="float: left;margin-left: 0.3cm;">
				<b style="font-size:12">&nbsp;</b><br/>
				</div>
			</div>
		</div>
      </td>
    </tr>
    <tr>
      <td colspan="4" style="border: 2px #000000 solid; margin-left: 0.2cm">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">Air Waybill Number:</b>
				</div>
				<div align="left" style="float: left;margin-left: 0.3cm;">
					<b style="font-size:19"><s:property value="#bean.Cwserverewbcode"/> </b><br/>
				</div>
			</div>
		</div>
      </td>
    </tr>
    <tr>
      <td width="231" style="border: 2px #000000 solid;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style=" margin-left: 0.1cm; margin-right:0.1cm;border-left :0px;">
					<div align="left" style="float: left;">
						<b style="font-size:14">Full Description Of Goods</b>
					</div>
				</div>
		</div>
       </td>
      <td width="59" style="border: 2px #000000 solid; ">
      	<div style="font-family:Arial, Helvetica, sans-serif;border-left :0px;">
			<div align="center">
			<b style="font-size:14">QTY</b>
			</div>
		</div>
      </td>
      <td width="133" style="border: 2px #000000 solid;">
      	<div style="font-family:Arial, Helvetica, sans-serif;border-left :0px;">
				<div style=" margin-left: 0.1cm; margin-right:0.1cm;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Commodity Code</b>
					</div>
				</div>
		</div>
      </td>
      <td width="66" style="border: 2px #000000 solid;border-left :0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style=" margin-left: 0.1cm; margin-right:0.1cm;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Unit Value</b>
					</div>
				</div>
		</div>
       </td>
      <td width="111" style="border: 2px #000000 solid;border-left :0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style=" margin-left: 0.1cm; margin-right:0.1cm;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Subtotal<br />Value</b>
					</div>
				</div>
		</div>
      </td>
      <td width="99" style="border: 2px #000000 solid;border-left :0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style=" margin-left: 0.1cm; margin-right:0.1cm;">
					<div align="left" style="float: left;">
					<b style="font-size:14"> Unit<br />Net<br />Weight</b>
					</div>
				</div>
		</div>
       </td>
      <td width="72" style="border: 2px #000000 solid;border-left :0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style=" margin-left: 0.1cm; margin-right:0.1cm;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Gross Weight </b>
					</div>
				</div>
		</div>
      </td>
      <td width="249" style="border: 2px #000000 solid;border-left :0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style=" margin-left: 0.1cm; margin-right:0.1cm;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Country Of<br />Manufacture</b>
					</div>
				</div>
		</div>
       </td>
    </tr>
    <!-- 定义变量 -->
    <s:set var="TotalDeclaredValue" value="0" />
    <s:set var="TotalPieces" value="0" />
    
    <!-- 循环读取数据 -->
    <s:iterator var="cargoInfo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#bean.Cwcode, #bean.Cwcustomerchargeweight)" status="sta">
    
    	
    <tr>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style=" margin-left: 0.1cm; margin-right:0.1cm;">
					<div align="left" style="float: left;">
					<font style="font-size:12"><s:property value="#cargoInfo.Ciciename"/></font>
					</div>
				</div>
		</div>
      </td>
      <td style="border: 2px #000000 solid; border-right: 0px;border-bottom: 0px;border-top: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style=" margin-left: 0.1cm; margin-right:0.1cm;">
					<div align="left" style="float: left;">
					<font style="font-size:12"><s:property value="#cargoInfo.Cicipieces"/></font>
					</div>
				</div>
		</div>
      </td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style=" margin-left: 0.1cm; margin-right:0.1cm;">
					<div align="left" style="float: left;">
					<font style="font-size:12"><s:property value="#cargoInfo.Cihscode"/></font>
					</div>
				</div>
		</div>
      </td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style=" margin-left: 0.1cm; margin-right:0.1cm;">
					<div align="left" style="float: left;">
					<font style="font-size:12"><s:property value="@java.lang.Double@parseDouble(#cargoInfo.Ciciunitprice)"/></font>
					</div>
				</div>
		</div>
      </td>
      <td width="113" style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style=" margin-left: 0.1cm; margin-right:0.1cm;">
					<div align="left" style="float: left;">
					<font style="font-size:12"><s:property value="@java.lang.Double@parseDouble(#cargoInfo.Cicipieces) * @java.lang.Double@parseDouble(#cargoInfo.Ciciunitprice)"/></font>
					</div>
				</div>
		</div>
      </td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style=" margin-left: 0.1cm; margin-right:0.1cm;">
					<div align="left" style="float: left;">
					<font style="font-size:12"><s:property value="@java.lang.Double@parseDouble(#cargoInfo.Cicihscode)"/></font>
					</div>
				</div>
		</div>
      </td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style=" margin-left: 0.1cm; margin-right:0.1cm;">
					<div align="left" style="float: left;">
					<font style="font-size:12"><s:property value="@java.lang.Double@parseDouble(#cargoInfo.Cicihscode)"/></font>
					</div>
				</div>
		</div>
      </td>
      <td style="border: 2px #000000 solid;border-bottom: 0px;border-top: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style=" margin-left: 0.1cm; margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<font style="font-size:12">&nbsp;</font>
				</div>
			</div>
		</div>
      </td>
    </tr>
    <!-- 计算多项的和 -->
    <!-- 1.计算总价。 -->
    <s:set var="setTotalDeclaredValue"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicipieces) * @java.lang.Double@parseDouble(#cargoInfo.Ciciunitprice)" />
    <s:set var="TotalDeclaredValue" value="#TotalDeclaredValue + #setTotalDeclaredValue" />
    <!-- 2.计算件数（票数）。 -->
    <s:set var="setTotalPieces" value="@java.lang.Integer@parseInt(#cargoInfo.Cicipieces)"/>
    <s:set var="TotalPieces" value="#TotalPieces + #setTotalPieces" />
    
   </s:iterator>
   <!-- 循环结束 -->
	<tr>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
    </tr>   
    <tr>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid;border-right: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-right: 0px;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid;border-bottom: 0px;border-top: 0px;">&nbsp;</td>
    </tr> 
   
    <tr>
      <td style="border: 0px #000000 solid; margin-left: 0.2cm">&nbsp; </td>
      <td colspan="4" style="border: 2px #000000 solid; margin-left: 0.2cm">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;float: left;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Total Declared Value:</b>
					</div>
					<div align="left" style="float: left;margin-left: 0.5cm;">
					<!-- 数据 -->
					<font style="font-size: 13"><s:property value="#TotalDeclaredValue"/></font>
					</div>
				</div>
				<div style="margin-right:0.3cm;float: right;">
					<div align="left" style="float: left;">
					<font style="font-size: 13"><s:property value="#cargoInfo.Ckckcode"/></font>
					</div>
				</div>
		</div>
       </td>
      <td colspan="3" style="border: 2px #000000 solid; margin-left: 0.2cm">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;float: left;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Total Net Weight:</b>
					</div>
					<div align="left" style="float: left;margin-left: 0.5cm;">
					<!-- 数据 -->
					<font style="font-size: 13"><s:property value="@java.lang.Double@parseDouble(#bean.Cwchargeweight)"/></font>
					</div>
				</div>
				<div style="margin-right:0.3cm;float: right;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Kgs.</b>
					</div>
				</div>
		</div>
      
        </td>
    </tr>
    <tr>
      <td style="border: 0px #000000 solid; margin-left: 0.2cm">&nbsp;</td>
      <td colspan="4" style="border: 2px #000000 solid; margin-left: 0.2cm">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Total Pieces:</b>
					</div>
					<div align="left" style="float: left;margin-left: 1cm;">
					<!-- 数据 -->
					<font style="font-size: 13"><s:property value="#TotalPieces"/></font>
					</div>
				</div>
		</div>
      </td>
      <td colspan="3" style="border: 2px #000000 solid; margin-left: 0.2cm">
      <div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;float: left;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Total Gross Weight:</b>
					</div>
					<div align="left" style="float: left;margin-left: 0.5cm;">
					<!-- 数据 -->
					<font style="font-size: 13"><s:property value="@java.lang.Double@parseDouble(#bean.Cwchargeweight)"/></font>
					</div>
				</div>
				<div style="margin-right:0.3cm;float: right;">
					<div align="left" style="float: left;">
					<b style="font-size:14">Kgs.</b>
					</div>
				</div>
		</div>
      </td>
    </tr>
  </table>
  <table width="1023" height="105" border="0" style="font-family:Arial, Helvetica, sans-serif;">
    <tr>
      <td width="171" height="23">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="left" style="float: left;">
				<b style="font-size:14">Payer Of GST/VAT:</b>
				</div>
		</div>
      
       </td>
      <td colspan="3">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="left" style="float: left;">
					<!-- 数据 -->
					<b style="font-size:14"></b>
				</div>
		</div>
      </td>
    </tr>
    <tr>
      <td>
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="left" style="float: left;">
				<b style="font-size:14"> Harm.Comm.Code:</b>
				</div>
		</div>
      
     </td>
      <td width="309">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="left" style="float: left;">
					<!-- 数据 -->
					<b style="font-size:14"></b>
				</div>
		</div>
      </td>
      <td colspan="2">
      	<div style="font-family:Arial, Helvetica, sans-serif;float: left;">
			<b style="font-size:14"> Currency Code:</b>
		</div>
		<div style="font-family:Arial, Helvetica, sans-serif;float: left;margin-left: 0.5cm;">
			<font style="font-size: 15"><s:property value="#cargoInfo.Ckckcode"/></font>
		</div>
      
      </td>
    </tr>
    <tr>
      <td colspan="2">
      	<div style="font-family:Arial, Helvetica, sans-serif;float:left;">
			<b style="font-size:14">Type Of Export:</b>
		</div>
		<div style="font-family:Arial, Helvetica, sans-serif;float:left;margin-left:0.5cm;">
			<font style="font-size:16">Permanent</font>
		</div>
       </td>
      <td colspan="2">
      <div style="font-family:Arial, Helvetica, sans-serif;float: left;">
			<b style="font-size:14"> Terms Of Trade:</b>
	  </div>
	  <div style="font-family:Arial, Helvetica, sans-serif;float: left; margin-left: 0.5cm;">
		<div style="float: left;">
			<b style="font-size:14"> Duliver Duty Unpaid:</b>
		</div>
		<div align="left" style="float: left;margin-left: 0.3cm;">
			<!-- 数据 -->
			<font style="font-size:18"><s:property value="#bean.Hwconsigneecity"/></font>
		</div>
	  </div>
     </td>
    </tr>
    <tr>
      <td>
      <div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="left" style="float: left;">
				<b style="font-size:14"> Tems Of Payment:</b>
				</div>
		</div>
      </td>
      <td colspan="3">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
					<!-- 数据 -->
					<b style="font-size:14"></b>
				</div>
			</div>
		</div>
      </td>
    </tr>
    <tr>
      <td>
      	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="left" style="float: left;">
				<b style="font-size:14">Reason For Export:</b>
				</div>
		</div>
       </td>
      <td colspan="3">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
					<!-- 数据 -->
					<b style="font-size:14"></b>
				</div>
			</div>
		</div>
      </td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <table width="1029" height="97"  border="0" style="font-family:Arial, Helvetica, sans-serif;">
    <tr>
      <td colspan="4">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="left" style="float: left;">
				<b style="font-size:14">I/We hereby certity that the information of this invoice is true and correct and that the contents of this shipment are as stated above.</b>				</div>
			</div>      
	  </td>
    </tr>
    <!-- 控制高度 -->
     <tr>
      <td colspan="4">&nbsp;</td>
     </tr>
     <tr>
      <td colspan="4">&nbsp;</td>
     </tr>
    <tr>
      <td  colspan="4">
      	<div  style="font-family:Arial, Helvetica, sans-serif;float: left;">
			<b style="font-size:14"> Signature:</b>	
		</div>     
      <div style="float:left;margin-top: 10px;margin-left:0.5cm;">
		<hr style="width: 330px;border: 2px #000000 solid;"/>
      </div>
      	
      </td>
    </tr>
    <tr>
       <td  colspan="4" height="24px;">
      	<div  style="font-family:Arial, Helvetica, sans-serif;float: left;">
			<font style="font-size: 15">Position in Company:</font>	
		</div> 
      </td>
    </tr>
    <tr>
       <td  colspan="4">
      	<div  style="font-family:Arial, Helvetica, sans-serif;float: left;">
			<font style="font-size: 15">Shipping Cousultant: </font>				
		</div>
		<div style="float:left;margin-top: 10px;margin-left:0.1cm;">
			<hr style="width: 330px;border: 1px #000000 solid;"/>
      	</div>
      	<div  style="font-family:Arial, Helvetica, sans-serif;float: left;">
			<font style="font-size: 15">Company Stamp: </font>			
		</div>
      	
      </td>
    </tr>
  </table>
  			<s:if test="#request.listForFedex.size() == 0 && #request.listForSTD.size() == 0">
				<s:if test='(#dhlIndex.index+1) < #request.listForDHLCN.size()'>
					<p style="page-break-after:always">&nbsp;</p>
				</s:if>
			</s:if>
			<s:else>
				<p style="page-break-after:always">&nbsp;</p>
			</s:else>
  
   </s:iterator>
   
</body>
</html>
