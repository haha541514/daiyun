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
    
    <title>std</title>
    
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
    <s:iterator var="listForSTD" value="#request.listForSTD" status="stdIndex">
   
		<br/>
          	<div align="center" style="font-size:40px">
			<b >Proforma Invoice</b>
            </div>
            <center>
          <table width="961" height="274">
          
		  <tr >
            <td colspan="3"  style="margin-top:-4px">
              <div align="right" style="margin-right:0.5cm;">
              	<b style="font-size: 20">Airwaybill No.</b>
              </div>
            </td>
            <td width="283"  align="left" style="font-size:18px;">
            
             <div  style="font-family:Arial, Helvetica, sans-serif;float: left;">
		  		<font style="font-size: 20;"><s:property value="#listForSTD.Cwserverewbcode"/></font>
		  </div>     
      	  <div style="float:left; margin-top: -6px;">
	      	<hr style="width: 330px;border: 2px #000000 solid;"/>
          </div>
            	
            </td>
          </tr>
		  <tr>
		  	<td colspan="4">&nbsp;</td>
		  </tr>
		  <tr >
          <td colspan="3"  style="margin-top:-4px">
	          <div align="right" style="margin-right:1.2cm;">
	          <b style="font-size: 20">DATE:</b>
	          </div>
          </td>
          
          <td width="283"  align="left" style="font-size:18px;">
          <div  style="font-family:Arial, Helvetica, sans-serif;float: left;">
		  		<font style="font-size: 20;"><s:property value="(#listForSTD.Hwsignoutdate).substring(0,10)"/></font>
		  </div>     
      	  <div style="float:left; margin-top: -6px;">
	      	<hr style="width: 330px;border: 2px #000000 solid;"/>
          </div>
		  </td>
          </tr>
		  
		  
            <tr><td colspan="2" align="left" >
            <div style="margin-top:10px;font-size:22px">
			<b style=" margin-left:5px">FROM</b>			</div>
            </td>
            <td colspan="2" align="left">
             <div style="margin-top:10px;font-size:22px">
		  <b style="margin-left:5px">TO</b>		  </div>          </td>
          </tr>
          <tr >
          <td  style="margin-top:-4px">
          <div style="margin-top:9px;font-size:20px">
          <b>Company Name</b><b>:</b>          </div>          </td>
          <td align="left" style="font-size:18px;">
	          <div style="margin-top:9px">
	          <s:property value="#listForSTD.Hwshippercompany"/>
	          </div>          </td>
          <td  style="margin-top:-4px">
          <div style="margin-top:9px;font-size:20px">
          <b>Company Name:</b>          </div>          </td>
          <td width="283"  align="left" style="font-size:18px;">
	          <div style="margin-top:9px">
	          <s:property value="#listForSTD.Hwconsigneecompany"/>
	          </div>          </td>
          </tr>
            <tr>
          <td  align="left" style="font-size:20px;">
          <div style="margin-top:9px;margin-left:2px">
          <b>Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>          </div>          </td>
          <td align="left" style="font-size:18px;">
	          <div style="margin-top:9px">
	          	<s:property value="#listForSTD.Hwshipperaddress1"/>
	          </div>          </td>
          <td  align="left" style="font-size:20px;">
          <div style="margin-top:9px;font-size:20px;margin-left:2px">
          <b>Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>          </div>          </td>
	      <td align="left" style="font-size:18px;">
		      <div style="margin-top:9px">
		      <s:property value="#listForSTD.Hwconsigneeaddress1"/></div>		  </td>
          </tr>
          <tr>
          <td width="156">
          <b>&nbsp;</b>          </td>
	          <td align="left" style="font-size:18px;"><div style="margin-top:9px">
	          <s:property value="#listForSTD.Hwshipperaddress2"/>
	          </div>          </td>
          <td width="160">
          <b>&nbsp;</b>          </td>
          <td  align="left" style="font-size:18px;">
          <div style="margin-top:9px">
          <s:property value="#listForSTD.Hwconsigneeaddress2"/></div></td>
          </tr>
            <tr>
          <td  height="23">&nbsp; </td>
          <td width="342" align="left" style="font-size:18px;">
          <div style="margin-top:9px"><s:property value="#listForSTD.Hwshipperaddress3"/></div></td>
          <td width="160">
          <b>&nbsp;</b>          </td>
          <td  align="left" style="font-size:18px;"><div style="margin-top:9px">
          <s:property value="#listForSTD.Hwconsigneeaddress3"/></div></td>
          </tr>
          <tr>
          <td  height="25">
          <div style="margin-top:10px;font-size:20px;margin-left:0px">
          <b>Contact Name&nbsp;&nbsp;</b>
          <b>:</b>          </div>          </td>
          <td  align="left" style="font-size:18px;">
          <div style="margin-top:9px">
          <s:property value="#listForSTD.Hwshippername"/>
          </div>          </td>
          <td >
         <div style="margin-top:10px;font-size:20px;margin-left:0px">
          <b>Contact Name&nbsp;&nbsp;</b>
          <b>:</b>          </div>          </td>
          <td align="left" style="font-size:18px;">
	          <div style="margin-top:9px">
	          <s:property value="#listForSTD.Hwconsigneename"/>
	          </div>          </td>
          </tr>
          <tr>
          <td >
          <div style="margin-top:10px;font-size:20px">
          <b>Phone No.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
          <b>:</b>          </div>          </td>
          <td  align="left" style="font-size:18px;">
          <div style="margin-top:9px">
          <s:property value="#listForSTD.Hwshippertelephone"/>
          </div>          </td>
          <td >
          <div style="margin-top:10px;font-size:20px">
          <b>Phone No.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
          <b>:</b>          </div>          </td>
          <td align="left" style="font-size:18px;">
          <div style="margin-top:9px">
          <s:property value="#listForSTD.Hwconsigneetelephone"/>
          </div>          </td>
          </tr>
          </table>
         </center>
         <hr style="width:970px; margin-left:-3px;margin-top:0px;border: 2px #000000 solid;"/>
         <table width="965" height="75" style="margin-top:0px">
         	<tr>
          <td width="166">
          <div style="margin-top:10px;font-size:20px;">
          <b>No. of Package</b><b>&nbsp;&nbsp;&nbsp;:</b>
         </div>
          </td>
          <td width="825" align="left" style="font-size:18px;">
          <div style="margin-top:9px">
          	<s:property value="#listForSTD.Cwpieces"/>
          </div>
          </td>
          </tr>
          <tr>
          <td width="166">
          <div style="margin-top:10px;font-size:20px;">
          <b>Total Weight</b>
          <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>
          </div>
          </td>
          <td width="825">
          <div style="margin-top:9px" align="left" style="font-size:18px;">
          <s:property value="#listForSTD.Cwserverchargeweight"/>
          </div>
          </td>
          </tr>
      </table>
         <table width="965">  
         <tr>
          <td width="510px" height="21">
          <div style="margin-top:10px;font-size:24px;">
          <b>TERMS OF DELIVERY&nbsp;&nbsp;:</b>
          
          </div>
          </td>
          <td width="460px">&nbsp;
          </td>
          </tr>
      </table>
          <table align="center" width="965px" cellspacing="0" cellpadding="0" style=" border-collapse: collapse; border: 0px #000000 solid;" >
          	<tr>
            	<td width="160" align="center" style="border-right: 0px;border: 2px #000000 solid;height:28px"><div style="font-size:20px;"><b>Qty(PCS)</b></div></td>
                <td width="450" align="center" style="border: 2px #000000 solid;"><div style="font-size:20px;"><b>Description</b></div></td>
                <td width="160" align="center" style="border: 2px #000000 solid;"><div style="font-size:20px;"><b>Unit Price(USD)</b></div></td>
                <td width="160" align="center" style="border: 2px #000000 solid;"><div style="font-size:20px;"><b>TOTAL</b></div></td>
            </tr>
            
            
             <s:set var="TotalDeclaredValue" value="0" />
             <s:set var="ckcode" value="" />
            <s:iterator var="cargoForUPS" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#listForSTD.Cwcode, #listForSTD.Cwcustomerchargeweight)" status="stas" >
            
            <tr>
            	<td align="center"  style="border: 2px #000000 solid;border-top:0px;border-bottom:0px;border-right: 0px;">
            		<div style="font-family:Arial, Helvetica, sans-serif;">
							<div align="center">
							<font style="font-size: 18px; font-weight:600 "><s:property value='#cargoForUPS.Cicipieces'/></font>
							</div>
		 			</div>
            	</td>
                <td align="center"  style="border: 2px #000000 solid;border-top:0px;border-bottom:0px;font-size: 18px;">
                <div align="center"  style="font-family:Arial, Helvetica, sans-serif;">
                <s:property value='#cargoForUPS.Ciciename'/>
                </div>
                </td>
                <td align="right" style="border: 2px #000000 solid;border-top:0px;border-bottom:0px;">
                	<div style="font-family:Arial, Helvetica, sans-serif;">
							<div align="right" style="margin-right:0.5cm;">
							<font style="font-size: 18px; font-weight:600 "><s:property value='@java.lang.Double@parseDouble(#cargoForUPS.Ciciunitprice)'/></font>
							</div>
		 			</div>
                </td>
                <td align="right" style="border: 2px #000000 solid;border-top:0px;border-bottom:0px;">
                	<div style="font-family:Arial, Helvetica, sans-serif;">
						<div align="right" style="margin-right:0.5cm;">
						<font style="font-size: 18px; font-weight:600 ">
							<s:property value='@java.lang.Double@parseDouble(#cargoForUPS.Cicipieces) * @java.lang.Double@parseDouble(#cargoForUPS.Ciciunitprice)'/>
						
						</font>
						</div>
		 			</div>
              </tr>
            <!-- 计算总金额 -->
            <s:set var="ckcode" value="#cargoForUPS.Ckckcode"/>
    		<s:set var="setTotalDeclaredValue"  value="@java.lang.Double@parseDouble(#cargoForUPS.Cicipieces) * @java.lang.Double@parseDouble(#cargoForUPS.Ciciunitprice)" />
   	 		<s:set var="TotalDeclaredValue" value="#TotalDeclaredValue + #setTotalDeclaredValue" />
            </s:iterator>
             <tr>
            	<td align="center" style="border: 2px #000000 solid;height:25px;border-top:0px;border-bottom:0px;border-right: 0px;">&nbsp;</td>
                <td align="center" style="border: 2px #000000 solid; border-top:0px;border-bottom:0px;">&nbsp;</td>
                <td align="right" style="border: 2px #000000 solid; border-top:0px;border-bottom:0px;">&nbsp;</td>
                <td align="right" style="border: 2px #000000 solid; border-top:0px;border-bottom:0px;">&nbsp;</td>
            </tr>
             <tr>
            	<td align="center" style="border: 2px #000000 solid;height:25px;border-top:0px;border-bottom:0px;border-right: 0px;">&nbsp;</td>
                <td align="center" style="border: 2px #000000 solid; border-top:0px;border-bottom:0px;">&nbsp;</td>
                <td align="right" style="border: 2px #000000 solid; border-top:0px;border-bottom:0px;">&nbsp;</td>
                <td align="right" style="border: 2px #000000 solid; border-top:0px;border-bottom:0px;">&nbsp;</td>
            </tr>
             <tr>
            	<td align="center" style="border: 2px #000000 solid;height:25px;border-top:0px;border-bottom:0px;border-right: 0px;">&nbsp;</td>
                <td align="center" style="border: 2px #000000 solid; border-top:0px;border-bottom:0px;">&nbsp;</td>
                <td align="right" style="border: 2px #000000 solid; border-top:0px;border-bottom:0px;">&nbsp;</td>
                <td align="right" style="border: 2px #000000 solid; border-top:0px;border-bottom:0px;">&nbsp;</td>
            </tr>
            <tr>
            	<td align="center" style="border: 2px #000000 solid;height:25px;border-top:0px;border-right: 0px;">&nbsp;</td>
                <td align="center" style="border: 2px #000000 solid;border-top:0px;">&nbsp;</td>
                <td align="right" style="border: 2px #000000 solid;border-top:0px;">&nbsp;</td>
                <td align="right" style="border: 2px #000000 solid;border-top:0px;">&nbsp;</td>
            </tr>
            <tr>
            	<td align="right" colspan="3" style="border-bottom:0px; border-left:0px; border-right:0px">
            		<div style="font-family:Arial, Helvetica, sans-serif;">
						<div style="margin-right:0.5cm;">
							<div align="right">
							<font style="font-size: 16px;">SubTotal</font>
							</div>
						</div>
		 			</div>
              	</td >
                <td style="border: 2px #000000 solid;height:28px">
                	<div style="font-family:Arial, Helvetica, sans-serif;border-top: 0px;">
						<div style="margin-left:0.3cm;">
							<div align="left" style="float:left;" >
							<font style="font-size: 18px;"><s:property value='#ckcode'/>&nbsp;:</font>
							</div>
							<div align="left" style="float:left;margin-left:0.2cm;" >
							<font style="font-size: 18"><s:property value='#TotalDeclaredValue'/></font>
							</div>
						</div>
		 			</div>
		 		</td>
            </tr>
              <tr>
            	<td align="right" colspan="3" style="border-bottom:0px; border-left:0px; border-right:0px">
            		<div style="font-family:Arial, Helvetica, sans-serif;">
						<div style="margin-right:0.5cm;">
							<div align="right">
							<font style="font-size: 16px;">Shipping cost</font>
							</div>
						</div>
		 			</div>
                </td>
                <td  style="border: 2px #000000 solid;height:28px;border-top: 0px;" >&nbsp;
                </td>
            </tr>
              <tr>
            	<td align="right"  colspan="3" style="border-bottom:0px; border-left:0px; border-right:0px ;border-top: 0px;">
            		<div style="font-family:Arial, Helvetica, sans-serif;">
						<div style="margin-right:0.5cm;">
							<div align="right">
							<b style="font-size: 18">TOTAL</b>
							</div>
						</div>
		 			</div>
          	  	</td>
                <td  style="border: 2px #000000 solid;height:28px;border-top: 0px;">
                	<div style="font-family:Arial, Helvetica, sans-serif;">
						<div style="margin-left:0.3cm;">
							<div align="left" style="float:left;" >
							<font style="font-size: 18px;"><s:property value='#ckcode'/>&nbsp;:</font>
							</div>
							<div align="left" style="float:left;margin-left:0.2cm;" >
							<font style="font-size: 18px;"><s:property value='#TotalDeclaredValue'/></font>
							</div>
						</div>
		 			</div>
                </td>
            </tr>
          </table>
         
         <div style="margin-top:35px;font-size:20px;width:965" >
	         <div style="float: left;margin-left: 2px;">
				<b>Reason for Export&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>
			 </div>
			 <div style="float:left; margin-top: -20px;" >
				<s:if test="#TotalDeclaredValue < 128 ">
					<font style="font-size: 16px;">SAMPLE OF NO COMMERCIAL VALUE</font>
		        </s:if>
		        <s:else>
		        &nbsp;
		        </s:else>
	       		<hr style="width:750px;margin-left:220px; margin-top:-6px;;border: 2px #000000 solid;"/>
	        </div>
        </div>
	    <div align="left" style="width:900px;margin-top:4px;margin-left:-66px;font-size:20px">
        	<b>I declare that the information is true and correct to the best of my knowledge,and that</b>
        </div>
       <div align="left" style="width:900px;margin-top:4px;margin-left:-66px;font-size:20px">
        	<b>the goods are of&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><b>:</b>
      </div>
        
        <div align="left" style="width:900px;margin-top:4px;margin-left:-66px;font-size:20px">
        	<b>I certify that the contents of this shipment are as stated above.</b>
        </div>
        
        
        <s:if test='(#stdIndex.index+1) < #request.listForSTD.size()'>
			<p style="page-break-after:always">&nbsp;</p>
		</s:if>
</s:iterator>
  </body>
</html>
