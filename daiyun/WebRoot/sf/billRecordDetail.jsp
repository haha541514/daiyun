<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@ page import="kyle.leis.eo.finance.billrecord.da.BillrecordColumns"%>
<%@ page import="kyle.leis.eo.billing.receivable.da.ReceivableforbillColumns"%>
<%@ page import="kyle.leis.eo.operation.corewaybill.dax.CorewaybillDemand"%>
<%@ page import="kyle.leis.fs.dictionary.district.dax.DistrictDemand"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>账单明细</title>
<link href="../css/master.css" type="text/css" rel="stylesheet" />
<link href="../css/admin.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <div id="content">
		    <div class="breadcrumbs">
			    您现在的位置&nbsp;<a href="#">首页</a>  <a href="#">会员中心</a>  <span class="word_gray">查看虚拟地址</span>
			</div>
		    <div class="admin_box">
			    <div class="admin_lft">
					<jsp:include page="${pageContext.request.contextPath}/op/tree.jsp" />
				</div>
				<div class="admin_rit_ads">
				    <div class="admin_ads_head">
					    <div class="admin_ads_head_lft">
					    	<h3>账单明细</h3>
						</div>						
					</div>
					<div class="admin_ads_check">
					   <p>
					    <table width="720px" border="0" cellpadding="0" cellspacing="1">
                           <s:set var="BillRecord" value="#request.objBRColumns"></s:set>
							<tr><td>&nbsp;</td></tr>
							<tr>
								<td align="right">帐单标号：</td>
								<td align="left"><s:property value="#BillRecord.Brbrid" /></td>
								<td align="right">公司代码：</td>
								<td align="left"><s:property value="#BillRecord.Cococode" /></td>
							</tr>
							<tr>
								<td align="right">帐单类型：</td>
								<td align="left"><s:property value="#BillRecord.Bkbkname" /></td>
								<td align="right">帐单状态：</td>
								<td align="left"><s:property value="#BillRecord.Brsbrsname" /></td>
							</tr>
							<tr>
								<td align="right">帐单日期：</td>
								<td align="left"><s:property value="#BillRecord.Brbroccurdate" /></td>
								<td align="right">帐单金额：</td>
								<td align="left"><s:property value="#BillRecord.Brbrtotal" /></td>
							</tr>
							<tr>
								<td align="right">币&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;种：</td>
								<td align="left"><s:property value="BillRecord.Ckckname" /></td>
							</tr>
                        </table>
					</p>
                    </div>
                 	<DIV style="width: 800px;">
					<div class="admin_table" style="OVERFLOW-y: auto; OVERFLOW-x: auto; WIDTH: 800px; HEIGHT: 335px;">
					<table width="1500px" border="0" cellpadding="0" cellspacing="1" bgcolor="#d5d5d5" class="manage_form1" >
                     <thead>
                     <tr align="center" style="color: #FFF" >
							<Td width=100 height="40px;" rowspan="3" class="manage_form_table" align="center">
								<strong>运单号</strong>
							</Td>
							<Td width=100 rowspan="3" class="manage_form_table"  align="center">
								<strong>百千运单号</strong>	
							</Td>									
							<Td width=100 rowspan="3" class="manage_form_table" align="center">
								<strong>转单号</strong>									</Td>		
							<Td width=100 rowspan="3" class="manage_form_table" align="center">
								<strong>到货日期</strong>									</Td>														
							<Td width=100 rowspan="3" class="manage_form_table" >
								<strong>产品</strong>									</Td>
							<Td width=80 rowspan="3" class="manage_form_table" >
								<strong>贷物类型</strong>									</Td>
							<Td width=60 rowspan="3" class="manage_form_table" >
								<strong>件数</strong>									</Td>
							<Td width=80 rowspan="3" class="manage_form_table" >
								<strong>实重(kg)</strong>									</Td>
							<Td width=100 rowspan="3" class="manage_form_table" >
								<strong>材积重(kg)</strong>									</Td>
							<Td width=100 rowspan="3" class="manage_form_table" >
								<strong>计费重(kg)</strong>									</Td>
							<Td width=120 rowspan="3" class="manage_form_table" >
								<strong>目的地</strong>									</Td>
							<Td width=60 colspan="5" class="manage_form_table" >
								<strong>应收费用</strong>									</Td>
							<Td width=160 rowspan="3" class="manage_form_table" >
								<strong>备注</strong>									</Td>
						</tr>
						<tr align="center" class="manage_form_bk4">
							<Td width=100 height="20px;" rowspan="2" class="manage_form_table">
								<strong>运费</strong>									
							</Td>
							<Td width=100 height="20px" rowspan="2" class="manage_form_table" >
								<strong>燃油费</strong>									
							</Td>
							<Td width=80 height="20px" colspan="2" class="manage_form_table" >
								<strong>杂费</strong>									
							</Td>
							<Td width=120 height="20px" rowspan="2" class="manage_form_table" >
								<strong>本位币合计</strong>									
						    </Td>
						</tr>
						<tr align="center" class="manage_form_bk4">
							<Td width=120  height="20px" class="manage_form_table" >
								<strong>杂费项目</strong>									
							</Td>
							<Td width=100  height="20px" class="manage_form_table" >
								<strong>金额</strong>									</Td>
						</tr>
						</thead>
						<TBODY>
					<%
						HashMap<String,List<ReceivableforbillColumns>> RFBColumnsMap = (HashMap<String,List<ReceivableforbillColumns>>)request.getAttribute("RFBColumnsMap");
						List<ReceivableforbillColumns> listReceivableforbillColumns = new ArrayList<ReceivableforbillColumns>();
						BigDecimal objResultFee = new BigDecimal("0");
						BigDecimal objChengeResultFee = new BigDecimal("0");
						if(!RFBColumnsMap.isEmpty() && RFBColumnsMap.size()>0){
							int i=0;
							for(Map.Entry<String,List<ReceivableforbillColumns>> entry:RFBColumnsMap.entrySet()){
								BigDecimal freightValue = new BigDecimal("0");
								BigDecimal oilFee = new BigDecimal("0");
								String strFkname = "";
								BigDecimal objOtherFee = new BigDecimal("0");
								listReceivableforbillColumns = entry.getValue();
								ReceivableforbillColumns objRFBColumns;
								objRFBColumns = listReceivableforbillColumns.get(0);	
								for(ReceivableforbillColumns objLRFBColumns:listReceivableforbillColumns){
									if(objLRFBColumns.getFkfkcode().equals("A0101")){
										freightValue = freightValue.add(new BigDecimal(objLRFBColumns.getRvrvactualtotal()));
									}else if(objLRFBColumns.getFkfkcode().equals("A0102")){
										oilFee = oilFee.add(new BigDecimal(objLRFBColumns.getRvrvactualtotal()));
									}else{
										strFkname = objLRFBColumns.getFkfkname();
										objOtherFee = objOtherFee.add(new BigDecimal(objLRFBColumns.getRvrvactualtotal())); 
									}
								}
								i++;
								if(i%2==0){
						%>
							<TR class="manage_form_bk2" style="overflow: auto" align="center">
						<%
							}else{
						%>
							<TR class="manage_form_bk" style="overflow: auto" align="center">
						<%}	%>
				
					<TD width=100 align="left"><%=objRFBColumns.getCwcwcustomerewbcode() %></TD>
					<TD width=100 align="left"><%=objRFBColumns.getCwcwewbcode() %></TD>					
					<TD width=100 align="left">
						<% if (!StringUtility.isNull(objRFBColumns.getPkpkshowserverewbcode()) &&
								objRFBColumns.getPkpkshowserverewbcode().equals("N"))
								out.print(objRFBColumns.getCwcwewbcode());
						   else 
								out.print(objRFBColumns.getCwcwserverewbcode()); %>						
					</TD>
					<TD width=180 align="left"><%=objRFBColumns.getRvrvoccurdate() %></TD>																
					<TD width=100 align="left"><%=objRFBColumns.getPkpkname() %></TD>
					<TD width=80 align="left"><%=objRFBColumns.getCtctname() %></TD>
					<TD width=60 align="right"><%=objRFBColumns.getCwcwpieces() %></TD>
					<TD width=80 align="right"><%= new BigDecimal(objRFBColumns.getCwcwgrossweight()).divide(new BigDecimal("1"),3,4) %></TD>
					<TD width=80 align="right"><%=new BigDecimal(CorewaybillDemand.getVolumeweight(objRFBColumns.getCwcwcode())).setScale(3) %></TD>
					<TD width=80 align="right"><%= new BigDecimal(objRFBColumns.getCwcwchargeweight()).divide(new BigDecimal("1"),3,4) %></TD>
					<TD width=120 align="left">
					<%
						if(!StringUtility.isNull(objRFBColumns.getCddtdtname()))
							out.print(objRFBColumns.getCddtdtname());
						else if(!StringUtility.isNull(objRFBColumns.getSdtdtcode()))
							out.print(DistrictDemand.getDtnameByDtcode(objRFBColumns.getSdtdtcode()));
						else
							out.print("");	
					%>
					</TD>
					<TD width=80 align="right"><%= freightValue.divide(new BigDecimal("1"),3,4)%></TD>
					<TD width=120 align="right"><%=oilFee.divide(new BigDecimal("1"),3,4)%></TD>
					<TD width=60 align="left"><%=strFkname%></TD>
					<TD width=60 align="right">
						<%=!String.valueOf(objOtherFee).equals("0") ? String.valueOf(objOtherFee.divide(new BigDecimal("1"),3,4)):""%>
					</TD>
					<TD width=60 align="right">
					<%
						BigDecimal objTotal = new BigDecimal("0").divide(new BigDecimal("1"),3,4);
						objTotal = objTotal.add(freightValue);
						objTotal = objTotal.add(oilFee);
						objTotal = objTotal.add(objOtherFee);
						objTotal.setScale(3);
						out.print(objTotal);
					%>
					</TD>
					<TD width=160 align="left"><%=objRFBColumns.getRvrvremark() != null ? objRFBColumns.getRvrvremark() : "" %></TD>
				</TR>
				<%
					objResultFee = objResultFee.add(objTotal); 
				}%>
				<TR>
					<TD >&nbsp;</TD>
					<TD >&nbsp;</TD>
					<TD >&nbsp;</TD>
					<TD >&nbsp;</TD>
					<TD >&nbsp;</TD>
					<TD >&nbsp;</TD>
					<TD >&nbsp;</TD>
					<TD >&nbsp;</TD>
					<TD colspan="3" >
					<!-- <%
					out.print("合计：");
					out.print(objResultFee);
				%> -->
						&nbsp;
					</TD>
					<TD  colspan="2">
					<%
						out.print("合计(RBM)：");
						out.print(objResultFee);
					%>
					</TD>
				</TR>
					<%}
					%>
					<!-- 判断定制块的值是否为空 -->
					<%
						if(listReceivableforbillColumns.size()==0 && listReceivableforbillColumns==null){
					%>
						<tr class="manage_form_bk2">
							<td colspan="10"><h3 style="color: red;">无相关信息！</h3></td>
						</tr>
					<% 
						}
					%>
							</TBODY>
					  </TABLE>
					</DIV>
				</DIV>   
			</div>
		</div>
		<!-- 分页 -->
		<div class="page" style="margin-right: 10px">
		</div>
	</div>
	<div style="clear:both"></div>
</body>
</html>

