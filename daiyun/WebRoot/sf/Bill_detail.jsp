<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="kyle.common.util.jlang.DateFormatUtility"%>
<%@page import="kyle.common.util.jlang.StringUtility"%>
<%@page import="kyle.common.util.jlang.DateUtility"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@ page import="java.math.BigDecimal"  %>
<%@ page import="java.util.*"%>
<%@ page import="kyle.leis.eo.finance.billrecord.da.BillrecordColumns"%>
<%@ page import="kyle.leis.eo.billing.receivable.da.ReceivableforbillColumns"%>
<%@ page import="kyle.leis.eo.operation.corewaybill.dax.CorewaybillDemand"%>
<%@ page import="kyle.leis.fs.dictionary.district.dax.DistrictDemand"%>
<%@taglib uri = "/project" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>账单详情</title>
		
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_total.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_page.css" />
		
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
<style>

.page { text-align:right; margin-top:10px; height:26px; padding:3px 0px;color: #000000;}
.page a { display:inline; border:1px solid #ccc; height:20px; line-height:20px; margin-left:5px; padding:2px 7px;}
.page a:hover { border:1px solid #3a739d; text-decoration:none; color:#3a739d; background:#f6fbff;}
</style>
<script type="text/javascript">


</script>
</head>

<body>

<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="${pageContext.request.contextPath }/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath }/op/recharge.jsp" target="_blank">充值</a></span> | <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="${pageContext.request.contextPath }/images/logo.jpg" /></div>
        <div class="right"><img src="${pageContext.request.contextPath }/images/tel.jpg" /></div>
      </div>
      <div class="nav">
		   <jsp:include page="../pg/include/main_menu.jsp"></jsp:include>
			    	
        <div class="nav_last"></div>
      </div>
    </div>
  </div>
  <div class="forwarding">
		<jsp:include page="../op/tree.jsp" />
     
    <div class="right">
      <div class="home">
        <h3>我的代运  > 我的信息 > <span>账单明细</span></h3>
      </div>
      <div class="balance">
        <div class="r_title">账单明细</div>
        <div class="bill_nir">
          <s:set var="BillRecord" value="#request.objBRColumns"></s:set>
         <ul>
         	<li> 
         	    <h3 style="float: right;"><span style="font-size:12px; font-weight:normal;">帐单标号：<s:property value="#BillRecord.Brbrid" /> </span></h3>     
         		<h3><span style="font-size:12px; font-weight:normal;">公司代码：<s:property value="#BillRecord.Cococode" /></span></h3>
         	</li>
         	<li>
         	    <h3 style="float: right;"><span style="font-size:12px; font-weight:normal;">帐单类型：<s:property value="#BillRecord.Bkbkname" /> </span></h3> 
         		<h3><span style="font-size:12px; font-weight:normal;">帐单状态：<s:property value="#BillRecord.Brsbrsname" /></span></h3>
     		</li>
         	<li> 
         	     <h3 style="float: right;"><span style="font-size:12px; font-weight:normal;">帐单日期：<s:property value="#BillRecord.Brbroccurdate" /></span></h3> 
         		 <h3><span style="font-size:12px; font-weight:normal;">帐单金额:<s:property value="#BillRecord.Brbrtotal" /> </span></h3>
      		</li>
         </ul>
        
         
        </div>
      </div>
      
			<div class="result" style="WIDTH: 860px; HEIGHT: 335px;">
					<table width="1500px" border="0" cellpadding="0" cellspacing="1"   >
                     <thead>
                     <tr align="center" style="background:#edf8fd;" >
							<td width=100 height="40px;" rowspan="3"  align="center">
								<strong>运单号</strong>
							</td>
							<!-- 
							<td width=100 rowspan="3"   align="center">
								<strong>百千运单号</strong>	
							</td>-->									
							<td width=100 rowspan="3"  align="center">
								<strong>转单号</strong>									</td>		
							<td width=100 rowspan="3"  align="center">
								<strong>到货日期</strong>									</td>														
							<td width=100 rowspan="3"  >
								<strong>产品</strong>									</td>
							<td width=80 rowspan="3"  >
								<strong>贷物类型</strong>									</td>
							<td width=60 rowspan="3"  >
								<strong>件数</strong>									</td>
							<td width=80 rowspan="3"  >
								<strong>实重(kg)</strong>									</td>
							<td width=100 rowspan="3"  >
								<strong>材积重(kg)</strong>									</td>
							<td width=100 rowspan="3"  >
								<strong>计费重(kg)</strong>									</td>
							<td width=120 rowspan="3"  >
								<strong>目的地</strong>									</td>
							<td width=60 colspan="5"  >
								<strong>应收费用</strong>									</td>
							<td width=160 rowspan="3"  >
								<strong>备注</strong>									</td>
						</tr>
						<tr align="center" style="background:#edf8fd;" >
							<td width=100 height="20px;" rowspan="2" >
								<strong>运费</strong>									
							</td>
							<td width=100 height="20px" rowspan="2" >
								<strong>燃油费</strong>									
							</td>
							<td width=80 height="20px" colspan="2"  >
								<strong>杂费</strong>									
							</td>
							<td width=120 height="20px" rowspan="2"  >
								<strong>本位币合计</strong>									
						    </td>
						</tr>
						<tr align="center" style="background:#edf8fd;" >
							<td width=120  height="20px"  >
								<strong>杂费项目</strong>									
							</td>
							<td width=100  height="20px"  >
								<strong>金额</strong>									</td>
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
				
					<td width=100 align="left"><%=objRFBColumns.getCwcwcustomerewbcode() %></td>
					<!-- <td width=100 align="left"><%=objRFBColumns.getCwcwewbcode() %></td> -->					
					<td width=100 align="left">
						<% if (!StringUtility.isNull(objRFBColumns.getPkpkshowserverewbcode()) &&
								objRFBColumns.getPkpkshowserverewbcode().equals("N"))
								out.print(objRFBColumns.getCwcwewbcode());
						   else 
								out.print(objRFBColumns.getCwcwserverewbcode()); %>						
					</td>
					<td width=180 align="left"><%=objRFBColumns.getRvrvoccurdate() %></td>																
					<td width=100 align="left"><%=objRFBColumns.getPkpkname() %></td>
					<td width=80 align="left"><%=objRFBColumns.getCtctname() %></td>
					<td width=60 align="right"><%=objRFBColumns.getCwcwpieces() %></td>
					<td width=80 align="right"><%= new BigDecimal(objRFBColumns.getCwcwgrossweight()).divide(new BigDecimal("1"),3,4) %></td>
					<td width=80 align="right"><%=new BigDecimal(CorewaybillDemand.getVolumeweight(objRFBColumns.getCwcwcode())).setScale(3) %></td>
					<td width=80 align="right"><%= new BigDecimal(objRFBColumns.getCwcwchargeweight()).divide(new BigDecimal("1"),3,4) %></td>
					<td width=120 align="left">
					<%
						if(!StringUtility.isNull(objRFBColumns.getCddtdtname()))
							out.print(objRFBColumns.getCddtdtname());
						else if(!StringUtility.isNull(objRFBColumns.getSdtdtcode()))
							out.print(DistrictDemand.getDtnameByDtcode(objRFBColumns.getSdtdtcode()));
						else
							out.print("");	
					%>
					</td>
					<td width=80 align="right"><%= freightValue.divide(new BigDecimal("1"),3,4)%></td>
					<td width=120 align="right"><%=oilFee.divide(new BigDecimal("1"),3,4)%></td>
					<td width=60 align="left"><%=strFkname%></td>
					<td width=60 align="right">
						<%=!String.valueOf(objOtherFee).equals("0") ? String.valueOf(objOtherFee.divide(new BigDecimal("1"),3,4)):""%>
					</td>
					<td width=60 align="right">
					<%
						BigDecimal objTotal = new BigDecimal("0").divide(new BigDecimal("1"),3,4);
						objTotal = objTotal.add(freightValue);
						objTotal = objTotal.add(oilFee);
						objTotal = objTotal.add(objOtherFee);
						objTotal.setScale(3);
						out.print(objTotal);
					%>
					</td>
					<td width=160 align="left"><%=objRFBColumns.getRvrvremark() != null ? objRFBColumns.getRvrvremark() : "" %></td>
				</TR>
				<%
					objResultFee = objResultFee.add(objTotal); 
				}%>
				<TR>
					<td >&nbsp;</td>
					<td >&nbsp;</td>
					<td >&nbsp;</td>
					<td >&nbsp;</td>
					<td >&nbsp;</td>
					<td >&nbsp;</td>
					<td >&nbsp;</td>
					<td >&nbsp;</td>
					<td colspan="3" >
					<!-- <%
					out.print("合计：");
					out.print(objResultFee);
				%> -->
						&nbsp;
					</td>
					<td  colspan="2">
					<%
						out.print("合计(RBM)：");
						out.print(objResultFee);
					%>
					</td>
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


        
    </div>
  </div>
  <div class="clear"></div>
  <div id="bottom">
    <div class="copyright">
      <div class="nir">
        <div class="left"> Copyright © 2012 深圳市代运物流网络有限公司<br />
          (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号 </div>
        <div class="right"><img src="${pageContext.request.contextPath }/images/tel2.jpg" /></div>
      </div>
    </div>
    <div class="bottom_nav"> <a href="#">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
</div>



	</body>
</html>
