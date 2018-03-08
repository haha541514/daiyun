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
		  <tr>
		    <td style="width:9cm;" valign="top"><div>
                <table align="center" cellpadding="0" cellspacing="0" style=" border-collapse: collapse; border: 2px #000000 solid;width: 7.6cm;height:8.2cm;" >
                  <tr>
                    <td height="5" colspan="3" style="border: 2px #000000 solid;height: 1cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
                        <div style="margin-left:0.3cm;">
                          <div align="left" style="float: left;"> <b style="font-size:14px">CUSTOMS</b><br/>
                              <b style="font-size:14px">DECLARATION</b> </div>
                          <div align="left" style="float: left; margin-top:4px; margin-left:0.5cm;"> <b style="font-size:12px">May be opened</b><br/>
                              <b style="font-size:12px">officially</b> </div>
                          <div align="left" style="float: left; margin-top:4px; margin-left:0.5cm;"> <b style="font-size:14px">CN22</b><br/>
                          </div>
                        </div>
                    </div></td>
                  </tr>
                  <tr>
                    <td height="5" colspan="3" style="border: 2px #000000 solid;height: 1cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
                        <div style="margin-left:0.3cm;">
                          <div align="left" style="float: left;"> <b style="font-size:10px">Postal administration</b><br/>
                          </div>
                          <div align="left" style="float: left; margin-top:4px; margin-left:0.3cm;"> <b style="font-size:14px;">Important!</b><br/>
                              <b style="font-size:9px;font-family:Arial, Helvetica, sans-serif;margin-bottom: 5px;">See instructions on the back</b> </div>
                        </div>
                    </div></td>
                  </tr>
                  <tr>
                    <td height="10" colspan="3" style="border: 2px #000000 solid;height:1.2cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
                        <div style="margin-left:0.2cm;">
                          <div align="left" style="float: left; margin-top: 1px;">
                            <input name="checkbox" type="checkbox" />
                            &nbsp;<b style="font-size:11px;">Gift</b><br/>
                            <input name="checkbox2" type="checkbox"  />
                            &nbsp;<b style="font-size:11px;">Documents</b><br/>
                          </div>
                          <div align="left" style="float: left; margin-top: 1px;margin-left:0.2cm;width:4.5cm;">
                            <input name="checkbox2" type="checkbox"/>
                            <b style="font-size:11px">Commricial sample</b><br/>
                            <input name="checkbox2" type="checkbox" />
                            <b style="font-size:11px">Other </b><span style="font-family:Arial, Helvetica, sans-serif;font-size:9px;">Tick one of more boxes</span><br/>
                          </div>
                        </div>
                    </div></td>
                  </tr>
                  <tr>
                    <td width="165" style="border: 2px #000000 solid;font-size:11px; width:4cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
                        <div align="left" style="margin-left:0.2cm;width:4cm;font-size:10px; "> <b>Quantity and detailed discription of contents (1)</b> </div>
                    </div></td>
                    <td width="69" style="border: 2px #000000 solid;font-size:11px;width: 1.5cm;"><div style="font-family:Arial, Helvetica, sans-serif;width:1.5cm;">
                        <div align="left" style="margin-left:0.1cm;font-size:10px;"> <b>Weight</b><br/>
                            <b>(In kg)</b> </div>
                    </div></td>
                    <td width="49" style="border: 2px #000000 solid;font-size:11px;width: 1.3cm;"><div style="font-family:Arial, Helvetica, sans-serif;">
                        <div align="left" style="margin-left:0.1cm;font-size:10px;"> <b>value</b><br/>
                            <b>(3)</b> </div>
                    </div></td>
                  </tr>
                  <!-- 循环输出 -->
                  <s:set var="bean" value="#totalSize"/>
                  <s:iterator var="cargoInfo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryAndweightByCwCode(#bean.Cwcw_code, #bean.Cwcw_customerchargeweight)" status="sta">
                    <tr>
                      <td  style="font-size:11px; border: 2px #000000 solid;  height: auto;"><div style="font-family:Arial, Helvetica, sans-serif;width:4cm;">
                          <div align="left" style="margin-left:0.2cm;width:4cm;font-size:8px;"> <b>
                            <s:property value="#cargoInfo.Ciciename"/>
                            </b> &nbsp;&nbsp;<b>(
                              <s:property value="#cargoInfo.Ciciattacheinfo"/>
                              )</b> &nbsp;&nbsp;<b>(
                                <s:property value="#cargoInfo.Ciciremark"/>
                                )</b> </div>
                      </div></td>
                      <td style="font-size:11px; border: 2px #000000 solid;"><div style="font-family:Arial, Helvetica, sans-serif;width: 1.5cm;font-size:10px;">
                          <div align="left" style="margin-left:0.1cm;"> <b>
                            <s:property value="#cargoInfo.Cicihscode"/>
                          </b> </div>
                      </div></td>
                      <td style="font-size:12px; border: 2px #000000 solid;"><div style="font-family:Arial, Helvetica, sans-serif;">
                          <div align="left" style="margin-left:0.1cm;font-size:10px;"> <b>$
                            <s:property value="#cargoInfo.Cicitotalprice" />
                          </b> </div>
                      </div></td>
                    </tr>
                    <!-- 设置累加重量和价格 -->
                    <s:set var="setPrice"  value="@java.lang.Double@parseDouble(#cargoInfo.Cicitotalprice)" />
                    <s:set var="setPieces" value="@java.lang.Integer@parseInt(#cargoInfo.Cicipieces)" />
                    <s:set var="totalPrice" value="#totalPrice+#setPrice"  />
                    <s:set var="totalPieces" value="#totalPieces+#setPieces"  />
                  </s:iterator>
                  <tr>
                    <td style="border: 2px #000000 solid;height: 1.1cm;"><div style="font-family:Arial, Helvetica, sans-serif;width:4cm;">
                        <div align="left" style="margin-left:0.2cm;font-size: 11px;width:4cm; font-size:10px;"> <b>For commercial iterms only
                          if known,HS tariffnurmber(4) and
                          country of oright of goods(5)</b> </div>
                    </div></td>
                    <td rowspan="2" style="border: 2px #000000 solid;"><div style="font-family:Arial, Helvetica, sans-serif;font-size: 11px;width: 1.5cm;">
                        <div align="left" style="margin-left:0.1cm; font-size:10px;"> <b>Total Weight</b><br/>
                            <b>(In kg)</b><br/>
                            <b>(
                              <s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_customerchargeweight)"/>
                              )</b> </div>
                    </div></td>
                    <td rowspan="2" style="border: 2px #000000 solid;font-size: 11px;"><div style="font-family:Arial, Helvetica, sans-serif;">
                        <div align="left" style="margin-left:0.1cm;font-size:10px;"> <b>total value</b><br />
                            <b>(
                              <s:property value="#totalPrice" />
                              )</b> </div>
                    </div></td>
                  </tr>
                  <tr>
                    <td style="border: 2px #000000 solid;font-size: 11px;"><div style="font-family:Arial, Helvetica, sans-serif;width:4cm;">
                        <div align="left" style="margin-left:0.2cm;width:4cm; font-size:10px;"> <b>Total Pieces(
                          <s:property value="#totalPieces" />
                          )</b> </div>
                    </div></td>
                  </tr>
                  <tr>
                    <td colspan="3" style="font-size:11px; border: 2px #000000 solid;height: auto; width:7cm;"><div style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 2px;width:270px;">
                        <div align="left" style="margin-left:0.2cm;font-size:10px;"> <b>I,the undersigned,whose name and address are given on the item,
                          certify that particulars given in this declaration are correct and
                          that this item dose not contain any dangerous article or artices 
                          prohibired by legisation or by postal or customs regulations Date
                          and sender's signature(8) </b> </div>
                    </div></td>
                  </tr>
              </table></div>
<p style="page-break-after:always">&nbsp;</p>
					<div>
                  <table border="1" align="center" cellpadding="0" cellspacing="0" style="width:7.6cm;height:8.2cm; border-collapse: collapse; border: 2px #000000 solid;" >
                    <tr>
                      <td colspan="3" style="border: 2px #000000 solid;" align="center"><!-- 收件人信息 -->
                          <table border="0" cellpadding="0" cellspacing="2" width="7.6cm" height="298">
                            <tr>
                              <td colspan="2"  width="88"><div style="font-family:Arial, Helvetica, sans-serif;">
                                  <div align="left" style="margin-left:0.2cm; margin-top: 1.4cm;">
                                    <%--<b><s:property value="#bean.Cwcw_customerewbcode"/></b>
					        	--%>
                                    <b>
                                      <s:property value="#bean.Cwcw_ewbcode"/>
                                    </b> </div>
                              </div></td>
                            </tr>
                            <tr>
                              <td><div style="font-family:Arial, Helvetica, sans-serif;">
                                  <div align="left" style="margin-left:0.2cm;">
                                    <%--<b><s:property value="#bean.Ccoco_labelcode"/>&nbsp;&nbsp;<s:property value="#bean.Chnchn_sname"/></b>
				        --%>
                                    <b>
                                      <s:property value="#bean.Cwcw_customerewbcode"/>
                                    </b> </div>
                              </div></td>
                            </tr>
                            <!-- 商品 -->
                            <s:iterator var="cargo" value="@kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand@queryByCwCode(#bean.Cwcw_code)" status="sta">
                              <tr>
                                <td colspan="2" width="310"><div style="font-family:Arial, Helvetica, sans-serif;margin-bottom: 5px;">
                                    <div align="left" style="margin-left:0.2cm;margin-right:0.1cm;margin-bottom :0.5cm;  font-size: 11px;" > [
                                        <s:property value="#cargo.Ciciename"/>
                                      ]
                                      &nbsp;&nbsp;[
                                      <s:property value="#cargo.Ciciattacheinfo"/>
                                      ]
                                      &nbsp;&nbsp;[
                                      <s:property value="#cargo.Ciciremark"/>
                                      ]
                                      &nbsp;&nbsp;[
                                      <s:property value="#cargo.Cicipieces"/>
                                      ]/ </div>
                                </div></td>
                              </tr>
                            </s:iterator>
                            <tr>
                              <td colspan="2"><div align="left" style="margin-left:0.2cm;"> <b style="font-size:12px">To Name：</b><span style="font-size:10px;">
                                <s:property value="#bean.Hwhw_consigneename"/>
                              </span> </div></td>
                            </tr>
                            <tr>
                              <td height="17" colspan="2"><div align="left" style="margin-left:0.2cm;"> <b style="font-size:12px">To Address：</b><span style="font-size:10px;">
                                <s:property value="#bean.Hwhw_consigneeaddress1"/>
                                  <s:property value="#bean.Hwhw_consigneeaddress2"/>
                                  <s:property value="#bean.Hwhw_consigneecity"/>
                                  <s:property value="#bean.Hwhw_consigneeaddress3"/>
                              </span> </div></td>
                            </tr>
                            <tr>
                              <td colspan="2" ><div align="left" style="margin-left:0.2cm;"> <b style="font-size:12px">Zipcode：</b><span style="font-size:10px;">
                                <s:property value="#bean.Hwhw_consigneepostcode"/>
                              </span> </div></td>
                            </tr>
                            <tr>
                              <td colspan="2"><div align="left" style="margin-left:0.2cm;"> <b style="font-size:12px">Country：</b><span style="font-size:10px;">
                                <s:property value="#bean.Dtdt_ename"/>
                              </span> </div></td>
                            </tr>
                            <tr>
                              <td colspan="2"><div align="left" style="margin-left:0.2cm;"> <b style="font-size:12px">To Tel：</b><span style="font-size:10px;">
                                <s:property value="#bean.Hwhw_consigneetelephone"/>
                              </span> </div></td>
                            </tr>
                            <tr>
                              <td colspan="2"><div align="left" style="margin-left:0.1cm; margin-bottom: 0.1cm; margin-top: 0.1cm;">
                                  <%--<div style="margin-left: 2.5cm;font-size: 14px;"><b><s:property value="#bean.Cwcw_ewbcode"/></b></div>
						    --%>
                                  <img src="barcode.br?hrsize=0mm&ewbcode_type=BQ&msg=<s:property value='#bean.Cwcw_ewbcode' />" 
											style="width: 7cm;height: 1.6cm;" /> </div></td>
                            </tr>
                        </table>
						
					  </td>
                    </tr>
                  </table></div>
		    </td>
		  </tr>
      </table>
      <s:if test="#request.listWayBillsOTS.size()==0 && #request.listWayBillsPY.size()==0 && #request.listWayBillsGH.size()==0 && #request.listWayBillsSGGH.size()==0 && #request.listWayBillsSGPY.size()==0 && #request.listWayBillsSWGH.size()==0 && #request.listWayBillsOTSR.size()==0">
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
