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
    <s:iterator var="listForFedex" value="#request.listForFedex" status="fedexIndex">

  <table width="1049" height="714" border="0" align="center" cellpadding="0" cellspacing="0" style=" border-collapse: collapse; border: 0px #000000 solid;">
    <tr>
      <td colspan="2" align="center" style="border: 2px #000000 solid;border-left: 0px;border-top:0px;border-right: 0px;">
      <div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="center" >
				<b style="font-size:20">COMMERCIAL INVOICE</b>&nbsp;&nbsp;&nbsp;<font style="font-size: 16">(商业发票)</font>
			</div>
			<div style="height: 0.5px;">&nbsp;</div>
	  </div>	
      </td>
    </tr>
    <tr>
      <td height="64" colspan="2" style="border: 2px #000000 solid;  ">
      <table width="1049" height="62" border="0" style=" border-collapse: collapse; border: 0px #000000 solid;">
        <tr>
          <td width="117" height="56" style="border: 2px #000000 solid; border-left: 0px;border-top:0px;border-bottom: 0px;">
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="left" style="float: left;">
				<b style="font-size:12">INTERNATIONAL AIR WAYBILL NO.</b><font style="font-size: 14px;" >(国际空运提单号)</font>
				</div>
			</div>
           
          </td>
          <td width="486" align="center" style="border: 2px #000000 solid;border-top:0px;border-bottom: 0px;border-right: 0px;">
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="center" >
					<b style="font-size:22"><s:property value="#listForFedex.Cwserverewbcode"/></b>
				</div>
	  		</div>
          </td>
          <td width="440" style="border: 2px #000000 solid;border-top:0px;border-bottom: 0px;border-right: 0px;">
    		<div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="left" style="float: left;">
				<b style="font-size:12">&nbsp;&nbsp;（Note:all shipments must be accompanied by a FedEx International Air Waybill and two duplicate copies of Cl.）</b><font style="font-size: 12px;" >(请注意：所有货件必须附有FedEx国际运单及两份商业发票副本)</font>
				</div>
			</div>      
        </tr>
      </table>
      </td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid; border-top: 0px;" width="521">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
				<b style="font-size:12">DATE OF EXPORTATION &nbsp;&nbsp;</b><font style="font-size: 12px;" >(发货日期)</font>
				</div>
			</div>
		 </div>	
      </td>
      <td style="border: 2px #000000 solid;border-top: 0px;" width="524">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
				<b style="font-size:12">SHIPPER&#39;S EXPORT REFERENCES(i.e.,order no.,invoice no.)</b><font style="font-size: 12px;" >寄件人发货参考<BR />信息(例如：订单号码，发票号码)</font>
				</div>
			</div>
		 </div>
      </td>
    </tr>
    
    <tr>
      <td style="border: 2px #000000 solid;" align="center">
      	 <div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="center" >
				<b style="font-size:16" ><s:property value="(#listForFedex.Hwsignoutdate).substring(0,10)"/></b>
			</div>
	  	</div>
      </td>
      <td style="border: 2px #000000 solid;" align="center">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="center" >
				<b style="font-size:16"><s:property value="#listForFedex.Cwcustomerewbcode"/></b>
			</div>
	  	</div>
      </td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid; height: auto;border-bottom: 0px;" >
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;margin-right:0.5cm;">
				<div align="left" style="float: left;">
				<b style="font-size:12">
				SHIPPER/EXPORTER(complete name,address,telephone,Business Registration<br/>
				No./Customs/Tax ID No.e.g GST/RFC/VAT/IN/EIN/ABN/SSN,or as locally required)</b><font style="font-size: 12px;" ><br />
				发货人(请填写姓名、地址、电话号码、营业登记号、进口税、税金 ID号如GST/RFC/VAT<br/>/IN/EIN/ABN/SSN,或根据本地海关要求填写其它信息)
				</font>
				</div>
			</div>
		 </div>
      </td>
      <td style="border: 2px #000000 solid;border-bottom: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;margin-right:0.5cm;">
				<div align="left" style="float: left;">
				<b style="font-size:12">
					CONSIGNEE(complete name, address,telephone,Business Registration No./Customs/<br/>Tax IDNo.e.g GST/RFC/VAT/IN/EIN/ABN/SSN,or as locally required)</b><font style="font-size: 12px;" >收货人(请填写姓名、<br/>地址、电话号码、营业登记号、进口税、税金ID号，如GST/RFC/VAT/IN/EIN/ABN/SSN,<br/>或根据本地海关要求填写其它信息) 
				</font>
				</div>
			</div>
		 </div>	
      
      
      </td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid;" rowspan="2">
      <table width="521" height="152" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="100">
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
					<font style="font-size:16">COMPANY:</font>				
				</div>
				</div>   
			</div>      
		 </td>
          <td>
          <div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="left" style="float: left;">
				<b style="font-size:18"><s:property value="#listForFedex.Hwshippercompany"/></b>			
				</div>
		  </div>		 
		  </td>
        </tr>
        <tr>
          <td>
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
					<font style="font-size:16">ATTN:</font>				
				</div>
				</div>   
			</div>          
		</td>
          <td>
			 <div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="left" style="float: left;">
					<b style="font-size:18"><s:property value="#listForFedex.Hwshippername"/></b>				
				</div>
		    </div>
		  </td>
        </tr>
        <tr>
          <td >
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
					<font style="font-size:16">Address:</font>				
				</div>
				</div>   
			</div>         
		</td>
			
          <td >
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="left" style="float: left;">
					<b style="font-size:18"><s:property value="#listForFedex.Hwshipperaddress1"/></b>				
				</div>
		    </div>          
		    </td>
        </tr>
        <tr>
          <td rowspan="2" >&nbsp;</td>
          <td >
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="left" style="float: left;">
					<font style="font-size:16"><s:property value="#listForFedex.Hwshipperaddress2"/></font>				
				</div>
		    </div> 
          </td>
          </tr>
        <tr>
          <td >
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="left" style="float: left;">
					<b style="font-size:18"><s:property value="#listForFedex.Hwshipperaddress3"/></b>				
				</div>
		    </div> 
          </td>
          </tr>
        <tr>
          <td >
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
					<font style="font-size:16">TEL:</font>			
				</div>
				</div>   
			</div>       
			</td>
          <td>
          <div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="center" >
					<b style="font-size:18"><s:property value="#listForFedex.Hwshippertelephone"/></b>				
				</div>
		    </div> 
          </td>
        </tr>
      </table></td>
      <td style="border: 2px #000000 solid;" height="132">
      <table width="526" height="129" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="111" style="border: 2px #000000 solid; border-left: 0px;border-top: 0px; border-right:0px;">
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
						<font style="font-size:16">ATTN:</font>
					</div>
				</div>
			 </div>	
          </td>
          <td width="415" style="border: 2px #000000 solid; border-right: 0px;border-top: 0px;">
          	<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
					<b style="font-size:22"><s:property value="#listForFedex.Hwconsigneename"/></b>				
				</div>
			</div>
          </td>
        </tr>
        <tr>
          <td  style="border: 2px #000000 solid; border-left: 0px;border-top: 0px; border-right:0px;">
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
						<font style="font-size:16">COMPANY:</font>
					</div>
				</div>
			 </div>
          </td>
          <td style="border: 2px #000000 solid; border-right: 0px;border-top: 0px;">
          <div style="font-family:Arial, Helvetica, sans-serif;">
          	<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
					<b style="font-size:22"><s:property value="#listForFedex.Hwconsigneecompany"/></b>				
				</div>
			</div>
			</div>
          </td>
        </tr>
        <tr>
          <td  style="border: 2px #000000 solid; border-left: 0px;border-top: 0px; border-right:0px;height: 40px;">
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
						<font style="font-size:16">ADDR:</font>
					</div>
				</div>
			 </div>
          </td>
          <td  rowspan="2" style="border: 2px #000000 solid; border-right: 0px;border-top: 0px;">
          <div style="font-family:Arial, Helvetica, sans-serif;">
          	<div style="margin-left:0.3cm;">
				<div align="left" >
					<b style="font-size:22"><s:property value="#listForFedex.Hwconsigneeaddress1"/></b>				
				</div>
			</div>
			</div>
			<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" >
						<b style="font-size:16"><s:property value="#listForFedex.Hwconsigneeaddress2"/></b>				
					</div>
				</div>
			</div>
			<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" >
						<b style="font-size:22"><s:property value="#listForFedex.Hwconsigneeaddress3"/></b>				
					</div>
				</div>
			</div>
          </td>
        </tr>
        <tr>
          <td  style="border: 2px #000000 solid; border-left: 0px;border-top: 0px; border-right:0px;height: 40px;">&nbsp;</td>
          </tr>
        <tr>
          <td  style="border: 2px #000000 solid; border-left: 0px;border-top: 0px; border-right:0px;">
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
						<font style="font-size:16">POST CODE:</font>
					</div>
				</div>
			 </div>
          </td>
          <td style="border: 2px #000000 solid; border-top: 0px; border-right:0px;">
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="center" >
					<b style="font-size:22"><s:property value="#listForFedex.Hwconsigneepostcode"/></b>				
				</div>
		</div>
          </td>
        </tr>
        <tr>
          <td  style="border: 2px #000000 solid; border-left: 0px;border-top: 0px; border-right:0px;border-bottom: 0px;">
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div style="margin-left:0.3cm;">
					<div align="left" style="float: left;">
						<font style="font-size:16"> TEL:</font>
					</div>
				</div>
			 </div>
         </td>
          <td style="border: 2px #000000 solid;border-top: 0px; border-right:0px;border-bottom: 0px;">
          	<div style="font-family:Arial, Helvetica, sans-serif;">
				<div align="center" >
					<b style="font-size:22"><s:property value="#listForFedex.Hwconsigneetelephone"/></b>				
				</div>
			</div>
          </td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid;" height="15">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
					<b style="font-size:12">PORTER-IF OTHER THAN CONSIGNEE进口商-如不是收件人请填写此</b>
				</div>
			</div>
		 </div>
      </td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid;border-top: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
					<b style="font-size:12">COUNTRY OF EXPORT</b><font style="font-size: 12">(出口发货国家)</font>
				</div>
			</div>
		 </div>
     </td>
      <td style="border: 2px #000000 solid;border-top: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
					<b style="font-size:14">(complete name, address and telephone)</b><font style="font-size: 12">(填写姓名，地址，电话)</font>
				</div>
			</div>
		 </div>
      </td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.8cm;">
				<div align="left" style="float: left;">
					<b style="font-size:14"> CHINA</b>
				</div>
			</div>
		 </div>
      </td>
      <td style="border: 2px #000000 solid; border-bottom: 0px;" rowspan="9" align="center" height="26px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="center" >
				<font style="font-size:14">Same as Consignee </font>
			</div>
			<div style="height: 0.5px;">&nbsp;</div>
	  </div>
      </td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
					<b style="font-size:12"> REASON FOR EXPORT(e.g.personal gift,return for repair)</b><font style="font-size:12">出口原因</font>
				</div>
			</div>
		 </div>
     </td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.8cm;">
				<div align="left" style="float: left;">
					<font style="font-size:14">SAMPLE</font>
				</div>
			</div>
		 </div>
      </td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
					<b style="font-size:12">COUNTRY OF ULTIMATE DESTINATION</b><font style="font-size:12">(目的地国家)</font>
				</div>
			</div>
		 </div>
      </td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid;border-top: 0px;" align="center">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="center" >
				<font style="font-size:16"><s:property value="#listForFedex.Dthubcode"/></font>
			</div>
	  </div>
      </td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid;border-top: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
					<b style="font-size:12">COUNTRY OF ORIGIN </b>
				</div>
			</div>
		 </div>
      </td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.8cm;">
				<div align="left" style="float: left;">
					<font style="font-size:14">CHINA </font>
				</div>
			</div>
		 </div>
      </td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
					<b style="font-size:12">COUNTRY OF ULTIMATE DESTINATION </b>
				</div>
			</div>
		 </div>
     </td>
    </tr>
    <tr>
      <td style="border: 2px #000000 solid;border-bottom: 0px; height: 28px;" align="center">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="center" >
				<font style="font-size:16"><s:property value="#listForFedex.Dthubcode"/></font>
			</div>
	  </div>
      </td>
    </tr>
    
  </table>
  
  <!-- 产品信息  -->
  
  <table width="1053" height="240" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" width="80" height="70">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">COUNTRY<br />OF<br />ORIGIN<br /></b><font style="font-size: 12;">货物原产国</font> 			
			</div>
			</div>
		 </div>     
	</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" width="70">
		<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">MARK/NO'S<br/></b><font style="font-size: 12;">外包装标识</font>				
			</div>
			</div>
		 </div>	
	</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" width="67">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">TYPE OF PACKAGING<br/></b><font style="font-size: 12;">包装类型 </font>		
			</div>
			</div>
		 </div>      
	</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" width="64">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14"> NO.OF PKGS<br/></b><font style="font-size: 12;">件数 </font>				
			</div>
			</div>
		 </div>     
	 </td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" width="141">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14"> FULL DESCRIPTION OF GOODS<br/></b><font style="font-size: 12;">货品描述  </font>			
			</div>
			</div>
		 </div>     
	</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" width="80">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14"> Material<br/></b><font style="font-size: 12;">质材 </font>		
			</div>
			</div>
		 </div>     
		</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" width="55">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">USE<br/></b><font style="font-size: 12;">用途 </font>				
			</div>
			</div>
		 </div>      
		</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" width="54">
     	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">QTY<br /></b><font style="font-size: 12;">数量  </font>		
			</div>
			</div>
		 </div>     
	</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" width="50">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">UNIT OF MEASURE<br/></b><font style="font-size: 12;">度量单位  </font>				
			</div>
			</div>
		 </div>     
	 </td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" width="120">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">UNIT VALUE<br /></b><font style="font-size: 12;">单价(<b style="font-size:14">USD</b>)  </font>			
			</div>
			</div>
		 </div>      
	</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" width="140">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">TOTAL VALUE<br /></b><font style="font-size: 12;">总价值(<b style="font-size:14">USD</b>)  </font>				
			</div>
			</div>
		 </div>      
	</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; " width="73" >
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">WEIGHT<br /></b><font style="font-size: 12;">重量 </font>			
			</div>
			</div>
		 </div>      
	</td>
    </tr>
    
    
    <tr>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" rowspan="5">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="center" >
				<font style="font-size:16">CHINA</font>			
			</div>
  		</div>      </td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" rowspan="5">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="center" >
				<font style="font-size:16">N/A</font>		
			</div>
  		</div>      
  	</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" rowspan="5">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="center" >
				<font style="font-size:16">carton</font>			
			</div>
  		</div>      
  	</td>
      
      <td colspan="9" height="28" style="border: 2px #000000 solid; border-bottom: 0px;">
      <!-- 货物信息 -->
	  <table height="34" border="0" cellpadding="0px;" cellspacing="0px;" >
	  
	  <!-- 定义变量 -->
	  <s:set var="TotalPieces" value="0" />
	  <s:set var="TotalDeclaredValue" value="0" />
	  <!-- 货物信息  循环读取开始 -->
    	<s:iterator var="cargoInfoForFedex" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#listForFedex.Cwcode, #listForFedex.Cwcustomerchargeweight)" status="stas" >
	       
	        <tr>
	        <!-- 去掉第一行外的其他行 -->
	         <s:if test="#stas.index == 0">
	         <!-- 件数 -->
	        	<td  width="55" height="28px;" style="border: 2px #000000 solid; border-top: 0px; border-left:0px;">
	          		<div style="font-family:Arial, Helvetica, sans-serif;">
						<div align="center" style="margin-left:0.1cm;margin-right:0.1cm;">
						<font style="font-size:16"><s:property value="#listForFedex.Cwpieces"/></font>				
						</div>
			 		</div> 
	         	 </td>
	       	 </s:if>
	       	 <s:if test="#stas.index > 0">
		       	 <td width="54" height="30px;" style="border: 2px #000000 solid; border-top: 0px; border-left:0px;">
		          	<div style="font-family:Arial, Helvetica, sans-serif;">
						<div align="center" style="margin-left:0.1cm;margin-right:0.1cm;" >
						<font style="font-size:16">&nbsp;</font>				
						</div>
				 	</div> 
				 </td>
	       	 </s:if>
	       	 <!-- 去掉第一行外的其他行结束 -->
	       	 <!-- FULL DESCRIPTION OF GOODS货品描述 -->
	          <td width="139" style="border: 2px #000000 solid; border-top: 0px; border-left:0px;">
	          	<div style="font-family:Arial, Helvetica, sans-serif;">
					<div style="margin-left:0.1cm;margin-right:0.1cm;">
						<div align="left" style="float: left;margin-left:0.1cm;margin-right:0.1cm;">
						<font style="font-size:16"><s:property value="#cargoInfoForFedex.Ciciename"/>/</font>				
						</div>
					</div>
			 	</div>
	          </td>
	          <!-- 质材  -->
	          <td width="79" style="border: 2px #000000 solid; border-top: 0px; border-left:0px;">
	          	<div style="font-family:Arial, Helvetica, sans-serif;">
					<div style="margin-left:0.1cm;margin-right:0.1cm;">
						<div align="left" style="float: left;">
						<font style="font-size:16"><s:property value="#listForFedex."/></font>				
						</div>
					</div>
			 	</div>
	          </td>
	           <!-- 用途  -->
	          <td width="55" style="border: 2px #000000 solid; border-top: 0px; border-left:0px;">
	          	<div style="font-family:Arial, Helvetica, sans-serif;">
					<div style="margin-left:0.1cm;margin-right:0.1cm;">
						<div align="left" style="float: left;">
						<font style="font-size:16"><s:property value="#listForFedex."/></font>		
						</div>
					</div>
			 	</div>
	          </td>
	          <!-- 数量   -->
	          <td width="53.5" style="border: 2px #000000 solid; border-top: 0px; border-left:0px;">
		          <div style="font-family:Arial, Helvetica, sans-serif;">
					<div align="center" >
					<font style="font-size:16"><s:property value="#cargoInfoForFedex.Cicipieces"/></font>			
					</div>
			 	</div>
			 </td>
			 <!-- 度量 -->
	          <td id="unitTemp" width="78" style="border: 2px #000000 solid; border-top: 0px; border-left:0px; border-bottom: 0px;">
	          	<div style="font-family:Arial, Helvetica, sans-serif;">
					<div align="center">
					<font style="font-size:16">&nbsp;</font>			
					</div>
			 	</div>
	          </td>
	          
	          <!-- 单价   -->
	          <td width="116" style="border: 2px #000000 solid; border-top: 0px; border-left:0px;">
	          	<div style="font-family:Arial, Helvetica, sans-serif;">
					<div align="center" >
				<font style="font-size:16"><s:property value="@java.lang.Double@parseDouble(#cargoInfoForFedex.Ciciunitprice)"/></font>				
					</div>
				</div>
	          </td>
	          <!-- 总价值    -->
	          <td width="135" style="border: 2px #000000 solid; border-top: 0px; border-left:0px;">
	          	<div style="font-family:Arial, Helvetica, sans-serif;">
						<div align="center" >
						<font style="font-size:16"><s:property value="@java.lang.Double@parseDouble(#cargoInfoForFedex.Cicipieces) * @java.lang.Double@parseDouble(#cargoInfoForFedex.Ciciunitprice)"/></font>				
						</div>
					</div>
	          </td>
	         <!--重量 --> 
	          <td width="64" style="border: 2px #000000 solid; border-top: 0px; border-left:0px; border-right: 0px;">
	          	<div style="font-family:Arial, Helvetica, sans-serif;">
					<div align="center" >
						<font style="font-size:16"><s:property value="@java.lang.Double@parseDouble(#cargoInfoForFedex.Cicihscode)"/></font>				
						</div>
					</div>
	          </td>
	        </tr>
	        <!-- 1.计算件数（票数）。 -->
    		<s:set var="setTotalPieces" value="@java.lang.Integer@parseInt(#cargoInfoForFedex.Cicipieces)"/>
    		<s:set var="TotalPieces" value="#TotalPieces + #setTotalPieces" />
	        <!-- 2.计算总价。 -->
    		<s:set var="setTotalDeclaredValue"  value="@java.lang.Double@parseDouble(#cargoInfoForFedex.Cicipieces) * @java.lang.Double@parseDouble(#cargoInfoForFedex.Ciciunitprice)" />
   	 		<s:set var="TotalDeclaredValue" value="#TotalDeclaredValue + #setTotalDeclaredValue" />
        </s:iterator>
      <!-- 货物信息  循环读取结束 -->
      </table>		 
      </td>
      </tr>
    <tr>
      <td height="28" style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px; border-top : 0px; ">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px; border-top : 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px; border-top : 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px; border-top : 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px; border-top : 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px; border-top : 0px;">
	  	<div style="font-family:Arial, Helvetica, sans-serif;">
						<div align="center">
						<font style="font-size:16">PCS</font>			
						</div>
				 	</div>
	  </td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px; border-top : 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px; border-top : 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-top : 0px;">&nbsp;</td>
    </tr>
    
    <tr>
      <td height="28" style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px; ">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px; ">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px; border-top : 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px;">&nbsp;</td>
    </tr>
    <tr>
      <td height="28" style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px; border-top : 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px;">&nbsp;</td>
    </tr>
    <tr>
      <td height="28" style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;" height="48">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">TOTAL PKGS <br /></b><font style="font-size:12">总件数</font>			
			</div>
			</div>
		 </div>       
	</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">QTY<br /></b><font style="font-size:12">数量</font>
				</div>
		 	</div>
		 </div>    
		</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">OF<br />MEASURE<br /></b><font style="font-size:12">度量单位 </font>			
			</div>
			</div>
		 </div>      
	</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px; border-right: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">TOTAL VALUE <br /></b><font style="font-size:12">总价值(<b style="font-size:14">USD</b>) </font>				
			</div>
			</div>
		 </div>      
	</td>
      <td style="border: 2px #000000 solid; border-bottom: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.1cm;margin-right:0.1cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14">TOTAL WEIGHT <br /></b><font style="font-size:12">总重量 </font>				
				</div>
			</div>
		 </div>      
	</td>
    </tr>
    <tr>
      <td height="28" style="border: 2px #000000 solid; border-right: 0px; border-left: 0px; border-right: 0px;border-bottom: 0px;">&nbsp;
      	
      </td>
      <td style="border: 2px #000000 solid; border-right: 0px; border-left: 0px;border-bottom: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-right: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="center" >
			<font style="font-size:16"><s:property value="#listForFedex.Cwpieces"/></font>				
			</div>
	 	</div>
      </td>
      <td style="border: 2px #000000 solid; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-right: 0px;">&nbsp;</td>
     
      <td style="border: 2px #000000 solid; border-right: 0px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="center" >
			<font style="font-size:16"><s:property value="#TotalPieces"/></font>				
			</div>
	 	</div>
      </td>
       <td style="border: 2px #000000 solid; border-right: 0px;">
       	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="center">
			<font style="font-size:16">PCS</font>		
			</div>
	 	</div>
       </td>
      <td style="border: 2px #000000 solid; border-right: 0px;">&nbsp;</td>
      <td style="border: 2px #000000 solid; border-right: 0px;">
      <div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="center" >
			<font style="font-size:16"><s:property value="#TotalDeclaredValue"/></font>			
			</div>
	 	</div>
      	
      </td>
      <td style="border: 2px #000000 solid; ">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div align="center" >
		<font style="font-size:16"><s:property value="@java.lang.Double@parseDouble(#listForFedex.Cwchargeweight)"/>kg</font>			
			</div>
	 	</div>
      </td>
    </tr>
  </table>
  <table width="1053" height="172" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td colspan="2">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style=" margin-top:0.3cm;">
				<div align="left" style="float: left;">
					<b style="font-size:12">
						I DECLARE ALL THE INFORMATION CONTAINED IN THE INVOICE TO BE TRUE AND CORRECT.
					</b><font style="font-size: 12;">我声明发票上所填信息均真实准确</font>
				</div>
			</div>
		 </div>       
		 </td>
    </tr>
    <tr>
      <td width="413" height="39">
  		<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.2cm;">
				<div align="left" style="float: left;margin-top: 20px;">
				<div  style="font-family:Arial, Helvetica, sans-serif;">
					<div style="margin-left:0.3cm;">
						<div align="left" style="float: left;">
						<b style="font-size:16"><s:property value="#listForFedex.Hwshippername"/></b>				
						</div>
					</div>   
			 	</div> 			
			</div>
			</div>
		 </div>   </td>
      <td width="628">
  		<div style="margin-left:0.2cm;">
			<div align="left" style="float: left;">
			<font style="font-size:12;margin-top: 20px;">
				   职位（请用标志字体填写）				
			</font>				
			</div>
	  	</div>     
	  </td>
    </tr>
    <tr>
      <td rowspan="2" align="left">
      	<div style="margin-left:0.2cm;">
			<div align="left">
				<hr style="width: 250px;border: 2px #000000 solid;"/>
			</div>
			<div style=" font-family:Arial, Helvetica, sans-serif;margin-top: -6px;">
			
			<b>SIGNATURE OF SHIPPER/EXPORTER</b> <font style="font-size: 12px;">发货人签名</font>				
			</div>
	    </div>
	    </td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;
      	
      </td>
    </tr>
    <tr>
      <td  height="28px;">
      	<div style="font-family:Arial, Helvetica, sans-serif;">
			<div style="margin-left:0.3cm;">
				<div align="left" style="float: left;">
				<b style="font-size:14"><s:property value="#listForFedex.Hwshippername"/></b>				
				</div>
			</div>   
	    </div>
      </td>
      <td>
      	<div style="font-family:Arial, Helvetica, sans-serif;margin-left:0.2cm;">
			<div align="left" style="float: left;">
			<b style="font-size:14">
		  	 shipping manager				
		   </b>				
		   </div>
	  	</div>      
	  </td>
    </tr>
    <tr>
      <td rowspan="2" align="left">
      	      
      	<div style="margin-left:0.2cm;">
			<div align="left">
				<hr style="width: 250px;border: 2px #000000 solid;"/>
			</div>
			<div style="font-family:Arial, Helvetica, sans-serif;margin-top: -6px;">
				<b style="font-size:14">NAME(PLEASE PRINT)</b>			
			</div>
		</div>
	</td>
      <td>
      	<div style="font-family:Arial, Helvetica, sans-serif;margin-left:0.2cm;">
			<div align="left" style="float: left;">
				<b style="font-size:14">TITLE(PLEASE PRINT)</b>			
			</div>
		</div>      
	</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>
	  	<div style="font-family:Arial, Helvetica, sans-serif;margin-left:0.2cm;">
			<div align="left" style="float: left;">
				<font style="font-size:12">姓名(请用标志字体填写)</font>			
			</div>
		</div>      
	  </td>
      <td>&nbsp;</td>
    </tr>
  </table>
  	<s:if test="#request.listForSTD.size() == 0 ">
	<s:if test='(#fedexIndex.index+1) < #request.listForFedex.size()'>
		<p style="page-break-after:always">&nbsp;</p>
	</s:if>
	</s:if>
	<s:else>
	<p style="page-break-after:always">&nbsp;</p>
	</s:else>
 </s:iterator>
    
  </body>
</html>
